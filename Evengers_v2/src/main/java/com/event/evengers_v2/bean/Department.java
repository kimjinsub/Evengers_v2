package com.event.evengers_v2.bean;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Alias("department")
@Data
public class Department {
	private String dept_code;
	private String dept_name;
	private String c_id;
}
