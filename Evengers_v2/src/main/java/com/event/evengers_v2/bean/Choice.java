package com.event.evengers_v2.bean;

import org.apache.ibatis.type.Alias;

import lombok.Data;
@Alias("choice")
@Data
public class Choice {
	private String e_code;
	private String m_id;

}
