package com.event.evengers_v2.bean;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Alias("estimatepayimage")
@Data
public class EstimatePayImage {
  private String estpi_code;
  private String estpi_orifilename;
  private String estpi_sysfilename;
  private String estp_code;
}
