package com.event.evengers_v2.dao;

import com.event.evengers_v2.bean.EventSchedule;

public interface ScheduleDao {

	int isAssigned(String ep_code);

	EventSchedule getEvtScheduleList(String ep_code);

	boolean insertEvtSchedule(EventSchedule es);

}
