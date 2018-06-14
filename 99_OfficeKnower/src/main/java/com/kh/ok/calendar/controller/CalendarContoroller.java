package com.kh.ok.calendar.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.ok.calendar.model.service.CalendarService;
import com.kh.ok.calendar.model.vo.Schedule;

@Controller
public class CalendarContoroller {

	@Autowired
	private CalendarService calendarService;
	
	@RequestMapping("/cal/cal.do")
	public String demo() {
		
		return"calendar/calendarView";
	}
	
	@RequestMapping("/cal/calTest.do")
	public String scheduleList(Model model) {
		List<Schedule> list = calendarService.selectSechedule();
		model.addAttribute("list",list);
		System.out.println("list@controller" + list);
		return "calendar/calendarView";
	}
}
