package com.event.evengers_v2.bean;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Alias("eventpay")
@Data
public class EventPay {
	private String ep_code;
	private String e_code;
	private String m_id;
	private int ep_total;
	private Date ep_dday;
	private Date ep_payday;
	private int ep_refundstate;
}
