package com.event.evengers_v2.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.ModelAndView;

import com.event.evengers_v2.bean.BuySelectedOption;
import com.event.evengers_v2.bean.Event;
import com.event.evengers_v2.bean.EventBuy;
import com.event.evengers_v2.bean.EventOption;
import com.event.evengers_v2.bean.EventPay;
import com.event.evengers_v2.bean.EventPaySelectedOption;
import com.event.evengers_v2.dao.EventDao;
import com.event.evengers_v2.dao.PayDao;
import com.google.gson.Gson;

@Service
public class PayMM {
	private ModelAndView mav;
	@Autowired
	HttpSession session;
	@Autowired
	PayDao payDao;
	@Autowired
	EventDao eDao;
	
	@Transactional
	public String evtBuy(HttpServletRequest request) {
		String msg=null;
		EventBuy eb=new EventBuy();
		eb.setE_code(request.getParameter("e_code"));
		String m_id=session.getAttribute("id").toString();
		eb.setM_id(m_id);
		eb.setEb_total(Integer.parseInt(request.getParameter("eb_total")));
		String dday=request.getParameter("eb_dday").replace("T", " ");
		boolean buy=false;
		try {
			eb.setEb_dday(new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(dday));
			Event e=eDao.getEvtInfo(request.getParameter("e_code"));
			SimpleDateFormat format1= new SimpleDateFormat("yyyy-MM-dd");
			Date selected_dday= format1.parse(request.getParameter("eb_dday")
					.substring(0, request.getParameter("eb_dday").indexOf("T")));
			Date today = new Date();
			today=format1.parse(format1.format(today));
			long diff=selected_dday.getTime()-today.getTime();
			long diffDays=diff/(24*60*60*1000);
			if(selected_dday.compareTo(today)>=1) {
				if(diffDays>=e.getE_reservedate()) {
					buy=payDao.ebInsert(eb);
				}
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}
		String eb_code=payDao.getEb_code(eb);
		if(request.getParameter("eo_code")!=null) {
			BuySelectedOption bs=new BuySelectedOption();
			String[] eo_codes=request.getParameter("eo_code").split(",");
			bs.setEb_code(eb_code);
			int cnt=0;
			for(String eo_code:eo_codes) {
				bs.setEo_code(eo_code);
				if(payDao.evtBuyOptionInsert(bs)) {
					cnt++;
				}
			}
			if(buy&&cnt==eo_codes.length) {
				msg=eb_code;
			}
		}else if(buy) {
			msg=eb_code;
		}else {
			msg="구매실패";
		}
		return msg;
	}
	public ModelAndView getEvtBuyInfo(String eb_code) {
		mav=new ModelAndView();
		EventBuy eb=payDao.getEvtBuyInfo(eb_code);
		System.out.println("eb_code="+eb_code);
		ArrayList<BuySelectedOption> bsList=new ArrayList<>();
		if(payDao.getEvtBuyOptionCount(eb_code)!=0) {
			bsList=payDao.getEvtBuyOptions(eb_code);
		}
		if(eb!=null) {
			Event e=new Event();
			e=eDao.getEvtInfo(eb.getE_code());
			mav.addObject("e", e);
			mav.addObject("eb", eb);
			mav.addObject("bsList", bsList);
			mav.addObject("makeHtml_evtBuyInfo", makeHtml_evtBuyInfo(e,eb,bsList));
			mav.setViewName("memberViews/evtBuyInfo");
		}else {
			mav.setViewName("./#");
		}
		return mav;
	}
	private String makeHtml_evtBuyInfo(Event e, EventBuy eb, ArrayList<BuySelectedOption> bsList) {
		StringBuilder sb = new StringBuilder();
		sb.append("<div class='col-lg-6' id='ebInfo'>"
				+ "		<img src='upload/thumbnail/"+e.getE_sysfilename()
				+"			'height='250' width='250'/>"
				+ "		<h2>"+e.getE_name()+"</h2>"
				+ "		<p>총가격:"+eb.getEb_total()+"원</p>");
		int i=1;
		if(bsList!=null) {
			for(BuySelectedOption bs:bsList) {
				EventOption eo=new EventOption();
				eo=eDao.getEoInfo(bs.getEo_code());
				sb.append("	<p>옵션"+i+":"+eo.getEo_name()
				+"("+eo.getEo_price()+")</p>");
				i++;
			}
		}
		sb.append("		<p>상세정보:"+e.getE_contents()+"</p>"
				+ "</div>"
				+ "<button id='payBtn'>결제하기</button>"
				+ "<button id='rejectBtn'>구매취소</button>");
		return sb.toString();
	}
	@Transactional(rollbackFor = Exception.class)
	public String evtPay(String eb_code) {
		System.out.println("eb_code="+eb_code);
		EventBuy eb=payDao.getEvtBuyInfo(eb_code);
		EventPay ep = new EventPay();
		ep.setE_code(eb.getE_code());
		ep.setM_id(eb.getM_id());
		ep.setEp_total(eb.getEb_total());
		ep.setEp_dday(eb.getEb_dday());
		boolean result_pay=payDao.evtPay(ep);
		
		ArrayList<BuySelectedOption> bsList=payDao.getEvtBuyOptions(eb_code);
		String ep_code=payDao.getEpCode(ep.getM_id(),ep.getE_code());
		ArrayList<EventPaySelectedOption> epsList=new ArrayList<>();
		if(bsList.size()>0) {
			for(BuySelectedOption bs:bsList) {
				EventPaySelectedOption eps = new EventPaySelectedOption();
				eps.setEo_code(bs.getEo_code());
				eps.setEp_code(ep_code);
				boolean result_eps=payDao.epsInsert(eps);
				if(result_eps)epsList.add(eps);
			}
		}
		if(result_pay) {
			return ep_code;
		}else {
			return "결제실패";
		}
	}
	public ModelAndView memberEvtPay(String ep_code) {
		String m_id=session.getAttribute("id").toString();
		EventPay ep=new EventPay();
		ep.setEp_code(ep_code);
		ep.setM_id(m_id);
		ep=payDao.memberEvtPay(ep);
		mav.addObject("ep", ep);
		ArrayList<EventPaySelectedOption> epsList=new ArrayList<>();
		ArrayList<EventOption> eoList=new ArrayList<>();
		if(payDao.memberEps(ep_code)!=null) {
			epsList=payDao.memberEps(ep_code);
			mav.addObject("epsList", new Gson().toJson(epsList));
			for(EventPaySelectedOption eps:epsList) {
				EventOption eo=eDao.getEoInfo(eps.getEo_code());
				eoList.add(eo);
			}
		}
		//데이터포맷 설정
		try {
			Event e=eDao.getEvtInfo(ep.getE_code());
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			Date payday=format.parse(format.format(ep.getEp_dday()));
			long refundAble_long=payday.getTime()-e.getE_refunddate()*(24*60*60*1000);
			Date refundAble=new Date(refundAble_long);
			mav.addObject("refundAble", format.format(refundAble));
			mav.addObject("ep_payday", format.format(ep.getEp_payday()));
			mav.addObject("ep_dday", format.format(ep.getEp_dday()));
		} catch (ParseException e1) {
			e1.printStackTrace();
		}
		mav.addObject("eoList", new Gson().toJson(eoList));
		Event e=eDao.getEvtInfo(ep.getE_code());
		mav.addObject("e", e);
		mav.setViewName("commonViews/evtPayDetail");
		return mav;
	}
	public ModelAndView memberPayList() {
		mav=new ModelAndView();
		String m_id=session.getAttribute("id").toString();
		ArrayList<EventPay> epList=payDao.memberPayList(m_id);
		mav.addObject("makeHtml_memberPayList", makeHtml_memberpayList(epList));
		mav.setViewName("memberViews/payList");
		return mav;
	}
	
	private String makeHtml_memberpayList(ArrayList<EventPay> epList) {
		StringBuilder sb=new StringBuilder();
		for(EventPay ep:epList) {
			Event e=eDao.getEvtInfo(ep.getE_code());
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			Date refundAble=null;
			try {
				Date payday = format.parse(format.format(ep.getEp_dday()));
				long refundAble_long=payday.getTime()-e.getE_refunddate()*(24*60*60*1000);
				refundAble=new Date(refundAble_long);
			} catch (ParseException e1) {
				e1.printStackTrace();
			}
			sb.append("<div class='payList'>"
					+ "		<img src='upload/thumbnail/"+e.getE_sysfilename()+"'/>"
					+ "		<p>결제코드:"+ep.getEp_code()+"</p>"
					+ "		<p>이벤트명:"+e.getE_name()+"</p>"
					+ "		<p>기본가:"+e.getE_price()+"원</p>"
					+ "		<p>총가격:"+ep.getEp_total()+"원</p>");
			if(payDao.memberEps(ep.getEp_code())!=null) {
				ArrayList<EventPaySelectedOption> epsList=payDao.memberEps(ep.getEp_code());
				for(EventPaySelectedOption eps:epsList) {
					EventOption eo=eDao.getEoInfo(eps.getEo_code());
					sb.append("<p>이벤트옵션:"+eo.getEo_name()+"/(+"+eo.getEo_price()+"원)</p>");
				}
			}
			sb.append("		<p>이벤트 날짜"+format.format(ep.getEp_dday())+"</p>"
					+ "		<p>결제 날짜:"+format.format(ep.getEp_payday())+"</p>"
					+ "		<p>환불가능일:~"+format.format(refundAble)+"까지</p>");
			try {
				if(refundAble.compareTo(format.parse(format.format(new Date())))>=0) {//환불가능
					sb.append("<button onclick='refundEvt'>환불하기</button>");
				}else {//환불불가
					sb.append("<button disabled=disabled>환불불가</button>");
				}
				//A.compareTo(B) 
				//A가 B보다 미래면 +1 과거면 -1 같으면0
			} catch (ParseException e1) {
				e1.printStackTrace();
			}
			sb.append("</div>");
		}
		return sb.toString();
	}
}
