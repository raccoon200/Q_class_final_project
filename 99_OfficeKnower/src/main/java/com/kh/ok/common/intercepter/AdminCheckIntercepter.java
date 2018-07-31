package com.kh.ok.common.intercepter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.kh.ok.member.model.vo.Member;

public class AdminCheckIntercepter extends HandlerInterceptorAdapter{
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession(false);
		if(session != null) {
			if(session.getAttribute("memberLoggedIn") != null) {
				Member m = (Member)session.getAttribute("memberLoggedIn");
				System.out.println(m.getGrade());
				System.out.println(m.getGrade().contains("관리자"));
				if(m.getGrade() == null || !m.getGrade().contains("관리자")) {
					request.setAttribute("msg", "잘못된 경로입니다.c");
					request.setAttribute("loc", "/");
					request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
					return false;
				}
			}
		}
		return super.preHandle(request, response, handler);
	}
}
