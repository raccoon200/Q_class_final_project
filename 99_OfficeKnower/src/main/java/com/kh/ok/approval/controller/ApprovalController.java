package com.kh.ok.approval.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ApprovalController {
	
	@RequestMapping("/office/approval.do")
	public ModelAndView approvalDagi () {
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("approval/approval_dagi");
		return mav;
	}
}
