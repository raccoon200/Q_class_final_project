package com.kh.ok.board.controller;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.ok.board.model.service.BoardService;

import oracle.net.aso.s;




@Controller
public class BoardController {
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired
	private BoardService boardService;
	@RequestMapping("/board/boardBasicList")
	public ModelAndView selectBoardList(@RequestParam (value="cPage", required=false, defaultValue="1") int cPage) {
		ModelAndView mav = new ModelAndView();
		
		// numPerPage 선언
		int numPerPage = 5;
		
		
		List<Map<String, String>> list = boardService.selectBoardBasicList(cPage, numPerPage);
		System.out.println("list : "+list);
		
		int pageNum = boardService.selectBoardCount();
		mav.addObject("list", list);
		mav.addObject("numPerPage", numPerPage);
		mav.addObject("cPage", cPage);
		mav.addObject("pageNum",pageNum);
		return mav;
		
	}
	
}
