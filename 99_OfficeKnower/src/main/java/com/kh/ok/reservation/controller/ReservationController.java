package com.kh.ok.reservation.controller;

import static org.hamcrest.CoreMatchers.instanceOf;

import java.sql.Time;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.type.IntegerTypeHandler;
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
import com.kh.ok.member.model.service.MemberService;
import com.kh.ok.member.model.vo.Member;
import com.kh.ok.reservation.model.service.ReservationService;
import com.kh.ok.reservation.model.vo.Reservation;
import com.kh.ok.reservation.model.vo.Resources;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@SessionAttributes({"resources", "category"})
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
		List<Map<String, String>> resources =  reservationService.selectResources(com_no);
		List<Map<String, String>> category = reservationService.selectCategory(com_no);	
		
		mav.addObject("list", list);
		mav.addObject("listN", listN);
		mav.addObject("resources", resources);
		mav.addObject("category", category);

		System.out.println("이악"+category);
		return mav;
	}
	@RequestMapping("/reservation/reservationEnroll")
	public ModelAndView reservationEnroll(HttpServletRequest request, Reservation reservation) {
		ModelAndView mav = new ModelAndView();
		Member m = (Member)request.getSession(false).getAttribute("memberLoggedIn");
		reservation.setCom_no(m.getCom_no());
		//날짜
		String date = reservation.getStartdate();
		List<Map<String, String>> dateList = reservationService.selectReservationDateList(reservation.getCom_no());
		List<String> startDateList = new ArrayList<>();
		List<String> startTimeList = new ArrayList<>();
		List<String> quitTimeList = new ArrayList<>();
		System.out.println("디비"+dateList);
		
		for (Map<String, String> map : dateList) {
			if(map.get("STARTDATE").equals(date)) {
			startDateList.add(map.get("STARTDATE"));
			startTimeList.add(map.get("STARTTIME"));
			quitTimeList.add(map.get("QUITTIME"));
			}
		}		
		System.out.println("데"+startDateList);
		System.out.println("타"+startTimeList);
		//종료시간
		String end = request.getParameter("end");
		String[] strArr = end.split(":");
		LocalTime endTime = LocalTime.of(Integer.parseInt(strArr[0]), Integer.parseInt(strArr[1]));
		System.out.println("끝"+endTime);
		//시작 시간
		String start = request.getParameter("start");
		strArr = start.split(":");
		LocalTime startTime = LocalTime.of(Integer.parseInt(strArr[0]), Integer.parseInt(strArr[1]));
		System.out.println("시작"+startTime);
		LocalTime startTimePre = null;
		LocalTime quitTimePre = null;
		
		for (int i=0; i<dateList.size(); i++) {
				String[] startTimePreArr = startTimeList.get(i).split(":");
				String[] quitTimePreArr = quitTimeList.get(i).split(":");
				startTimePre = LocalTime.of(Integer.parseInt(startTimePreArr[0]), Integer.parseInt(startTimePreArr[1]));
				quitTimePre = LocalTime.of(Integer.parseInt(quitTimePreArr[0]), Integer.parseInt(quitTimePreArr[1])); 

				if(endTime.isAfter(startTimePre) && startTime.isBefore(quitTimePre)) {
					System.out.println("걸리냐!!?");
					mav.addObject("msg", "예약중인 시간입니다.");
					mav.addObject("loc", "/reservation/reservationListPage");
					mav.setViewName("common/msg");
					return mav;
				}
			}
				
				
					/*if(startTime.isBefore(quitTimePre)) {
						System.out.println("걸리냐!!?");
						mav.addObject("msg", "예약중인 시간입니다.");
						mav.addObject("loc", "/reservation/reservationListPage");
						mav.setViewName("common/msg");
						return mav;
					}
				System.out.println(startTimePre+""+quitTimePre);*/

				
				
		/*// startTime이 endTime 보다 이전 시간 인지 비교
		System.out.println(startTime.isAfter(endTime));    // true

		// startTime이 endTime 보다 이후 시간 인지 비교
		startTime.isAfter(endTime); // false
*/		
		
		String userId = m.getUserId();
		String com_no = m.getCom_no();
			
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
	public String selectOneReservationNo(@RequestParam(value="reservationNo") int reservationNo) throws JsonProcessingException{
		Reservation reservation = reservationService.selectOneReservationNo(reservationNo);
		ObjectMapper mapper = new ObjectMapper();
		String jsonStr = mapper.writeValueAsString(reservation);
		return jsonStr;
	}
	
	@RequestMapping("/reservation/reservationDeleteOne")
	public ModelAndView reservationDeleteOne(@RequestParam(value="reservation_no") int reservation_no, @RequestParam(value="flag", required=false) String flag) {
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
		if(str=="") {
			member.setGrade("");
		}else {
			member.setGrade(str);
		}
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
	public JSONArray searchAdmin(@RequestParam(value="userName") String userName, HttpSession session) {
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
	public ModelAndView insertAdmin(@RequestParam(value="userId") String userId) {
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
	@RequestMapping("reservation/reservationReturn")
	public ModelAndView reservationReturn(@RequestParam(value="reservation_no") int reservation_no) {
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
	public ModelAndView reservationYesClick(@RequestParam(value="reservation_no") int reservation_no) {
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
	public ModelAndView reservationNotClick(@RequestParam(value="reservation_no") int reservation_no) {
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
	public ModelAndView reservationReturnClick(@RequestParam(value="reservation_no") int reservation_no) {
		ModelAndView mav = new ModelAndView();
		int result = reservationService.reservationQuitStatusSetYes(reservation_no);
		String msg = result>0?"반납 확인":"반납 확인 실패";
		String loc = "/reservation/reservationReturnManagement";
		
		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		mav.setViewName("common/msg");

		return mav;
	}
	
	@RequestMapping("/reservation/reservationCategoryManagement")
	public ModelAndView reservationCategoryManagement(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();		
		HttpSession session = request.getSession(false);
		Member member = (Member)session.getAttribute("memberLoggedIn");
		List<Map<String, String>> list = reservationService.reservationCategoryListCnt(member.getCom_no());
		List<Map<String, String>> resources =  reservationService.selectResources(member.getCom_no());
		List<Map<String, String>> category = reservationService.selectCategory(member.getCom_no());
		mav.addObject("categoryListCnt" ,list);
		mav.addObject("resources", resources);
		mav.addObject("category", category);
		return mav;
	}
	
	@RequestMapping("/reservation/reservationCategoryAdd")
	public ModelAndView reservationCategoryAdd(HttpServletRequest request, @RequestParam(value="category") String category, @RequestParam(value="category_purpose", defaultValue = "미기입") String category_purpose) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession(false);
		Member member = (Member)session.getAttribute("memberLoggedIn");
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("category", category);
		map.put("category_purpose", category_purpose);
		map.put("com_no", member.getCom_no());
		int result = reservationService.reservationCategoryAdd(map);
		String msg = result>0?"추가 성공":"추가 실패";
		String loc = "/reservation/reservationCategoryManagement";
		
		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		mav.setViewName("common/msg");
		return mav;
	}
	
	@RequestMapping("/reservation/reservationCategoryUpdate") 
	public ModelAndView reservationCategoryUpdate(@RequestParam(value="category") String category, @RequestParam(value="category_purpose", defaultValue = "미기입") String category_purpose, @RequestParam(value="category_origin") String category_origin){
		ModelAndView mav = new ModelAndView();
		HashMap<String, String> map = new HashMap<>();
		map.put("category", category);
		map.put("category_purpose", category_purpose);
		map.put("category_origin", category_origin);
		int result = reservationService.reservationCategoryUpdate(map);
		
		String msg = result>0?"수정 성공":"수정 실패";
		String loc = "/reservation/reservationCategoryManagement";
		
		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		mav.setViewName("common/msg");
		return mav;
	}
	
	@RequestMapping("/reservation/reservationCategoryDelete")
	@ResponseBody
	public JSONObject reservationCategoryDelete(@RequestParam(value="category") String category, HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		Member m = (Member)session.getAttribute("memberLoggedIn");
		HashMap<String, String> map = new HashMap<>();
		map.put("com_no", m.getCom_no());
		map.put("category", category);
		int result = reservationService.reservationCategoryDelete(map);
		String msg = result>0?"삭제 성공":"삭제 실패";
		String loc = "/reservation/reservationCategoryManagement";
		JSONObject json = new JSONObject();
		json.put("msg", msg);
		json.put("loc", loc);
		return json;
	}
	
	@RequestMapping("/reservation/reservationResourcesManagement")
	public ModelAndView reservationResourcesManagement(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession(false);
		Member m = (Member)session.getAttribute("memberLoggedIn");
		List<Map<String, String>> resList = reservationService.selectResources(m.getCom_no());
		List<Map<String, String>> cateList = reservationService.selectCategory(m.getCom_no());
		List<Map<String, String>> resources =  reservationService.selectResources(m.getCom_no());
		List<Map<String, String>> category = reservationService.selectCategory(m.getCom_no());
		mav.addObject("resList", resList);
		mav.addObject("cateList", cateList);
		mav.addObject("resources", resources);
		mav.addObject("category", category);
		return mav;
	}
	
	@RequestMapping("/reservation/reservationResourcesAdd")
	public ModelAndView reservationResourcesAdd(@RequestParam(value="com_no") String com_no, @RequestParam(value="resource__name") String resource__name, @RequestParam(value="category") String category) {
		ModelAndView mav = new ModelAndView();
		Resources resources = new Resources();
		resources.setCom_no(com_no);
		resources.setResource__name(resource__name);
		resources.setCategory(category);

		int result = reservationService.reservationResourcesAdd(resources);
		String msg = result>0?"추가 성공":"추가 실패";
		String loc = "/reservation/reservationResourcesManagement";
		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		mav.setViewName("common/msg");
		return mav;
	}
	
	@RequestMapping("/reservation/reservationResourcesUpdate")
	public ModelAndView reservationResourcesUpdate(@RequestParam(value="res_no") int res_no, @RequestParam(value="resource__name") String resource__name, @RequestParam(value="category") String category) {
		ModelAndView mav = new ModelAndView();
		Resources resources = new Resources(res_no, resource__name, category, "1");
		int result = reservationService.reservationResourcesUpdate(resources);
		String msg = result>0?"수정 성공":"수정 실패";
		String loc = "/reservation/reservationResourcesManagement";
		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		mav.setViewName("common/msg");
		return mav;
	}
	
	@RequestMapping("reservation/reservationResourcesDelete")
	public ModelAndView reservationResourcesDelete(@RequestParam(value="res_no") int res_no) {
		ModelAndView mav = new ModelAndView();
		int result = reservationService.reservationResourcesDelete(res_no);
		String msg = result>0?"삭제 성공":"삭제 실패";
		String loc = "/reservation/reservationResourcesManagement";
		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		mav.setViewName("common/msg");
		return mav;
	}
	
	@RequestMapping("reservation/reservationListCategory")
	public ModelAndView reservationListCategory(@RequestParam(value="category") String SelectCategory, HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		ModelAndView mav = new ModelAndView();
		Member m = (Member)session.getAttribute("memberLoggedIn");
		HashMap<String, String> map = new HashMap<>();
		map.put("userId", m.getUserId());
		map.put("category", SelectCategory);
		List<Reservation> CList = reservationService.reservationListCategory(map);
		List<Reservation> CListNull = reservationService.reservationListCategoryNull(map);
		List<Map<String, String>> resources =  reservationService.selectResources(m.getCom_no());
		List<Map<String, String>> category = reservationService.selectCategory(m.getCom_no());

		mav.addObject("CList", CList);
		mav.addObject("CListNull", CListNull);
		mav.addObject("category", category);
		mav.addObject("resources", resources);
		mav.addObject("SelectCategory", SelectCategory);
		return mav;
	}
}
