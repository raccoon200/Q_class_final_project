package com.kh.ok.breakTime.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.ok.breakTime.model.service.BreakService;
import com.kh.ok.breakTime.model.vo.Break;
import com.kh.ok.member.model.vo.Member;

@Controller
public class BreakController {
	@Autowired
	BreakService breakService;
	
	@RequestMapping("/break/myBreak")
	public String myBreak(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		String userId = null;
		String comId = null;
		if(session != null && session.getAttribute("memberLoggedIn") != null) {
			 userId = ((Member)session.getAttribute("memberLoggedIn")).getUserId();	
			 comId = ((Member)session.getAttribute("memberLoggedIn")).getCom_no();
		}
		
		List<Break> myBreak = breakService.selectMyBreak(userId);
		List<Map<String,String>> breaklist = breakService.selectBreakList(comId);
		
		System.out.println("breakList=" + breaklist);
		System.out.println("myBreak@myBreak =" + myBreak);
	   
		model.addAttribute("myBreak",myBreak);
		model.addAttribute("breaklist",breaklist);
		
		return "break/myBreak";
	}
	
	@RequestMapping("/break/breakCreate.do")
	public String breakCreate() {
		
		
		return "break/breakCreate";
	}
	
	@RequestMapping("/break/searchMember.do")
	@ResponseBody
	public String searchMember(HttpServletRequest request) {
		String enrolldate1 = request.getParameter("enrolldate1");
		String enrolldate2 = request.getParameter("enrolldate2");
		String name_com = request.getParameter("name_com");
		
		System.out.println("enrolldate1" + enrolldate1);
		System.out.println("enrolldate2" + enrolldate2);
		System.out.println("name_com" + name_com);
		
		
		
		return "break/breakCreate";
	}
}
