package com.kh.ok.loginmanager;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

public class LoginManager {
	private static LoginManager loginManager = null;
	//로그인한 접속자를 담기위한 해시테이블
	private static HashMap<String, HttpSession> sessionMap = new HashMap<String, HttpSession>();
	
	/**
	 * 싱글톤패턴 사용
	 */
	public static synchronized LoginManager getInstance() {
		if(loginManager == null) {
			loginManager = new LoginManager();
		}
		return loginManager;
	}
	
	//전체 출력
	public void sessionAllPut() throws Exception{
		System.out.println(sessionMap);
	}
	
	//session보관
	public void sessionMapPut(String adminId, HttpSession session) throws Exception{
		sessionMap.put(adminId, session);
	}
	
	public HttpSession sessionIdRturn(String adminId) throws Exception{
		HttpSession temp = (HttpSession)sessionMap.get(adminId);
		return temp;
	}
	//보관중인 session 삭제
	public void sessionMapDel(String adminId) throws Exception{
		sessionMap.remove(adminId);
	}
	
	//session 중인 ID 찾기
	public Boolean sessionSearch(String adminId) throws Exception{
		HttpSession temp = sessionMap.get(adminId);
		if(temp != null) {
			return true;
		}else {
			return false;
		}
	}
}
