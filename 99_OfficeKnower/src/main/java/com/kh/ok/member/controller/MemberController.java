package com.kh.ok.member.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.kh.ok.job.model.service.JobService;
import com.kh.ok.job.model.vo.Job;
import com.kh.ok.member.model.service.MemberService;
import com.kh.ok.member.model.vo.Member;

//@SessionAttributes({"memberLoggedIn"})
@Controller
public class MemberController {
	//private Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private JobService jobService;
	
	//@Autowired	
	//BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@RequestMapping("/member/memberOneSelect.do")
	public ModelAndView memberOneSelect(@RequestParam String userId) {
		ModelAndView mav = new ModelAndView();

		Member member = memberService.selectUserId(userId);
		List<Job> jlist = jobService.selectJobList(member.getCom_no());
		
		mav.addObject("member",member);
		mav.addObject("jlist",jlist);
		mav.setViewName("member/memberOneView");
		
		return mav;
	}
	
	@RequestMapping("/member/memberOneUpdate.do")
	public ModelAndView memberOneUpdate( Member member) {
		ModelAndView mav = new ModelAndView();
		System.out.println(member);
		
		mav.addObject("member",member);
		mav.setViewName("member/memberOneView");
		
		return mav;
	}
	
	@RequestMapping("/member/memberEnroll.do")
	public ModelAndView memberEnroll() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}

	
	/*@RequestMapping("/member/memberLogin.do")
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
				logger.debug("["+userId+"]이 로그인 함.");
				
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
	}*/
}
