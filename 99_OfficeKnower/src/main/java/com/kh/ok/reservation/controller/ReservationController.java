package com.kh.ok.reservation.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.ok.member.model.vo.Member;
import com.kh.ok.reservation.model.service.ReservationService;
import com.kh.ok.reservation.model.vo.Reservation;

@Controller
public class ReservationController {
	
	@Autowired
	private ReservationService reservationService;
	
	@RequestMapping("/reservation/reservationListPage")
	public ModelAndView reservationListPage(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		String userId = null;
		if(session != null && session.getAttribute("memberLoggedIn") != null) {
			 userId = ((Member)session.getAttribute("memberLoggedIn")).getUserId();	
		}
		ModelAndView mav = new ModelAndView();
		List<Reservation> list = reservationService.reservationListPage(userId);
		System.out.println(list);
		mav.addObject("list", list);
		return mav;
	}
}
