package com.event.evengers_v2.bean;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Alias("eventcategory")
@Data
public class EventCategory {

	private String ec_name;
}

