package com.event.evengers_v2.handler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.google.gson.Gson;

@Service
public class WebSocketHandler extends TextWebSocketHandler{
	List<WebSocketSession> sessions = new ArrayList<>();
	private Logger logger = LoggerFactory.getLogger(WebSocketHandler.class);
	Map<String,Object> box;
	@Autowired
	MemberDao mDao;
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// 커넥션이 연결 됐을때
		sessions.add(session);
		logger.info("첫 웹소켓 연결됨 ID:"+session);
		logger.info("id:"+session.getId());
		logger.info("연결 IP:"+session.getRemoteAddress().getHostName());

		Map<String, Object> httpSession = session.getAttributes();
		int chatInNow=mDao.chatInCheck(httpSession.get("id").toString());
		if(chatInNow==0) {
			mDao.chatIn(session.getId(), httpSession.get("id").toString());
			Map<String,String> ceoConnMsg = new HashMap<>();
			ceoConnMsg.put("ceoConnMsg", "상담 접속에 성공하였습니다.");
			handleTextMessage(session, new TextMessage(new Gson().toJson(ceoConnMsg)));
		}else {
			Map<String,String> connMsg = new HashMap<>();
			connMsg.put("doubleChat", "y");
			handleTextMessage(session, new TextMessage(new Gson().toJson(connMsg)));
		}
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) 
			throws Exception {
		JSONParser parser = new JSONParser();
		JSONObject obj=new JSONObject();
		obj = (JSONObject) parser.parse(message.getPayload());
		
		if(obj.get("doubleChat")!=null) {
			box=new HashMap<>();
			box.put("doubleChat","y");
			box.put("connFailMsg","이전 상담을 종료하고 다시 시도해주세요");
			session.sendMessage(new TextMessage(new Gson().toJson(box)));
		}
		if(obj.get("ceoConnMsg")!=null) {
			box=new HashMap<>();
			box.put("ceoConnMsg",obj.get("ceoConnMsg"));
			session.sendMessage(new TextMessage(new Gson().toJson(box)));
		}
		//sender,receiver : httpSession id
		//sender_wsId,receiver_wsId : webSocket id
		String sender=session.getAttributes().get("id").toString();
		String sender_wsId=session.getId();
		String receiver="";
		String receiver_wsId="";
		if(obj.get("receiver")!=null) {
			receiver=obj.get("receiver").toString();
			receiver_wsId=mDao.getSessionId(receiver);
		}
		//ArrayList<String> receiver_sessionIdList=mDao.getSessionId(receiver);//websocket id
		/////////////////////////////////////
		
		//소비자의 상담요청으로 판매자에게 보내는 메세지
		if(obj.get("connMsg")!=null) {//sender:member -> receiver:ceo
			if(mDao.chatInCheck(receiver)==1) {//ceo접속중
				if(mDao.getStats(receiver)==0) {//ceo채팅중아님
					for(WebSocketSession wss:sessions) {
						if(wss.getId().equals(receiver_wsId)) {
							box=new HashMap<>();box.put("receiver", receiver);box.put("sender", sender);
							box.put("connMsg",obj.get("connMsg"));
							wss.sendMessage(new TextMessage(new Gson().toJson(box)));
							mDao.updateStats(receiver,1);
							//1:채팅중, 0:채팅중아님
						}
					}
					box=new HashMap<>();box.put("receiver", receiver);box.put("sender", sender);
					box.put("connMsg",receiver+"님이 연결되었습니다");
					session.sendMessage(new TextMessage(new Gson().toJson(box)));
					mDao.updateStats(sender,1);
					
				}else {//ceo가 이미 채팅 중
					box=new HashMap<>();box.put("receiver", receiver);box.put("sender", sender);
					box.put("connMsgFail1","상대방이 이미 채팅중입니다.");
					session.sendMessage(new TextMessage(new Gson().toJson(box)));
					afterConnectionClosed(session, new CloseStatus(1000));
				}
			}else {//ceo미접속
				box=new HashMap<>();box.put("receiver", receiver);box.put("sender", sender);
				box.put("connMsgFail2","상대방이 접속중이지 않습니다.");
				session.sendMessage(new TextMessage(new Gson().toJson(box)));
				afterConnectionClosed(session, new CloseStatus(1000));
			}
		}
		
		///////////서로가 접속시 서로에게 보내는 메시지
		if(obj.get("msg")!=null) {
			if(mDao.chatInCheck(receiver)==1) {
				for(WebSocketSession wss:sessions) {
					if(wss.getId().equals(receiver_wsId)) {
						box=new HashMap<>();box.put("receiver", receiver);box.put("sender", sender);
						box.put("msg",sender+":"+obj.get("msg"));
						wss.sendMessage(new TextMessage(new Gson().toJson(box)));
					}
				}
			}else {//unreachable
				box=new HashMap<>();box.put("receiver", receiver);box.put("sender", sender);
				box.put("msg",receiver+"님이 없습니다.");
				session.sendMessage(new TextMessage(new Gson().toJson(box)));
			}
		}
		///////////////////
		if(obj.get("memberDisConnMsg")!=null) {
			for(WebSocketSession wss:sessions) {
				if(wss.getId().equals(receiver_wsId)) {
					box=new HashMap<>();box.put("receiver", receiver);box.put("sender", sender);
					box.put("memberDisConnMsg",obj.get("memberDisConnMsg"));
					wss.sendMessage(new TextMessage(new Gson().toJson(box)));
					mDao.updateStats(receiver, 0);
					
				}
			}
			box=new HashMap<>();box.put("receiver", sender);box.put("sender", receiver);
			box.put("memberDisConnMsg",receiver+"님과의 상담이 종료되었습니다.");
			session.sendMessage(new TextMessage(new Gson().toJson(box)));
			mDao.updateStats(sender, 0);
			afterConnectionClosed(session, new CloseStatus(1000));
		}
		if(obj.get("ceoDisConnMsg")!=null) {
			logger.info("...왜냐구");
			System.out.println("=============================================");
			System.out.println(sessions);
			WebSocketSession disWs = null;
			for(WebSocketSession wss:sessions) {
				if(wss.getId().equals(receiver_wsId)) {
					box=new HashMap<>();box.put("receiver", receiver);box.put("sender", sender);
					box.put("ceoDisConnMsg",obj.get("ceoDisConnMsg"));
					wss.sendMessage(new TextMessage(new Gson().toJson(box)));
					mDao.updateStats(receiver, 0);
					disWs=wss;
				}
			}
			box=new HashMap<>();box.put("receiver", sender);box.put("sender", receiver);
			box.put("ceoDisConnMsg",receiver+"님과의 상담이 종료되었습니다.\n새로운 상담을 기다립니다.");
			session.sendMessage(new TextMessage(new Gson().toJson(box)));
			mDao.updateStats(sender, 0);
			afterConnectionClosed(disWs, new CloseStatus(1000));
		}
		if(obj.get("finishChat")!=null) {
			logger.info("...왜냐구");
			System.out.println("=============================================");
			System.out.println(sessions);
			WebSocketSession disWs = null;
			for(WebSocketSession wss:sessions) {
				if(wss.getId().equals(receiver_wsId)) {
					box=new HashMap<>();box.put("receiver", receiver);box.put("sender", sender);
					box.put("finishChat",obj.get("finishChat"));
					wss.sendMessage(new TextMessage(new Gson().toJson(box)));
					mDao.updateStats(receiver, 0);
					disWs=wss;
				}
			}
			box=new HashMap<>();box.put("receiver", sender);box.put("sender", receiver);
			box.put("finishChat",receiver+"님과의 상담이 종료되었습니다.\n상담을 종료합니다");
			session.sendMessage(new TextMessage(new Gson().toJson(box)));
			mDao.updateStats(sender, 0);
			if(disWs!=null) {
				afterConnectionClosed(disWs, new CloseStatus(1000));
			}
			afterConnectionClosed(session, new CloseStatus(1000));
		}
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		// 커넥션이 클로즈 됐을때
		sessions.remove(session);
		logger.info("afterConnectionClosed:"+session);
		mDao.chatOut(session.getAttributes().get("id").toString());
	}
}
