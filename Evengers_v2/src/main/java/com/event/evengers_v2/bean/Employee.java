package com.event.evengers_v2.bean;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Alias("employee")
@Data
public class Employee {
	private String emp_code;
	private String emp_name; 
	private String c_id;
	private String p_code;
	private String dept_code; 
	private String emp_rrn;
	private Date emp_enterdate;
	private String emp_tel;
	private String emp_addr;
	private String emp_email;
	private String emp_bank;
	private String emp_acnumber;
	private String emp_orifilename;
	private String emp_sysfilename;
}
