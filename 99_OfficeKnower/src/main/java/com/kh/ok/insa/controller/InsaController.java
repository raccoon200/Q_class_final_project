package com.kh.ok.insa.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.kh.ok.insa.model.service.InsaService;
import com.kh.ok.member.model.vo.Member;

@SessionAttributes({"memberLoggedIn"})
@Controller
public class InsaController {
	@Autowired
	private InsaService insaService;
	
	@RequestMapping("/insa/memberListAll.do")
	public ModelAndView memberListAll(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		Member m = null;
		if(request.getSession(false) != null);
			m = (Member)request.getSession().getAttribute("memberLoggedIn");
		List<Member> list =  insaService.memberListAll(m.getCom_no());
//		System.out.println(list);
		
		mav.addObject("list",list);
		mav.setViewName("insa/memberListAll");
		return mav;
	}
}
