package com.event.evengers_v2.bean;

import org.apache.ibatis.type.Alias;

import lombok.Data;
   @Alias("questionimage")
  @Data
public class QuestionImage {
  private String qi_code;
  private String q_orifilename;
  private String q_sysfilename;
  private String q_code;

}
   
