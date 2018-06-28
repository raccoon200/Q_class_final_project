package com.kh.ok.address.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.ok.address.model.service.AddressService;
import com.kh.ok.address.model.vo.Address;


@Controller
public class AddressController {
	
	private Logger logger = 
			LoggerFactory.getLogger(getClass());
	
	@Autowired
	private AddressService addressService;
	
	/*@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;*/
	
	@RequestMapping("/address/addressView.do")
	public ModelAndView addressView(){
		
		
		ModelAndView mav = new ModelAndView();
		List<Address> list = addressService.addressView();
		logger.info(list.toString());
		mav.addObject("address", list);
		mav.setViewName("address/addressView");
		
		return mav;
	}
	
	
	
	@RequestMapping("/address/addressAdd.do")
	public String addressAdd() {
		if(logger.isDebugEnabled())
			logger.debug("주소 추가");
		
  
		return "address/addressAdd";
	}

	
	
	
	
	
	
	@RequestMapping("/address/addressAddEnd.do")
	public String addressAddEnd(Address address, Model model){
		if(logger.isDebugEnabled())
			logger.debug("주소 추가 저장완료");

		//1.비지니스로직 실행
		int result = addressService.addressAdd(address);
		System.out.println("result" + result);
		
		//2.처리결과에 따라 view단 분기처리
		String loc = "/"; 
		String msg = "";
		if(result>0) msg="주소추가 완료되었습니다.";
		else msg="주소추가 실패하였습니다.";
		
		model.addAttribute("loc", loc);
		model.addAttribute("msg", msg);
		
		return "common/msg";
	}
	
	

	
/*	@RequestMapping("/address/addressUpdate.do")
	public ModelAndView addressUpdate(Address address){
		if(logger.isDebugEnabled())
			logger.debug("주소록 수정");
		
		ModelAndView mav = new ModelAndView();
		System.out.println(address);
			
		//1.비지니스로직 실행
		int result = addressService.addressUpdate(address);
		
		//2.처리결과에 따라 view단 분기처리
		String loc = "/"; 
		String msg = "";
			if(result>0){ 
				msg="회원정보수정성공!";
				mav.addObject("addressOk", address);
			}
			else msg="회원정보수정실패!";
		
		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		mav.setViewName("common/msg");
		
		return mav;
	}*/
	

	
}








