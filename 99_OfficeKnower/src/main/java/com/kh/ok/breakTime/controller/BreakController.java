package com.kh.ok.breakTime.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.ok.breakTime.model.service.BreakService;
import com.kh.ok.breakTime.model.vo.Break;
import com.kh.ok.breakTime.model.vo.BreakRequest;
import com.kh.ok.member.model.vo.Member;

@Controller
public class BreakController {
	
	@Autowired
	BreakService breakService;
	
	//test용
	@RequestMapping("/break/test")
	public String test() {
		
		return "break/breakPic";
	}
	//test용
	@RequestMapping("/break/testCal")
	public String test2() {
		
		return "break/testCal";
	}
	
	
	
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
	public Map<String,Object> searchMember(HttpServletRequest request) {
		String enrolldate1 = request.getParameter("enrolldate1");
		String enrolldate2 = request.getParameter("enrolldate2");
		String name_com = request.getParameter("name_com");
		
		HttpSession session = request.getSession(false);
		String comId = null;
		if(session != null && session.getAttribute("memberLoggedIn") != null) {
			 comId = ((Member)session.getAttribute("memberLoggedIn")).getCom_no();
		}
		

		System.out.println("enrolldate1" + enrolldate1);
		System.out.println("enrolldate2" + enrolldate2);
		System.out.println("name_com" + name_com);
		System.out.println("comId" + comId);
		
		
		Map<String,String> map = new HashMap<String,String>();
		Map<String,Object> mlist = new HashMap<String, Object>();
		map.put("enrolldate1",enrolldate1);
		map.put("enrolldate2",enrolldate2);
		map.put("name_com",name_com);
		map.put("comId",comId);
		
		List<Map<String,String>> memberList = breakService.searchMember(map);
		mlist.put("list",memberList);
		System.out.println("memberList=" + memberList);
		
		return mlist;
	}
	
	@RequestMapping("/break/choiceMember.do")
	@ResponseBody
	public Map<String,Object> choiceMember(HttpServletRequest request){
		String[] userid = request.getParameter("userid").split(",");
		for(int i=0; i<userid.length; i++) {
			System.out.println(",가 들어가서 그런가?= " +userid[i]);
		}
		
		
		Map<String,Object> map = new HashMap<String,Object>();
		Map<String,Object> choiceList = new HashMap<String,Object>();
		
		
		List<String> userList = new ArrayList<String>();
		if(userid.length>0) {
			
			for(int i=0; i<userid.length; i++) {
				userList.add(userList.size(), userid[i]);
				System.out.println("userList" + userList);
			}
		}
		map.put("userList", userList);
		
		List<Map<String,String>> memberList = breakService.choiceMember(map);
		choiceList.put("memberList", memberList);
		
		System.out.println("다중" +memberList);
		
		return choiceList;
	}
	
	@RequestMapping("/break/choiceMemberDelete.do")
	@ResponseBody
	public Map<String,Object> choiceMemberDelete(HttpServletRequest request){
		String[] userid = request.getParameter("userid").split(",");
		for(int i=0; i<userid.length; i++) {
			System.out.println(",가 들어가서 그런가?= " +userid[i]);
		}
		String enrolldate1 = request.getParameter("enrolldate1");
		String enrolldate2 = request.getParameter("enrolldate2");
		String name_com = request.getParameter("name_com");
		
		HttpSession session = request.getSession(false);
		String comId = null;
		if(session != null && session.getAttribute("memberLoggedIn") != null) {
			 comId = ((Member)session.getAttribute("memberLoggedIn")).getCom_no();
		}
		
		Map<String,Object> map = new HashMap<String,Object>();
		Map<String,Object> deleteAfterList = new HashMap<String,Object>();
		
		List<String> userList = new ArrayList<String>();
		if(userid.length>0) {
			
			for(int i=0; i<userid.length; i++) {
				userList.add(userList.size(), userid[i]);
				System.out.println("userList" + userList);
			}
		}
		map.put("userList", userList);
		map.put("comId", comId);
		map.put("enrolldate1",enrolldate1);
		map.put("enrolldate2",enrolldate2);
		map.put("name_com",name_com);
		
		List<Map<String,String>> deleteAfterMember = breakService.choiceMemberDelete(map);
		System.out.println("지우고 남은 회원=" + deleteAfterMember);
		deleteAfterList.put("deleteAfterMember", deleteAfterMember);
		
		return deleteAfterList;
	}
	
	@RequestMapping("/break/createReward.do")
	@ResponseBody
	public Map<String,Object> createReward(HttpServletRequest request){
		
		String userid = request.getParameter("userid");
		int regular = Integer.parseInt(request.getParameter("regular"));
		int reward = Integer.parseInt(request.getParameter("reward"));
		String afterReward = request.getParameter("afterReward");
		System.out.println("포상휴가" + userid);
		System.out.println("포상휴가" + regular);
		System.out.println("포상휴가" + reward);
		System.out.println("포상휴가" + afterReward);
		
		Map<String,Object> map = new HashMap<String,Object>();
		Map<String,Object> createReward = new HashMap<String,Object>();
		
		map.put("userid", userid);
		map.put("afterReward", afterReward);
		
		//List<Map<String,String>> afterList = new ArrayList<>();
		
		if(regular==0 && reward==0 ) {
			int Insertresult = breakService.insertReward(map);
			List<Map<String,String>> afterList = breakService.afterInsert(map);
			System.out.println("포상휴가 생성 insert= " +Insertresult);
			
			createReward.put("afterList",afterList);
			
		}else if (regular!=0 || reward!=0) {
			int Updateresult = breakService.updateReward(map);
			List<Map<String,String>> afterList = breakService.afterUpdate(map);
			
			System.out.println("포상휴가 생성 update= " +Updateresult);
			createReward.put("afterList",afterList);
		}

		
		return createReward;
	}
	
	
	@RequestMapping("/break/breakRequest.do")
	public String breakRequest(Model model,HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		String userId = null;
		
		if(session != null && session.getAttribute("memberLoggedIn") != null) {
			 userId = ((Member)session.getAttribute("memberLoggedIn")).getUserId();	
			 
		}
		
		List<Break> myBreak = breakService.selectMyBreak(userId);
		Map<String,String> userInfo= breakService.selectMyInfo(userId);
		System.out.println("userInfo" +userInfo);
		
		model.addAttribute("myBreak",myBreak);
		model.addAttribute("userInfo",userInfo);
		return "break/breakRequest";
	}
	
	
	@RequestMapping("/break/breakInsert.do")
	public ModelAndView breakInesert(BreakRequest breakrequest, @RequestParam(value = "upFile", required = false) MultipartFile upFile, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = request.getSession(false);
		String userId = null;
		String comId = null;
		if(session != null && session.getAttribute("memberLoggedIn") != null) {
			 userId = ((Member)session.getAttribute("memberLoggedIn")).getUserId();	
			 comId = ((Member)session.getAttribute("memberLoggedIn")).getCom_no();
		}
		breakrequest.setUserid(userId);
		breakrequest.setCom_no(comId);
		
		String username[] = request.getParameterValues("appUsername");
		String approvals = "";
		
		System.out.println("길이" +username.length );
		
		int cnt =0;
		for(int i=username.length-1; i>=0; i--) {
			cnt++;
			System.out.println("결재자 이름 이다!!!!!!!!!!!!"+i +username[i]);
			
			if(i==0) {
				approvals += username[i] ;
			}else {
				approvals += username[i]+",";
			}
			System.out.println("i는 뭐지??" + i);
		}
		System.out.println("cnt" +cnt);
		breakrequest.setApprovals(approvals);
		breakrequest.setApproval_status(cnt);
		System.out.println("approvals" + approvals);
		
		
		
		// 1. 파일업로드처리
		String saveDirectory = request.getSession().getServletContext().getRealPath("/resources/upload/break");
		// requet로부터 session을 얻고 여기서 ServletContext()를 받아 절대경로를 받아옴

		/***** MultipartFile을 이용한 파일 업로드 처리로직 시작 *****/
		MultipartFile f = upFile;
		try {
			if (f != null) {
				if (!f.isEmpty()) {
					// 파일명 재생성
					String originalFileName = f.getOriginalFilename();
					String ext = originalFileName.substring(originalFileName.lastIndexOf(".") + 1); // 확장자
					SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
					int rndNum = (int) (Math.random() * 1000);
					String renamedFileName = sdf.format(new Date(System.currentTimeMillis())) + "_" + rndNum + "."
							+ ext;
					try {
						f.transferTo(new File(saveDirectory + "/" + renamedFileName)); // 실제 서버에 파일을 저장하는 코드
					} catch (IllegalStateException e) {
						e.printStackTrace();
					} catch (IOException e) {
						e.printStackTrace();
					}
					// VO객체 담기 
					breakrequest.setRenamed_file_name(renamedFileName);
					
				}else {
					breakrequest.setRenamed_file_name("no");
				}
			}else{
				breakrequest.setRenamed_file_name("no");
			}
		
			System.out.println("breakRequest" + breakrequest);
			System.out.println("여기 들언오림ㄴㅇ러ㅣㅁ노하ㅓㄻ어ㅣ;ㅏㄴㅁㄹ이ㅏ;ㅇㄴ멀;ㅑㅣㅓ");
			
			
			mav.setViewName("redirect:/break/breakRequest.do");
			
			int breakInesert = breakService.breakInesert(breakrequest);
			
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		
		
		
		return mav;
	}
		
	
	
	
	
}
