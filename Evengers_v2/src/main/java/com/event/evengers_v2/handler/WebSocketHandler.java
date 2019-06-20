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
		logger.info("AfterConnectionEstablished:"+session);
		logger.info("id:"+session.getId());
		logger.info("연결 IP:"+session.getRemoteAddress().getHostName());
		
		Map<String, Object> httpSession = session.getAttributes();
		/*int chatInNow=mDao.chatInCheck(httpSession.get("id").toString());
		if(chatInNow==0) {
			mDao.chatIn(session.getId(), httpSession.get("id").toString());
		}*///ceo에서 여러개를 받지못함
		mDao.chatIn(session.getId(), httpSession.get("id").toString());
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		JSONParser parser = new JSONParser();
		JSONObject obj=null;
		obj = (JSONObject) parser.parse(message.getPayload());
		String sender=session.getAttributes().get("id").toString();
		logger.info("sender="+sender);//evengers id : mem
		int flag=mDao.memberDoubleChk(session.getAttributes().get("id").toString());
		String receiver=obj.get("receiver").toString();//evengers_id
		ArrayList<String> receiver_sessionIdList=mDao.getSessionId(receiver);//websocket id
		/////////////////////////////////////
		if(obj.get("matching")!=null) {
			if(obj.get("matching").equals("yes")) {//ceo에서 요청하니...sender:ceo receiver:member
				mDao.removeOtherWS(sender,session.getId());//새로연결된 세션빼고 나머지 같은아이디 CHAT테이블에서 제거
				mDao.waitingOut(sender,receiver);//대기실에서 매칭된 대기목록 지우기
			}
		}
		if(obj.get("disConn")!=null) {
			if(obj.get("disConn").equals("yes")) {//member에서요청하니 sender:member receiver:ceo
				mDao.waitingOut(receiver,sender);//대기실에서 매칭된 대기목록 지우기
			}
		}
		/////////////////////////////////
		switch(flag) {
			case sentFrom.CEO://ceo가 sendMsg()했을때
				for(WebSocketSession wss:sessions) {
					logger.info("ceo to mem");
					for(String receiver_sessionId:receiver_sessionIdList) {
						logger.info("receiver_sessionId:"+receiver_sessionId);
						if((wss.getAttributes().get("id").toString()).equals(receiver)) {//상대(member)에게만//websocket id
							box=new HashMap<>();
							box.put("sender", sender);
							if(obj.get("sysMsg")!=null) {
								box.put("sysMsg", obj.get("sysMsg"));
							}else {
								box.put("msg", obj.get("nick")+":"+obj.get("msg"));
							}
							wss.sendMessage(new TextMessage(new Gson().toJson(box)));
						}
					}
				}
				break;
			case sentFrom.MEMBER://member가 sendMsg()했을때
				for(WebSocketSession wss:sessions) {
					logger.info("mem to ceo");
					for(String receiver_sessionId:receiver_sessionIdList) {
						logger.info("receiver_sessionId:"+receiver_sessionId);
						if((wss.getAttributes().get("id").toString()).equals(receiver)) {//상대(ceo)에게만
							box=new HashMap<>();
							box.put("sender", sender);
							if(obj.get("disConnMsg")!=null) {
								box.put("disConnMsg", obj.get("disConnMsg"));
							}else {
								box.put("msg", obj.get("nick")+":"+obj.get("msg"));
							}
							/////////////////////
							if(obj.get("connMsg")!=null) {
								box.put("connMsg", obj.get("connMsg"));
								if(mDao.alreadyWait(receiver,sender)==0) {//1:대기중 0:대기X
									mDao.inWaitingRoom(receiver,sender);
									box.put("hasNewReq", "yes");
								}
							}
							wss.sendMessage(new TextMessage(new Gson().toJson(box)));
						}
					}
				}
				break;
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
		int flag=mDao.memberDoubleChk(session.getAttributes().get("id").toString());
		logger.info("flag="+flag);
	}
}
