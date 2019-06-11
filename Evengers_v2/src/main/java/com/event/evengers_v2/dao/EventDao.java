package com.event.evengers_v2.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale.Category;

import org.apache.ibatis.annotations.Param;

import com.event.evengers_v2.bean.Choice;
import com.event.evengers_v2.bean.Event;
import com.event.evengers_v2.bean.EventImage;
import com.event.evengers_v2.bean.EventOption;
import com.event.evengers_v2.bean.Review;

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

	public int getEoPrice(String eo_code);

	public EventOption getEoInfo(String eo_code);
	
	
	public boolean review(Review review);

	public List<Review> getReview(String e_code);

	public Review reviewCheck(@Param("m_id")String id, @Param("e_code")String e_code);

	public String reviewMemberCheck(@Param("m_id")String id);

	public boolean reviewModifyBtn(Review review);

	public boolean reviewDelete(Review review);

	public float getStarAverage(String e_code);

	public boolean choice(@Param("e_code")String e_code,@Param("m_id") String id);

	public boolean choiceDelete(@Param("e_code")String e_code, @Param("m_id")String id);

	public String getChoiceChk(@Param("e_code")String e_code, @Param("m_id")String id);

	public int reviewChk(String e_code);

	public List<Choice> choiceList(@Param("m_id")String id);


}
