package com.event.evengers_v2.bean;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Alias("eventoption")
@Data
public class EventOption {
   private String eo_code;
   private String eo_name;
   private int eo_price;
   private String e_code;
}