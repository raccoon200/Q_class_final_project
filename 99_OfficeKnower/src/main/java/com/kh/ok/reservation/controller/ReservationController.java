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

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

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
		reservation.setQuit_status("N");
		reservation.setPhoto("photo.jpg");
		reservation.setApproval_status("N");
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
	public ModelAndView reservationDeleteOne(int reservation_no) {
		int result = reservationService.reservationDeleteOne(reservation_no);
		ModelAndView mav = new ModelAndView();
		String msg = result>0?"취소완료":"취소실패";
		String loc = "/reservation/reservationListPage";
		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		mav.setViewName("common/msg");
		return mav;
	}
	@RequestMapping("/reservation/admin/reservationAdminInsert.do")
	public ModelAndView reservationAdminInsert(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Member m = (Member)session.getAttribute("memberLoggedIn");
		String com_no = m.getCom_no();
		List<Map<String, String>> reservationAdminList = reservationService.selectListAdmin(com_no);
		
		mav.addObject("reservationAdminList", reservationAdminList);
		return mav;
	}
	@RequestMapping("/reservation/admin/reservationAdminDelete.do")
	public ModelAndView reservationAdminDelete(Member member) {
		ModelAndView mav = new ModelAndView();
		String str= "";
		String arr[] = member.getGrade().split(",");
		for(int i=0; i<arr.length; i++) {
			System.out.println(arr[i]);
			
			if(!arr[i].equals("예약관리자")) {
				if(i!=0) {
					str += ",";
				}
				str += arr[i];
			}
		}
		System.out.println(str);
		if(str=="") {
			member.setGrade("");
		}else {
			member.setGrade(str);
		}
		System.out.println(member);
		int result = reservationService.deleteAdmin(member);
	
	
		String loc = "/";
		String msg = "";

		if (result > 0) {
			msg = "예약 관리자 삭제 성공";
			loc = "/reservation/admin/reservationAdminInsert.do";
		} else
			msg = "예약 관리자 삭제 실패";
		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		mav.setViewName("common/msg");
		
		return mav;
	}
	@RequestMapping("/reservation/admin/searchAdmin")
	@ResponseBody
	public JSONArray searchAdmin(@RequestParam String userName, HttpSession session) {
		Member member = (Member)session.getAttribute("memberLoggedIn");
		member.setUserName('%'+userName+'%');
		List<Map<String,String>> userList = reservationService.selectAdmin(member);
		JSONArray jsonArr = new JSONArray();
		for(Map<String,String> m : userList) {
			JSONObject jsonO = new JSONObject();
			jsonO.put("userId", m.get("USERID"));
			jsonO.put("userName", m.get("USERNAME"));
			jsonO.put("emp_no", m.get("EMP_NO"));
			jsonO.put("dept", m.get("DEPT"));
			jsonO.put("grade", m.get("GRADE"));
			jsonO.put("position", m.get("POSITION"));
			jsonArr.add(jsonO);
		}
		
		return jsonArr;
	}
	@RequestMapping("/reservation/admin/adminInsertEnd.do")
	public ModelAndView insertAdmin(@RequestParam String userId) {
		ModelAndView mav = new ModelAndView();
		
		Member m = reservationService.selectMember(userId);
		if(m.getGrade() == null || m.getGrade() == "") {
			m.setGrade("예약관리자");
		}else {
			m.setGrade(",예약관리자");
		}
		int result = reservationService.adminInsert(m);
		
		
		String loc = "/";
		String msg = "";

		if (result > 0) {
			msg = "예약 관리자 추가 성공";
			loc = "/reservation/admin/reservationAdminInsert.do";
		} else
			msg = "예약 관리자 추가 실패";
		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		mav.setViewName("common/msg");
		return mav;
	}
}
