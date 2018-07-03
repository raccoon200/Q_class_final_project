package com.kh.ok.common.intercepter;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.kh.ok.member.model.vo.Member;

public class CompanyCheckIntercepter extends HandlerInterceptorAdapter{
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession();
		
		if(session.getAttribute("memberLoggedIn") != null) {
			Member m = (Member)session.getAttribute("memberLoggedIn");
			if(m.getCom_no()==null) {
				response.sendRedirect("/ok/");
				return false;
			}
		}
		return super.preHandle(request, response, handler);
	}

}
