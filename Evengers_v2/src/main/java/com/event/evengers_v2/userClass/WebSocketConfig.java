package com.event.evengers_v2.userClass;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

@Configuration
@EnableWebSocket
public class WebSocketConfig implements WebSocketConfigurer{
	@Autowired
	private WebSocketHandler websockethandler;

	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		registry.addHandler(websockethandler, "/webSocket").setAllowedOrigins("*")
		.withSockJS();
		/*registry.addHandler(websockethandler, "/webSocket").setAllowedOrigins("*")
		.withSockJS().setInterceptors(new HttpSessionHandshakeInterceptor())
		.setClientLibraryUrl("http://localhost/evengers_v2/js/sockjs.min.js");*/
	}
	
	
}