package com.kh.ok.calendar.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.ok.calendar.model.service.CalendarService;

@Controller
public class CalendarContoroller {

	@Autowired
	private CalendarService calendarService;
	
	@RequestMapping("/cal/cal.do")
	public String demo() {
		
		return"calendar/calendarView";
	}
}
