package com.kh.ok.insa.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.kh.ok.insa.model.service.InsaService;
import com.kh.ok.member.model.vo.Member;

@SessionAttributes({"memberLoggedIn"})
@Controller
public class InsaController {
	@Autowired
	private InsaService insaService;
	
	@RequestMapping("/insa/memberListAll.do")
	public ModelAndView memberListAll(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		Member m = null;
		if(request.getSession(false) != null);
			m = (Member)request.getSession().getAttribute("memberLoggedIn");
		List<Member> list =  insaService.memberListAll(m.getCom_no());
		List<String> yearList = insaService.yearListGroup(m.getCom_no());
		List<String> positionList = insaService.positionListGroup(m.getCom_no());
		
			
		for(int i =0; i<list.size(); i++) {
			if(list.get(i).getPosition() == null)
				list.get(i).setPosition("미기재");
		}
			
//		System.out.println(list);
//		System.out.println(yearList);
		System.out.println(positionList);
		
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
												@RequestParam("com_no") String com_no) throws JsonProcessingException {
		
		Map<String,String> map = new HashMap<String,String>();
		map.put("searchKey", searchKey);
		map.put("com_no", com_no);
		List<Member> list = new ArrayList<Member>();	
		
		list = insaService.insaMemberSearch(map);
		
		System.out.println("searchKey="+searchKey);
		System.out.println("com_no="+com_no);
		
		
		return list;
	}
}
