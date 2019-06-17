package com.event.evengers_v2.userClass;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.security.core.userdetails.User;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class WebSocketHandler extends TextWebSocketHandler{
	List<WebSocketSession> sessions = new ArrayList<>();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// 커넥션이 연결 됐을때
		System.out.println("AfterConnectionEstablished:"+session);
		sessions.add(session);
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// 소켓에 메세지를 보냈을때
		System.out.println("handleTextMessage:"+session);
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		// 커넥션이 클로즈 됐을때
		System.out.println("afterConnectionClosed:"+session);
	}
	
}
