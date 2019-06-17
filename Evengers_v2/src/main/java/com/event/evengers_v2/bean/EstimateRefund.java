package com.event.evengers_v2.bean;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;
@Alias("estimaterefund")
@Data
public class EstimateRefund {
	private String estr_code;
	private Date estr_refunddate;
	private String estp_code;
	private int estr_penalty;
	private int estr_state;
}
