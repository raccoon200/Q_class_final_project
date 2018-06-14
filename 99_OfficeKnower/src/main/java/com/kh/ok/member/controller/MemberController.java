package com.kh.ok.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.ok.member.model.service.MemberService;
import com.kh.ok.member.model.vo.Member;

@Controller
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	@RequestMapping("/member/memberEnroll.do")
	public ModelAndView memberEnroll() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	
	@RequestMapping("/member/memberLogin.do")
	public ModelAndView memberLogin(@RequestParam String userId, @RequestParam String password) {
		ModelAndView mav = new ModelAndView();
		Member m = memberService.selectOne(userId);
		
		String msg = "";
		String loc = "/";
		if(m==null) {
			msg="존재하지 않는 아이디입니다";
		}else {
			if(bcryptPasswordEncoder.matches(password, m.getPassword())) {
				msg="로그인 성공";
				/*logger.debug("["+userId+"]이 로그인 함.");*/
				//기존 세션 처리
				//session.setAttribute("memberLoggedIn", m);
				mav.addObject("memberLoggedIn",m);
			}else {
				msg="비밀번호가 틀렸습니다.";
			}
		}
		mav.addObject("msg",msg);
		mav.addObject("loc",loc);
		//view단지정
		mav.setViewName("common/msg");
		return mav;
	}
}
