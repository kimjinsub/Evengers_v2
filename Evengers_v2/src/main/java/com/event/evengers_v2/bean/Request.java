package com.event.evengers_v2.bean;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Alias("request")
@Data
public class Request {
   private String req_code;
   private String m_id;
   private String ec_name;
   private String req_title;
   private String req_contents;
   private String req_hopedate;
   private String req_hopearea;
   private String req_hopeaddr;
  
   
   
}