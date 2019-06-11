package com.event.evengers_v2.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.event.evengers_v2.bean.Question;
import com.event.evengers_v2.bean.QuestionImage;
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

	public Map<String, Object> myReqList(String id, Integer pageNum) {
		ArrayList<Request> rList = new ArrayList<Request>();
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> map1 = new HashMap<String, Object>();
		
		if(id.equals("admin")) {
			System.out.println("관리자 계정 모든리스트 출력");
			rList=rDao.AllReqList(map);
		}else {
			System.out.println("개인 계정 개별 리스트 출력");
			map.put("id",id);
			rList = rDao.myReqList(map);
		}
		map1.put("rList", rList);

		return map1;
	}

	public ModelAndView evtReqInfo(String req_code1) {
		mav=new ModelAndView();
		System.out.println("해당되는 아이디 : " + req_code1);
		Request request = rDao.getReqInfo(req_code1);	//리퀘스트 빈의 자료 
		mav.addObject("request", request);
		
		List<RequestImage> rfList = rDao.getReqImageInfo(req_code1);	//리퀘스트 이미지 빈의 자료
		mav.addObject("rfList",rfList);
		
		mav.setViewName("memberViews/myReqInfo");
		return mav;
	}

	
}
