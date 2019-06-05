package com.event.evengers_v2.bean;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Alias("event")
@Data
public class Event {
   private String e_code;
   private String e_name;
   private String c_id;
   private int e_price;
   private String e_category;
   private int e_reservedate;
   private int e_refunddate;
   private String e_contents;
   private String e_orifilename;
   private String e_sysfilename;
   
   
}