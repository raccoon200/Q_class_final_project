package com.kh.ok.calendar.controller;



import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
	
	@RequestMapping("/cal/scheduleInsert")
	public String scheduleInsert(Schedule schedule, Model model) {
		System.out.println(schedule);
		
		int result = calendarService.selectInsert(schedule);
		
		System.out.println("result@controller"+result);
		
		return "redirect:/cal/calTest.do";
	}
	
	@RequestMapping("/cal/selectCalendar")
	@ResponseBody
	public Map<String,Object> selectCalendar(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		String userId = null;
		if(session != null && session.getAttribute("memberLoggedIn") != null) {
			 userId = ((Member)session.getAttribute("memberLoggedIn")).getUserId();	
		}
		Map<String,Object> map = new HashMap<String, Object>();
		
		List<String> list = calendarService.selectCalendar(userId);
		System.out.println("map@controller" + list);
		map.put("list",list);
		
		return map;
	}
	
	@RequestMapping("/cal/scheduleDelete")
	public String scheduleDelete(HttpServletRequest request) {
		String sid = request.getParameter("sid");
		System.out.println("sid@controller"+sid);
		
		int result = calendarService.scheduleDelete(sid);
		
		return "redirect:/cal/calTest.do";
	}
	
    @RequestMapping("/cal/scheduleUpdate")
    public String scheduleUpdate(Schedule schedule, Model model) {
    	System.out.println("업데이트용" +schedule);
		
		int result = calendarService.scheduleUpdate(schedule);
		System.out.println("업데이트 result" + result);
    	
    	return "redirect:/cal/calTest.do";
    }
	
	
	
	
}
