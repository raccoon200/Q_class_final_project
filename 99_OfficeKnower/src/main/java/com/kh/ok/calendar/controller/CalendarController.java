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
import com.kh.ok.calendar.model.vo.Calendar;
import com.kh.ok.calendar.model.vo.Schedule;
import com.kh.ok.member.model.vo.Member;

@Controller
public class CalendarController {

	@Autowired
	private CalendarService calendarService;
	
	@RequestMapping("/cal/cal.do")
	public String demo() {
		
		return"calendar/test";
	}
	
	@RequestMapping("/cal/calTest.do")
	public String scheduleList(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		String userId = null;
		if(session != null && session.getAttribute("memberLoggedIn") != null) {
			 userId = ((Member)session.getAttribute("memberLoggedIn")).getUserId();	
		}
		
		String calendar_name = request.getParameter("calendar_name");
		System.out.println("calTest@calendar_name" + calendar_name);
		
		Map<String,String> map = new HashMap<String,String>();
		map.put("userId", userId);
		map.put("calendar_name", calendar_name);
		List<Schedule> list = calendarService.selectSechedule(map);
		List<String> clist = calendarService.selectCalendar(userId);
		System.out.println("clist" + clist);
	    
		
		model.addAttribute("list",list);
		model.addAttribute("clist",clist);
		model.addAttribute("memberLoggedIn",(Member)session.getAttribute("memberLoggedIn"));
		
		System.out.println("list@controller" + list);
		return "calendar/calendarView";
	}
	
	
	@RequestMapping("/cal/calcalendar.do")
	public String calendarView(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		String userId = null;
		if(session != null && session.getAttribute("memberLoggedIn") != null) {
			 userId = ((Member)session.getAttribute("memberLoggedIn")).getUserId();	
		}
		
		String calendar_name = request.getParameter("calendar_name");
		System.out.println("calTest@calendar_name" + calendar_name);
		
		Map<String,String> map = new HashMap<String,String>();
		map.put("userId", userId);
		map.put("calendar_name", calendar_name);
		List<Schedule> list = calendarService.calendarView(map);
		

		model.addAttribute("list",list);
		model.addAttribute("memberLoggedIn",(Member)session.getAttribute("memberLoggedIn"));
		
		System.out.println("list@controller" + list);
		return "calendar/calendarView";
		//return "common/nav";
	}
	
	@RequestMapping("/cal/calUpdate")
	public String calUpdate(Model model, HttpServletRequest request) {
		String calendarid = request.getParameter("calendarid");
		String name = request.getParameter("calendar_name");
		String color = request.getParameter("colorSelect");
	    System.out.println("calUpdate" + calendarid);
	    System.out.println("calUpdate" + name);
	    System.out.println("calUpdate" + color);
		
		Map<String,String> map = new HashMap<String,String>();
		map.put("calendarid", calendarid);
		map.put("name", name);
		map.put("color", color);
		
		int result = calendarService.calUpdate(map);
		System.out.println(result);
		return "redirect:/cal/calTest.do";
	}
	
	
	@RequestMapping("/cal/calInsert")
	public String calInsert(Model model, HttpServletRequest request) {
		String calName = request.getParameter("calendar_name");
		String calColor = request.getParameter("colorSelect");
		String calType = request.getParameter("calendarType");
		String userId = request.getParameter("userid");
		System.out.println("calInsert" + calName);
		System.out.println("calInsert" + calColor);
		
		Map<String,String> map = new HashMap<String,String>();
		
		map.put("calName", calName);
		map.put("calColor", calColor);
		map.put("calType", calType);
		map.put("userId", userId);
		int result = calendarService.calInsert(map);
		
		return "redirect:/cal/calTest.do";
	}
	
	@RequestMapping("/cal/caldelete.do")
	public String caldelete(Model model, HttpServletRequest request) {
		String calId = request.getParameter("calid");
		
		int result = calendarService.caldelete(calId);
		System.out.println(result);
		
		return "redirect:/cal/calTest.do";
	}
	

	@RequestMapping("/cal/scheduleInsert")
	public String scheduleInsert(Schedule schedule, Model model) {
		System.out.println("scheduleInsert" + schedule);
		
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
