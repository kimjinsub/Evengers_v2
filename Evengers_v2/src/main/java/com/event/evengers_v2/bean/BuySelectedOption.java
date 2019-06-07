package com.event.evengers_v2.bean;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Alias("buyselectedoption")
@Data
public class BuySelectedOption {
	private String bs_code;
	private String eo_code;
	private String eb_code;
}
