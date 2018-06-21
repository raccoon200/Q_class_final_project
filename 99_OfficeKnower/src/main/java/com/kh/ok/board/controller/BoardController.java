package com.kh.ok.board.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.ok.board.model.service.BoardService;
import com.kh.ok.board.model.vo.Board;
import com.kh.ok.board.model.vo.BoardBookMark;
import com.kh.ok.board.model.vo.BoardGroup;
import com.kh.ok.board.model.vo.BoardMenu;
import com.kh.ok.member.model.vo.Member;

@Controller
public class BoardController {
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired
	private BoardService boardService;
	
	@RequestMapping("/board/test")
	public ModelAndView board() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("board/test2");
		return mav;
	}
	@RequestMapping("/board/boardTest")
	public ModelAndView boardTest(String id1, String id2) {
		System.out.println(id1);
		System.out.println(id2);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("board/test");
		return mav;
	}
	
	@RequestMapping("/board/boardBasicList")
	public ModelAndView selectBoardList(@RequestParam(value = "cPage", required = false, defaultValue = "1") int cPage,
			HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();

		HttpSession session = request.getSession(false);
		String userId = null;
		if (session != null && session.getAttribute("memberLoggedIn") != null) {
			userId = ((Member) session.getAttribute("memberLoggedIn")).getUserId();
		}
		
		// numPerPage 선언
		int numPerPage = 5;
		
		
		List<Map<String, String>> list = boardService.selectBoardBasicList(cPage, numPerPage);
		System.out.println("list : " + list);

		int pageNum = boardService.selectBoardCount();
		mav.addObject("list", list);
		mav.addObject("numPerPage", numPerPage);
		mav.addObject("cPage", cPage);
		mav.addObject("pageNum", pageNum);

		return mav;

	}
	
	@RequestMapping("/board/boardView")
	public ModelAndView selectBoardView(@RequestParam int boardNo) {
		ModelAndView mav = new ModelAndView();
		
		Board board = boardService.selectBoardView(boardNo);
		System.out.println("/board/boardView : "+board);
	
		mav.addObject("board",board);
		
		return mav;
	}

	@RequestMapping("/board/boardForm")
	public void selectBoardForm() {
	
	}
	
	@RequestMapping("/board/boardFormEnd.do")
	public ModelAndView insertBoard(Board board, @RequestParam(value="upFile", required=false) MultipartFile upFile, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		
		logger.debug("게시판 페이지 저장");
		/*logger.debug("board = "+board);
		logger.debug("upFileName = "+upFile.getName());
		logger.debug("upFile originalFileName="+upFile.getOriginalFilename());
		logger.debug("size = "+upFile.getSize());*/
		
		

		
		try {
			//1. 파일업로드처리
			String saveDirectory = request.getSession().getServletContext().getRealPath("/resources/upload/board");
			//requet로부터 session을 얻고 여기서 ServletContext()를 받아 절대경로를 받아옴
			
			/***** MultipartFile을 이용한 파일 업로드 처리로직 시작 *****/
			MultipartFile f = upFile;
			if(f!=null) {
				if(!f.isEmpty()) {
					//파일명 재생성
					String originalFileName = f.getOriginalFilename();
					String ext = originalFileName.substring(originalFileName.lastIndexOf(".")+1);	//확장자
					SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
					int rndNum = (int)(Math.random()*1000);
					String renamedFileName = sdf.format(new Date(System.currentTimeMillis()))+"_"+rndNum+"."+ext;
					try {
						f.transferTo(new File(saveDirectory+"/"+renamedFileName)); //실제 서버에 파일을 저장하는 코드
					} catch (IllegalStateException e) {
						e.printStackTrace();
					} catch (IOException e) {
						e.printStackTrace();
					}
					//VO객체 담기
					board.setOriginal_file_name(originalFileName);
					board.setRenamed_file_name(renamedFileName);
				}
			}
			/***** MultipartFile을 이용한 파일 업로드 처리로직 끝 *****/
			System.out.println("board : "+board);
			//2. 비지니스로직
			int result = boardService.insertBasicBoard(board);	//여기까지는 boardNo가 0이지만 이 함수가 끝난후
			int boardNo = board.getBoard_no();	//boardNo는 해당 no로 바뀐다.
			logger.debug("boardNo@Controller="+boardNo);
			//3. view단 분기
			String loc= "/";
			String msg = "";
			
			if(result>0) {
				msg = "게시판 등록성공";
				loc="/board/boardView.do?boardNo="+boardNo;
			}
			else
				msg="게시물 등록 실패";
			mav.addObject("msg",msg);
			mav.addObject("loc", loc);
			mav.setViewName("common/msg");
		}catch(Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	
	@RequestMapping("/board/boardDownload.do")
	public void fileDownload(@RequestParam String oName, @RequestParam String rName, HttpServletRequest request, HttpServletResponse response) {
		logger.debug("파일다운로드페이지["+oName+","+rName+"]");
		
		BufferedInputStream bis = null;
		ServletOutputStream sos = null;
		
		String saveDirectory = request.getSession().getServletContext().getRealPath("/resources/upload/board"); //request로부터 session을 얻고 거기서 servletcontext를 얻는구조
		
		File savedFile = new File(saveDirectory+"/"+rName);
		
		
		try {
			bis = new BufferedInputStream(new FileInputStream(savedFile));
			sos = response.getOutputStream();
		
			//응답세팅
			response.setContentType("application/octet-stream; charset=utf-8");
			
			//한글파일명 처리
			String resFilename = "";
			boolean isMSIE = request.getHeader("user-agent").indexOf("MSIE")!= -1 || request.getHeader("user-agent").indexOf("Trident") != -1;
			// IE 8이하는 MSIE라는 키워드를, 이후는 Trident라는 키워드를 갖고 있기에 둘다 체크해봐야함.
			
			if(isMSIE) {
				//ie는 utf-8인코딩을 명시적으로 해줌.
				resFilename = URLEncoder.encode(oName, "utf-8");	//이렇게 하면 공백이 +로 바뀌는 문제가 있음.
				resFilename = resFilename.replaceAll("\\+", "%20");	// +를 공백으로 바꾸는 코드.
			}else {
				resFilename= new String(oName.getBytes("utf-8"), "ISO-8859-1");	//기존 파일명을 바이트로 바꾼 후 ISO-8859-1형식으로 재 인코딩...
				
			}
			logger.debug("resFilename="+resFilename);
			
			response.addHeader("Content-Disposition", "attachment; filename=\""+resFilename+"\"");
			
			//쓰기
			int read = 0;
			while((read=bis.read())!=-1) {
				sos.write(read);
			}
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				sos.close();
				bis.close();
			}catch(IOException e) {
				e.printStackTrace();
			}
			
		}
	}
	
	@RequestMapping("/board/boardUpdate")
	public ModelAndView boardUpdate(@RequestParam int boardNo) {
		Board board = boardService.selectBoardView(boardNo);
		ModelAndView mav = new ModelAndView();
		mav.addObject("board", board);
		return mav;
	}
	@RequestMapping("/board/boardUpdateEnd")
	public ModelAndView boardUdpateEnd(Board board, @RequestParam(value="upFile", required=false) MultipartFile upFile, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		
		logger.debug("게시판 페이지 저장");
		/*logger.debug("board = "+board);
		logger.debug("upFileName = "+upFile.getName());
		logger.debug("upFile originalFileName="+upFile.getOriginalFilename());
		logger.debug("size = "+upFile.getSize());*/
		
		
		
		
		try {
			//1. 파일업로드처리
			String saveDirectory = request.getSession().getServletContext().getRealPath("/resources/upload/board");
			//requet로부터 session을 얻고 여기서 ServletContext()를 받아 절대경로를 받아옴
			
			/***** MultipartFile을 이용한 파일 업로드 처리로직 시작 *****/
			MultipartFile f = upFile;
			if(f!=null) {
				if(!f.isEmpty()) {
					//파일명 재생성
					String originalFileName = f.getOriginalFilename();
					String ext = originalFileName.substring(originalFileName.lastIndexOf(".")+1);	//확장자
					SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
					int rndNum = (int)(Math.random()*1000);
					String renamedFileName = sdf.format(new Date(System.currentTimeMillis()))+"_"+rndNum+"."+ext;
					try {
						f.transferTo(new File(saveDirectory+"/"+renamedFileName)); //실제 서버에 파일을 저장하는 코드
					} catch (IllegalStateException e) {
						e.printStackTrace();
					} catch (IOException e) {
						e.printStackTrace();
					}
					//VO객체 담기
					board.setOriginal_file_name(originalFileName);
					board.setRenamed_file_name(renamedFileName);
				}
			}
			/***** MultipartFile을 이용한 파일 업로드 처리로직 끝 *****/
			System.out.println("board : "+board);
			//2. 비지니스로직
			int result = boardService.updateBasicBoard(board);	//여기까지는 boardNo가 0이지만 이 함수가 끝난후
			int boardNo = board.getBoard_no();	//boardNo는 해당 no로 바뀐다.
			System.out.println("result : "+result + ", boardNo : "+boardNo);
			//3. view단 분기
			String loc= "/";
			String msg = "";
			
			if(result>0) {
				msg = "게시물 수정 성공";
				loc="/board/boardView.do?boardNo="+boardNo;
			}
			else
				msg="게시물 수정 실패";
			mav.addObject("msg",msg);
			mav.addObject("loc", loc);
			mav.setViewName("common/msg");
		}catch(Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	
	@RequestMapping("/board/boardDelete")
	public ModelAndView boardDelete(@RequestParam int boardNo) {
		ModelAndView mav = new ModelAndView();
		
		int result = boardService.deleteBoard(boardNo);
		
		String msg ="";
		String loc ="";
		if(result>0) {
			msg = "게시물 삭제 성공";
			loc="/board/boardBasicList";
		}
		else
			msg="게시물 삭제 실패";
		mav.addObject("msg",msg);
		mav.addObject("loc", loc);
		mav.setViewName("common/msg");
		return mav;
	}
	
	//게시판 만들기
	@RequestMapping("/board/boardMenuForm")
	public void boardMenuForm() {
		
	}
	
	@RequestMapping("/board/boardMenuFormEnd")
	public ModelAndView boardMenuFormEnd(BoardMenu boardMenu, @RequestParam String[] memberInfo) {
		ModelAndView mav = new ModelAndView();
		System.out.println("boardMenu : "+boardMenu);
		System.out.println("memberInfo : "+memberInfo);
		for(int i=0; i<memberInfo.length; i++) {
			System.out.println(memberInfo[i]);
		}
		int result = boardService.insertBoardMenu(boardMenu);
		
		BoardGroup[] bg = new BoardGroup[memberInfo.length];
		for(int i=0; i<bg.length; i++) {
			bg[i] = new BoardGroup(boardMenu.getBoard_menu_no(), memberInfo[i]);
			int result2 = boardService.insertBoardGroup(bg[i]);
			if(result2<=0) {
				result = 0; 
			}
		}
		
		String msg ="";
		String loc ="";
		if(result>0) {
			msg = "게시판 생성 성공";
			loc="/board/boardBasicList";
		}
		else
			msg="게시판 생성 실패";
		mav.addObject("msg",msg);
		mav.addObject("loc", loc);
		mav.setViewName("common/msg");
		return mav;
		
	}
	
	@RequestMapping(value = "/board/importantApply")
	public int importantApply(@RequestParam(value="boardNo", required=false) int boardNo, HttpSession session) {
		
		Member m = (Member) session.getAttribute("memberLoggedIn");
		String userId = m.getUserId();
		
		BoardBookMark bbm = new BoardBookMark(boardNo, userId);
		
		/*int result = boardService.importantApply(bbm);
		*/
		return 0;
		
		/*mav.setViewName("board/boardView?boardNo="+boardNo);
		return mav;*/
	}
	@RequestMapping(value = "/board/importantDelete")
	public int importantDelete(@RequestParam(value="boardNo", required=false) int boardNo, HttpSession session) {
		Member m = (Member) session.getAttribute("memberLoggedIn");
		String userId = m.getUserId();
		
		BoardBookMark bbm = new BoardBookMark(boardNo, userId);
		
		//int result = boardService.importantDelete(bbm);
		
		return 0;
	}
}
