package com.event.evengers_v2.bean;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Alias("position")
@Data
public class Position {
	private String p_code;
	private String p_name;
	private String c_id;
	private int p_salary;
}
