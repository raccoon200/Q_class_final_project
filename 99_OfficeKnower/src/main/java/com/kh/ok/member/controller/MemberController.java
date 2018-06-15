package com.kh.ok.member.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.ok.member.model.service.MemberService;
import com.kh.ok.member.model.vo.Member;

//@SessionAttributes({"memberLoggedIn"})
@Controller
public class MemberController {
	//private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private MemberService memberService;
	
	@RequestMapping("/member/memberOneSelect.do")
	public ModelAndView memberOneSelect(@RequestParam String userId) {
		ModelAndView mav = new ModelAndView();
		System.out.println(userId);
		Member m = memberService.memberOneSelect(userId);
		
		mav.addObject("member",m);
		mav.setViewName("member/memberOneView");
		
		return mav;
	}
}
