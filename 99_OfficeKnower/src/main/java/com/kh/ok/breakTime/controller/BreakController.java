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
import com.kh.ok.breakTime.model.vo.BreakSetting;
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
	public String myBreak(@RequestParam(value = "cPage", required = false, defaultValue = "1") int cPage, Model model, HttpServletRequest request) {
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
		
		
		//페이징처리
		int numPerPage = 5;
		List<Map<String,Object>> BreakRequest = breakService.selectBreakRequest(cPage, numPerPage,comId);
		System.out.println("BreakRequest = " + BreakRequest);
		int pageNum = breakService.selectBreakRequestCnt(comId);
		
		
	   
		model.addAttribute("myBreak",myBreak);
		model.addAttribute("breaklist",breaklist);
		model.addAttribute("BreakRequest",BreakRequest);
		model.addAttribute("numPerPage",numPerPage);
		model.addAttribute("pageNum",pageNum);
		model.addAttribute("cPage",cPage);
		
		return "break/myBreak";
	}
	
	
	
	
	
	@RequestMapping("/break/breakCreate.do")
	public ModelAndView breakCreate(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession(false);
		Member m = (Member)session.getAttribute("memberLoggedIn");;
		BreakSetting bs = breakService.selectBreakSetting(m.getCom_no());
		String[] breakdays = bs.getBreakdays().substring(1, bs.getBreakdays().lastIndexOf(",")).split(",");
		bs.setN(breakdays[0]);
		bs.setN1(breakdays[1]);
		bs.setN2(breakdays[2]);
		bs.setN3(breakdays[3]);
		bs.setN4(breakdays[4]);
		bs.setN5(breakdays[5]);
		bs.setN6(breakdays[6]);
		bs.setN7(breakdays[7]);
		bs.setN8(breakdays[8]);
		bs.setN9(breakdays[9]);
		bs.setN10(breakdays[10]);
		bs.setN11(breakdays[11]);
		bs.setN12(breakdays[12]);
		mav.addObject("bs", bs);
		mav.setViewName("break/breakCreate");
		return mav;
	}
	
	@RequestMapping("/break/searchMember.do")
	@ResponseBody
	public Map<String,Object> searchMember(HttpServletRequest request) {
		String enrolldate1 = request.getParameter("enrolldate1")!= null ? request.getParameter("enrolldate1"):"";
		String enrolldate2 = request.getParameter("enrolldate2") != null ? request.getParameter("enrolldate2"):"";
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
		String[] selectedUser = request.getParameter("selectedUser").split(",");
		
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
		
		List<String> selectedUserList = new ArrayList<String>();
		if(selectedUser.length>0) {
			
			for(int i=0; i<selectedUser.length; i++) {
				selectedUserList.add(selectedUserList.size(), selectedUser[i]);
				System.out.println("selectedUserList" + selectedUserList);
			}
		}
		
		
		map.put("userList", userList);
		map.put("comId", comId);
		map.put("enrolldate1",enrolldate1);
		map.put("enrolldate2",enrolldate2);
		map.put("name_com",name_com);
		map.put("selectedUserList",selectedUserList);
		
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
				approvals += username[0];
			}else {
				if(username[i].equals("")) {
//					approvals += username[0];
				}else {
					approvals += username[i] + ",";
				}
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
		
	@RequestMapping("/break/breakSetting.do")
	public ModelAndView breakSetting(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession(false);
		Member m = (Member)session.getAttribute("memberLoggedIn");;
		BreakSetting bs = breakService.selectBreakSetting(m.getCom_no());
		String[] breakdays = bs.getBreakdays().substring(1, bs.getBreakdays().lastIndexOf(",")).split(",");
		bs.setN(breakdays[0]);
		bs.setN1(breakdays[1]);
		bs.setN2(breakdays[2]);
		bs.setN3(breakdays[3]);
		bs.setN4(breakdays[4]);
		bs.setN5(breakdays[5]);
		bs.setN6(breakdays[6]);
		bs.setN7(breakdays[7]);
		bs.setN8(breakdays[8]);
		bs.setN9(breakdays[9]);
		bs.setN10(breakdays[10]);
		bs.setN11(breakdays[11]);
		bs.setN12(breakdays[12]);
		mav.addObject("bs", bs);
		mav.setViewName("break/breakSetting");
		return mav;
	}
	@RequestMapping("/break/breakSettingEnd.do")
	public ModelAndView breakSettingEnd(BreakSetting bs) {
		ModelAndView mav = new ModelAndView();
		bs.setBreakdays("," + bs.getN()+","+ bs.getN1()+","+ bs.getN2()+","+ bs.getN3()+","+ bs.getN4()
					   +","+ bs.getN5()+","+ bs.getN6()+","+ bs.getN7()+","+ bs.getN8()+","+ bs.getN9()
					   +","+ bs.getN10()+","+ bs.getN11()+","+ bs.getN12()+",");
		int result = breakService.updateBreakSetting(bs);
		if(result > 0) {
			mav.setViewName("redirect:/break/breakSetting.do");
		}else {
			mav.addObject("loc", "/break/breakSetting.do");
			mav.addObject("msg", "휴가 기본 설정에 실패했습니다.\\n관리자에게 문의하세요.");
			mav.setViewName("common/msg");
		}
		return mav;
	}
	@RequestMapping("/break/breakCreateEnd.do")
	public ModelAndView breakCreateEnd(BreakSetting bs) {
		ModelAndView mav = new ModelAndView();
		
		breakService.callProc_break_manual(bs);
		
		mav.addObject("loc", "/break/breakCreate.do");
		mav.addObject("msg", "정기휴가가 생성되었습니다.");
		mav.setViewName("common/msg");
		return mav;
	}
}
