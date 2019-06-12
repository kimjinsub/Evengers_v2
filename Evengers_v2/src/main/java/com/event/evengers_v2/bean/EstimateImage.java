package com.event.evengers_v2.bean;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Alias("estimateimage")
@Data
public class EstimateImage {
  private String esti_code;
  private String esti_orifilename;
  private String esti_sysfilename;
  private String est_code;
}
