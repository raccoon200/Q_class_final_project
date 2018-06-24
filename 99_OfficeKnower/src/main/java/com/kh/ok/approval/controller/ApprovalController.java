package com.kh.ok.approval.controller;

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
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.ok.approval.model.service.ApprovalService;
import com.kh.ok.approval.model.vo.Connect;
import com.kh.ok.approval.model.vo.Dept;
import com.kh.ok.approval.model.vo.Title_of_Account;
import com.kh.ok.member.model.vo.Member;

@Controller
public class ApprovalController {
	@Autowired
	private ApprovalService approvalService;
	
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
}
