package com.kh.ok.breakTime.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


import com.kh.ok.breakTime.controller.model.service.BreakService;

@Controller
public class BreakController {
	@Autowired
	BreakService breakService;
	
	@RequestMapping("/break/myBreak")
	public String myBreak() {
	
		
	
		
		return "break/myBreak";
	}
	
	
}
