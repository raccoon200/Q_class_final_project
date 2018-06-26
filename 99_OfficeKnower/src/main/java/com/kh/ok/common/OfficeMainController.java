package com.kh.ok.common;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class OfficeMainController {
	@RequestMapping("/office/office_main.do")
	public ModelAndView showOfficeMain() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("common/office_main");
		return mav;
	}
}
