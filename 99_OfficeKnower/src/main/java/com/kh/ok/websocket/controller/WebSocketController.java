package com.kh.ok.websocket.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.ok.member.model.vo.Member;

@Controller
public class WebSocketController {
	/*
	@GetMapping("main.ctr")
	public String main(Model model) {
		return "chatting/main";
	}*/
	@RequestMapping("/webTest.do")
	public ModelAndView webtest(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("websocket");
		HttpSession session = request.getSession(false);
		
		Member user = (Member)session.getAttribute("memberLoggedIn");
		System.out.println("user name : " + user.getUserId());
		System.out.println("normal chat page");
		mv.addObject("userid", user.getUserId());
		return mv;
	}
}
