package com.event.evengers_v2.bean;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Alias("calculate")
@Data
public class Calculate {
	private String cal_code;
	private String c_id;
	private Date cal_receiptdate;
	private String cal_category;
	private String cal_contents;
	private int cal_price;
}
