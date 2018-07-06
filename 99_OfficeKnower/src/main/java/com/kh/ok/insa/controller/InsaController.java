package com.kh.ok.insa.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.kh.ok.approval.model.vo.Dept;
import com.kh.ok.breakTime.model.service.BreakService;
import com.kh.ok.insa.model.service.InsaService;
import com.kh.ok.insa.model.vo.Position;
import com.kh.ok.job.model.service.JobService;
import com.kh.ok.job.model.vo.Job;
import com.kh.ok.member.model.vo.Member;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

//희운
@SessionAttributes({"personBreak", "memberLoggedIn"})
/*@SessionAttributes({"memberLoggedIn"})*/
@Controller
public class InsaController {
	@Autowired
	private InsaService insaService;
	
	@Autowired
	private JobService jobService;
	
	@Autowired
	BreakService breakService;
	
	@RequestMapping("/insa/memberListAll.do")
	public ModelAndView memberListAll(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		Member m = null;
		if(request.getSession(false) != null);
			m = (Member)request.getSession().getAttribute("memberLoggedIn");
		List<Member> list =  insaService.memberListAll(m.getCom_no());
		List<String> yearList = insaService.yearListGroup(m.getCom_no());
		List<String> positionList = insaService.positionListGroup(m.getCom_no());
		List<Dept> dlist = insaService.selectDeptList(m.getCom_no());
		//희운 시작
			HttpSession session = request.getSession(false);
			String userId = ((Member)request.getSession().getAttribute("memberLoggedIn")).getUserId();
			
			List<Map<String,String>> personBreak = breakService.personBreak(userId);
			System.out.println("인사에서 personBreak" + personBreak);
			mav.addObject("personBreak",personBreak);
		//희운 끝
	
		
		for(int i =0; i<list.size(); i++) {
			if(list.get(i).getPosition() == null)
				list.get(i).setPosition("미기재");
		}
//		System.out.println(list);
//		System.out.println(yearList);
//		System.out.println(positionList);
		
		mav.addObject("dlist",dlist);
		mav.addObject("list",list);
		mav.addObject("yearList",yearList);
		mav.addObject("positionList",positionList);
		mav.setViewName("insa/memberListAll");
		
		return mav;
	}
	
	@RequestMapping("/insa/profileUpdate.do")
	public String profileUpdate(@RequestParam(value="photoUpload", required = false) MultipartFile photoUpload, HttpServletRequest request) {
		String saveDirectory = request.getSession().getServletContext().getRealPath("/resources/upload/member");
		String originalFileName = photoUpload.getOriginalFilename();
		String ext = originalFileName.substring(originalFileName.lastIndexOf(".")+1);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
		int rndNum = (int)(Math.random()*1000);
		String renamedFileName = sdf.format(new Date(System.currentTimeMillis()))+"_"+rndNum+"."+ext;
		try {
			photoUpload.transferTo(new File(saveDirectory+"/"+renamedFileName));
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		Member m = (Member)request.getSession().getAttribute("memberLoggedIn");
		m.setPhoto(renamedFileName);
		
		int result = insaService.profileUpdate(m);
		
		return "redirect:/insa/memberListAll.do";
	}
	
	@RequestMapping("/insa/memberManagement.do")
	public ModelAndView memberManagement(@RequestParam(value="cPage", required=false, defaultValue="1") int cPage,HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		
		int numPerPage = 10;
		
		Member m = null;
		if(request.getSession(false) != null);
		m = (Member)request.getSession().getAttribute("memberLoggedIn");

		List<Member> list =  insaService.selectmemberListAll(m.getCom_no(), numPerPage, cPage);
//		System.out.println("list="+list);
		int boardCnt = insaService.selectMemberListCnt(m.getCom_no());
//		System.out.println("boardCnt="+boardCnt);
		int totalPage = (int)(Math.ceil(boardCnt/(double)numPerPage));
		
		String pageBar ="";
		int pageBarSize = 5;
		
		int pageNo = (cPage-1)/pageBarSize*pageBarSize+1;
		
		int pageEnd = pageNo+pageBarSize-1;
		
		if(pageNo == 1) {
			
		} else {
			pageBar += "<a href= '"+request.getContextPath()+"/insa/memberManagement.do?cPage="+(pageNo-1)+"'><span class='page gradient'>이전</span></a>";
		}
		//[pageNo]
		while(pageNo <= pageEnd && pageNo <= totalPage){
			if(pageNo==cPage) {
				pageBar += "<span class='page active'>"+pageNo+"</span>";				
			}else {
				pageBar+="<a href='"+request.getContextPath()+"/insa/memberManagement.do?cPage="+pageNo+"'><span class='page gradient'>"+pageNo+"</span></a>";	
			}
			pageNo++;
		}
		//[다음]
		if(pageNo > totalPage) {
			
		}else {
			pageBar += "<a href= '"+request.getContextPath()+"/insa/memberManagement.do?cPage="+(pageNo)+"'><span class='page gradient'>다음</span></a>";
		}
		mav.addObject("list", list);
		mav.addObject("cPage", cPage);
		mav.addObject("boardCnt", boardCnt);
		mav.addObject("numPerPage", numPerPage);
		mav.addObject("pageBar", pageBar);
		mav.addObject("boardCnt",boardCnt);

		List<String> yearList = insaService.yearListGroup(m.getCom_no());
		List<String> positionList = insaService.positionListGroup(m.getCom_no());
		
		List<Job> jlist = jobService.selectJobList(m.getCom_no());
		List<Position> plist = insaService.selectPositionList(m.getCom_no());
		List<Dept> dlist = insaService.selectDeptList(m.getCom_no());
		
		mav.addObject("jlist",jlist);
		mav.addObject("plist",plist);
		mav.addObject("dlist",dlist);
		mav.addObject("yearList",yearList);
		mav.addObject("positionList",positionList);
		mav.setViewName("insa/insaMemberManagement");
		return mav;
	}
	
	// search
	@RequestMapping("/insa/insaSelectMemberSearch.do")
	public ModelAndView insaSelectMemberSearch(@RequestParam(value="cPage", required=false, defaultValue="1") int cPage,
												@RequestParam(value="searchKey") String searchKey,
												HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		int numPerPage = 10;
		
		Member m = null;
		if(request.getSession(false) != null);
		m = (Member)request.getSession().getAttribute("memberLoggedIn");

		Map<String,String> map = new HashMap<String,String>();
		map.put("searchKey", searchKey);
		map.put("com_no", m.getCom_no());

		List<Member> list =  insaService.insaSelectMemberSearch(m.getCom_no(), numPerPage, cPage, map);
		System.out.println("list="+list);
		
		int boardCnt = insaService.selectSelectMemberListCnt(map);
		System.out.println("boardCnt="+boardCnt);
		int totalPage = (int)(Math.ceil(boardCnt/(double)numPerPage));
		
		String pageBar ="";
		int pageBarSize = 5;
		
		int pageNo = (cPage-1)/pageBarSize*pageBarSize+1;
		
		int pageEnd = pageNo+pageBarSize-1;
		
		if(pageNo == 1) {
			
		} else {
			pageBar += "<a href= '"+request.getContextPath()+"/insa/memberManagement.do?cPage="+(pageNo-1)+"'><span class='page gradient'>이전</span></a>";
		}
		//[pageNo]
		while(pageNo <= pageEnd && pageNo <= totalPage){
			if(pageNo==cPage) {
				pageBar += "<span class='page active'>"+pageNo+"</span>";				
			}else {
				pageBar+="<a href='"+request.getContextPath()+"/insa/memberManagement.do?cPage="+pageNo+"'><span class='page gradient'>"+pageNo+"</span></a>";	
			}
			pageNo++;
		}
		//[다음]
		if(pageNo > totalPage) {
			
		}else {
			pageBar += "<a href= '"+request.getContextPath()+"/insa/memberManagement.do?cPage="+(pageNo)+"'><span class='page gradient'>다음</span></a>";
		}
		mav.addObject("list", list);
		mav.addObject("cPage", cPage);
		mav.addObject("boardCnt", boardCnt);
		mav.addObject("numPerPage", numPerPage);
		mav.addObject("pageBar", pageBar);
		mav.addObject("boardCnt",boardCnt);
		mav.addObject("searchKey",searchKey);
		
		List<String> yearList = insaService.yearListGroup(m.getCom_no());
		List<String> positionList = insaService.positionListGroup(m.getCom_no());
		
		mav.addObject("yearList",yearList);
		mav.addObject("positionList",positionList);
		mav.setViewName("insa/insaMemberManagement");
		return mav;
	}
	
	@RequestMapping("/insa/insaMemberSearch.do")
	@ResponseBody
	public List<Member> insaMemberSearch(@RequestParam("searchKey") String searchKey,
				HttpServletRequest request) throws JsonProcessingException {
		Member m = null;
		if(request.getSession(false) != null);
		m = (Member)request.getSession().getAttribute("memberLoggedIn");
		
		Map<String,String> map = new HashMap<String,String>();
		map.put("searchKey", searchKey);
		map.put("com_no", m.getCom_no());
		System.out.println(map.get("com_no"));
		System.out.println(map.get("searchKey"));
		
		List<Member> list = new ArrayList<Member>();	
		
		list = insaService.insaMemberSearch(map);
		
		return list;
	}
	
	@RequestMapping("/insa/insaNewMemberSearch.do")
	@ResponseBody
	public Map<String, Object> insaNewMemberSearch(@RequestParam("searchKey") String searchKey,
			HttpServletRequest request) throws JsonProcessingException {
		Map<String,String> map = new HashMap<String,String>();
		map.put("searchKey", searchKey);
		System.out.println(map.get("searchKey"));
		boolean searchchk = false;
		
		List<Member> list = new ArrayList<Member>();
		
		list = insaService.insaNewMemberSearch(map);
		
		for(int i =0; i< list.size(); i++) {
			if((list.get(i).getUserId()).equals(searchKey)) {
				searchchk = true;
				break;
			}
		}
		
		Map<String, Object> m = new HashMap<String, Object>();
		m.put("list", list);
		m.put("searchchk", searchchk);
		
		return m;
	}
	
	@RequestMapping("/insa/memberSelectManagement.do")
	public ModelAndView memberSelectManagement(@RequestParam("userId") String userId) {
		ModelAndView mav = new ModelAndView();
		
		Member member = insaService.memberSelectManagement(userId);
		List<Job> jlist = jobService.selectJobList(member.getCom_no());
		List<Position> plist = insaService.selectPositionList(member.getCom_no());
		List<Dept> dlist = insaService.selectDeptList(member.getCom_no());
		
		mav.addObject("member",member);
		mav.addObject("jlist",jlist);
		mav.addObject("plist",plist);
		mav.addObject("dlist",dlist);
		mav.setViewName("insa/insaMemberOneManagement");
		
		return mav;
	}
	
	@RequestMapping("/insa/checkIdDuplicate.do")
	@ResponseBody
	public Map<String,Object> checkIdDuplicate(@RequestParam("empNo") String empNo
						,@RequestParam("comNo") String comNo) throws JsonProcessingException {
		Map<String,Object> map = new HashMap<String,Object>();
		
		Map<String,String> no = new HashMap<String,String>();
		no.put("empNo", empNo);
		no.put("comNo", comNo);
		
		// 업무로직
		int count = insaService.checkIdDuplicate(no);
		System.out.println(count);
		boolean isUsable = count == 0 ? true:false;
		
		map.put("isUsable", isUsable);
		return map;
	}

	@RequestMapping("/insa/positioncheckIdDuplicate.do")
	@ResponseBody
	public Map<String,Object> positioncheckIdDuplicate(@RequestParam("newPosition") String newPosition
			,@RequestParam("comNo") String comNo) throws JsonProcessingException {
		
		List<Position> plist = insaService.selectPositionList(comNo);
		Map<String,Object> map = new HashMap<String,Object>();
		
		int count = 0; 
		// 업무로직
		for(int i =0; i < plist.size(); i++) {
			if((plist.get(i).getPosition()).equals(newPosition)) {
				count = 1;
			}
		}
		boolean isUsable = count == 0 ? true:false;
		
		map.put("isUsable", isUsable);
		return map;
	}
	@RequestMapping("/insa/positioncheckListDuplicate.do")
	@ResponseBody
	public Map<String,Object> positioncheckListDuplicate(@RequestParam("position") String position
			,@RequestParam("comNo") String comNo, HttpServletRequest request) throws JsonProcessingException {
		
		Member m = (Member)request.getSession().getAttribute("memberLoggedIn");
		List<Member> list =  insaService.memberListAll(m.getCom_no());
		List<String> selectmlist = new ArrayList<String>();
		
		Map<String,Object> map = new HashMap<String,Object>();
		boolean listEmpty = false;
		for(int i =0; i<list.size(); i++) {
			if((list.get(i).getPosition() != null?list.get(i).getPosition():"").equals(position)) {
				listEmpty = true;
				selectmlist.add(list.get(i).getUserId());
			}
		}
		
		map.put("userId", selectmlist);
		map.put("listEmpty", listEmpty);
		int count = 0; 

		boolean isUsable = count == 0 ? true:false;
		map.put("isUsable", isUsable);
		return map;
	}
	
	@RequestMapping("/insa/insaMemberOneUpdate.do")
	public String insaMemberOneUpdate(Member member) {
		ModelAndView mav = new ModelAndView();

		int result = insaService.insaMemberOneUpdate(member);
		
		return "redirect:/insa/memberSelectManagement.do?userId="+member.getUserId();
	}
	
	@RequestMapping("/insa/updatePositionModal.do")
	public String updatePositionModal(@RequestParam(value="position", required=false, defaultValue="") String position,
			@RequestParam(value="job", required=false, defaultValue="") String job,
			@RequestParam(value="comNo", required=false, defaultValue="") String comNo,
			@RequestParam(value="level", required=false, defaultValue="") int level,
			@RequestParam(value="updateType", required=false, defaultValue="") String updateType,
				HttpServletRequest request) {
		Map<String,Object> map = new HashMap<String,Object>();
		System.out.println(position);
		System.out.println(comNo);
		System.out.println(level);
		
		map.put("position", position);
		map.put("comNo", comNo);
		map.put("level", level);
		
		int result = insaService.updatePositionModal(map);
		
		return "redirect:/insa/positionManagement.do";
	}
	@RequestMapping("/insa/positionDeleteModal.do")
	public String positionDeleteModal(@RequestParam(value="selectposition", required=false) String position,
			@RequestParam(value="userId", required=false, defaultValue="") String[] userId,
			@RequestParam(value="com_no", required=false, defaultValue="") String com_no,
			@RequestParam(value="s_position", required=false, defaultValue="") String s_position,
			HttpServletRequest request) {
		List<Member> list = new ArrayList<Member>();
		list = insaService.insaMemberList(com_no);
		
		String[] userID = new String[list.size()];
		
		for(int i =0; i<list.size();i++) {
			userID[i] = list.get(i).getUserId();
		}
		
		Map<String,Object> map = new HashMap<String,Object>();
		position = (position == null) ?"변경 직위 ":position;
		
		for(int i = 0; i<userId.length; i++)
			System.out.println("userId="+userId[i]);
		System.out.println("position="+position);  // 선택한값
		System.out.println("com_no="+com_no);
		System.out.println("s_position="+s_position); // 기존에 값
		
		int result =0;
		map.put("userId", userID);
		map.put("com_no", com_no);
		map.put("position", position);
		map.put("s_position", s_position);
		
		if(position.equals("변경 직위 ")) {
			result = insaService.insaPositionDelete(map);
		}else if(position.equals(s_position)) {
			
		}else if(!position.equals("변경 직위 ")) {
			result = insaService.insaPositionUpdate(map);
			result = insaService.insaPositionDelete(map);
		}
		
		map.put("position", position);
		
//		int result = insaService.updatePositionModal(map);
		
		return "redirect:/insa/positionManagement.do";
	}

	@RequestMapping("/insa/insaMemberDelete.do")
	public String insaMemberDelete(@RequestParam(value="position", required=false, defaultValue="") String position,
			@RequestParam(value="job", required=false, defaultValue="") String job,
			@RequestParam(value="status", required=false, defaultValue="") String status,
			@RequestParam(value="userId", required=false, defaultValue="") String[] userId,
			@RequestParam(value="updateType", required=false, defaultValue="delete") String updateType,
			HttpServletRequest request) {
		
		int result = 0;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("position", position);
		map.put("job", job);
		map.put("status", status);
		map.put("userId", userId);
		map.put("updateType", updateType);
		
		switch(updateType) {
		case "position":
			job = ""; status ="";
			result = insaService.insaMemberUpdate(map);
			break;
		case "job":
			position=""; status="";
			result = insaService.insaMemberUpdate(map);
			break;
		case "status":
			position=""; job="";
			result = insaService.insaMemberUpdate(map);
			break;
		case "delete":
			position=""; job=""; status="";
			result = insaService.insaMemberDelete(map);
			break;
		}
		
		return "redirect:/insa/memberManagement.do";
	}

	@RequestMapping("/insa/positionManagement.do")
	@ResponseBody
	public ModelAndView positionManagement(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
			
		Member m = (Member)request.getSession().getAttribute("memberLoggedIn");
		
		// 업무로직
		List<Position> plist = insaService.selectPositionList(m.getCom_no());
		List<Job> jlist = jobService.selectJobList(m.getCom_no());
		List<Member> list =  insaService.memberListAll(m.getCom_no());
		
		mav.addObject("plist", plist);
		mav.addObject("jlist", jlist);
		mav.addObject("member",m);
		mav.addObject("list",list);
		
		mav.setViewName("insa/insaPositionJobManagement");
		return mav;
	}

	@RequestMapping("/insa/insaPositionAdd.do")
	public String insaPositionAdd(
			@RequestParam(value="position", required=false, defaultValue="") String[] position
								
								,HttpServletRequest request) {
		Member m = (Member)request.getSession().getAttribute("memberLoggedIn");
		
//			System.out.println("포지션 : "+position[position.length-1]);
		System.out.println("포지션 = " + position.length);
		Map<String,Object> map = new HashMap<>();
		map.put("position", position[position.length-1]);
		map.put("com_no", m.getCom_no());
		map.put("level", position.length);
		
//		System.out.println(position.length);
		
		int result = 0;
		
		if(!position[position.length-1].isEmpty()) {
			result = insaService.positionInsert(map);
		}
		
		return "redirect:/insa/positionManagement.do";
	}

	@RequestMapping("/insa/insaJobAdd.do")
	public String insaJobAdd(
			@RequestParam(value="job", required=false, defaultValue="") String[] job
			,HttpServletRequest request) {
		Member m = (Member)request.getSession().getAttribute("memberLoggedIn");
		Map<String,String> map = new HashMap<String,String>();
		map.put("job", job[job.length-1]);
		map.put("com_no", m.getCom_no());
		
//		System.out.println( m.getCom_no());
//		System.out.println(map.get("job"));
		int result = insaService.insaJobInsert(map);
		
		return "redirect:/insa/positionManagement.do";
	}
	
	@RequestMapping("/insa/jobDeleteModal.do")
	public String jobDeleteModal(
			@RequestParam(value="job", required=false, defaultValue="") String job,
			@RequestParam(value="selectjob", required=false, defaultValue="") String selectjob,			
			HttpServletRequest request) {
		Member m = (Member)request.getSession().getAttribute("memberLoggedIn");
		Map<String,String> map = new HashMap<String,String>();
		map.put("job", job);
		map.put("com_no", m.getCom_no());
		map.put("selectjob", selectjob);
		
		System.out.println("selectjob="+selectjob);  // 삭제할 값
		System.out.println("job="+job);				// 옮길값
		
		int result = 0;
		
		if(!job.equals("")) {
			result = insaService.insaMemberJobUpdate(map);
		}
		
		result = insaService.insaJobDelete(map);
		
		return "redirect:/insa/positionManagement.do";
	}
	
	@RequestMapping("/insa/updateJobModal.do")
	public String updateJobModal(
			@RequestParam(value="job", required=false, defaultValue="") String job,
			@RequestParam(value="selectjob", required=false, defaultValue="") String selectjob
			,HttpServletRequest request) {
		Member m = (Member)request.getSession().getAttribute("memberLoggedIn");
		Map<String,String> map = new HashMap<String,String>();
		map.put("selectjob", selectjob);
		map.put("job", job);
		map.put("com_no", m.getCom_no());

		int result = insaService.insaJobUpdate(map);
		
		return "redirect:/insa/positionManagement.do";
	}
	
	@RequestMapping("/insa/insaManagement.do")
	@ResponseBody
	public ModelAndView insaManagement(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
			
		Member m = (Member)request.getSession().getAttribute("memberLoggedIn");
		
		// 업무로직
		List<Member> list =  insaService.memberListAll(m.getCom_no());
		
		mav.addObject("list",list);
		
		mav.setViewName("insa/insaManagement");
		return mav;
	}
	
	@RequestMapping("/insa/searchAdmin")
	@ResponseBody
	public JSONArray searchAdmin(@RequestParam String userName, HttpSession session) {
		Member member = (Member)session.getAttribute("memberLoggedIn");
		member.setUserName('%'+userName+'%');
		List<Map<String,String>> userList = insaService.insaselectAdmin(member);
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
	
	@RequestMapping("/insa/adminInsertEnd.do")
	public ModelAndView insertAdmin(@RequestParam String userId,
			@RequestParam(value="grade", required=false, defaultValue="")String grade) {
		ModelAndView mav = new ModelAndView();
		
		Member m = insaService.memberSelectManagement(userId);
		
			m.setGrade("인사관리자");
//		System.out.println("grade="+grade);
//		System.out.println("userId="+userId);
		int result = insaService.insaadminInsert(m);
		
		String loc = "/";
		String msg = "";

		if (result > 0) {
			msg = "인사 관리자 추가 성공";
			loc = "/insa/insaManagement.do";
		} else
			msg = "인사 관리자 삭제 실패";
		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		mav.setViewName("common/msg");
		return mav;
	}
	@RequestMapping("/insa/adminDeleteEnd.do")
	public ModelAndView adminDeleteEnd(@RequestParam String userId) {
		ModelAndView mav = new ModelAndView();
		
		Member m = insaService.memberSelectManagement(userId);
		System.out.println("실행하니?");
		m.setGrade("");
		int result = insaService.insaadminInsert(m);
		
		String loc = "/";
		String msg = "";
		
		if (result > 0) {
			msg = "인사 관리자 삭제 성공";
			loc = "/insa/insaManagement.do";
		} else
			msg = "인사 관리자 삭제 실패";
		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		mav.setViewName("common/msg");
		return mav;
	}
//	슈퍼관리자
	@RequestMapping("/insa/insaSuperManagement.do")
	public ModelAndView insaSuperManagement(HttpServletRequest request) {
		
		ModelAndView mav = new ModelAndView();
		Member m = (Member)request.getSession().getAttribute("memberLoggedIn");
		// 업무로직
		List<Member> list =  insaService.memberListAll(m.getCom_no());
		
		mav.addObject("list",list);
		
		mav.setViewName("insa/insaSuperManagement");
		return mav;
	}
	@RequestMapping("/insa/adminSuperInsertEnd.do")
	public ModelAndView adminSuperInsertEnd(@RequestParam String userId,
			@RequestParam(value="grade", required=false, defaultValue="")String grade) {
		ModelAndView mav = new ModelAndView();
		
		Member m = insaService.memberSelectManagement(userId);
		
			m.setGrade("슈퍼관리자");
//		System.out.println("grade="+grade);
//		System.out.println("userId="+userId);
		int result = insaService.insaadminInsert(m);
		
		String loc = "/";
		String msg = "";
		
		if (result > 0) {
			msg = "슈퍼 관리자 추가 성공";
			loc = "/insa/insaSuperManagement.do";
		} else
			msg = "슈퍼 관리자 삭제 실패";
		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		mav.setViewName("common/msg");
		return mav;
	}
	@RequestMapping("/insa/adminSuperDeleteEnd.do")
	public ModelAndView adminSuperDeleteEnd(@RequestParam String userId) {
		ModelAndView mav = new ModelAndView();
		
		Member m = insaService.memberSelectManagement(userId);
		
		m.setGrade("1");
		int result = insaService.insaadminInsert(m);
		
		String loc = "/";
		String msg = "";
		
		if (result > 0) {
			msg = "슈퍼 관리자 삭제 성공";
			loc = "/insa/insaSuperManagement.do";
		} else
			msg = "슈퍼 관리자 삭제 실패";
		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		mav.setViewName("common/msg");
		return mav;
	}
	/*@RequestMapping("/insa/newMemberAdminAdd.do")
	public ModelAndView newMemberAdminAdd(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("/insa/newMemberAdminAdd");
		return mav;
	}*/
	
	@RequestMapping("/insa/newMemberAdminAddModal.do")
	public String newMemberAdminAddModal(
			@RequestParam(value="searchKey", required=false, defaultValue="") String searchKey,
			HttpServletRequest request) {
		
		Member m = (Member)request.getSession().getAttribute("memberLoggedIn");
		
		Map<String,String> map = new HashMap<String,String>();
		map.put("com_no", m.getCom_no());
		map.put("userId", searchKey);
		
		int result = insaService.insaMemberAddUpdate(map);
		
		return "redirect:/insa/memberManagement.do";
	}
//	조직관리
	@RequestMapping("/insa/deptManagement.do")
	public ModelAndView deptManagement(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("/insa/deptAdminAdd");
		return mav;
	}
	
}
