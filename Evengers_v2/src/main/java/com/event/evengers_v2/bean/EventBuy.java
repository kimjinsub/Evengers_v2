package com.event.evengers_v2.bean;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Alias("eventbuy")
@Data
public class EventBuy {
	private String eb_code;
	private String e_code;
	private String m_id;
	private int eb_total;
	private Date eb_dday;
}
