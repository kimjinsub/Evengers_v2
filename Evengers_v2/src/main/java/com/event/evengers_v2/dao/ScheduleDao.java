package com.event.evengers_v2.dao;

import java.util.ArrayList;
import java.util.Date;

import org.apache.ibatis.annotations.Param;

import com.event.evengers_v2.bean.EstimateSchedule;
import com.event.evengers_v2.bean.EventPay;
import com.event.evengers_v2.bean.EventSchedule;

public interface ScheduleDao {

	int isAssigned(String ep_code);

	EventSchedule getEvtScheduleList(String ep_code);

	boolean insertEvtSchedule(EventSchedule es);

	ArrayList<String> dateCheck(@Param("assigned_codes")ArrayList<String> assigned_codes
			, @Param("calDate")String calDate);
	
	EventSchedule howManyEvtSchedule(@Param("dept_code")String dept_code
			, @Param("ep_code")String ep_code);
	EstimateSchedule getEstScheduleList(String estp_code);

	boolean insertEstSchedule(EstimateSchedule ests);

	EstimateSchedule getScheduledEstsList(@Param("estp_code")String estp_code
					, @Param("dept_code")String dept_code);

	ArrayList<String> dateCheckEstp(
			@Param("assigned_estp_codes")ArrayList<String> assigned_estp_codes, 
			@Param("calDate")String calDate);

	EstimateSchedule howManyEstSchedule(@Param("dept_code")String dept_code, 
			@Param("estp_code")String estp_code);

	ArrayList<EventPay> notScheduledEpList(
			@Param("ep_codes")ArrayList<String> ep_codes, 
			@Param("today")Date today, 
			@Param("pageNum")int pageNum, 
			@Param("listCount")int listCount);

}
