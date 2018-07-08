package com.kh.ok.approval.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.ok.approval.model.service.ApprovalService;
import com.kh.ok.approval.model.vo.Account;
import com.kh.ok.approval.model.vo.Approval;
import com.kh.ok.approval.model.vo.Connect;
import com.kh.ok.approval.model.vo.Dept;
import com.kh.ok.approval.model.vo.Title_of_Account;
import com.kh.ok.breakTime.model.vo.BreakRequest;
import com.kh.ok.member.model.vo.Member;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
public class ApprovalController {
	@Autowired
	private ApprovalService approvalService;
	Logger logger = LoggerFactory.getLogger(getClass());

	@RequestMapping("/office/approval/code.do")
	public ModelAndView aprovalCode(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession(false);
		String com_no = ((Member)session.getAttribute("memberLoggedIn")).getCom_no();
		List<Connect> connectList = approvalService.selectListConnect(com_no);
		List<Title_of_Account> toaList = approvalService.selectListToa(com_no);
		List<Dept> deptList = approvalService.selectListDept(com_no);
		
		System.out.println("com_no : "+com_no);
		System.out.println("connectList : "+connectList);
		System.out.println("toaList : "+toaList);
		System.out.println("deptList : "+deptList);
		
		mav.addObject("connectList",connectList);
		mav.addObject("toaList",toaList);
		mav.addObject("deptList",deptList);
		mav.setViewName("approval/admin/code");
		return mav;
	}
	@RequestMapping("/approval/checkCodeDuplicate.do")
	@ResponseBody
	public String checkCodeDuplicate(@RequestParam("code") String code, @RequestParam("com_no") String com_no, @RequestParam("flag") String flag) throws JsonProcessingException {
		String jsonStr = "";
		Map<String, String> map = new HashMap<String, String>();
		ObjectMapper mapper = new ObjectMapper();
		map.put("code", code);
		map.put("com_no", com_no);
		if("connectionCode".equals(flag)) {
			map.put("table", "connection");
		}else if("gajongCode".equals(flag)) {
			map.put("table", "tbl_title_of_account");
		}else if("deptCode".equals(flag)) {
			map.put("table", "tbl_dept");
		}
		
		int count = approvalService.checkCodeDuplicate(map);
		boolean isUsable = count==0?true:false;
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("isUsable", isUsable);
		jsonStr = mapper.writeValueAsString(result);
		
		return jsonStr;
	}
	@RequestMapping("/approval/connectionInsert.do")
	public ModelAndView connectionInsert (Connect connect) {
		ModelAndView mav = new ModelAndView();
		
		int result = approvalService.connectionInsert(connect);
		if(result > 0) {
			mav.setViewName("redirect:/office/approval/code.do");
			mav.addObject("tabSelected","connection");
		}else {
			mav.addObject("loc","/office/approval/code.do");
			mav.addObject("msg","거래처 추가에 실패했습니다. 관리자에게 문의해주세요.");
			mav.addObject("tabSelected","connection");
			mav.setViewName("common/msg");
		}
		
		return mav;
	}
	@RequestMapping("/approval/gajongInsert.do")
	public ModelAndView gajongInsert (Title_of_Account gajong) {
		ModelAndView mav = new ModelAndView();
		
		int result = approvalService.gajongInsert(gajong);
		if(result > 0) {
			mav.setViewName("redirect:/office/approval/code.do");
			mav.addObject("tabSelected","gajong");
		}else {
			mav.addObject("loc","/office/approval/code.do");
			mav.addObject("msg","계정과목 추가에 실패했습니다. 관리자에게 문의해주세요.");
			mav.addObject("tabSelected","gajong");
			mav.setViewName("common/msg");
		}
		return mav;
	}
	@RequestMapping("/approval/deptInsert.do")
	public ModelAndView deptInsert (Dept dept) {
		ModelAndView mav = new ModelAndView();
		
		int result = approvalService.deptInsert(dept);
		if(result > 0) {
			mav.setViewName("redirect:/office/approval/code.do");
			mav.addObject("tabSelected","dept");
		}else {
			mav.addObject("loc","/office/approval/code.do");
			mav.addObject("msg","계정과목 추가에 실패했습니다. 관리자에게 문의해주세요.");
			mav.addObject("tabSelected","dept");
			mav.setViewName("common/msg");
		}
		return mav;
	}
	@RequestMapping("/approval/connectionUpdate.do")
	public ModelAndView connectionUpdate(Connect connect, @RequestParam("preCode") String preCode) {
		ModelAndView mav = new ModelAndView();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("connect", connect);
		map.put("preCode", preCode);
		int result = approvalService.connectionUpdate(map);
		if(result > 0) {
			mav.setViewName("redirect:/office/approval/code.do");
			mav.addObject("tabSelected","connection");
		}else {
			mav.addObject("loc","/office/approval/code.do");
			mav.addObject("msg","거래처 수정에 실패했습니다. 관리자에게 문의해주세요.");
			mav.addObject("tabSelected","connection");
			mav.setViewName("common/msg");
		}
		return mav;
	}
	@RequestMapping("/approval/gajongUpdate.do")
	public ModelAndView gajongUpdate(Title_of_Account toa, @RequestParam("preCode") String preCode) {
		ModelAndView mav = new ModelAndView();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("toa", toa);
		map.put("preCode", preCode);
		int result = approvalService.gajongUpdate(map);
		
		if(result > 0) {
			mav.setViewName("redirect:/office/approval/code.do");
			mav.addObject("tabSelected","gajong");
		}else {
			mav.addObject("loc","/office/approval/code.do");
			mav.addObject("msg","계정과목 수정에 실패했습니다. 관리자에게 문의해주세요.");
			mav.addObject("tabSelected","gajong");
			mav.setViewName("common/msg");
		}
		return mav;
	}
	@RequestMapping("/approval/deptUpdate.do")
	public ModelAndView deptUpdate(Dept dept, @RequestParam("preCode") String preCode) {
		ModelAndView mav = new ModelAndView();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("dept", dept);
		map.put("preCode", preCode);
		int result = approvalService.deptUpdate(map);
		
		if(result > 0) {
			mav.setViewName("redirect:/office/approval/code.do");
			mav.addObject("tabSelected","dept");
		}else {
			mav.addObject("loc","/office/approval/code.do");
			mav.addObject("msg","부서 수정에 실패했습니다. 관리자에게 문의해주세요.");
			mav.addObject("tabSelected","dept");
			mav.setViewName("common/msg");
		}
		
		return mav;
	}
	@RequestMapping("/approval/deleteCode.do")
	public ModelAndView deleteCode(@RequestParam("flag") String flag, @RequestParam("code") String code, @RequestParam("com_no") String com_no) {
		ModelAndView mav = new ModelAndView();
		Map<String, String> map = new HashMap<String, String>();
		map.put("code", code);
		map.put("com_no", com_no);
		if("connection".equals(flag)) {
			map.put("table", "connection");
		}else if("gajong".equals(flag)) {
			map.put("table", "tbl_title_of_account");
		}else if("dept".equals(flag)) {
			map.put("table", "tbl_dept");
		}
		
		int result = approvalService.deleteCode(map);
		
		if(result > 0) {
			mav.setViewName("redirect:/office/approval/code.do");
			mav.addObject("tabSelected",flag);
		}else {
			mav.addObject("loc","/office/approval/code.do");
			mav.addObject("msg","삭제에 실패했습니다. 관리자에게 문의해주세요.");
			mav.addObject("tabSelected",flag);
			mav.setViewName("common/msg");
		}
		return mav;
	}
	@RequestMapping("/approval/deleteCodes.do")
	public ModelAndView deleteCodes(@RequestParam("flag") String flag, @RequestParam("code") String[] code, @RequestParam("com_no") String com_no) {
		ModelAndView mav = new ModelAndView();
		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println("code = " + code);
		System.out.println("flag= " + flag);
		System.out.println("com_no = " + com_no);
		map.put("code", code);
		map.put("com_no", com_no);
		if("connection".equals(flag)) {
			map.put("table", "connection");
		}else if("gajong".equals(flag)) {
			map.put("table", "tbl_title_of_account");
		}else if("dept".equals(flag)) {
			map.put("table", "tbl_dept");
		}
		
		int result = approvalService.deleteCodes(map);
		if(result > 0) {
			mav.setViewName("redirect:/office/approval/code.do");
			mav.addObject("tabSelected",flag);
		}else {
			mav.addObject("loc","/office/approval/code.do");
			mav.addObject("msg","삭제에 실패했습니다. 관리자에게 문의해주세요.");
			mav.addObject("tabSelected",flag);
			mav.setViewName("common/msg");
		}
		return mav;
	}
	@RequestMapping("/office/approval/account.do")
	public ModelAndView selectListAccount(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession(false);
		String com_no = ((Member)session.getAttribute("memberLoggedIn")).getCom_no();
		List<Account> list = approvalService.selectListAccount(com_no);
		mav.addObject("accountList", list);
		mav.setViewName("approval/admin/account");
		return mav;
	}
	@RequestMapping("/approval/selectListByName.do")
	@ResponseBody
	public Map<String, Object> selectListByName(@RequestParam("name") String name, @RequestParam("com_no") String com_no) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("name", name);
		map.put("com_no", com_no);
		
		List<Member> list = approvalService.selectListByName(map);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("list", list);
		return result;
	}
	@RequestMapping("/approval/accountInsert.do")
	public ModelAndView accountInsert(Account account) {
		ModelAndView mav = new ModelAndView();
		
		int result = approvalService.accountInsert(account);
		if(result > 0) {
			mav.setViewName("redirect:/office/approval/account.do");
		}else {
			mav.addObject("loc","/office/approval/account.do");
			mav.addObject("msg","계좌 등록에 실패했습니다. 관리자에게 문의해주세요.");
			mav.setViewName("common/msg");
		}
		
		return mav;
	}
	@RequestMapping("/approval/accountDuplicate.do")
	@ResponseBody
	public Map<String, Object> accountDuplicate(@RequestParam("com_no") String com_no, @RequestParam("userId") String userId){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("com_no", com_no);
		map.put("userId", userId);
		
		int result = approvalService.accountDuplicate(map);
		boolean isUsable = result>0?false:true;
		map.put("isUsable",isUsable);
		
		return map;
	}
	@RequestMapping("/approval/accountUpdate.do")
	public ModelAndView accountUpdate(Account account) {
		ModelAndView mav = new ModelAndView();
		
		int result = approvalService.accountUpdate(account);
		if(result > 0) {
			mav.setViewName("redirect:/office/approval/account.do");
		}else {
			mav.addObject("loc","/office/approval/account.do");
			mav.addObject("msg","계좌 수정에 실패했습니다. 관리자에게 문의해주세요.");
			mav.setViewName("common/msg");
		}
		return mav;
	}
	@RequestMapping("/approval/accountDelete.do")
	public ModelAndView accountDelete(@RequestParam("userId") String userId) {
		ModelAndView mav = new ModelAndView();
		
		int result = approvalService.accountDelete(userId);
		if(result > 0) {
			mav.setViewName("redirect:/office/approval/account.do");
		}else {
			mav.addObject("loc","/office/approval/account.do");
			mav.addObject("msg","계좌 수정에 실패했습니다. 관리자에게 문의해주세요.");
			mav.setViewName("common/msg");
		}
		return mav;
	}
	@RequestMapping("/approval/approvalInsert.do")
	public ModelAndView approvalInsert(Locale locale, HttpServletRequest request, HttpSession session2) {
		ModelAndView mav = new ModelAndView();
		Member m = (Member)session2.getAttribute("memberLoggedIn");
		String com_no = m.getCom_no();
		Date date = new Date();		
		DateFormat yearFormat = new SimpleDateFormat("yyyy");
		DateFormat monthFormat = new SimpleDateFormat("MM");

		System.out.println(monthFormat.format(date));
		System.out.println(((Integer.parseInt(monthFormat.format(date))/10)>0?"":"0")+(Integer.parseInt(monthFormat.format(date))-1));
		System.out.println(((Integer.parseInt(monthFormat.format(date))/10)>0?"":"0")+(Integer.parseInt(monthFormat.format(date))-2));
		
		mav.addObject("year", yearFormat.format(date));
		mav.addObject("year_1", ""+(Integer.parseInt(yearFormat.format(date))-1));
		mav.addObject("year_2", ""+(Integer.parseInt(yearFormat.format(date))-2));
		mav.addObject("month", monthFormat.format(date));
		mav.addObject("month_1", ((Integer.parseInt(monthFormat.format(date))/10)>0?"":"0")+(Integer.parseInt(monthFormat.format(date))-1));
		mav.addObject("month_2", ((Integer.parseInt(monthFormat.format(date))/10)>0?"":"0")+(Integer.parseInt(monthFormat.format(date))-2));
		
		HttpSession session = request.getSession(false);
		Member memberLoggedIn = (Member)(session.getAttribute("memberLoggedIn"));
		
		List<Member> list = approvalService.selectListMember(memberLoggedIn.getCom_no());
		mav.addObject("list", list);
		List<Map<String, String>> title_of_accountList = approvalService.selectTitle_Of_Account(com_no);
		List<Map<String, String>> deptList = approvalService.selectDeptList(com_no);
		System.out.println("title_of_accountList : "+title_of_accountList);
		System.out.println("deptList : "+deptList);
		mav.addObject("title_of_accountList", title_of_accountList);
		mav.addObject("deptList", deptList);
		mav.setViewName("approval/approvalInsert");
		return mav;
	}
	@RequestMapping("/approval/selectaccountListByName.do")
	@ResponseBody
	public Map<String, Object> selectaccountListByName (@RequestParam("name") String name, @RequestParam("com_no") String com_no) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("name", name);
		map.put("com_no", com_no);
		
		List<Member> list = approvalService.selectaccountListByName(map);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("list", list);
		return result;
	}
	@RequestMapping("/approval/approvalSetting.do")
	public ModelAndView approvalSetting(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("approval/approvalSetting");
		return mav;
	}
	@RequestMapping("/approval/approvalSignUpdate")
	public ModelAndView approvalSignUpdate(HttpSession session, @RequestParam(value = "upFile", required = false) MultipartFile upFile,
			HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		Member m = (Member)session.getAttribute("memberLoggedIn");
	
	
		if(upFile.getOriginalFilename()=="") {
			m.setSign("sign_default.png");
		}

		try {
		
			// 1. 파일업로드처리
			String saveDirectory = request.getSession().getServletContext().getRealPath("/resources/upload/member");
			// requet로부터 session을 얻고 여기서 ServletContext()를 받아 절대경로를 받아옴

			/***** MultipartFile을 이용한 파일 업로드 처리로직 시작 *****/
			MultipartFile f = upFile;
			if (f != null ) {
				if (!f.isEmpty()) {
					// 파일명 재생성
					String originalFileName = f.getOriginalFilename();
					String ext = originalFileName.substring(originalFileName.lastIndexOf(".") + 1); // 확장자
					SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
					int rndNum = (int) (Math.random() * 1000);
					String renamedFileName = sdf.format(new Date(System.currentTimeMillis())) + "_" + rndNum + "."
							+ ext;
					if(f.getOriginalFilename() != "") {
						m.setSign(renamedFileName);
					}
					System.out.println(m);
					try {
						f.transferTo(new File(saveDirectory + "/" + renamedFileName)); // 실제 서버에 파일을 저장하는 코드
					} catch (IllegalStateException e) {
						e.printStackTrace();
					} catch (IOException e) {
						e.printStackTrace();
					}
					
				}
			}
			
			/***** MultipartFile을 이용한 파일 업로드 처리로직 끝 *****/
			// 2. 비지니스로직
			int result = approvalService.updateSign(m); 
			// 3. view단 분기
			String loc = "/";
			String msg = "";

			if (result > 0) {
				msg = "서명 수정 성공";
				loc = "/approval/approvalSetting.do";
			} else
				msg = "서명 수정 실패";
			mav.addObject("msg", msg);
			mav.addObject("loc", loc);
			mav.setViewName("common/msg");
		} catch (Exception e) {
			e.printStackTrace();
		
		}
		return mav;
	}
	@RequestMapping("/approval/admin/approvalAdminInsert.do")
	public ModelAndView approvalAdminInsert(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Member m = (Member)session.getAttribute("memberLoggedIn");
		String com_no = m.getCom_no();
		List<Map<String, String>> approvalAdminList = approvalService.selectListAdmin(com_no);
		
		mav.addObject("approvalAdminList", approvalAdminList);
		return mav;
	}
	@RequestMapping("/approval/admin/approvalAdminDelete.do")
	public ModelAndView approvalAdminDelete(Member member) {
		ModelAndView mav = new ModelAndView();
		String str= "";
		String arr[] = member.getGrade().split(",");
		for(int i=0; i<arr.length; i++) {
			System.out.println(arr[i]);
			
			if(!arr[i].equals("전자결재관리자")) {
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
		int result = approvalService.deleteAdmin(member);
	
	
		String loc = "/";
		String msg = "";

		if (result > 0) {
			msg = "전자결재 관리자 삭제 성공";
			loc = "/approval/admin/approvalAdminInsert.do";
		} else
			msg = "전자결재 관리자 삭제 실패";
		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		mav.setViewName("common/msg");
		
		return mav;
	}
	@RequestMapping("/approval/admin/searchAdmin")
	@ResponseBody
	public JSONArray searchAdmin(@RequestParam String userName, HttpSession session) {
		Member member = (Member)session.getAttribute("memberLoggedIn");
		member.setUserName('%'+userName+'%');
		List<Map<String,String>> userList = approvalService.selectAdmin(member);
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
	@RequestMapping("/approval/admin/adminInsertEnd.do")
	public ModelAndView insertAdmin(@RequestParam String userId) {
		ModelAndView mav = new ModelAndView();
		
		Member m = approvalService.selectMember(userId);
		if(m.getGrade() == null || m.getGrade() == "") {
			m.setGrade("전자결재관리자");
		}else {
			m.setGrade(",전자결재관리자");
		}
		int result = approvalService.adminInsert(m);
		
		
		String loc = "/";
		String msg = "";

		if (result > 0) {
			msg = "전자결재 관리자 추가 성공";
			loc = "/approval/admin/approvalAdminInsert.do";
		} else
			msg = "전자결재 관리자 추가 실패";
		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		mav.setViewName("common/msg");
		return mav;
	}
	@RequestMapping("/approvals/insertApprovalExtra")
	public ModelAndView insertApproval(@RequestParam("approvals") String approvals, @RequestParam("writer") String writer, @RequestParam("content") String content,
			@RequestParam("com_no") String com_no, @RequestParam("title") String title) throws JsonProcessingException {
		ModelAndView mav = new ModelAndView();
		Approval approval = new Approval();
		approval.setApproval_no("기타-");
		approval.setWriter(writer);
		approval.setCom_no(com_no);
		approval.setTitle(title);
		
		String[] appro = approvals.split(",");
		String newAppro = "";
		for(int i=appro.length-1; i>=0; i--) {
			
			newAppro += appro[i];
			if(i!=0) newAppro+= ",";
		}
		
		approval.setApprovals(newAppro);
		approval.setApproval_status(appro.length-1);
		
		if(approval.getApproval_status()==0) {
			approval.setStatus("결재 완료");
		}else {
			approval.setStatus("결재 중");
		}
		
		String jsonStr = "";
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> contents = new HashMap<String, Object>();
		contents.put("kind", "기타");
		contents.put("content", content);
		jsonStr = mapper.writeValueAsString(contents);
		
		approval.setContent(jsonStr);
		
		int result = approvalService.approvalInsert(approval);
		
		
		String loc = "/";
		String msg = "";

		if (result > 0) {
			msg = "결재 등록 성공";
			loc = "/office/approval.do";
		} else
			msg = "결재 등록 실패";
		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		mav.setViewName("common/msg");
	
		return mav;
	}
	
	@RequestMapping("/approvals/insertApprovalSpending")
	public ModelAndView insertApprovalSpending(@RequestParam(value="approvals") String approvals, 
			@RequestParam(value="title") String title, @RequestParam(value="writer") String writer, @RequestParam(value="year") int year, @RequestParam(value="month") int month,
			@RequestParam(value="bankName") String bankName, @RequestParam(value="account_no") String account_no, @RequestParam(value="userId") String userId, @RequestParam(value="transaction") String transaction, HttpSession session) throws JsonProcessingException {
		ModelAndView mav = new ModelAndView();
		Approval approval = new Approval();
		approval.setApproval_no("지결-");
		approval.setWriter(writer);
		approval.setTitle(title);
		approval.setSpender(userId);
		Member m = (Member)session.getAttribute("memberLoggedIn");
		approval.setCom_no(m.getCom_no());
		
		String[] appro = approvals.split(",");
		String newAppro = "";
		for(int i=appro.length-1; i>=0; i--) {
			
			newAppro += appro[i];
			if(i!=0) newAppro+= ",";
		}
		
		approval.setApprovals(newAppro);
		approval.setApproval_status(appro.length-1);
		if(approval.getApproval_status()==0) {
			approval.setStatus("결재 완료");
		}else {
			approval.setStatus("결재 중");
		}
		String jsonStr = "";
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> contents = new HashMap<String, Object>();
		contents.put("kind", "지결");
		contents.put("year", year);
		contents.put("month", month);
		contents.put("bankName", bankName);
		contents.put("account_no", account_no);
		contents.put("userId", userId);
		contents.put("transaction", transaction);
		jsonStr = mapper.writeValueAsString(contents);
		
		approval.setContent(jsonStr);
		int result = approvalService.approvalInsert(approval);
		
		String loc = "/";
		String msg = "";

		if (result > 0) {
			msg = "결재 등록 성공";
			loc = "/approval/admin/approvalDataList";
		} else
			msg = "결재 등록 실패";
		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		mav.setViewName("common/msg");
	
		return mav;
	}
	@RequestMapping("/approval/admin/approvalDataList")
	public ModelAndView approvalDataList(@RequestParam(value = "cPage", required = false, defaultValue = "1") int cPage,HttpSession session) {
		ModelAndView mav = new ModelAndView();
		// numPerPage 선언
		int numPerPage = 5;
		Member m = (Member)session.getAttribute("memberLoggedIn");
		List<Map<String, String>> approvalDataList = approvalService.selectApprovalDataList(cPage, numPerPage,m.getCom_no());
		for(int i=0; i<approvalDataList.size(); i++) {
			String str = approvalDataList.get(i).get("CONTENT");
			approvalDataList.get(i).replace("CONTENT", str);
		}
		
		int pageNum = approvalService.approvalDataListCount(m.getCom_no());

		mav.addObject("numPerPage", numPerPage);
		mav.addObject("cPage", cPage);
		mav.addObject("pageNum", pageNum);
		
		mav.addObject("approvalDataList", approvalDataList);
		return mav;
	}
	@RequestMapping("/office/approval.do")	//대기
	public ModelAndView ApprovalList(HttpSession session) {	
		ModelAndView mav = new ModelAndView();
		Member m = (Member)session.getAttribute("memberLoggedIn");
		String com_no = m.getCom_no();
		String userId = m.getUserId();
		
		
		//결재
		List<Map<String,Object>> approvalDataList = approvalService.selectApprovalList(com_no);
				
		List<Map<String, Object>> approvalWaitList = new ArrayList<Map<String,Object>>();
		for(int i=0; i<approvalDataList.size(); i++) {
			System.out.println(approvalDataList.get(i).get("APPROVAL_STATUS"));
			int approval_status = ((BigDecimal)approvalDataList.get(i).get("APPROVAL_STATUS")).intValue();
			String status = (String) approvalDataList.get(i).get("STATUS");
			String approvalsT = (String) approvalDataList.get(i).get("APPROVALS");
			if(approvalsT.contains(userId)) { //지출자(a,b,c,d)에 내가 포함이 되면
				if(status.equals("결재 완료") || status.equals("반려")) {	// 완료일 경우
					
				}else {
					String[] approvals = approvalsT.split(",");
					HashMap<String, Integer> approvals_people = new HashMap<String, Integer>();
					for(int j=0; j<approvals.length; j++) {
						approvals_people.put(approvals[j], j+1);
					}
					if(approvals_people.get(userId) == approval_status) { //대기
						approvalWaitList.add(approvalDataList.get(i));
					}else if(approvals_people.get(userId) < approval_status) { //예정
						
					}else if(approvals_people.get(userId) > approval_status) { //진행
   
					}else {
						logger.warn("approval_status 오류 ");
					}
				}
			}
		}

		//휴가
		List<Map<String,Object>> breakRequestList = approvalService.selectBreakRequestList(com_no);
		
		List<Map<String, Object>> breakRequestWaitList = new ArrayList<Map<String,Object>>();
		for(int i=0; i<breakRequestList.size(); i++) {
			System.out.println(breakRequestList.get(i).get("APPROVAL_STATUS"));
			int approval_status = ((BigDecimal)breakRequestList.get(i).get("APPROVAL_STATUS")).intValue();
			String status = (String) breakRequestList.get(i).get("STATUS");
			String approvalsT = (String) breakRequestList.get(i).get("APPROVALS");
			if(approvalsT.contains(userId)) { //지출자(a,b,c,d)에 내가 포함이 되면
				if(status.equals("결재 완료") || status.equals("반려")) {	// 완료일 경우
					
				}else {
					String[] approvals = approvalsT.split(",");
					HashMap<String, Integer> approvals_people = new HashMap<String, Integer>();
					for(int j=0; j<approvals.length; j++) {
						approvals_people.put(approvals[j], j+1);
					}
					if(approvals_people.get(userId) == approval_status) { //대기
						breakRequestWaitList.add(breakRequestList.get(i));
					}else if(approvals_people.get(userId) < approval_status) { //예정
						
					}else if(approvals_people.get(userId) > approval_status) { //진행
   
					}else {
						logger.warn("breakRequest_status 오류 ");
					}
				}
			}
		}
		
		mav.addObject("approvalWaitList", approvalWaitList);
		mav.addObject("breakRequestWaitList", breakRequestWaitList);
		mav.setViewName("approval/approval_dagi");
		return mav;
	}
	@RequestMapping("/office/expectedApproval.do") //예정
	public ModelAndView expectedApprovalList(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Member m = (Member)session.getAttribute("memberLoggedIn");
		String com_no = m.getCom_no();
		String userId = m.getUserId();
		
		List<Map<String,Object>> approvalDataList = approvalService.selectApprovalList(com_no);
		List<Map<String, Object>> approvalExpectedList = new ArrayList<Map<String,Object>>();
		for(int i=0; i<approvalDataList.size(); i++) {
			System.out.println(approvalDataList.get(i).get("APPROVAL_STATUS"));
			int approval_status = ((BigDecimal)approvalDataList.get(i).get("APPROVAL_STATUS")).intValue();
			String status = (String) approvalDataList.get(i).get("STATUS");
			String approvalsT = (String) approvalDataList.get(i).get("APPROVALS");
			if(approvalsT.contains(userId)) { //지출자(a,b,c,d)에 내가 포함이 되면
				if(status.equals("결재 완료") || status.equals("반려")) {	// 완료일 경우

				}else {
					String[] approvals = approvalsT.split(",");
					HashMap<String, Integer> approvals_people = new HashMap<String, Integer>();
					for(int j=0; j<approvals.length; j++) {
						approvals_people.put(approvals[j], j+1);
					}
					if(approvals_people.get(userId) == approval_status) { //대기

					}else if(approvals_people.get(userId) < approval_status) { //예정
						approvalExpectedList.add(approvalDataList.get(i));
					}else if(approvals_people.get(userId) > approval_status) { //진행

					}else {
						logger.warn("approval_status 오류 ");
					}
				}
			}
		}
		
		//휴가
		List<Map<String,Object>> breakRequestList = approvalService.selectBreakRequestList(com_no);
		
		List<Map<String, Object>> breakRequestExpectedList = new ArrayList<Map<String,Object>>();
		for(int i=0; i<breakRequestList.size(); i++) {
			System.out.println(breakRequestList.get(i).get("APPROVAL_STATUS"));
			int approval_status = ((BigDecimal)breakRequestList.get(i).get("APPROVAL_STATUS")).intValue();
			String status = (String) breakRequestList.get(i).get("STATUS");
			String approvalsT = (String) breakRequestList.get(i).get("APPROVALS");
			if(approvalsT.contains(userId)) { //지출자(a,b,c,d)에 내가 포함이 되면
				if(status.equals("결재 완료") || status.equals("반려")) {	// 완료일 경우
					
				}else {
					String[] approvals = approvalsT.split(",");
					HashMap<String, Integer> approvals_people = new HashMap<String, Integer>();
					for(int j=0; j<approvals.length; j++) {
						approvals_people.put(approvals[j], j+1);
					}
					if(approvals_people.get(userId) == approval_status) { //대기
						
					}else if(approvals_people.get(userId) < approval_status) { //예정
						breakRequestExpectedList.add(breakRequestList.get(i));
					}else if(approvals_people.get(userId) > approval_status) { //진행
   
					}else {
						logger.warn("breakRequest_status 오류 ");
					}
				}
			}
		}
		mav.addObject("approvalExpectedList", approvalExpectedList);
		mav.addObject("breakRequestExpectedList", breakRequestExpectedList);
		mav.setViewName("approval/approval_dPwjd");
		return mav;
	}
	@RequestMapping("/office/progressApproval.do") //진행
	public ModelAndView progressApprovalList(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Member m = (Member)session.getAttribute("memberLoggedIn");
		String com_no = m.getCom_no();
		String userId = m.getUserId();
		
		List<Map<String,Object>> approvalDataList = approvalService.selectApprovalList(com_no);

		List<Map<String, Object>> approvalProgressList = new ArrayList<Map<String,Object>>();

		for(int i=0; i<approvalDataList.size(); i++) {
			System.out.println(approvalDataList.get(i).get("APPROVAL_STATUS"));
			int approval_status = ((BigDecimal)approvalDataList.get(i).get("APPROVAL_STATUS")).intValue();
			String status = (String) approvalDataList.get(i).get("STATUS");
			String approvalsT = (String) approvalDataList.get(i).get("APPROVALS");
			if(approvalsT.contains(userId)) { //지출자(a,b,c,d)에 내가 포함이 되면
				if(status.equals("결재 완료") || status.equals("반려")) {	// 완료일 경우

				}else {
					String[] approvals = approvalsT.split(",");
					HashMap<String, Integer> approvals_people = new HashMap<String, Integer>();
					for(int j=0; j<approvals.length; j++) {
						approvals_people.put(approvals[j], j+1);
					}
					if(approvals_people.get(userId) == approval_status) { //대기

					}else if(approvals_people.get(userId) < approval_status) { //예정

					}else if(approvals_people.get(userId) > approval_status) { //진행
						approvalProgressList.add(approvalDataList.get(i));
					}else {
						logger.warn("approval_status 오류 ");
					}
				}
			}
		}
		
		//휴가
		List<Map<String,Object>> breakRequestList = approvalService.selectBreakRequestList(com_no);
		
		List<Map<String, Object>> breakRequestProgressList = new ArrayList<Map<String,Object>>();
		for(int i=0; i<breakRequestList.size(); i++) {
			System.out.println(breakRequestList.get(i).get("APPROVAL_STATUS"));
			int approval_status = ((BigDecimal)breakRequestList.get(i).get("APPROVAL_STATUS")).intValue();
			String status = (String) breakRequestList.get(i).get("STATUS");
			String approvalsT = (String) breakRequestList.get(i).get("APPROVALS");
			if(approvalsT.contains(userId)) { //지출자(a,b,c,d)에 내가 포함이 되면
				if(status.equals("결재 완료") || status.equals("반려")) {	// 완료일 경우
					
				}else {
					String[] approvals = approvalsT.split(",");
					HashMap<String, Integer> approvals_people = new HashMap<String, Integer>();
					for(int j=0; j<approvals.length; j++) {
						approvals_people.put(approvals[j], j+1);
					}
					if(approvals_people.get(userId) == approval_status) { //대기
						
					}else if(approvals_people.get(userId) < approval_status) { //예정
						
					}else if(approvals_people.get(userId) > approval_status) { //진행
						breakRequestProgressList.add(breakRequestList.get(i));
					}else {
						logger.warn("breakRequest_status 오류 ");
					}
				}
			}
		}
		mav.addObject("approvalProgressList", approvalProgressList);
		mav.addObject("breakRequestProgressList", breakRequestProgressList);
		mav.setViewName("approval/approval_wlsgod");
		return mav;
	}
	@RequestMapping("/office/completeApproval.do") //완료
	public ModelAndView completeApprovalList(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Member m = (Member)session.getAttribute("memberLoggedIn");
		String com_no = m.getCom_no();
		String userId = m.getUserId();
		
		List<Map<String,Object>> approvalDataList = approvalService.selectApprovalList(com_no);

		List<Map<String, Object>> approvalCompleteList = new ArrayList<Map<String,Object>>();
		for(int i=0; i<approvalDataList.size(); i++) {
			System.out.println(approvalDataList.get(i).get("APPROVAL_STATUS"));
			int approval_status = ((BigDecimal)approvalDataList.get(i).get("APPROVAL_STATUS")).intValue();
			String status = (String) approvalDataList.get(i).get("STATUS");
			String approvalsT = (String) approvalDataList.get(i).get("APPROVALS");
			if(approvalsT.contains(userId)) { //지출자(a,b,c,d)에 내가 포함이 되면
				if(status.equals("결재 완료") || status.equals("반려")) {	// 완료일 경우
					approvalCompleteList.add(approvalDataList.get(i));
				}else {
					String[] approvals = approvalsT.split(",");
					HashMap<String, Integer> approvals_people = new HashMap<String, Integer>();
					for(int j=0; j<approvals.length; j++) {
						approvals_people.put(approvals[j], j+1);
					}
					if(approvals_people.get(userId) == approval_status) { //대기

					}else if(approvals_people.get(userId) < approval_status) { //예정

					}else if(approvals_people.get(userId) > approval_status) { //진행

					}else {
						logger.warn("approval_status 오류 ");
					}
				}
			}
		}
		
		//휴가
		List<Map<String,Object>> breakRequestList = approvalService.selectBreakRequestList(com_no);
		
		List<Map<String, Object>> breakRequestCompleteList = new ArrayList<Map<String,Object>>();
		for(int i=0; i<breakRequestList.size(); i++) {
			System.out.println(breakRequestList.get(i).get("APPROVAL_STATUS"));
			int approval_status = ((BigDecimal)breakRequestList.get(i).get("APPROVAL_STATUS")).intValue();
			String status = (String) breakRequestList.get(i).get("STATUS");
			String approvalsT = (String) breakRequestList.get(i).get("APPROVALS");
			if(approvalsT.contains(userId)) { //지출자(a,b,c,d)에 내가 포함이 되면
				if(status.equals("결재 완료") || status.equals("반려")) {	// 완료일 경우
					breakRequestCompleteList.add(breakRequestList.get(i));
				}else {
					String[] approvals = approvalsT.split(",");
					HashMap<String, Integer> approvals_people = new HashMap<String, Integer>();
					for(int j=0; j<approvals.length; j++) {
						approvals_people.put(approvals[j], j+1);
					}
					if(approvals_people.get(userId) == approval_status) { //대기
						
					}else if(approvals_people.get(userId) < approval_status) { //예정
						
					}else if(approvals_people.get(userId) > approval_status) { //진행
						
					}else {
						logger.warn("breakRequest_status 오류 ");
					}
				}
			}
		}
		mav.addObject("approvalCompleteList", approvalCompleteList);
		mav.addObject("breakRequestCompleteList", breakRequestCompleteList);
		mav.setViewName("approval/approval_dhksfy");
		return mav;
	}
	@RequestMapping("/office/approvalView")
	public ModelAndView selectApprovalView(@RequestParam("approval_no") String approval_no, @RequestParam("navkind") String navkind, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Approval approval = approvalService.selectApprovalOne(approval_no);
		Member writer = null;
		String spenderName ="";
		String status = approval.getStatus();
		String approvalsT = approval.getApprovals();
		String[] approvals;
	
		String com_name = approvalService.selectComName(approval.getCom_no());
		approvals = approvalsT.split(",");
		ArrayList<Member> approvals_list = new ArrayList<Member>();
		for(int j=approvals.length-1; j>=0; j--) {
			Member m = approvalService.selectMember(approvals[j]);
			approvals_list.add(m);
			if(approval.getWriter().equals(approvals[j])) {	//작성자 객체 생성
				writer = m;
			}
		}
		if(approval.getSpender() != null) {
			spenderName = approvalService.selectUserName(approval.getSpender());
		}
		
		int approvals_count = approvals_list.size();	
		for(int i=0; i<approvals_list.size(); i++) {
			System.out.println(approvals_list.get(i));
		}
		mav.addObject("status", status);
		mav.addObject("writer", writer);
		mav.addObject("com_name", com_name);
		mav.addObject("approvals_list", approvals_list);
		mav.addObject("approvals_count", approvals_count);
		mav.addObject("approval", approval);
		mav.addObject("spenderName", spenderName);
		mav.addObject("navkind",navkind);
		mav.setViewName("approval/approval_view");
		return mav;
	}

	@RequestMapping("/approval/approvalAccept")
	public ModelAndView approvalAccept(@RequestParam("approval_no") String approval_no, @RequestParam("navkind") String navkind, @RequestParam("approval_status") int approval_status, @RequestParam("status") String status) {
		ModelAndView mav = new ModelAndView();
		Approval approval = new Approval();
		approval.setApproval_no(approval_no);
		approval.setApproval_status(approval_status);
		approval.setStatus(status);
		approval.setApproval_status(approval.getApproval_status()-1);
		if(!approval.getStatus().equals("반려") &&  approval.getApproval_status()==0) {
			approval.setStatus("결재 완료");
		}
		int result = approvalService.approvalAccept(approval);
		
		if(result > 0) {
			mav.addObject("msg", "결재를 정상적으로 처리했습니다.");
		}else {
			mav.addObject("msg", "결재를 처리하지 못했습니다");
		}
		mav.addObject("loc", "/office/approvalView?approval_no="+approval.getApproval_no()+"&navkind="+navkind);
		mav.setViewName("common/msg");
		return mav;
	}
	
	@RequestMapping("/approval/approvalReject")
	public ModelAndView approvalReject(@RequestParam("approval_no") String approval_no, @RequestParam("navkind") String navkind, @RequestParam("approval_status") int approval_status) {
		ModelAndView mav = new ModelAndView();
		Approval approval = new Approval();
		approval.setApproval_no(approval_no);
		approval.setApproval_status(approval_status);
		approval.setApproval_status(approval.getApproval_status()-1);
		approval.setStatus("반려");
		
		int result = approvalService.approvalReject(approval);
		
		if(result > 0) {
			mav.addObject("msg", "결재를 정상적으로 처리했습니다.");
		}else {
			mav.addObject("msg", "결재를 처리하지 못했습니다");
		}
		mav.addObject("loc", "/office/approvalView?approval_no="+approval.getApproval_no()+"&navkind="+navkind);
		mav.setViewName("common/msg");
		return mav;
	}
	
	@RequestMapping("/office/approvalBreakRequestView")
	public ModelAndView approvalBreakRequestView(@RequestParam("break_request_no") String break_request_no, @RequestParam("navkind") String navkind) {
		ModelAndView mav = new ModelAndView();
		BreakRequest breakRequest = approvalService.selectBreakRequestOne(break_request_no);
		Member writer = null;
		String status = breakRequest.getStatus();
		String approvalsT = breakRequest.getApprovals();
		String[] approvals;
	
		String com_name = approvalService.selectComName(breakRequest.getCom_no());
		approvals = approvalsT.split(",");
		ArrayList<Member> approvals_list = new ArrayList<Member>();
		for(int j=approvals.length-1; j>=0; j--) {
			Member m = approvalService.selectMember(approvals[j]);
			approvals_list.add(m);
			if(breakRequest.getUserid().equals(approvals[j])) {	//작성자 객체 생성
				writer = m;
			}
		}
		
		int approvals_count = approvals_list.size();	
		for(int i=0; i<approvals_list.size(); i++) {
			System.out.println(approvals_list.get(i));
		}
		
		System.out.println("navkind : "+navkind);
		mav.addObject("status", status);
		mav.addObject("writer", writer);
		mav.addObject("com_name", com_name);
		mav.addObject("approvals_list", approvals_list);
		mav.addObject("approvals_count", approvals_count);
		mav.addObject("breakRequest", breakRequest);
		mav.addObject("navkind",navkind);
		mav.setViewName("approval/breakRequest_view");
		return mav;
	}
	
	@RequestMapping("/approval/approvalDownload.do")
	public void fileDownload(@RequestParam String rName, HttpServletRequest request,
			HttpServletResponse response) {

		BufferedInputStream bis = null;
		ServletOutputStream sos = null;

		String saveDirectory = request.getSession().getServletContext().getRealPath("/resources/upload/break"); // request로부터
																												// session을
																												// 얻고
																												// 거기서
																												// servletcontext를
																												// 얻는구조

		File savedFile = new File(saveDirectory + "/" + rName);

		try {
			bis = new BufferedInputStream(new FileInputStream(savedFile));
			sos = response.getOutputStream();

			// 응답세팅
			response.setContentType("application/octet-stream; charset=utf-8");

			// 한글파일명 처리
			String resFilename = "";
			boolean isMSIE = request.getHeader("user-agent").indexOf("MSIE") != -1
					|| request.getHeader("user-agent").indexOf("Trident") != -1;
			// IE 8이하는 MSIE라는 키워드를, 이후는 Trident라는 키워드를 갖고 있기에 둘다 체크해봐야함.

			if (isMSIE) {
				// ie는 utf-8인코딩을 명시적으로 해줌.
				//resFilename = URLEncoder.encode(oName, "utf-8"); // 이렇게 하면 공백이 +로 바뀌는 문제가 있음.
				resFilename = resFilename.replaceAll("\\+", "%20"); // +를 공백으로 바꾸는 코드.
			} else {
				//resFilename = new String(oName.getBytes("utf-8"), "ISO-8859-1"); // 기존 파일명을 바이트로 바꾼 후 ISO-8859-1형식으로 재
																					// 인코딩...

			}
			logger.debug("resFilename=" + resFilename);

			response.addHeader("Content-Disposition", "attachment; filename=\"" + resFilename + "\"");

			// 쓰기
			int read = 0;
			while ((read = bis.read()) != -1) {
				sos.write(read);
			}

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				sos.close();
				bis.close();
			} catch (IOException e) {
				e.printStackTrace();
			}

		}
	}
	@RequestMapping("/approval/breakRequestAccept")
	public ModelAndView breakRequestAccept(@RequestParam("break_request_no") String break_request_no, @RequestParam("navkind") String navkind, @RequestParam("approval_status") int approval_status, @RequestParam("status") String status) {
		ModelAndView mav = new ModelAndView();
		BreakRequest breakRequest = new BreakRequest();
		breakRequest.setBreak_request_no(break_request_no);
		breakRequest.setApproval_status(approval_status);
		breakRequest.setStatus(status);
		breakRequest.setApproval_status(breakRequest.getApproval_status()-1);
		if(!breakRequest.getStatus().equals("반려") &&  breakRequest.getApproval_status()==0) {
			breakRequest.setStatus("결재 완료");
		}
		int result = approvalService.breakRequestAccept(breakRequest);
		
		if(result > 0) {
			mav.addObject("msg", "결재를 정상적으로 처리했습니다.");
		}else {
			mav.addObject("msg", "결재를 처리하지 못했습니다");
		}
		mav.addObject("loc", "/office/approvalBreakRequestView?break_request_no="+breakRequest.getBreak_request_no()+"&navkind="+navkind);
		mav.setViewName("common/msg");
		return mav;
	}
	
	@RequestMapping("/approval/breakRequestReject")
	public ModelAndView breakRequestReject(@RequestParam("break_request_no") String break_request_no, @RequestParam("navkind") String navkind, @RequestParam("approval_status") int approval_status) {
		ModelAndView mav = new ModelAndView();
		BreakRequest breakRequest = new BreakRequest();
		breakRequest.setBreak_request_no(break_request_no);
		breakRequest.setApproval_status(approval_status);
		breakRequest.setApproval_status(breakRequest.getApproval_status()-1);
		breakRequest.setStatus("반려");
		
		int result = approvalService.breakRequestReject(breakRequest);
		
		if(result > 0) {
			mav.addObject("msg", "결재를 정상적으로 처리했습니다.");
		}else {
			mav.addObject("msg", "결재를 처리하지 못했습니다");
		}
		mav.addObject("loc", "/office/approvalBreakRequestView?break_request_no="+breakRequest.getBreak_request_no()+"&navkind="+navkind);
		mav.setViewName("common/msg");
		return mav;
	}
	
}
