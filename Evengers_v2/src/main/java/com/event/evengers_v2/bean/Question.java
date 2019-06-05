package com.event.evengers_v2.bean;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Alias("question")
@Data
public class Question {
    
   private String q_code;
   private String m_id;
   private String q_title;
   private String q_contents;
   private String q_date;
}
