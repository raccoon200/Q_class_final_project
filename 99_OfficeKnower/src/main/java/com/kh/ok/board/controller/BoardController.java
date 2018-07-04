package com.kh.ok.board.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.ok.board.model.service.BoardService;
import com.kh.ok.board.model.vo.Board;
import com.kh.ok.board.model.vo.BoardBookMark;
import com.kh.ok.board.model.vo.BoardGroup;
import com.kh.ok.board.model.vo.BoardMenu;
import com.kh.ok.board.model.vo.Comment;
import com.kh.ok.member.model.vo.Member;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
public class BoardController {
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired
	private BoardService boardService;

	@RequestMapping("/board/boardBasicList")
	public ModelAndView selectBoardList(@RequestParam(value = "cPage", required = false, defaultValue = "1") int cPage,
			HttpServletRequest request,
			@RequestParam(value = "boardMenuNo", required = false, defaultValue = "1") int board_menu_no) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession(false);
		String userId = null;
		String com_no = null;
		if (session != null && session.getAttribute("memberLoggedIn") != null) {
			Member m = (Member) session.getAttribute("memberLoggedIn");
			userId = m.getUserId();
			com_no = m.getCom_no();
		}

		// numPerPage 선언
		int numPerPage = 5;

		List<Map<String, String>> list = boardService.selectBoardBasicList(cPage, numPerPage, board_menu_no);
		BoardMenu boardMenu = boardService.selectBoardMenu(board_menu_no);

		int pageNum = boardService.selectBoardCount(board_menu_no);
		mav.addObject("list", list);
		mav.addObject("numPerPage", numPerPage);
		mav.addObject("cPage", cPage);
		mav.addObject("pageNum", pageNum);
		mav.addObject("board_menu_title", boardMenu.getTitle());
		mav.addObject("currentMenuNo", board_menu_no);
		mav.addObject("board_menu_kind", boardMenu.getKind());
		//////
		BoardMenu boardMenuParam = new BoardMenu();
		boardMenuParam.setCom_no(com_no);
		boardMenuParam.setKind("그룹게시판");
		List<Map<String, String>> groupBoard = boardService.selectBoardGroupList(boardMenuParam);
		boardMenuParam.setKind("전사게시판");
		List<Map<String, String>> basicBoard = boardService.selectBoardBasicList(boardMenuParam);

		mav.addObject("groupBoard", groupBoard);
		mav.addObject("basicBoard", basicBoard);
		//////

		return mav;

	}

	@RequestMapping("/board/boardImportantList")
	public ModelAndView selectImportantBoardList(
			@RequestParam(value = "cPage", required = false, defaultValue = "1") int cPage, HttpServletRequest request,
			HttpSession session) {
		ModelAndView mav = new ModelAndView();

		session = request.getSession(false);
		String userId = null;
		String com_no = null;
		if (session != null && session.getAttribute("memberLoggedIn") != null) {
			userId = ((Member) session.getAttribute("memberLoggedIn")).getUserId();
			com_no = ((Member) session.getAttribute("memberLoggedIn")).getCom_no();
		}

		// numPerPage 선언
		int numPerPage = 5;

		List<Map<String, String>> list = boardService.selectBoardImportantList(cPage, numPerPage, userId);

		int pageNum = boardService.selectBoardImportantCount(userId);
		mav.addObject("list", list);
		mav.addObject("numPerPage", numPerPage);
		mav.addObject("cPage", cPage);
		mav.addObject("pageNum", pageNum);

		//////
		BoardMenu boardMenuParam = new BoardMenu();
		boardMenuParam.setCom_no(com_no);
		boardMenuParam.setKind("그룹게시판");
		List<Map<String, String>> groupBoard = boardService.selectBoardGroupList(boardMenuParam);
		boardMenuParam.setKind("전사게시판");
		List<Map<String, String>> basicBoard = boardService.selectBoardBasicList(boardMenuParam);

		mav.addObject("groupBoard", groupBoard);
		mav.addObject("basicBoard", basicBoard);
		//////
		return mav;

	}

	@RequestMapping("/board/boardRecentList")
	public ModelAndView selectRecentBoardList(HttpServletRequest request, HttpSession session) {
		ModelAndView mav = new ModelAndView();

		session = request.getSession(false);
		String userId = null;
		String com_no = null;
		if (session != null && session.getAttribute("memberLoggedIn") != null) {
			userId = ((Member) session.getAttribute("memberLoggedIn")).getUserId();
			com_no = ((Member) session.getAttribute("memberLoggedIn")).getCom_no();
		}

		List<Map<String, String>> list = boardService.selectBoardRecentList(userId);

		mav.addObject("list", list);
		//////
		BoardMenu boardMenuParam = new BoardMenu();
		boardMenuParam.setCom_no(com_no);
		boardMenuParam.setKind("그룹게시판");
		List<Map<String, String>> groupBoard = boardService.selectBoardGroupList(boardMenuParam);
		boardMenuParam.setKind("전사게시판");
		List<Map<String, String>> basicBoard = boardService.selectBoardBasicList(boardMenuParam);

		mav.addObject("groupBoard", groupBoard);
		mav.addObject("basicBoard", basicBoard);
		//////
		return mav;

	}

	@RequestMapping("/board/boardView")
	public ModelAndView selectBoardView(@RequestParam int boardNo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		ModelAndView mav = new ModelAndView();

		// 쿠키검사 (조회수)
		Cookie[] cookies = request.getCookies();
		String boardCookieVal = "";
		boolean hasRead = false;

		if (cookies != null) {
			for (Cookie c : cookies) {
				String name = c.getName();
				String value = c.getValue();

				if ("boardCookie".equals(name)) {
					boardCookieVal = value;
					if (boardCookieVal.contains("|" + boardNo + "|")) {
						hasRead = true;
						break;
					}

				}
			}
		}
		// 게시글 읽음여부
		if (!hasRead) {
			// 조회수 증가
			int result = boardService.increaseBoardCount(boardNo);

			// 쿠키생성
			Cookie boardCookie = new Cookie("boardCookie", boardCookieVal + "|" + boardNo + "|");
			// boardCookie.setPath("/mvc/board");//작성안하면, 자동으로 현재경로로 셋팅됨.
			// boardCookie.setMaxAge(60*60*24);//작성안하면, 브라우져에서 영구저장.
			response.addCookie(boardCookie);

		}

		Board board = boardService.selectBoardView(boardNo);
		System.out.println("/board/boardView : " + board);
		Member m = (Member) session.getAttribute("memberLoggedIn");
		String com_no = m.getCom_no();
		BoardBookMark bbm = new BoardBookMark(boardNo, m.getUserId());
		if (boardService.selectBoardBookMark(bbm) > 0) {
			board.setBookmark("Y");
		} else {
			board.setBookmark("N");
		}

		mav.addObject("board", board);

		List<Map<String, String>> commentList = boardService.selectCommentList(boardNo);
		mav.addObject("commentList", commentList);

		//////
		BoardMenu boardMenuParam = new BoardMenu();
		boardMenuParam.setCom_no(com_no);
		boardMenuParam.setKind("그룹게시판");
		List<Map<String, String>> groupBoard = boardService.selectBoardGroupList(boardMenuParam);
		boardMenuParam.setKind("전사게시판");
		List<Map<String, String>> basicBoard = boardService.selectBoardBasicList(boardMenuParam);

		mav.addObject("groupBoard", groupBoard);
		mav.addObject("basicBoard", basicBoard);
		//////
		return mav;
	}

	@RequestMapping("/board/boardForm")
	public ModelAndView selectBoardForm(HttpSession session,
			@RequestParam(value = "boardMenuNo", required = false, defaultValue = "0") int boardMenuNo) {
		String userId = null;
		String com_no = null;
		if (session.getAttribute("memberLoggedIn") != null) {
			userId = ((Member) session.getAttribute("memberLoggedIn")).getUserId();
			com_no = ((Member) session.getAttribute("memberLoggedIn")).getCom_no();
		}

		List<Map<String, String>> board_menu_list = boardService.selectBoardMenuList(userId);
		System.out.println(board_menu_list);
		ModelAndView mav = new ModelAndView();
		mav.addObject("board_menu_list", board_menu_list);
		mav.addObject("currentMenuNo", boardMenuNo);
		//////
		BoardMenu boardMenuParam = new BoardMenu();
		boardMenuParam.setCom_no(com_no);
		boardMenuParam.setKind("그룹게시판");
		List<Map<String, String>> groupBoard = boardService.selectBoardGroupList(boardMenuParam);
		boardMenuParam.setKind("전사게시판");
		List<Map<String, String>> basicBoard = boardService.selectBoardBasicList(boardMenuParam);

		mav.addObject("groupBoard", groupBoard);
		mav.addObject("basicBoard", basicBoard);
		//////
		return mav;
	}

	@RequestMapping("/board/boardFormEnd.do")
	public ModelAndView insertBoard(Board board, @RequestParam(value = "upFile", required = false) MultipartFile upFile,
			HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();

		logger.debug("게시판 페이지 저장");
		/*
		 * logger.debug("board = "+board);
		 * logger.debug("upFileName = "+upFile.getName());
		 * logger.debug("upFile originalFileName="+upFile.getOriginalFilename());
		 * logger.debug("size = "+upFile.getSize());
		 */

		try {
			// 1. 파일업로드처리
			String saveDirectory = request.getSession().getServletContext().getRealPath("/resources/upload/board");
			// requet로부터 session을 얻고 여기서 ServletContext()를 받아 절대경로를 받아옴

			/***** MultipartFile을 이용한 파일 업로드 처리로직 시작 *****/
			MultipartFile f = upFile;
			if (f != null) {
				if (!f.isEmpty()) {
					// 파일명 재생성
					String originalFileName = f.getOriginalFilename();
					String ext = originalFileName.substring(originalFileName.lastIndexOf(".") + 1); // 확장자
					SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
					int rndNum = (int) (Math.random() * 1000);
					String renamedFileName = sdf.format(new Date(System.currentTimeMillis())) + "_" + rndNum + "."
							+ ext;
					try {
						f.transferTo(new File(saveDirectory + "/" + renamedFileName)); // 실제 서버에 파일을 저장하는 코드
					} catch (IllegalStateException e) {
						e.printStackTrace();
					} catch (IOException e) {
						e.printStackTrace();
					}
					// VO객체 담기
					
					board.setRenamed_file_name(renamedFileName);
				}
			}
			/***** MultipartFile을 이용한 파일 업로드 처리로직 끝 *****/
			System.out.println("board : " + board);
			// 2. 비지니스로직
			int result = boardService.insertBasicBoard(board); // 여기까지는 boardNo가 0이지만 이 함수가 끝난후
			int boardNo = board.getBoard_no(); // boardNo는 해당 no로 바뀐다.
			logger.debug("boardNo@Controller=" + boardNo);
			// 3. view단 분기
			String loc = "/";
			String msg = "";

			if (result > 0) {
				msg = "게시판 등록성공";
				loc = "/board/boardView.do?boardNo=" + boardNo;
			} else
				msg = "게시물 등록 실패";
			mav.addObject("msg", msg);
			mav.addObject("loc", loc);
			mav.setViewName("common/msg");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}

	@RequestMapping("/board/boardDownload.do")
	public void fileDownload(@RequestParam String oName, @RequestParam String rName, HttpServletRequest request,
			HttpServletResponse response) {
		logger.debug("파일다운로드페이지[" + oName + "," + rName + "]");

		BufferedInputStream bis = null;
		ServletOutputStream sos = null;

		String saveDirectory = request.getSession().getServletContext().getRealPath("/resources/upload/board"); // request로부터
																												// session을
																												// 얻고
																												// 거기서
																												// servletcontext를
																												// 얻는구조

		File savedFile = new File(saveDirectory + "/" + rName);

		try {
			bis = new BufferedInputStream(new FileInputStream(savedFile));
			sos = response.getOutputStream();

			// 응답세팅
			response.setContentType("application/octet-stream; charset=utf-8");

			// 한글파일명 처리
			String resFilename = "";
			boolean isMSIE = request.getHeader("user-agent").indexOf("MSIE") != -1
					|| request.getHeader("user-agent").indexOf("Trident") != -1;
			// IE 8이하는 MSIE라는 키워드를, 이후는 Trident라는 키워드를 갖고 있기에 둘다 체크해봐야함.

			if (isMSIE) {
				// ie는 utf-8인코딩을 명시적으로 해줌.
				resFilename = URLEncoder.encode(oName, "utf-8"); // 이렇게 하면 공백이 +로 바뀌는 문제가 있음.
				resFilename = resFilename.replaceAll("\\+", "%20"); // +를 공백으로 바꾸는 코드.
			} else {
				resFilename = new String(oName.getBytes("utf-8"), "ISO-8859-1"); // 기존 파일명을 바이트로 바꾼 후 ISO-8859-1형식으로 재
																					// 인코딩...

			}
			logger.debug("resFilename=" + resFilename);

			response.addHeader("Content-Disposition", "attachment; filename=\"" + resFilename + "\"");

			// 쓰기
			int read = 0;
			while ((read = bis.read()) != -1) {
				sos.write(read);
			}

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				sos.close();
				bis.close();
			} catch (IOException e) {
				e.printStackTrace();
			}

		}
	}

	@RequestMapping("/board/boardUpdate")
	public ModelAndView boardUpdate(@RequestParam int boardNo, HttpSession session) {
		Board board = boardService.selectBoardView(boardNo);
		ModelAndView mav = new ModelAndView();
		String userId = null;
		String com_no = null;
		if (session.getAttribute("memberLoggedIn") != null) {
			userId = ((Member) session.getAttribute("memberLoggedIn")).getUserId();
			com_no = ((Member) session.getAttribute("memberLoggedIn")).getCom_no();
		}

		List<Map<String, String>> board_menu_list = boardService.selectBoardMenuList(userId);
		System.out.println(board_menu_list);
		mav.addObject("board", board);
		mav.addObject("board_menu_list", board_menu_list);

		//////
		BoardMenu boardMenuParam = new BoardMenu();
		boardMenuParam.setCom_no(com_no);
		boardMenuParam.setKind("그룹게시판");
		List<Map<String, String>> groupBoard = boardService.selectBoardGroupList(boardMenuParam);
		boardMenuParam.setKind("전사게시판");
		List<Map<String, String>> basicBoard = boardService.selectBoardBasicList(boardMenuParam);

		mav.addObject("groupBoard", groupBoard);
		mav.addObject("basicBoard", basicBoard);
		//////
		return mav;
	}

	@RequestMapping("/board/boardUpdateEnd")
	public ModelAndView boardUdpateEnd(Board board,
			@RequestParam(value = "upFile", required = false) MultipartFile upFile, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();

		logger.debug("게시판 페이지 저장");
		/*
		 * logger.debug("board = "+board);
		 * logger.debug("upFileName = "+upFile.getName());
		 * logger.debug("upFile originalFileName="+upFile.getOriginalFilename());
		 * logger.debug("size = "+upFile.getSize());
		 */

		try {
			// 1. 파일업로드처리
			String saveDirectory = request.getSession().getServletContext().getRealPath("/resources/upload/board");
			// requet로부터 session을 얻고 여기서 ServletContext()를 받아 절대경로를 받아옴

			/***** MultipartFile을 이용한 파일 업로드 처리로직 시작 *****/
			MultipartFile f = upFile;
			if (f != null) {
				if (!f.isEmpty()) {
					// 파일명 재생성
					String originalFileName = f.getOriginalFilename();
					String ext = originalFileName.substring(originalFileName.lastIndexOf(".") + 1); // 확장자
					SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
					int rndNum = (int) (Math.random() * 1000);
					String renamedFileName = sdf.format(new Date(System.currentTimeMillis())) + "_" + rndNum + "."
							+ ext;
					try {
						f.transferTo(new File(saveDirectory + "/" + renamedFileName)); // 실제 서버에 파일을 저장하는 코드
					} catch (IllegalStateException e) {
						e.printStackTrace();
					} catch (IOException e) {
						e.printStackTrace();
					}
					// VO객체 담기
					board.setOriginal_file_name(originalFileName);
					board.setRenamed_file_name(renamedFileName);
				}
			}
			/***** MultipartFile을 이용한 파일 업로드 처리로직 끝 *****/
			System.out.println("board : " + board);
			// 2. 비지니스로직
			int result = boardService.updateBasicBoard(board); // 여기까지는 boardNo가 0이지만 이 함수가 끝난후
			int boardNo = board.getBoard_no(); // boardNo는 해당 no로 바뀐다.
			System.out.println("result : " + result + ", boardNo : " + boardNo);
			// 3. view단 분기
			String loc = "/";
			String msg = "";

			if (result > 0) {
				msg = "게시물 수정 성공";
				loc = "/board/boardView.do?boardNo=" + boardNo;
			} else
				msg = "게시물 수정 실패";
			mav.addObject("msg", msg);
			mav.addObject("loc", loc);
			mav.setViewName("common/msg");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}

	@RequestMapping("/board/boardDelete")
	public ModelAndView boardDelete(@RequestParam int boardNo) {
		ModelAndView mav = new ModelAndView();

		int result = boardService.deleteBoard(boardNo);

		String msg = "";
		String loc = "";
		if (result > 0) {
			msg = "게시물 삭제 성공";
			loc = "/board/boardBasicList";
		} else
			msg = "게시물 삭제 실패";
		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		mav.setViewName("common/msg");
		return mav;
	}

	// 게시판 만들기
	@RequestMapping("/board/boardMenuForm")
	public ModelAndView boardMenuForm(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String com_no = ((Member) session.getAttribute("memberLoggedIn")).getCom_no();
		String com_name = boardService.selectComName(com_no);
		List<Map<String, String>> deptList = boardService.selectDeptList(com_no);

		mav.addObject("deptList", deptList);

		mav.addObject("com_name", com_name);

		//////
		BoardMenu boardMenuParam = new BoardMenu();
		boardMenuParam.setCom_no(com_no);
		boardMenuParam.setKind("그룹게시판");
		List<Map<String, String>> groupBoard = boardService.selectBoardGroupList(boardMenuParam);
		boardMenuParam.setKind("전사게시판");
		List<Map<String, String>> basicBoard = boardService.selectBoardBasicList(boardMenuParam);

		mav.addObject("groupBoard", groupBoard);
		mav.addObject("basicBoard", basicBoard);
		//////
		return mav;
	}
	@RequestMapping(value = "/board/memberCompanyListAll")
	public @ResponseBody Map memberCompanyListAll(Locale locale, Model model, HttpSession session) {
		
		Member m = (Member) session.getAttribute("memberLoggedIn");
		System.out.println(m.getUserId());
		System.out.println(m.getCom_no());
		
		List<Map<String,String>> ls = boardService.memberCompanyListAll(m.getCom_no());
		List<Map<String,String>> list = new ArrayList<Map<String,String>>();
		for(int i=0; i<ls.size(); i++) {
			list.add(ls.get(i));
		}
		Map<String,String> map = new HashMap();
		map.put("count", ""+ls.size());
		
		list.add(map);
		Map result = new HashMap();
		result.put("members",  list);
	
		
		
		return result;
	}
	@RequestMapping("/board/boardMenuFormEnd")
	public ModelAndView boardMenuFormEnd(BoardMenu boardMenu, @RequestParam String[] memberInfo) {
		ModelAndView mav = new ModelAndView();
		System.out.println("boardMenu : " + boardMenu);
		System.out.println("memberInfo : " + memberInfo);
		for (int i = 0; i < memberInfo.length; i++) {
			System.out.println(memberInfo[i]);
		}
		int result = boardService.insertBoardMenu(boardMenu);

		BoardGroup[] bg = new BoardGroup[memberInfo.length];
		for (int i = 0; i < bg.length; i++) {
			bg[i] = new BoardGroup(boardMenu.getBoard_menu_no(), memberInfo[i]);
			int result2 = boardService.insertBoardGroup(bg[i]);
			if (result2 <= 0) {
				result = 0;
			}
		}

		String msg = "";
		String loc = "";
		if (result > 0) {
			msg = "게시판 생성 성공";
			loc = "/board/boardBasicList";
		} else
			msg = "게시판 생성 실패";
		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		mav.setViewName("common/msg");
		return mav;

	}

	@RequestMapping(value = "/board/importantApply")
	public void importantApply(@RequestParam(value = "boardNo", required = false) int boardNo, HttpSession session) {

		Member m = (Member) session.getAttribute("memberLoggedIn");
		String userId = m.getUserId();

		BoardBookMark bbm = new BoardBookMark(boardNo, userId);

		int result = boardService.importantApply(bbm);

		/*
		 * mav.setViewName("board/boardView?boardNo="+boardNo); return mav;
		 */
	}

	@RequestMapping(value = "/board/importantDelete")
	public void importantDelete(@RequestParam(value = "boardNo", required = false) int boardNo, HttpSession session) {
		Member m = (Member) session.getAttribute("memberLoggedIn");
		String userId = m.getUserId();

		BoardBookMark bbm = new BoardBookMark(boardNo, userId);

		int result = boardService.importantDelete(bbm);

	}

	@RequestMapping("/board/commentInsert")
	public ModelAndView commentInsert(Comment comment) {
		ModelAndView mav = new ModelAndView();
		System.out.println(comment);
		int result = boardService.insertComment(comment);

		String loc = "/";
		String msg = "";

		if (result > 0) {
			msg = "댓글 등록 성공";
			loc = "/board/boardView.do?boardNo=" + comment.getBoard_no();
		} else
			msg = "댓글 등록 실패";
		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		mav.setViewName("common/msg");
		return mav;
	}

	@RequestMapping("/board/commentDelete")
	public ModelAndView commentDelete(Comment comment) {
		ModelAndView mav = new ModelAndView();

		System.out.println(comment.getBoard_no());

		int result = boardService.deleteComment(comment.getComment_no());

		String loc = "/";
		String msg = "";

		if (result > 0) {
			msg = "댓글 삭제 성공";
			loc = "/board/boardView.do?boardNo=" + comment.getBoard_no();
		} else
			msg = "댓글 삭제 실패";
		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		mav.setViewName("common/msg");
		return mav;
	}

	@RequestMapping("/board/boardMenuManage")
	public ModelAndView boardMenuManage(HttpSession session) {

		ModelAndView mav = new ModelAndView();
		Member m = (Member) session.getAttribute("memberLoggedIn");
		String com_no = ((Member) session.getAttribute("memberLoggedIn")).getCom_no();
		List<Map<String, String>> list = boardService.selectBoardMenuManageList(m);

		mav.addObject("list", list);

		//////
		BoardMenu boardMenuParam = new BoardMenu();
		boardMenuParam.setCom_no(com_no);
		boardMenuParam.setKind("그룹게시판");
		List<Map<String, String>> groupBoard = boardService.selectBoardGroupList(boardMenuParam);
		boardMenuParam.setKind("전사게시판");
		List<Map<String, String>> basicBoard = boardService.selectBoardBasicList(boardMenuParam);

		mav.addObject("groupBoard", groupBoard);
		mav.addObject("basicBoard", basicBoard);
		//////
		return mav;
	}

	@RequestMapping("/board/boardMenuDelete")
	public ModelAndView boardMenuDelete(@RequestParam int boardMenuNo) {
		ModelAndView mav = new ModelAndView();
		int result = boardService.deleteBoardMenu(boardMenuNo);
		String loc = "/";
		String msg = "";

		if (result > 0) {
			msg = "게시판 삭제 성공";
			loc = "/board/boardMenuManage";
		} else
			msg = "게시판 삭제 실패";
		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		mav.setViewName("common/msg");
		return mav;
	}

	@RequestMapping(value = "/board/selectBoardMenuMember")
	public @ResponseBody Map selectBoardMenuMember(@RequestParam String dept, HttpSession session) throws JsonProcessingException, UnsupportedEncodingException {
		Member m = (Member) session.getAttribute("memberLoggedIn");
		String com_no = m.getCom_no();
		Member member = new Member();
		member.setCom_no(com_no);
		member.setDept(dept);

		Map<String, Object> map = new HashMap<String, Object>();
		ObjectMapper mapper = new ObjectMapper();
		String jsonStr = null;

		List<Map<String, String>> memberList = boardService.selectBoardMenuMember(member);
	
		/*map.put("memberList", memberList);
		jsonStr = mapper.writeValueAsString(map);*/
		Map result = new HashMap();
		result.put("memberList",  memberList);
		return result;

	}
	
	@RequestMapping("/board/boardMenuFormUpdate")
	public ModelAndView boardMenuFormUpdate(@RequestParam int boardMenuNo, HttpSession session ) {
		ModelAndView mav = new ModelAndView();
		System.out.println("boardMenu : "+boardMenuNo);
		BoardMenu boardMenu = boardService.selectBoardMenu(boardMenuNo);
		List<Map<String, String>> boardGroupList = boardService.selectBoardMemberList(boardMenu.getBoard_menu_no());
		mav.addObject("_boardMenu", boardMenu);
		mav.addObject("_boardGroupList", boardGroupList);
		
		String com_no = ((Member) session.getAttribute("memberLoggedIn")).getCom_no();
		String com_name = boardService.selectComName(com_no);
		List<Map<String, String>> deptList = boardService.selectDeptList(com_no);

		mav.addObject("deptList", deptList);

		mav.addObject("com_name", com_name);

		//////
		BoardMenu boardMenuParam = new BoardMenu();
		boardMenuParam.setCom_no(com_no);
		boardMenuParam.setKind("그룹게시판");
		List<Map<String, String>> groupBoard = boardService.selectBoardGroupList(boardMenuParam);
		boardMenuParam.setKind("전사게시판");
		List<Map<String, String>> basicBoard = boardService.selectBoardBasicList(boardMenuParam);

		mav.addObject("groupBoard", groupBoard);
		mav.addObject("basicBoard", basicBoard);
		//////
		return mav;
	}
	@RequestMapping("/board/boardMenuFormUpdateEnd")
	public ModelAndView boardMenuFormUpdateEnd(BoardMenu boardMenu, @RequestParam String[] memberInfo) {
		ModelAndView mav = new ModelAndView();
		System.out.println("boardMenu : " + boardMenu);
		System.out.println("memberInfo : " + memberInfo);
		for (int i = 0; i < memberInfo.length; i++) {
			System.out.println(memberInfo[i]);
		}
		int result = boardService.updateBoardMenu(boardMenu);

		BoardGroup[] bg = new BoardGroup[memberInfo.length];
		for (int i = 0; i < bg.length; i++) {
			bg[i] = new BoardGroup(boardMenu.getBoard_menu_no(), memberInfo[i]);
			System.out.println("----");
			System.out.println(bg[i].getBoard_menu_no()+", "+bg[i].getUserId());
			
			int result2 = boardService.insertBoardGroup(bg[i]);
			if (result2 <= 0) {
				result = 0;
			}
		}

		String msg = "";
		String loc = "";
		if (result > 0) {
			msg = "게시판 수정 성공";
			loc = "/board/boardBasicList";
		} else
			msg = "게시판 생성 실패";
		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		mav.setViewName("common/msg");
		
		
		return mav;

	}
	@RequestMapping("/board/admin/boardAdminInsert.do")
	public ModelAndView boardAdminInsert(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Member m = (Member)session.getAttribute("memberLoggedIn");
		String com_no = m.getCom_no();
		List<Map<String, String>> boardAdminList = boardService.selectListAdmin(com_no);
		
		mav.addObject("boardAdminList", boardAdminList);
		
		//////
		BoardMenu boardMenuParam = new BoardMenu();
		boardMenuParam.setCom_no(com_no);
		boardMenuParam.setKind("그룹게시판");
		List<Map<String, String>> groupBoard = boardService.selectBoardGroupList(boardMenuParam);
		boardMenuParam.setKind("전사게시판");
		List<Map<String, String>> basicBoard = boardService.selectBoardBasicList(boardMenuParam);

		mav.addObject("groupBoard", groupBoard);
		mav.addObject("basicBoard", basicBoard);
		//////
		return mav;
	}
	@RequestMapping("/board/admin/boardAdminDelete.do")
	public ModelAndView boardAdminDelete(Member member) {
		ModelAndView mav = new ModelAndView();
		String str= "";
		String arr[] = member.getGrade().split(",");
		for(int i=0; i<arr.length; i++) {
			System.out.println(arr[i]);
			
			if(!arr[i].equals("게시판관리자")) {
				if(i!=0) {
					str += ",";
				}
				str += arr[i];
			}
		}
		System.out.println(str);
		if(str=="") {
			member.setGrade("");
		}else {
			member.setGrade(str);
		}
		System.out.println(member);
		int result = boardService.deleteAdmin(member);
	
	
		String loc = "/";
		String msg = "";

		if (result > 0) {
			msg = "게시판 관리자 삭제 성공";
			loc = "/board/admin/boardAdminInsert.do";
		} else
			msg = "게시판 관리자 삭제 실패";
		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		mav.setViewName("common/msg");
		
		return mav;
	}
	@RequestMapping("/board/admin/searchAdmin")
	@ResponseBody
	public JSONArray searchAdmin(@RequestParam String userName, HttpSession session) {
		Member member = (Member)session.getAttribute("memberLoggedIn");
		member.setUserName('%'+userName+'%');
		List<Map<String,String>> userList = boardService.selectAdmin(member);
		JSONArray jsonArr = new JSONArray();
		for(Map<String,String> m : userList) {
			JSONObject jsonO = new JSONObject();
			jsonO.put("userId", m.get("USERID"));
			jsonO.put("userName", m.get("USERNAME"));
			jsonO.put("emp_no", m.get("EMP_NO"));
			jsonO.put("dept", m.get("DEPT"));
			jsonO.put("grade", m.get("GRADE"));
			jsonO.put("position", m.get("POSITION"));
			jsonArr.add(jsonO);
		}
		
		return jsonArr;
	}
	@RequestMapping("/board/admin/adminInsertEnd.do")
	public ModelAndView insertAdmin(@RequestParam String userId) {
		ModelAndView mav = new ModelAndView();
		
		Member m = boardService.selectMember(userId);
		if(m.getGrade() == null || m.getGrade() == "") {
			m.setGrade("게시판관리자");
		}else {
			m.setGrade(",게시판관리자");
		}
		int result = boardService.adminInsert(m);
		
		
		String loc = "/";
		String msg = "";

		if (result > 0) {
			msg = "게시판 관리자 추가 성공";
			loc = "/board/admin/boardAdminInsert.do";
		} else
			msg = "게시판 관리자 추가 실패";
		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		mav.setViewName("common/msg");
		return mav;
	}
}
