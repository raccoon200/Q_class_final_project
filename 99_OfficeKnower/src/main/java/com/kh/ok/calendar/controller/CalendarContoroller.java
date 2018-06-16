package com.kh.ok.calendar.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.ok.calendar.model.service.CalendarService;
import com.kh.ok.calendar.model.vo.Schedule;
import com.kh.ok.member.model.vo.Member;

@Controller
public class CalendarContoroller {

	@Autowired
	private CalendarService calendarService;
	
	@RequestMapping("/cal/cal.do")
	public String demo() {
		
		return"calendar/calendarView";
	}
	
	@RequestMapping("/cal/calTest.do")
	public String scheduleList(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		String userId = null;
		if(session != null && session.getAttribute("memberLoggedIn") != null) {
			 userId = ((Member)session.getAttribute("memberLoggedIn")).getUserId();	
		}
		
		List<Schedule> list = calendarService.selectSechedule(userId);
		model.addAttribute("list",list);
		model.addAttribute("memberLoggedIn",(Member)session.getAttribute("memberLoggedIn"));
		
		System.out.println("list@controller" + list);
		return "calendar/calendarView";
	}
}
