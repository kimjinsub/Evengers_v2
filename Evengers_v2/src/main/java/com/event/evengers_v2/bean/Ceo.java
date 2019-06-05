package com.event.evengers_v2.bean;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Alias("ceo")
@Data
public class Ceo {
	//기업 
	private String c_id;
	private String c_pw;
	private String c_name;
	private String c_tel;
	private String c_email;
	private String c_email1;		//이메일 뒷자리
	private String c_rn;
	
}
