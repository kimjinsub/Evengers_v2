package com.event.evengers_v2.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.event.evengers_v2.bean.Estimate;
import com.event.evengers_v2.bean.EstimateImage;
import com.event.evengers_v2.bean.Request;
import com.event.evengers_v2.bean.RequestImage;
import com.event.evengers_v2.dao.EventDao;
import com.event.evengers_v2.dao.RequestDao;
import com.event.evengers_v2.userClass.DBException;
import com.event.evengers_v2.userClass.Paging;
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

	public ModelAndView estInsert(MultipartHttpServletRequest multi) {
		mav = new ModelAndView();
		String c_id = session.getAttribute("id").toString();
		Estimate est = new Estimate();
		String contents = multi.getParameter("est_contents");
		String total = multi.getParameter("est_total");
		String okDate = multi.getParameter("est_okDate");
		String refundDate = multi.getParameter("est_refundDate");
		String req_code = multi.getParameter("req_code");
		System.out.println("contents:" + contents);
		System.out.println("total:" + total);
		System.out.println("okDate=" + okDate);
		System.out.println("멀티req_code:"+req_code);
		est.setC_id(c_id);
		est.setReq_code(req_code);
		est.setEst_contents(contents);
		est.setEst_total(Integer.parseInt(total));
		est.setEst_okdate(Integer.parseInt(okDate));
		est.setEst_refunddate(Integer.parseInt(refundDate));
		String view = null;
		boolean e = rDao.estInsert(est);
		String est_code = rDao.getEstCode(c_id);
		ArrayList<String[]> estfileList = file.multiFileUp(multi, 3);
		int cnt2 = 0;
		EstimateImage ei = new EstimateImage();
		for (int i = 0; i < estfileList.size(); i++) {
			ei.setEsti_orifilename(estfileList.get(i)[0]);
			ei.setEsti_sysfilename(estfileList.get(i)[1]);
			System.out.println("ei_ori=" + ei.getEsti_orifilename());
			System.out.println("ei_sys=" + ei.getEsti_sysfilename());
			ei.setEst_code(est_code);
			if (rDao.estImageInsert(ei)) {
				cnt2++;
			}
		}
		if (cnt2 == estfileList.size()) {
			view = "ceoViews/sentEstList";

		} else {
			view = "ceoViews/estPageFrm";
		}
		mav.setViewName(view);
		return mav;

	}

	public Map<String, Object> getEstList(String id, Integer pageNum) {
		ArrayList<Estimate> estList = new ArrayList<Estimate>();
		ArrayList<Request> reqList = new ArrayList<Request>();
		int num = (pageNum == null) ? 1 : pageNum;
		System.out.println("아이디:" + id);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("num", num);
		estList = rDao.getEstList(map);
		System.out.println("estList:" + estList);
		reqList = rDao.getReqList();
		Map<String, Object> map1 = new HashMap<String, Object>();
		map1.put("estList", estList);
		map1.put("reqList", reqList);
		map1.put("paging", getPaging(num));
		// System.out.println("jsonStr=" + jsonStr);
		return map1;
	}

	private Object getPaging(int pageNum) {
		int maxNum = rDao.getEstCount(); // 전체 글의 갯수
		System.out.println("전페" + maxNum);

		int listCount = 5; // 페이지당 글의 수
		int pageCount = 2; // 그룹당 페이지 수
		String boardName = "ceoViews/sentEstList"; // 게시판이 여러개 일떄

		Paging paging = new Paging(maxNum, pageNum, listCount, pageCount, boardName);

		return paging.makeHtmlPaging();
	}

	public ModelAndView showEstimate(String est_code){
		mav = new ModelAndView();
		Estimate est = new Estimate();
		est = rDao.showEstimate(est_code);
		EstimateImage esti = new EstimateImage();
		esti = rDao.getEstimateImage(est_code);
		String req_code = est.getReq_code();
		Request req = new Request();
		req = rDao.getIdTitle(req_code);
		try {
		int okdate = est.getEst_okdate();
		int refunddate=est.getEst_refunddate();
		String hopedate=req.getReq_hopedate(); //2018-12-30
		SimpleDateFormat format1= new SimpleDateFormat("yyyy-MM-dd");
		Date hopedate1;
			hopedate1 = format1.parse(hopedate);
			format1.format(hopedate1);
			System.out.println("hopedate1:"+format1.format(hopedate1));
		Date today = new Date(); 
		today=format1.parse(format1.format(today));
		long refundAble=hopedate1.getTime()-refunddate*(24*60*60*1000);
		String refundable1=format1.format(new Date(refundAble));
		System.out.println("kkk"+refundable1+"일 Rkwl");
		System.out.println("누가먼저?:"+hopedate1.compareTo(today));
		mav.addObject("refundable",refundable1);
		long okAble=hopedate1.getTime()-okdate*(24*60*60*1000);
		String okAble1=format1.format(new Date(okAble));
		mav.addObject("ok",okAble1);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		mav.addObject("estimate", est);
		mav.addObject("estimateImage", esti);
		mav.addObject("request", req);
		mav.setViewName("ceoViews/detailEstimate");
		return mav;
	}
		/*
		 * if(selected_dday.compareTo(today)>=1) { //입력날짜가 현재보다 미래면 +1 과거면 -1 같으면0
		 * if(diffDays>=e.getE_reservedate()) { msg="<p id='possible'>가능한 날짜입니다</p>"; }
		 * else { msg="<p id='impossible'>불가능한 날짜입니다</p>"; } }else {
		 * msg="<p id='impossible'>불가능한 날짜입니다</p>"; }
		 */
	public Map<String, Object> myReqList(String id, Integer pageNum) {
		ArrayList<Request> rList = new ArrayList<Request>();
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> map1 = new HashMap<String, Object>();
		boolean ceoChk=false;
		if(rDao.ceoChk(id)>0) {
			ceoChk=true;
		}
		
		if(id.equals("admin") || ceoChk) {
			System.out.println("관리자 계정 or 기업계정 모든리스트 출력");
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
		
		String id=session.getAttribute("id").toString();
		boolean ceoChk=false;
		if(rDao.ceoChk(id)>0) {
			ceoChk=true;
		}
		if(id.equals("admin") || ceoChk) {
			mav.setViewName("ceoViews/allReqInfo");
		}else {
			mav.setViewName("memberViews/myReqInfo");
		}
		
		return mav;
	}
	
	public void download(Map<String, Object> params) throws Exception {
		String root = (String) params.get("root");
		String sysFileName = (String) params.get("sysFileName");
		String oriFileName = (String) params.get("oriFileName");
		String fullPath = root + "upload/evtReqImage/" + sysFileName;

		HttpServletResponse resp = (HttpServletResponse) params.get("response");
		// 실제 다운로드
		file.download(fullPath, oriFileName, resp);

	}
	
	@Transactional
	public ModelAndView myReqDelete(String req_code) throws DBException{
		mav = new ModelAndView();
		
		boolean imgDel = rDao.reqImageDelete(req_code);
		boolean reqDel = rDao.reqDelete(req_code);
		
		System.out.println(imgDel);
		System.out.println(reqDel);
		
		if (reqDel == false) {
			throw new DBException();
		}
		if (imgDel && reqDel) {
			System.out.println("삭제 트랜잭션 성공");
		} else {
			System.out.println("띨패");
		}

		mav.setViewName("redirect:/memberMyPage");

		return mav;
	}

	public ModelAndView estimateDelete(String est_code) throws DBException {
		mav = new ModelAndView();
		boolean b = rDao.estiDelete(est_code);
		boolean r = rDao.estDelete(est_code); // 댓글

		if (r == false) {
			throw new DBException();
		}

		if (r) {
			System.out.println("삭제 트랜잭션 성공");
		} else {
			System.out.println("삭제 트랜잭션 실패");
		}

		mav.setViewName("redirect:/sentEstList");

		return mav;
	}
	
	public void download1(Map<String, Object> params) throws Exception {
		String root = (String) params.get("root");
		String sysFileName = (String) params.get("sysFileName");
		String oriFileName = (String) params.get("oriFileName");
		String fullPath = root + "upload/estimateImage/" + sysFileName;

		HttpServletResponse resp = (HttpServletResponse) params.get("response");
		// 실제 다운로드
		file.download(fullPath, oriFileName, resp);

	}

	public Map<String, Object> getRecivedEstList(String id, Integer pageNum) {
		ArrayList<Estimate> estList = new ArrayList<Estimate>();
		ArrayList<Request> reqList = new ArrayList<Request>();
		int num = (pageNum == null) ? 1 : pageNum;
		System.out.println("아이디:" + id);
		//Map<String, Object> map = new HashMap<String, Object>
		//map.put("id", id);
		//map.put("num", num);
		reqList = rDao.getRecivedEstList(id);
		for(int i=0;i<reqList.size();i++) {
			Request req=new Request();
			req=reqList.get(i);
			System.out.println("Req="+req);
			estList.addAll(rDao.getRecivedEstList1(req));
			
		}
		System.out.println("estList="+estList);
		//reqList = rDao.getReqList();
		Map<String, Object> map1 = new HashMap<String, Object>();
		map1.put("estList", estList);
		map1.put("reqList", reqList);
		//map1.put("paging", getPaging(num));
		// System.out.println("jsonStr=" + jsonStr);
		return map1;
	}
}
		
	

