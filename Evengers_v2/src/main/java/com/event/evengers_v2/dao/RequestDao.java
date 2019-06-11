package com.event.evengers_v2.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.event.evengers_v2.bean.QuestionImage;
import com.event.evengers_v2.bean.Request;
import com.event.evengers_v2.bean.RequestImage;

public interface RequestDao {

	public boolean evtReqInsert(Request rq);

	public boolean evtReqImageInsert(RequestImage ri);
	
	public String getReqCode();

	public ArrayList<Request> AllReqList(Map<String, Object> map);
	
	public ArrayList<Request> myReqList(Map<String, Object> map);

	public Request getReqInfo(String req_code1);

	public List<RequestImage> getReqImageInfo(String req_code1);

	
	
	

}
