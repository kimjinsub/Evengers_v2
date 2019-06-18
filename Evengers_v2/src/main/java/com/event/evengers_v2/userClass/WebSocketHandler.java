package com.event.evengers_v2.userClass;

import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.event.evengers_v2.dao.MemberDao;

@Service
public class WebSocketHandler extends TextWebSocketHandler{
	List<WebSocketSession> sessions = new ArrayList<>();
	private Logger logger = LoggerFactory.getLogger(WebSocketHandler.class);
	
	@Autowired
	MemberDao mDao;
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// 커넥션이 연결 됐을때
		sessions.add(session);
		logger.info("AfterConnectionEstablished:"+session);
		logger.info("id:"+session.getId());
		logger.info("연결 IP:"+session.getRemoteAddress().getHostName());
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// 소켓에 메세지를 보냈을때
		logger.info("handleTextMessage:"+session);
		logger.info("TextMessage-content:"+message.getPayload());
		JSONParser parser = new JSONParser();
		JSONObject obj = (JSONObject) parser.parse(message.getPayload());
		logger.info("parsed message...:");
		logger.info("nick:"+obj.get("nick"));
		logger.info("receiver:"+obj.get("receiver"));
		logger.info("sender:"+obj.get("sender"));
		logger.info("msg:"+obj.get("msg"));
		String receiver=obj.get("receiver").toString();
		String sender=obj.get("sender").toString();
		int chatInNow=mDao.chatInCheck(sender);
		if(chatInNow==0) {
			mDao.chatIn(session.getId(),sender);
		}
		String receiver_sessionId=mDao.getCeoSessionId(receiver);
		if(receiver_sessionId==null) {
			for(WebSocketSession wss:sessions) {
				if(wss.getId()==session.getId()) {
					wss.sendMessage(new TextMessage("상대가 비로그인 상태입니다"));
				}
			}
		}
		for(WebSocketSession wss:sessions) {
			if(wss.getId()==receiver_sessionId) {
				wss.sendMessage(new TextMessage(obj.get("nick")+":"+obj.get("msg")));
				//wss.sendMessage(new TextMessage(session.getId()+":"+message.getPayload()));
			}
		}
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		// 커넥션이 클로즈 됐을때
		sessions.remove(session);
		logger.info("afterConnectionClosed:"+session);
		if(mDao.chatOut(session.getId())) {
			logger.info(session.getId()+"님이 퇴장하셨습니다");
		}
	}
	
}
