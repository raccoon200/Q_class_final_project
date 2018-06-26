package com.kh.ok.reservation.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.kh.ok.member.model.vo.Member;
import com.kh.ok.reservation.model.service.ReservationService;
import com.kh.ok.reservation.model.vo.Reservation;
import com.kh.ok.reservation.model.vo.Resources;

@SessionAttributes({"resources"})
@Controller
public class ReservationController {
	
	@Autowired
	private ReservationService reservationService;
	
	@RequestMapping("/reservation/reservationListPage")
	public ModelAndView reservationListPage(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		Member member = (Member)session.getAttribute("memberLoggedIn");
		String userId = null;
		String com_no = null;
		if(session != null && session.getAttribute("memberLoggedIn") != null) {
			userId = member.getUserId();
			com_no = member.getCom_no();
		}
		ModelAndView mav = new ModelAndView();
		List<Reservation> list = reservationService.reservationListPage(userId);
		List<Resources> resources =  reservationService.selectResources(com_no);
		List<Map<String, String>> category = reservationService.selectCategory(com_no);
		System.out.println(list);
		System.out.println(resources);
		System.out.println(category);
		mav.addObject("list", list);
		mav.addObject("resources", resources);
		mav.addObject("category", category);
		return mav;
	}
}
