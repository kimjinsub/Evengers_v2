package com.event.evengers_v2.bean;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Alias("estimateschedule")
@Data
public class EstimateSchedule {
	private String ests_code;
	private String estp_code;
	private String dept_code;
}
