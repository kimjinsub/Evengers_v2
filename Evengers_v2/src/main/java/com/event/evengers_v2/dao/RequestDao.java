package com.event.evengers_v2.dao;

import com.event.evengers_v2.bean.Request;
import com.event.evengers_v2.bean.RequestImage;

public interface RequestDao {

	public boolean evtReqInsert(Request rq);

	public boolean evtReqImageInsert(RequestImage ri);
	
	public String getReqCode();
	
	

}
