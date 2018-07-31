package com.kh.ok.websocket;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.kh.ok.member.model.vo.Member;

public class WebSocketHandler extends TextWebSocketHandler {
	//전체 채팅
	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		sessionList.add(session);
		Map<String, Object> map = session.getAttributes();
		Member m = (Member)map.get("memberLoggedIn");
		logger.info("{} 연결됨", m.getUserId());
		System.out.println("채팅장 입장자 : " + m.getUserId());
	}


	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		/*for(int i = 0; i < 10; i++) {
			session.sendMessage(new TextMessage(message.getPayload()));
			Thread.sleep(1000);
		}*/
		Map<String, Object> map = session.getAttributes();
		Member m = (Member)map.get("memberLoggedIn");

		logger.info("{} 로부터 {} 받음",m.getUserId(), message.getPayload());
		
		for(WebSocketSession sess : sessionList) {
			Member m2 = (Member)(sess.getAttributes().get("memberLoggedIn"));
			if(m.getCom_no().equals(m2.getCom_no())){				
				sess.sendMessage(new TextMessage(m.getUserId()+"|"+message.getPayload()));
			}
		}
	}


	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		sessionList.remove(session);
		
		Map<String, Object> map = session.getAttributes();
		Member m = (Member)map.get("memberLoggedIn");
		
		logger.info("{} 연결 끊김", m.getUserId());
		
		System.out.println("채팅방 퇴장자 : " + m.getUserId());
	}
}
