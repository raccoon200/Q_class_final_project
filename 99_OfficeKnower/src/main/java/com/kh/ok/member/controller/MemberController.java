package com.kh.ok.member.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MemberController {
	
	@RequestMapping("/member/memberEnroll.do")
	public ModelAndView memberEnroll() {
		ModelAndView mav = new ModelAndView();
		
		return mav;		
	}
}
