package com.event.evengers_v2.bean;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Alias("estimate")
@Data
public class Estimate {
 private String est_code;
 private String req_code;
 private String c_id;
 private String est_contents;
 private int est_total;
 private int est_okdate;
 private int est_refunddate;
 
}
