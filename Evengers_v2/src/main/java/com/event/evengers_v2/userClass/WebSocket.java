package com.event.evengers_v2.userClass;

import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;

@ServerEndpoint(value="/webSocket")
public class WebSocket {
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	private static Set<Session> clients
		=Collections.synchronizedSet(new HashSet<Session>());
	
	@OnOpen
	public void opOpen(Session session) throws Exception {
		clients.add(session);
		logger.info("서버접속 : "+session.getId());
		logger.info("접속자 수 : "+clients.size()+"명");
		String msg="접속되었습니다";
		systemMsg("시스템: 새로운 사람이 입장했습니다. 현재 접속자 수:"+clients.size()+"명");
		pushMessage(session,msg);
	}

	public void pushMessage(Session session, String msg) 
			throws Exception{		
		session.getBasicRemote().sendText(msg);		
	}

	@OnClose
	public void onClose(Session session) throws Exception{
		logger.info("서버종료");
		clients.remove(session);
		logger.info("접속자 수 : "+clients.size()+"명");
		systemMsg("시스템: 누군가 퇴장했습니다. 현재 접속자 수:"+clients.size()+"명");
	}
	
	@OnMessage
	public void onMessage(String message, Session session) throws Exception{
		JSONParser parser = new JSONParser();
		JSONObject obj = (JSONObject)parser.parse(message);
		logger.info("object : "+obj);
		String nick = obj.get("nick").toString();
		String msg = obj.get("msg").toString();
		logger.info(nick+"> "+msg);
		String text=nick+"> "+msg;
		
		synchronized (clients) {
			for(Session client:clients) {
				if(!client.equals(session)) {
					client.getBasicRemote().sendText(text);
				}
			}
		}
	}
	
	private void systemMsg(String msg) throws Exception{
		synchronized (clients) {
			for(Session client:clients) {
				client.getBasicRemote().sendText(msg);
			}
		}
	}
}
