package com.kh.ok.approval.controller;

import java.io.File;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
import com.kh.ok.approval.model.vo.Connect;
import com.kh.ok.approval.model.vo.Dept;
import com.kh.ok.approval.model.vo.Title_of_Account;
import com.kh.ok.member.model.vo.Member;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
public class ApprovalController {
	@Autowired
	private ApprovalService approvalService;
	Logger logger = LoggerFactory.getLogger(getClass());
	@RequestMapping("/office/approval.do")
	public ModelAndView approvalDagi () {
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("approval/approval_dagi");
		return mav;
	}
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
	public ModelAndView approvalInsert(Locale locale, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		
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
	public ModelAndView approvalSignUpdate(HttpSession session, String basicFile, @RequestParam(value = "upFile", required = false) MultipartFile upFile,
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
}
