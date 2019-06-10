package com.event.evengers_v2.bean;

import org.apache.ibatis.type.Alias;

import lombok.Data;
   @Alias("questionreply")
  @Data
public class QuestionReply {
  private String qr_code;
  private String q_code;
  private String m_id;
  private String qr_date;
  private String qr_contents;
}
   
