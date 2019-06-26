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
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.event.evengers_v2.bean.Estimate;
import com.event.evengers_v2.bean.EstimateImage;
import com.event.evengers_v2.bean.EstimatePay;
import com.event.evengers_v2.bean.EstimatePayImage;
import com.event.evengers_v2.bean.EstimateRefund;
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

	@Transactional(rollbackFor = Exception.class)
	public ModelAndView evtReqInsert(MultipartHttpServletRequest multi){
		mav = new ModelAndView();
		String view = null;
		String m_id = session.getAttribute("id").toString();
		String ec_name = multi.getParameter("e_category");
		String req_title = multi.getParameter("req_title");
		String req_contents = multi.getParameter("req_contents");
		String req_hopedate = multi.getParameter("req_hopedate");
		String req_hopearea = multi.getParameter("req_hopearea");
		String req_hopeaddr = multi.getParameter("req_hopeaddr");
		
		try {
			req_hopedate = req_hopedate.replace('T', ' ');

			System.out.println("세션아이디 : " + m_id);
			System.out.println("카테고리 : " + ec_name);
			System.out.println("희망날짜 및 시간 : " + req_hopedate);

			Map<String, String> fileMap = file.singleFileUp(multi, 2);

			Request rq = new Request(); // 빈
			RequestImage ri = new RequestImage(); // 빈
			
			
			rq.setEc_name(ec_name);
			rq.setM_id(m_id);
			rq.setReq_title(req_title);
			rq.setReq_contents(req_contents);
			rq.setReq_hopedate(req_hopedate);
			rq.setReq_hopearea(req_hopearea);
			rq.setReq_hopeaddr(req_hopeaddr);

			System.out.println(rq.getReq_hopedate());

			SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
			Date hopedate1 = format1.parse(req_hopedate);
			format1.format(hopedate1);
			
			
			
			System.out.println("hopedate1:" + format1.format(hopedate1));
			Date today = new Date();

			today = format1.parse(format1.format(today));
			long insPos = hopedate1.getTime(); // req_hopedate의 값이 오늘 날짜보다 커야함

			if (insPos > today.getTime() && rDao.evtReqInsert(rq)) {
				String req_code = rDao.getReqCode();
				rq.setReq_code(req_code);
				if(fileMap.get("reqi_orifilename") != null) {
				ri.setReqi_orifilename(fileMap.get("reqi_orifilename"));
				ri.setReqi_sysfilename(fileMap.get("reqi_sysfilename"));
				ri.setReq_code(req_code);
				rDao.evtReqImageInsert(ri);
				System.out.println("삽입 검색 삽입 완료!");
				view = "memberViews/evtReqContents";}
					System.out.println("삽입 검색 삽입 완료!");
					view = "memberViews/evtReqContents";
				} else {
					System.out.println("삽입 검색 삽입 실패!");
					view = "memberViews/evtReqFrm";
				}
			mav.addObject("request", rq);
			mav.addObject("requestimage", ri);
			mav.setViewName(view);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
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
		for(int i=0;i<estList.size();i++) {
			Estimate est=new Estimate();
			est=estList.get(i);
			reqList.addAll(rDao.getReqList(est));
		}
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
		String id=session.getAttribute("id").toString();
		boolean ceoChk=false;
		int check=0;
		if(rDao.ceoChk(id)>0) {
			ceoChk=true;
		}
		if(id.equals("admin") || ceoChk) {
			check=1;
		}else {
			check=0;
		}
		mav.addObject("check",check);
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
			System.out.println("승인 가능일 : " + okAble1);
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
	public Map<String, Object> myReqList(String id, Integer pageNum,Integer listCount) {
		ArrayList<Request> rList = new ArrayList<Request>();
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> map1 = new HashMap<String, Object>();
		boolean ceoChk=false;
		if(rDao.ceoChk(id)>0) {
			ceoChk=true;
		}
		System.out.println("세션으 아이디 : " + id);
		if(id.equals("admin") || ceoChk) {
			System.out.println("관리자 계정 or 기업계정 모든리스트 출력");
			map.put("pageNum", pageNum);
			map.put("listCount", listCount);
			
			rList=rDao.AllReqList(map);
			/////페이징/////
			int maxNum = rDao.getAllReqCount(map); // 전체 글의 갯수 12
			System.out.println("관/기 전페" + maxNum);
			System.out.println("pageNum = " + pageNum);
			System.out.println("listCount =" + listCount);

			int pageCount = 2; // 그룹당 페이지 수
			String boardName = "getReqList"; // 게시판이 여러개 일떄

			String paging = new Paging(maxNum, pageNum, listCount, pageCount, boardName).makeHtmlAjaxPaging();
			
			map1.put("paging", paging);
			
		}else {
			System.out.println("개인 계정 개별 리스트 출력");
			map.put("pageNum", pageNum);
			map.put("listCount", listCount);
			map.put("id",id);
			
			rList = rDao.myReqList(map);	
			/////페이징/////
			int maxNum = rDao.getMyReqCount(map);	//4
			System.out.println("개개인 전페" + maxNum);
			System.out.println("pageNum = " + pageNum);
			System.out.println("listCount =" + listCount);
			int pageCount = 2; // 그룹당 페이지 수
			String boardName = "getReqList"; // 게시판이 여러개 일떄

			String paging = new Paging(maxNum, pageNum, listCount, pageCount, boardName).makeHtmlAjaxPaging();
			
			map1.put("paging", paging);
		}
		
		map1.put("rList", rList);
		map1.put("url", "memberViews/myReqList");

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
	public void download3(Map<String, Object> params) throws Exception {
		String root = (String) params.get("root");
		String sysFileName = (String) params.get("sysFileName");
		String oriFileName = (String) params.get("oriFileName");
		String fullPath = root + "upload/estimatePayImage/" + sysFileName;

		HttpServletResponse resp = (HttpServletResponse) params.get("response");
		// 실제 다운로드
		file.download(fullPath, oriFileName, resp);

	}

	public Map<String, Object> getRecivedEstList(int pageNum,int listCount) {
		ArrayList<Estimate> estList = new ArrayList<Estimate>();
		ArrayList<Request> reqList = new ArrayList<Request>();
		ArrayList<Request> reqList1 = new ArrayList<Request>();
		ArrayList<EstimateImage> estiList= new ArrayList<EstimateImage>();
		String id=session.getAttribute("id").toString();
		int maxNum = rDao.getReceivedEstCount(id);
	
		System.out.println("총~받은견적 리스트의 갯수 : " + maxNum);
		
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
		for(int i=0;i<estList.size();i++) {
			Estimate est=new Estimate();
			est=estList.get(i);
			String est_code=est.getEst_code();
			reqList1.add(rDao.getReqTitle(est));
			estiList.add(rDao.getEstimateImage(est_code));
		}
		 while (estiList.remove(null));
		 System.out.println(estiList);
		int pageCount = 2; // 그룹당 페이지 수
		String boardName = "getRecivedEstList"; // 게시판이 여러개 일떄

		String paging = new Paging(maxNum, pageNum, listCount, pageCount, boardName).makeHtmlAjaxPaging();
		
		System.out.println("estList="+estList);
		//reqList = rDao.getReqList();
		Map<String, Object> map1 = new HashMap<String, Object>();
		map1.put("estiList",estiList);
		map1.put("estList", estList);
		map1.put("reqList", reqList1);
		map1.put("paging", paging);
		//map1.put("paging", getPaging(num));
		// System.out.println("jsonStr=" + jsonStr);
		return map1;
	}
	

	@Transactional
	public ModelAndView estPay(String est_code) throws DBException, ParseException {
		mav = new ModelAndView();
		Estimate estimate = new Estimate();
		EstimatePay estimatepay = new EstimatePay();

		estimate = rDao.getEstInfo(est_code); // 견적코드와 맞는 정보

		String req_code = estimate.getReq_code();
		String estp_contents = estimate.getEst_contents();
		String c_id = estimate.getC_id();
		int estp_total = estimate.getEst_total();
		int estp_refunddate = estimate.getEst_refunddate();
		int okdate = estimate.getEst_okdate();

		System.out.println("받아온 req 코드!" + req_code);
		System.out.println("받아온 내용!" + estp_contents);
		System.out.println("받아온 총가격!" + estp_total);
		System.out.println("받아온 환불가능일!" + estp_refunddate);
		System.out.println("받아온 기업아이디!!" + c_id);

		estimatepay.setReq_code(req_code);
		estimatepay.setEstp_contents(estp_contents);
		estimatepay.setC_id(c_id);
		estimatepay.setEstp_total(estp_total);
		estimatepay.setEstp_refunddate(estp_refunddate);

		String hopedate = rDao.gethopedate(req_code);

		SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
		Date hopedate1 = format1.parse(hopedate);
		format1.format(hopedate1);

		System.out.println("hopedate1:" + format1.format(hopedate1));
		Date today = new Date();

		today = format1.parse(format1.format(today));
		long okAble = hopedate1.getTime() - okdate * (24 * 60 * 60 * 1000); // 승인가능일
		long refundAble = hopedate1.getTime() - estp_refunddate * (24 * 60 * 60 * 1000); // 환불가능일

		System.out.println("ok-able : " + okAble);
		System.out.println("refund-able : " + refundAble);
		System.out.println("to-day : " + today.getTime());
		// 오늘날짜 6-18 승인가능일 6-17이면 결제x 고로 (희망일-okdate)>오늘날짜

		if (okAble > today.getTime() && rDao.estPay(estimatepay)) {
			// 오늘날짜<(희망일-승인가능일)

			String estp_code = rDao.getEstpCode();
			System.out.println("estp_code=" + estp_code);
			EstimateImage esti = new EstimateImage();
			esti = rDao.getEstimateImage(est_code);
		    if(esti!=null) {
			EstimatePayImage estpi = new EstimatePayImage();
			estpi.setEstp_code(estp_code);
			estpi.setEstpi_orifilename(esti.getEsti_orifilename());
			estpi.setEstpi_sysfilename(esti.getEsti_sysfilename());
			System.out.println(estpi);
			boolean e = rDao.insertEstpi(estpi);
		    }// 견적결제 이미지 테이블에 삽입
			boolean b = rDao.estiDelete(est_code); // 견적 이미지 삭제
			boolean r = rDao.estDelete(est_code); // 견적 삭제

			if (r == false) {
				throw new DBException();
			}
			if (b && r) {
				System.out.println("삭제 트랜잭션 성공");
				System.out.println("결제가 완료 되었습니다.");
				mav.addObject("msg", 1);
			} else {
				System.out.println("삭제 트랜잭션 실패");
			}

		} else {
			System.out.println("띨패");
			mav.addObject("msg", 2);
		}

		mav.setViewName("memberViews/memberMyPage");

		return mav;
	}

		public ModelAndView receivedEstDenial(String est_code) {
		boolean b = rDao.estiDelete(est_code);		
		boolean r = rDao.estDelete(est_code);
		
		if(b && r) {
			System.out.println("견적거부삭제 완료우");
		}else {
			System.out.println("실패");
		}
		mav.setViewName("memberViews/memberMyPage");
		return mav;
	}
		public Map<String, Object> getEstPayList(String id, int pageNum, int listCount) {
			ArrayList<Request> reqList=new ArrayList<Request>();
			ArrayList<Request> reqList1=new ArrayList<Request>();
			ArrayList<EstimatePay> estpList=new ArrayList<EstimatePay>();
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", id);
			reqList=rDao.getReqCodes(id);
			//int maxNum = rDao.getEstPayCount(map);
			//System.out.println("이거 받은견적의 총 갯수 : " + maxNum);
			ArrayList<String> rs=new ArrayList<String>();
			System.out.println("ReqList="+reqList);
			for(int i=0;i<reqList.size();i++) {
				String req_code=reqList.get(i).getReq_code();
				
				map.put("req_code",req_code);
				map.put("pageNum", pageNum);
				map.put("listCount",listCount);
		        estpList.addAll(rDao.getEstPayList(map));
			}
			for(int i=0;i<estpList.size();i++) {
				EstimatePay estp=new EstimatePay();
				estp=estpList.get(i);
				if(estp.getEstp_refundstate()==0) {
		               String statemsg="결제완료";
		               rs.add(statemsg);}
		               else if(estp.getEstp_refundstate()==1) {
		                  String statemsg="환불중";
		                  rs.add(statemsg);
		               }else{
		                  String statemsg="환불완료";
		                  rs.add(statemsg);
		               }
				
				reqList1.add(rDao.getReqTitle1(estp));
			}
			
			
			ArrayList<EstimatePay> estpList1=new ArrayList<EstimatePay>();
		    // estpList1=rDao.getPageEstpList(pageNum);
			  while (estpList.remove(null));
			  System.out.println("estpList.size="+estpList.size());
			  
			  String paging=new Paging(estpList.size(), pageNum, listCount,2,"getEstPayList").makeHtmlAjaxPaging();
			
			 
			
			 System.out.println("estpList:"+estpList);
			Map<String, Object> map1 = new HashMap<String, Object>(); 
			map1.put("estpList", estpList);
			map1.put("reqList", reqList1);
			map1.put("paging",paging);
			map1.put("statemsg",rs);
			return map1;
			
		}
		

		public ModelAndView showEstpDetail(String estp_code) {
			mav = new ModelAndView();
			String msg = null;
			String refundStateMsg = null;
			EstimatePay estp = new EstimatePay();
			estp = rDao.getEstpDetail(estp_code);
			String req_code1 = estp.getReq_code();
			Request req = new Request();
			req = rDao.getReqInfo(req_code1);
			Estimate est = new Estimate();
			System.out.println("req:" + req);
			EstimatePayImage estpi = new EstimatePayImage();
			estpi = rDao.getEstpiImage(estp_code);
			System.out.println(estpi);
			int refundstate = estp.getEstp_refundstate();
			if (refundstate == 0) {
				refundStateMsg = "결제완료";
			} else if (refundstate == 1) {
				refundStateMsg = "환불중";
			} else {
				refundStateMsg = "환불완료";
			}
			try {
				Date payday = estp.getEstp_payday();
				int refunddate = est.getEst_refunddate();
				String hopedate = req.getReq_hopedate(); // 2018-12-30
				SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
				String payday1 = format1.format(payday);
				mav.addObject("payday", payday1);
				Date hopedate1;
				hopedate1 = format1.parse(hopedate);
				format1.format(hopedate1);
				System.out.println("hopedate1:" + format1.format(hopedate1));
				Date today = new Date();
				today = format1.parse(format1.format(today));
				long refundAble = hopedate1.getTime() - refunddate * (24 * 60 * 60 * 1000);
				String refundable1 = format1.format(new Date(refundAble));
				System.out.println("kkk" + refundable1 + "일 Rkwl");
				System.out.println("누가먼저?:" + hopedate1.compareTo(today));

				mav.addObject("refundable", refundable1);
				int check = hopedate1.compareTo(today);
				if (check == 0) {
					msg = "환불가능";
				} else if (check >= 1) {
					msg = "환불가능";
				} else {
					msg = "환불 불가능";
				}
			} catch (ParseException e) {
				e.printStackTrace();
			}
			mav.addObject("refundstate", refundStateMsg);
			mav.addObject("msg", msg);
			mav.addObject("estpi", estpi);
			mav.addObject("req", req);
			mav.addObject("estp", estp);
			mav.setViewName("memberViews/showEstimateDetail");

			return mav;
		}

		

		public ModelAndView estRefundRequest(String estp_code) {
			 mav=new ModelAndView();
				int c=rDao.estpStateChange(estp_code);
			 System.out.println("c="+c); 
			 boolean a=rDao.insertRefund(estp_code);
				return mav;
			}


		public Map<String, Object> estSell(String id,int pageNum,int listCount)  {
			ArrayList<EstimatePay> esList = new ArrayList<EstimatePay>();
			ArrayList<EstimatePayImage> imgList = new ArrayList<EstimatePayImage>();
			Map<String, Object> map = new HashMap<String, Object>();
			Map<String, Object> map1 = new HashMap<String, Object>();
						
			map.put("id", id);
			map.put("pageNum", pageNum);
			map.put("listCount", listCount);
			
			int maxNum = rDao.getEstpCount(map); 	//6
			System.out.println("maaaxNum = " + maxNum);	//6
			System.out.println("pageeNum = " + pageNum);	//1
			System.out.println("listtCount =" + listCount);	//10
			
			esList = rDao.getEstSell(map);
			for(int a=0 ; a<esList.size();a++) {
				
				imgList.addAll(rDao.estSellImageList(esList.get(a)));
			//	System.out.println(imgList.get(a));
			}
			int pageCount = 2; // 그룹당 페이지 수
			String boardName = "getEstpList"; // 게시판이 여러개 일떄

			String paging = new Paging(maxNum, pageNum, listCount, pageCount, boardName).makeHtmlAjaxPaging();
			
			map1.put("paging", paging);
			map1.put("esList", esList);	//맵에 저장해서 턴
			map1.put("imgList", imgList);
			
			return map1;
		}
		
		
		//매일 12시마다 메소드 실행
		//@Scheduled(fixedDelay = 1000) //1초마다 실행
		@Scheduled(cron = "00 00 00 * * *")
		public ModelAndView AutoDelete() {
			Estimate est = new Estimate();
			//est = rDao.getEstTable();
			
			return mav;
		}

		public Map<String, Object> reqSearch(String words ,String id) {
			ArrayList<Request> rList = new ArrayList<Request>();
			Map<String, Object> map = new HashMap<String, Object>();
			Map<String, Object> map1 = new HashMap<String, Object>();
	
			System.out.println("id는 뭐지 : " + id);
			System.out.println("words는 뭐지 : " + words);
			
			boolean ceoChk=false;
			if(rDao.ceoChk(id)>0) {
				ceoChk=true;
			}
			
			if(id.equals("admin") || ceoChk) {
				System.out.println("관리자 계정 or 기업계정 리스트 검색");
				map.put("words",words);
				rList=rDao.allReqSearch(map);
				
			}else {
				System.out.println("일반사람 리스트 검색");
				
				map.put("words", words);
				map.put("id", id);
				rList = rDao.reqSearch(map);
			}
			
			map1.put("rList", rList);
			
			return map1;
		}
		public Map<String, Object> RefundAcceptList(String id, Integer pageNum) {
			ArrayList<EstimatePay> estpList=new ArrayList<EstimatePay>();  
			ArrayList<EstimateRefund> estrList=new ArrayList<EstimateRefund>();
			estpList=rDao.RefundAcceptList1(id);
			ArrayList<Request> reqList=new ArrayList<Request>();  
			System.out.println("estpList:"+estpList);
			Map<String, Object> map1 = new HashMap<String, Object>();
			int listCount=10;
			for(int i=0;i<estpList.size();i++) {
			EstimatePay estp=new EstimatePay();
				estp=estpList.get(i);
				String req_code=estp.getReq_code();
				String estp_code=estp.getEstp_code();
				reqList.add(rDao.getRefundInfo(req_code));
				estrList.add(rDao.getEstr(estp_code));
			}
			System.out.println("estrList:"+estrList);
			 while (estrList.remove(null));
			map1.put("reqList",reqList);
			map1.put("estpList",estpList);
			map1.put("estrList",estrList);
			return map1;
		}

		public Map<String, Object> insertPenalty(EstimateRefund estr) {
			int a=rDao.insertPenalty(estr);
				int b=rDao.changeState(estr);
				String id=session.getAttribute("id").toString();
				ArrayList<EstimatePay> estpList=new ArrayList<EstimatePay>();  
				ArrayList<EstimateRefund> estrList=new ArrayList<EstimateRefund>();
				estpList=rDao.RefundAcceptList1(id);
				ArrayList<Request> reqList=new ArrayList<Request>();  
				System.out.println("estpList:"+estpList);
				Map<String, Object> map1 = new HashMap<String, Object>();
				for(int i=0;i<estpList.size();i++) {
				EstimatePay estp=new EstimatePay();
					estp=estpList.get(i);
					String req_code=estp.getReq_code();
					String estp_code=estp.getEstp_code();
					reqList.add(rDao.getRefundInfo(req_code));
					estrList.add(rDao.getEstr(estp_code));
				}
				map1.put("reqList",reqList);
				map1.put("estpList", estpList);
				map1.put("estrList", estrList);
				return map1;
		}

		public Map<String, Object> RefundCompleteList(String id, Integer pageNum, Integer listCount) {
			ArrayList<EstimatePay> estpList=new ArrayList<EstimatePay>();  
			ArrayList<EstimateRefund> estrList=new ArrayList<EstimateRefund>();
			estpList=rDao.RefundAcceptList(id);
			ArrayList<Request> reqList=new ArrayList<Request>();  
			System.out.println("estpList:"+estpList);
			Map<String, Object> map1 = new HashMap<String, Object>();
			for(int i=0;i<estpList.size();i++) {
			EstimatePay estp=new EstimatePay();
				estp=estpList.get(i);
				estp.getEstp_total();
				String req_code=estp.getReq_code();
				String estp_code=estp.getEstp_code();
				reqList.add(rDao.getRefundInfo(req_code));
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("estp_code",estp_code);
				map.put("pageNum",pageNum);
				map.put("listCount",listCount);
				estrList.add(rDao.getCompleteEstr(map));
			}
			  String paging=new Paging(estrList.size(),pageNum, listCount, 2, "estrRefundComplete").makeHtmlAjaxPaging();
		     map1.put("paging",paging);
			 map1.put("reqList",reqList);
			 map1.put("estpList", estpList);
			 map1.put("estrList", estrList);
			 return map1;
		}
		public String estEffectiveness(String okDate, String req_code1) {
			String msg = "";
			Request req = new Request();
			req = rDao.getReqInfo(req_code1);
			String hopeDate = req.getReq_hopedate();
			System.out.println("hopeDate=" + hopeDate);
			try {
				SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
				Date hopeDate1 = format1.parse(hopeDate);
				Date today = new Date();
				today = format1.parse(format1.format(today));
				
				long diff = hopeDate1.getTime() - today.getTime();
				long diffDays = diff / (24 * 60 * 60 * 1000);
				System.out.println("diff"+diff);
				System.out.println("날짜차이:" + diffDays + "일");
				long a=diffDays-Integer.parseInt(okDate);
				System.out.println("누가먼저?:" + hopeDate1.compareTo(today));
				System.out.println("a="+a);
				if (a>=0) {
					// 입력날짜(selected_dday)가 현재(today)보다 미래면 +1 과거면 -1 같으면0
						msg = "가능";
					} else {
						msg = "불가능";
				}
			} catch (ParseException e1) {
				e1.printStackTrace();
			}
			return msg;
		}

		public String refundEffectiveness(String refundDate, String req_code1) {
			String msg = "";
			Request req = new Request();
			req = rDao.getReqInfo(req_code1);
			String hopeDate = req.getReq_hopedate();
			System.out.println("hopeDate=" + hopeDate);
			try {
				SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
				Date hopeDate1 = format1.parse(hopeDate);
				Date today = new Date();
				today = format1.parse(format1.format(today));
				long diff = hopeDate1.getTime() - today.getTime();
				long diffDays = diff / (24 * 60 * 60 * 1000);
				System.out.println("diff"+diff);
				System.out.println("날짜차이:" + diffDays + "일");
				long a=diffDays-Integer.parseInt(refundDate);
				System.out.println("누가먼저?:" + hopeDate1.compareTo(today));
				System.out.println("a="+a);
				if (a>=0) {
					// 입력날짜(selected_dday)가 현재(today)보다 미래면 +1 과거면 -1 같으면0
						msg = "가능";
					} else {
						msg = "불가능";
				}
			} catch (ParseException e1) {
				e1.printStackTrace();
			}
			return msg;
		}
		public String dateChk(String date) {
			String msg ="";
			System.out.println("date!!" + date);
			date = date.replace('T', ' ');
			
			SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
			Date dday;
			try {
				dday = format1.parse(date);
				format1.format(dday);

				System.out.println("dday:" + format1.format(dday));
				Date today = new Date();
				
				long ddday = dday.getTime();
				
				if(ddday >= today.getTime()) {
					msg="<p id='possible'>가능한 날짜입니다</p>";
				}else msg="<p id='impossible'>불가능한 날짜입니다</p>";
				
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
			return msg;
		}
		}
		

