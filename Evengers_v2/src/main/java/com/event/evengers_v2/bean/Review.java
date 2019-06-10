package com.event.evengers_v2.bean;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Alias("review")
@Data
public class Review {
	private String e_code;
	private String m_id;
	private String re_writedate;
	private String re_contents;
	private int re_stars;
}