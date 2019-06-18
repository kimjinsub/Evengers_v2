package com.event.evengers_v2.bean;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Alias("estimatepay")
@Data
public class EstimatePay {
	private String estp_code;
	private String req_code;
	private String estp_contents;
	private String c_id;
	private int estp_total;
	@JsonFormat(pattern="yyyy-MM-dd")
	private Date estp_payday;
	private int estp_refunddate;
	private int estp_refundstate;
	
}
