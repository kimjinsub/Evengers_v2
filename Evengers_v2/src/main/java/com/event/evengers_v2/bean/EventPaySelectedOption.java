package com.event.evengers_v2.bean;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Alias("eventpayselectedoption")
@Data
public class EventPaySelectedOption {
	private String eps_code;
	private String eo_code;
	private String ep_code;
}
