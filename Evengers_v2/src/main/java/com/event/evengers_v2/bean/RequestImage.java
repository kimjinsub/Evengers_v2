package com.event.evengers_v2.bean;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Alias("requestimage")
@Data
public class RequestImage {
   private String reqi_code;
   private String reqi_orifilename;
   private String reqi_sysfilename;
   private String req_code;
    
   
   
}