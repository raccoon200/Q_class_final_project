package com.kh.ok.member.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.ok.member.model.service.MemberService;
import com.kh.ok.member.model.vo.Member;


@SessionAttributes({"memberLoggedIn"})
@Controller
public class MemberController {
	private Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	
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
		Map<String,Object> map = new HashMap<>();
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
	/*@RequestMapping("/member/memberEnrollEnd.do")
	public ModelAndView insertBoard(Member m,
									@RequestParam(value="upFile",required=false)
									MultipartFile[] upFiles,
									HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		logger.debug("게시판 페이지저장");
		
		logger.debug("upFiles.length="+upFiles.length);
		logger.debug("upFile1="+upFiles[0].getOriginalFilename());
		logger.debug("upFile2="+upFiles[1].getOriginalFilename());
		
		try {
		
			//1.파일업로드처리
			String saveDirectory = request.getSession()
										  .getServletContext()
										  .getRealPath("/resources/upload/member");
			
			*//****** MultipartFile을 이용한 파일 업로드 처리로직 시작 ******//*
			for(MultipartFile f: upFiles) {
				if(!f.isEmpty()) {
					//파일명 재생성
					String originalFileName = f.getOriginalFilename();
					String ext = originalFileName.substring(originalFileName.lastIndexOf(".")+1);
					SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
					int rndNum = (int)(Math.random()*1000);
					String renamedFileName = sdf.format(new Date(System.currentTimeMillis()))+
											"_"+rndNum+"."+ext;
					try {
						f.transferTo(new File(saveDirectory+"/"+renamedFileName));
					} catch (IllegalStateException e) {
						e.printStackTrace();
					} catch (IOException e) {
						e.printStackTrace();
					}
					//VO객체 담기
					Attachment attach = new Attachment();
					attach.setOriginalFileName(originalFileName);
					attach.setRenamedFileName(renamedFileName);
					attachList.add(attach);
				}
			}
			*//****** MultipartFile을 이용한 파일 업로드 처리로직 끝 ******//*
			logger.debug("attachList="+attachList);
			
			//2.비지니스로직
			int result = boardService.insertBoard(board, attachList);
			int boardNo = board.getBoardNo();
			logger.debug("boardNo@controller="+boardNo);
			
			//3.view단 분기
			String loc = "/";
			String msg = "";
			
			if(result>0) {
				msg = "게시물등록성공";
				loc = "/board/boardView.do?no="+boardNo;
			}
			else
				msg = "게시물등록실패";
			
			mav.addObject("msg", msg);
			mav.addObject("loc", loc);
			mav.setViewName("common/msg");
		
		} catch(Exception e) {
			throw new BoardException("게시물등록오류");
		}
		
		return mav;
	}*/
}
