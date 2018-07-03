package com.kh.ok.reservation.controller;

import static org.hamcrest.CoreMatchers.instanceOf;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.annotation.JsonCreator.Mode;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
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
		List<Reservation> listN = reservationService.reservationListPageN(userId);
		List<Resources> resources =  reservationService.selectResources(com_no);
		List<Map<String, String>> category = reservationService.selectCategory(com_no);
	//	System.out.println(list);
	//	System.out.println(resources);
//		System.out.println(category);
//		System.out.println(listN);
		mav.addObject("list", list);
		mav.addObject("listN", listN);
		mav.addObject("resources", resources);
		mav.addObject("category", category);
		return mav;
	}
	@RequestMapping("/reservation/reservationEnroll")
	public ModelAndView reservationEnroll(HttpServletRequest request, Reservation reservation) {
		ModelAndView mav = new ModelAndView();
		
		//작성자, 회사번호 가져오기
		HttpSession session = request.getSession(false);
		Member member = (Member)session.getAttribute("memberLoggedIn");
		String userId = member.getUserId();
		String com_no = member.getCom_no();
		//시작 종료 날짜구하기
		String start = request.getParameter("start");
		String end = request.getParameter("end");
		String date = reservation.getStartdate();
		reservation.setStartdate(date+" "+start);
		reservation.setQuitdate(date+" "+end);
		reservation.setWriter(userId);
		reservation.setCom_no(com_no);
		String[] res = reservation.getRes_name().split("\\*");
		reservation.setCategory(res[0]);
		reservation.setRes_no(Integer.parseInt(res[1]));
		reservation.setRes_name(res[2]);
		reservation.setQuit_status("");
		reservation.setPhoto("photo.jpg");
		System.out.println(reservation);
		int result = reservationService.reservationEnroll(reservation);
		String msg = result>0?"예약 신청완료":"예약 실패";
		String loc = "/reservation/reservationListPage";
		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		mav.setViewName("common/msg");
		return mav;
	}
	
	@RequestMapping(value="/reservation/selectOneReservationNo.do", produces = "application/json; charset=utf8")
	@ResponseBody
	public String selectOneReservationNo(int reservationNo) throws JsonProcessingException{
		Reservation reservation = reservationService.selectOneReservationNo(reservationNo);
		ObjectMapper mapper = new ObjectMapper();
		String jsonStr = mapper.writeValueAsString(reservation);
		return jsonStr;
	}
	
	@RequestMapping("/reservation/reservationDeleteOne")
	public ModelAndView reservationDeleteOne(int reservation_no, String flag) {
		int result = reservationService.reservationDeleteOne(reservation_no);
		ModelAndView mav = new ModelAndView();
		String msg = result>0?"취소완료":"취소실패";
		String loc = "/reservation/reservationListPage";
		if(("승인").equals(flag) || ("반려").equals(flag)) {
			loc = "/reservation/reservationApprovalManagement";
		} 
		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		mav.setViewName("common/msg");
		return mav;
	}
	@RequestMapping("reservation/reservationReturn")
	public ModelAndView reservationReturn(int reservation_no) {
		ModelAndView mav = new ModelAndView();
		int result = reservationService.reservationReturn(reservation_no);
		String msg = result>0?"반납완료":"반납실패";
		String loc = "/reservation/reservationListPage";
		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		mav.setViewName("common/msg");
		return mav;
	}
	
	@RequestMapping("/reservation/reservationApprovalManagement")
	public ModelAndView reservationApprovalManagement(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		ModelAndView mav = new ModelAndView();
		Member member = (Member)session.getAttribute("memberLoggedIn");
		String userId = member.getUserId();
		List<Reservation> listNull = reservationService.reservationApprovalNull();
		List<Reservation> list = reservationService.reservationApprovalYes();
		List<Reservation> listN = reservationService.reservationApprovalNo();
		mav.addObject("list", list);
		mav.addObject("listN", listN);
		mav.addObject("listNull", listNull);
		return mav;
	}
	
	@RequestMapping("/reservation/reservationYesClick")
	public ModelAndView reservationYesClick(int reservation_no) {
		ModelAndView mav = new ModelAndView();
		int result = reservationService.reservationApprovalSetYes(reservation_no);
		String msg = result>0?"승인완료":"승인실패";
		String loc = "/reservation/reservationApprovalManagement";
		
		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		mav.setViewName("common/msg");
		return mav;
	}
	
	@RequestMapping("/reservation/reservationNotClick")
	public ModelAndView reservationNotClick(int reservation_no) {
		ModelAndView mav = new ModelAndView();
		int result = reservationService.reservationApprovalSetNot(reservation_no);
		String msg = result>0?"반려완료":"반려실패";
		String loc = "/reservation/reservationApprovalManagement";
		
		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		mav.setViewName("common/msg");
		return mav;
	}
	
	@RequestMapping("/reservation/reservationReturnManagement")
	public ModelAndView reservationReturnManagement() {
		ModelAndView mav = new ModelAndView();
		List<Reservation> returnListN = reservationService.selectReturnListN();
		List<Reservation> returnListY = reservationService.selectReturnListY();
		
		mav.addObject("returnListN", returnListN);
		mav.addObject("returnListY", returnListY);
		
		return mav;
	}
	
	@RequestMapping("/reservation/reservationReturnClick")
	public ModelAndView reservationReturnClick(int reservation_no) {
		ModelAndView mav = new ModelAndView();
		int result = reservationService.reservationQuitStatusSetYes(reservation_no);
		String msg = result>0?"반납 확인":"반납 확인 실패";
		String loc = "/reservation/reservationReturnManagement";
		
		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		mav.setViewName("common/msg");

		return mav;
	}
}
