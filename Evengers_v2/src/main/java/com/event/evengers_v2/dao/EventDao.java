package com.event.evengers_v2.dao;

import java.util.ArrayList;
import java.util.Locale.Category;

import com.event.evengers_v2.bean.Event;
import com.event.evengers_v2.bean.EventImage;
import com.event.evengers_v2.bean.EventOption;

public interface EventDao {
	public boolean evtInsert(Event eb);
	
	boolean addCategory(String ec_name);

	ArrayList<Category> getCategories();

	boolean deleteCategory(String ec_name);
	
	public boolean evtOptionInsert(EventOption eob);
	
	public String getEvtCode(String c_id);

	ArrayList<Event> getEvtList(String ec_name);
	
	public boolean evtImageInsert(EventImage ei);

	public Event getEvtInfo(String e_code);

	public ArrayList<EventOption> getOption(String e_code);

}
