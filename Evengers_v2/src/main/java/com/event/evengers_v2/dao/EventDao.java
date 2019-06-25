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

	ArrayList<Event> getEvtList(@Param("ec_name")String ec_name
			,@Param("pageNum")int pageNum,@Param("listCount")int listCount);
	
	public boolean evtImageInsert(EventImage ei);

	public Event getEvtInfo(String e_code);

	public ArrayList<EventOption> getOption(String e_code);

	public int getEoPrice(String eo_code);

	public EventOption getEoInfo(String eo_code);
	
	
	public boolean review(Review review);

	public List<Review> getReview(@Param("e_code")String e_code,@Param("pageNum") Integer pageNum,@Param("listCount") Integer listCount);

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

	public List<Event> myEvtManagement(@Param("c_id")String id);

	public Event myEvtModify(String e_code);

	public String ei_sysFileName(String e_code);

	public boolean noFiNoOpModify(Event eb);

	public boolean okFiNoOpModify(Event eb);

	public boolean noFiOkOpModify(Event eb);

	public boolean okFiOkOpModify(Event eb);

	public boolean evtImageDelete(EventImage ei);

	public boolean evtOptionDelete(String e_code);
	
	public ArrayList<String> getEvtCodeList(String c_id);
	
	public ArrayList<Event> ceoEvtList2(@Param("c_id")String c_id);

	public int getEvtListSize(String ec_name);

	public ArrayList<Event> searchEvt(String evtSearch);

	public int rCount(String e_code);

	public int evtBuyChk(String id);
	
	public boolean myEvtDelete(String e_code);
	
	public List<EventImage> getEvtImg(String e_code);

	public int getReviewCount(String e_code);

}
