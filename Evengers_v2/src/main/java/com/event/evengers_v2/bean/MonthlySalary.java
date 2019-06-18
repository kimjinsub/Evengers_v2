package com.event.evengers_v2.bean;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Alias("monthlysalary")
@Data
public class MonthlySalary {
	private String ms_emp_code;
	private Date ms_date;
	private String ms_p_code;
	private String ms_c_id;
	private String ms_p_name;
	private int ms_p_salary;
	private String ms_emp_name;
}
