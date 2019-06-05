package com.event.evengers_v2.bean;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Alias("eventimage")
@Data
public class EventImage {
	private String ei_code;
	private String ei_orifilename;
	private String ei_sysfilename;
	private String e_code;
	
}
