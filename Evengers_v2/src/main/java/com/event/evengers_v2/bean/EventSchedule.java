package com.event.evengers_v2.bean;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Alias("eventschedule")
@Data
public class EventSchedule {
	private String es_code;
	private String ep_code;
	private String dept_code;
}
