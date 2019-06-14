package com.event.evengers_v2.bean;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;
@Alias("eventrefund")
@Data
public class EventRefund {
	 	private String er_code; 
	 	private Date er_refunddate; 
	 	private String ep_code; 
	 	private int er_penalty; 
	 	private int er_state; 
}