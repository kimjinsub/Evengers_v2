package com.event.evengers_v2.bean;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Alias("chat")
@Data
public class Chat {
	private String id;
	private String sessionid;
}
