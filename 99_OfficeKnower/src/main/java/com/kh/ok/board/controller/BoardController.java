package com.kh.ok.board.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
import com.kh.ok.member.model.vo.Member;
import com.kh.spring.board.model.exception.BoardException;

@Controller
public class BoardController {
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired
	private BoardService boardService;

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
		
		
		
		return mav;
	}

	@RequestMapping("/board/boardForm")
	public void selectBoardForm() {
	
	}
	
	@RequestMapping("/board/boardFormEnd")
	public ModelAndView selectBoardFormEnd(Board board, @RequestParam(value="upFile", required=false) MultipartFile upFile, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		
		logger.debug("게시판 페이지 저장");
		/*logger.debug("board = "+board);
		logger.debug("upFileName = "+upFile.getName());
		logger.debug("upFile originalFileName="+upFile.getOriginalFilename());
		logger.debug("size = "+upFile.getSize());*/
		MultipartFile f = upFile;
	

		try {
			//1. 파일업로드처리
			String saveDirectory = request.getSession().getServletContext().getRealPath("/resources/upload/board");
			//requet로부터 session을 얻고 여기서 ServletContext()를 받아 절대경로를 받아옴
			
			/***** MultipartFile을 이용한 파일 업로드 처리로직 시작 *****/
			
				if(f!=null && !f.isEmpty()) {
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
			/***** MultipartFile을 이용한 파일 업로드 처리로직 끝 *****/
			logger.debug("board = "+board);
			
			//2. 비지니스로직
			int result = boardService.insertBasicBoard(board);	//여기까지는 boardNo가 0이지만 이 함수가 끝난후
			int boardNo = board.getBoard_no();	//boardNo는 해당 no로 바뀐다.
			logger.debug("boardNo@Controller="+boardNo);
			//3. view단 분기
			String loc= "/";
			String msg = "";
			
			if(result>0) {
				msg = "게시판 등록성공";
				loc="/board/boardView.do?no="+boardNo;
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
}
