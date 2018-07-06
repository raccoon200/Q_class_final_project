package com.kh.ok.address.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.ok.address.model.service.AddressService;
import com.kh.ok.address.model.vo.Address;
import com.kh.ok.member.model.vo.Member;


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
	
	
	@RequestMapping("/address/addressTrash")
	public ModelAndView addressTrash(HttpServletRequest request){
		
		String addId= request.getParameter("addId");
		System.out.println("addId=" + addId);
		System.out.println("여기 들어오나??");
		
		ModelAndView mav = new ModelAndView();
		int result = addressService.addressTrash(addId);
		List<Address> list = addressService.addressView();
		logger.info(list.toString());
		mav.addObject("address", list);

		mav.setViewName("address/addressView");
			
		return mav;
	}
	
	@RequestMapping("/address/addressTrashList")
	public ModelAndView addressTrashList(HttpServletRequest request){
		
		ModelAndView mav = new ModelAndView();
		List<Address> list = addressService.addressTrashList();
		logger.info(list.toString());
		mav.addObject("address", list);
		mav.setViewName("address/addressTrash");
			
		return mav;
	}
/*	@RequestMapping(value ="/address/addressTrash", method = RequestMethod.POST)
	public String addressTrash(@RequestParam("addressTrashList") Address addressTrashList, ModelMap modelMap) throws Exception {
	    // 삭제할 사용자 ID마다 반복해서 사용자 삭제
	    for (String userId : addressTrashList) {
	        System.out.println("주소 삭제 = " + addressAdd());
	        int delete_count = addressService.addressAdd(addressTrashList);
	    }
	    // 목록 페이지로 이동
	    return "address/addressTrash";
	}*/
	
	
	@RequestMapping("/address/addressAdd.do")
	public String addressAdd() {
		if(logger.isDebugEnabled())
			logger.debug("주소 추가완료");
	
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
	
	
	@RequestMapping("/address/InsertAddress.do")
	public String InsertAddress(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
	      String userId = null;
	      String comId = null;
	      if(session != null && session.getAttribute("memberLoggedIn") != null) {
	          userId = ((Member)session.getAttribute("memberLoggedIn")).getUserId();   
	          comId = ((Member)session.getAttribute("memberLoggedIn")).getCom_no();
	      }
	  
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String tag = request.getParameter("tag");
		String company = request.getParameter("company");
		String address = request.getParameter("address");
		String anniversary = request.getParameter("anniversary");
		String memo = request.getParameter("memo");
		System.out.println("userId" + userId);
		System.out.println("comId" + comId);    //com_No
		System.out.println("name" + name);
		System.out.println("email" + email);
		System.out.println("phone" + phone);
		System.out.println("tag" + tag);
		System.out.println("company" + company);
		System.out.println("address" + address);
		System.out.println("anniversary" + anniversary);
		System.out.println("memo" + memo);
	
		
		Map<String,Object> map = new HashMap<>();
		map.put("comId",comId);
		map.put("userId",userId);
		map.put("name",name);
		map.put("phone",phone);
		map.put("email",email);
		map.put("tag",tag);
		map.put("company",company);
		map.put("address",address);
		map.put("anniversary",anniversary);
		map.put("memo",memo);
	
		int result = addressService.InsertAddress(map);
				
		return "address/addressAdd";
	}
 
	
}








