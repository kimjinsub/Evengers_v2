package com.event.evengers_v2.service;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.event.evengers_v2.bean.Request;
import com.event.evengers_v2.bean.RequestImage;
import com.event.evengers_v2.dao.EventDao;
import com.event.evengers_v2.dao.RequestDao;
import com.event.evengers_v2.userClass.UploadFile;



@Service
public class RequestMM {
	ModelAndView mav;
	
	@Autowired
	EventDao eDao;
	
	@Autowired
	RequestDao rDao;
	
	@Autowired
	UploadFile file;
	
	@Autowired
	private HttpSession session;
	
	public ModelAndView evtReqInsert(MultipartHttpServletRequest multi) {
		 mav = new ModelAndView(); 
		 String view = null;
		 
		 String m_id=session.getAttribute("id").toString();
		 String ec_name=multi.getParameter("e_category");
		 String req_title=multi.getParameter("req_title");
		 String req_contents=multi.getParameter("req_contents");
		 String req_hopedate=multi.getParameter("req_hopedate");
		 String req_hopearea=multi.getParameter("req_hopearea");
		 String req_hopeaddr=multi.getParameter("req_hopeaddr");
		 
		 req_hopedate = req_hopedate.replace('T',' ');
		 
		 System.out.println("세션아이디 : " + m_id);	 
		 System.out.println("카테고리 : " + ec_name);
		 System.out.println("희망날짜 및 시간 : " + req_hopedate);
		 
		 
		 Map<String, String> fileMap = file.singleFileUp(multi, 2);
				 
		 Request rq = new Request();	//빈
		 RequestImage ri = new RequestImage();	//빈
		 
		 rq.setEc_name(ec_name);
		 rq.setM_id(m_id);
		 rq.setReq_title(req_title);
		 rq.setReq_contents(req_contents);
		 rq.setReq_hopedate(req_hopedate);
		 rq.setReq_hopearea(req_hopearea);
		 rq.setReq_hopeaddr(req_hopeaddr);
		 
		 if(rDao.evtReqInsert(rq)) {
			 String req_code = rDao.getReqCode();
			 ri.setReqi_orifilename(fileMap.get("reqi_orifilename"));
			 ri.setReqi_sysfilename(fileMap.get("reqi_sysfilename"));
			 ri.setReq_code(req_code);
			 
			 if(rDao.evtReqImageInsert(ri)) {
				 System.out.println("삽입 검색 삽입 완료!");
				 view = "memberViews/evtReqContents";		
			 }else {
				 System.out.println("띨패");
			 	 view = "memberViews/evtReqFrm";
			 }
		 }
		 mav.addObject("request",rq);
		 mav.addObject("requestimage",ri);
		 
		 //mav.addObject("m_id", m_id);
		 mav.setViewName(view);
		 
		return mav;
		
	}

	public ModelAndView evtReqList() {
		String m_id=session.getAttribute("id").toString();
		Request rq = new Request();
		rq.setM_id(m_id);
		//rDao.evtReqList
		
		return mav;
	}

}
