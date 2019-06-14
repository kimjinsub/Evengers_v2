package com.event.evengers_v2.dao;

import java.util.ArrayList;
import java.util.Date;

import org.apache.ibatis.annotations.Param;

import com.event.evengers_v2.bean.EventSchedule;

public interface ScheduleDao {

	int isAssigned(String ep_code);

	EventSchedule getEvtScheduleList(String ep_code);

	boolean insertEvtSchedule(EventSchedule es);

	ArrayList<String> dateCheck(@Param("assigned_codes")ArrayList<String> assigned_codes
			, @Param("calDate")String calDate);
	
	EventSchedule howManyEvtSchedule(@Param("dept_code")String dept_code
			, @Param("ep_code")String ep_code);

}
