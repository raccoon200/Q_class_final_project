package com.kh.ok.member.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import com.kh.ok.member.model.service.MemberService;
import com.kh.ok.member.model.vo.Member;

@SessionAttributes({"memberLoggedIn"})
@Controller
public class MemberController {
	private Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	
	@RequestMapping("/member/memberEnroll.do")
	public ModelAndView memberEnroll() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	
	@RequestMapping("/member/memberLogin.do")
	public ModelAndView memberLogin(@RequestParam String userId, @RequestParam String password) {
		ModelAndView mav = new ModelAndView();
		Member m = memberService.selectUserId(userId);
		
		String msg = "";
		String loc = "/";
		if(m==null) {
			msg="존재하지 않는 아이디입니다";
		}else {
			if(bcryptPasswordEncoder.matches(password, m.getPassword())) {
				msg="로그인 성공";
				/*logger.debug("["+userId+"]이 로그인 함.");*/
				
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
	@RequestMapping("/member/memberLogout.do")
	public String memerLogout(SessionStatus sessionStatus) {
		if(logger.isDebugEnabled())
			logger.debug("로그아웃 요청");
		//현재 session상태를 끝났다고 마킹함.
		if(!sessionStatus.isComplete())
			sessionStatus.setComplete();
		return "redirect:/";
	}
}
