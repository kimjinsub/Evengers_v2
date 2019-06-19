package com.event.evengers_v2.bean;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Alias("waitingroom")
@Data
public class WaitingRoom {
	private String c_id;
	private String m_id;
}
