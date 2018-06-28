package com.kh.ok.member.controller;



import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.ok.job.model.service.JobService;
import com.kh.ok.job.model.vo.Job;
import com.kh.ok.member.model.service.MemberService;
import com.kh.ok.member.model.vo.Member;


@SessionAttributes({"memberLoggedIn"})
@Controller
public class MemberController {
	private Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private JobService jobService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	//@Autowired	
	//BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@RequestMapping("/member/memberOneSelect.do")
	public ModelAndView memberOneSelect(@RequestParam String userId) {
		ModelAndView mav = new ModelAndView();

		Member member = memberService.selectUserId(userId);
		List<Job> jlist = jobService.selectJobList(member.getCom_no());
		 
		mav.addObject("member",member);
		mav.addObject("jlist",jlist);
		mav.setViewName("member/memberOneView");
		
		return mav;
	}
	
	@RequestMapping("/member/memberOneUpdate.do")
	public String memberOneUpdate( Member member, HttpServletRequest request) {
		
		int result = memberService.memberOneUpdate(member);
		
		request.setAttribute("member", member);
		return "redirect:/member/memberOneSelect.do?userId="+member.getUserId();
	}
	
	@RequestMapping("/member/memberEnroll.do")
	public ModelAndView memberEnroll() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	
	@RequestMapping("/member/memberLogin.do")
	public ModelAndView memberLogin(@RequestParam String userId, @RequestParam String password) {
		ModelAndView mav = new ModelAndView();
		Member m = memberService.selectUserId(userId);
		
		String msg = "";
		String loc = "/";
		if(m==null) {
			msg="존재하지 않는 아이디입니다";
		}else {
			if(bcryptPasswordEncoder.matches(password, m.getPassword())) {
				msg="로그인 성공";
				/*logger.debug("["+userId+"]이 로그인 함.");*/
				loc="/office/office_main.do";
				mav.addObject("memberLoggedIn",m);
			}else {
				msg="비밀번호가 틀렸습니다.";
			}
		}
		mav.addObject("msg",msg);
		mav.addObject("loc",loc);
		//view단지정
		mav.setViewName("common/msg");
		return mav;
	}
	@RequestMapping("/member/memberLogout.do")
	public String memerLogout(SessionStatus sessionStatus) {
		if(logger.isDebugEnabled())
			logger.debug("로그아웃 요청");
		//현재 session상태를 끝났다고 마킹함.
		if(!sessionStatus.isComplete())
			sessionStatus.setComplete();
		return "redirect:/";
	}
	
	@RequestMapping("/member/checkIdDuplicate.do")
	@ResponseBody
	public String checkIdDuplicate(@RequestParam("userId") String userId) 
			throws JsonProcessingException {
		System.out.println(userId);
		logger.debug("@ResponseBody-jsonString ajax : "+userId);
		Map<String,Object> map = new HashMap<String, Object>();
		//jackson라이브러리에서 사용하는 바인더
		ObjectMapper mapper = new ObjectMapper();
		String jsonStr = null;
		
		//업무로직
		int count = memberService.checkIdDuplicate(userId);
		boolean isUsable = count==0?true:false;
		
		//jsonString변환
		map.put("isUsable", isUsable);
		jsonStr = mapper.writeValueAsString(map);
		 
		logger.debug("jsonStr="+jsonStr);
		return jsonStr;
	}
	
	@RequestMapping("/member/memberEnrollEnd.do")
	public ModelAndView memberEnrollEnd(Member member,
									@RequestParam(value="upFile",required=false)
									MultipartFile[] upFiles,
									HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		
		System.out.println("upFiles.length="+upFiles.length);
		logger.debug("upFile1="+upFiles[0].getOriginalFilename());
		logger.debug("upFile2="+upFiles[1].getOriginalFilename());
		
		try {
		
			//1.파일업로드처리
			String saveDirectory = request.getSession()
										  .getServletContext()
										  .getRealPath("/resources/upload/member");
			
			//****** MultipartFile을 이용한 파일 업로드 처리로직 시작 ******//*
			String originalFileName = null;
			String ext = null;
			SimpleDateFormat sdf = null;
			String renamedFileName = null;
			for(MultipartFile f: upFiles) {
				if(!f.isEmpty()) {
					//파일명 재생성
					originalFileName = f.getOriginalFilename();
					ext = originalFileName.substring(originalFileName.lastIndexOf(".")+1);
					sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
					int rndNum = (int)(Math.random()*1000);
					renamedFileName = sdf.format(new Date(System.currentTimeMillis()))+
											"_"+rndNum+"."+ext;
					try {
						f.transferTo(new File(saveDirectory+"/"+renamedFileName));
					} catch (IllegalStateException e) {
						e.printStackTrace();
					} catch (IOException e) {
						e.printStackTrace();
					}
					
				}
			}
			
			MultipartFile pf = upFiles[0];
			if(!pf.isEmpty()) {
				originalFileName = pf.getOriginalFilename();
				ext = originalFileName.substring(originalFileName.lastIndexOf(".")+1);
				sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
				int rndNum = (int)(Math.random()*1000);
				renamedFileName = sdf.format(new Date(System.currentTimeMillis()))+
										"_"+rndNum+"."+ext;
				member.setPhoto(renamedFileName);
			}
			
			pf = upFiles[1];
			if(!pf.isEmpty()) {
				originalFileName = pf.getOriginalFilename();
				ext = originalFileName.substring(originalFileName.lastIndexOf(".")+1);
				sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
				int rndNum = (int)(Math.random()*1000);
				renamedFileName = sdf.format(new Date(System.currentTimeMillis()))+
										"_"+rndNum+"."+ext;
				member.setSign(renamedFileName);
			}
			System.out.println(member);
			//****** MultipartFile을 이용한 파일 업로드 처리로직 끝 ******//*
			//파일이름 멤버에 추가
			//2.비지니스로직
			int result = memberService.memberEnrollEnd(member);
						
			//3.view단 분기
			String loc = "/";
			String msg = "";
			
			if(result>0) {
				msg = "게시물등록성공";
			}
			else
				msg = "게시물등록실패";
			
			mav.addObject("msg", msg);
			mav.addObject("loc", loc);
			mav.setViewName("common/msg");
		
		} catch(Exception e) {
			e.printStackTrace();
		}
		return mav;
	}

	
	@RequestMapping(value = "/member/memberCompanyListAll")
	public @ResponseBody Map memberCompanyListAll(Locale locale, Model model, HttpSession session) {
		
		Member m = (Member) session.getAttribute("memberLoggedIn");
		System.out.println(m.getUserId());
		System.out.println(m.getCom_no());
		
		List<Map<String,String>> ls = memberService.memberCompanyListAll(m.getCom_no());
		List<Map<String,String>> list = new ArrayList<Map<String,String>>();
		for(int i=0; i<ls.size(); i++) {
			list.add(ls.get(i));
		}
		Map<String,String> map = new HashMap();
		map.put("count", ""+ls.size());
		
		list.add(map);
		Map result = new HashMap();
		result.put("members",  list);
	
		
		
		return result;
	}

}
