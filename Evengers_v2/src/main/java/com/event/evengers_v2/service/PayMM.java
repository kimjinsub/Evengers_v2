package com.event.evengers_v2.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.ModelAndView;

import com.event.evengers_v2.bean.BuySelectedOption;
import com.event.evengers_v2.bean.Event;
import com.event.evengers_v2.bean.EventBuy;
import com.event.evengers_v2.bean.EventOption;
import com.event.evengers_v2.bean.EventPay;
import com.event.evengers_v2.bean.EventPaySelectedOption;
import com.event.evengers_v2.bean.EventRefund;
import com.event.evengers_v2.dao.EventDao;
import com.event.evengers_v2.dao.PayDao;
import com.google.gson.Gson;
import com.event.evengers_v2.userClass.DBException;

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
	@Transactional(readOnly = true, propagation = Propagation.SUPPORTS)
	public ModelAndView rejectBuy(String eb_code) throws DBException {
		mav = new ModelAndView();

		System.out.println("eb_code2=" + eb_code);
		boolean b = payDao.bsDelete(eb_code);
		boolean e = payDao.ebDelete(eb_code);

		if (e) {
			System.out.println("구매 삭제 성공");
		} else {
			System.out.println("구매 삭제 실패");
		}

		if (b == false) {
			throw new DBException();
		}

		mav.setViewName("index");
		return mav;
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
		mav.addObject("epList", epList);
		mav.addObject("makeHtml_memberPayList", makeHtml_memberpayList(epList));
		mav.setViewName("memberViews/payList");
		return mav;
	}
	
	private String makeHtml_memberpayList(ArrayList<EventPay> epList) {
		StringBuilder sb = new StringBuilder();
		for (EventPay ep : epList) {
			Event e = eDao.getEvtInfo(ep.getE_code());
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			Date refundAble = null;
			try {
				Date payday = format.parse(format.format(ep.getEp_dday()));
				long refundAble_long = payday.getTime() - e.getE_refunddate() * (24 * 60 * 60 * 1000);
				refundAble = new Date(refundAble_long);
			} catch (ParseException e1) {
				e1.printStackTrace();
			}
			String ep_code = ep.getEp_code();
			System.out.println("ep_code: " + ep_code);
			sb.append( "<div class='payList' name='"+ep_code+"'>" + "		<div class='payList2'><img src='upload/thumbnail/" + e.getE_sysfilename() + "'/></div>"
					+ "		<div class='payList3'><p>결제코드:" + ep.getEp_code() + "</p>" + "		<p>이벤트명:" + e.getE_name() + "</p>"
					+ "		<p>기본가:" + e.getE_price() + "원</p>" + "		<p>총가격:" + ep.getEp_total() + "원</p>");
			if (payDao.memberEps(ep.getEp_code()) != null) {
				ArrayList<EventPaySelectedOption> epsList = payDao.memberEps(ep.getEp_code());
				for (EventPaySelectedOption eps : epsList) {
					EventOption eo = eDao.getEoInfo(eps.getEo_code());
					sb.append("<p>이벤트옵션:" + eo.getEo_name() + "/(+" + eo.getEo_price() + "원)</p>");
				}
			}
			sb.append("		<p>이벤트 날짜" + format.format(ep.getEp_dday()) + "</p>" + "		<p>결제 날짜:"
					+ format.format(ep.getEp_payday()) + "</p>" + "		<p>환불가능일:~" + format.format(refundAble)
					+ "까지</p>");
			try {
				if (refundAble.compareTo(format.parse(format.format(new Date()))) >= 0) {// 환불가능
					sb.append("<div id='"+ep_code+"'><button class='ep_code' name='" + ep_code + "'>환불하기</button></div>");
				} else {// 환불불가
					sb.append("<div id='"+ep_code+"'><button disabled=disabled>환불불가</button></div>");
				}
				// A.compareTo(B)
				// A가 B보다 미래면 +1 과거면 -1 같으면0
			} catch (ParseException e1) {
				e1.printStackTrace();
			}
			sb.append("</div></div><hr>");
		}
		return sb.toString();
	}

	public String refundEvt(String ep_code) {
		String str = "";
		String m_id = (String) session.getAttribute("id");
		if (m_id != null) {
			if (payDao.refundChk(ep_code) == null) {
				if (payDao.refundEvt(ep_code, m_id)) {
					if (payDao.refundInsert(ep_code)) {
						str = "환불하기 요청됨";
					}
				} else {
					str = "환불하기 요청 안됨.";
				}
			} else {
				str = "이미 환불 요청중.";
			}
		}
		return str;
	}

	public ModelAndView ceoRefundList() {
		mav = new ModelAndView();
		String view = null;
		ArrayList<Event> eList = new ArrayList<Event>();
		ArrayList<EventPay> epList = new ArrayList<EventPay>();
		ArrayList<EventRefund> erList = new ArrayList<EventRefund>();
		ArrayList<EventPay> epList2 = new ArrayList<EventPay>();
		ArrayList<Event> eList2 = new ArrayList<Event>();
		String c_id = session.getAttribute("id").toString();
		if (eDao.ceoEvtList2(c_id) != null) {
			eList = eDao.ceoEvtList2(c_id);// 1 널 체크
		
			for (int i = 0; i < eList.size(); i++) {
				Event e = eList.get(i);
				String e_code = e.getE_code();
				if (payDao.epListPayList(e_code) != null) {
					epList.addAll(payDao.epListPayList(e_code));
				}

			}
		}
		for (int j = 0; j < epList.size(); j++) {
			EventPay ep = epList.get(j);
			System.out.println("ep: " + ep);
			String ep_code = ep.getEp_code();
			if (payDao.ceoRefundList(ep_code) != null) {
				erList.add(payDao.ceoRefundList(ep_code));
			}
		}
		for (int k = 0; k < erList.size(); k++) {// 네이밍
			EventRefund er = erList.get(k);
			System.out.println("er: " + er);
			String ep_code = er.getEp_code();
			if (payDao.eptableChk(ep_code) != null) {
				epList2.add(payDao.eptableChk(ep_code));
			}
			EventPay ep = epList2.get(k);
			System.out.println("ep: " + ep);
			String e_code = ep.getE_code();
			eList2.add(payDao.evttableChk(e_code));
		}
		mav.addObject("eList2", eList2);
		mav.addObject("epList2", epList2);
		mav.addObject("erList", erList);
		view = "ceoViews/ceoRefundList";
		mav.setViewName(view);
		return mav;
	}

	public int er_total(double ep_panalty, double total) {
		int er_total = 0;
		System.out.println(ep_panalty);
		System.out.println(total);

		er_total = (int) (total - Math.ceil(total * ep_panalty / 100));

		System.out.println(er_total);
		return er_total;
	}

	public String ceoRefundBtn(String ep_code, int ep_penalty) {
		String str = "";
		EventRefund er = new EventRefund();
		System.out.println("2222" + ep_code);
		System.out.println("2222" + ep_penalty);
		er.setEr_penalty(ep_penalty);
		er.setEp_code(ep_code);
		if (payDao.ceoRefundBtn(ep_code, ep_penalty)) {
			str = "등록됨";
		} else {
			str = "등록 안됨";
		}
		return str;
	}

	public ModelAndView refundCompleteList() {
		mav = new ModelAndView();
		String view = null;
		ArrayList<Event> eList = new ArrayList<Event>();
		ArrayList<EventPay> epList = new ArrayList<EventPay>();
		ArrayList<EventRefund> erList = new ArrayList<EventRefund>();
		ArrayList<EventPay> epList2 = new ArrayList<EventPay>();
		ArrayList<Event> eList2 = new ArrayList<Event>();
		String c_id = session.getAttribute("id").toString();
		if (eDao.ceoEvtList2(c_id) != null) {
			eList = eDao.ceoEvtList2(c_id);

			for (int i = 0; i < eList.size(); i++) {
				Event e = eList.get(i);
				String e_code = e.getE_code();
				if (payDao.epListPayList(e_code) != null) {
					epList.addAll(payDao.epListPayList(e_code));
				}

			}
		}
		for (int j = 0; j < epList.size(); j++) {
			EventPay ep = epList.get(j);
			System.out.println("ep: " + ep);
			String ep_code = ep.getEp_code();
			if (payDao.ceoRefundCompleteList(ep_code) != null) {
				erList.add(payDao.ceoRefundCompleteList(ep_code));
			}
		}
		for (int k = 0; k < erList.size(); k++) {// 네이밍
			EventRefund er = erList.get(k);
			System.out.println("er: " + er);
			String ep_code = er.getEp_code();
			if (payDao.eptableChk(ep_code) != null) {
				epList2.add(payDao.eptableChk(ep_code));
			}
			EventPay ep = epList2.get(k);
			System.out.println("ep: " + ep);
			String e_code = ep.getE_code();
			eList2.add(payDao.evttableChk(e_code));
		}
		System.out.println("------------------");
		System.out.println(epList);
		System.out.println(epList);
		System.out.println(erList);
		System.out.println(epList2);
		System.out.println(eList2);
		mav.addObject("er_total", er_total(epList2,erList));
		mav.addObject("eList2", eList2);
		mav.addObject("epList2", epList2);
		mav.addObject("erList", erList);
		mav.setViewName(view);
		return mav;
		//eventpay.ep_total 
		//eventrefund.er_penalty
	}

	private Object er_total(ArrayList<EventPay> epList2, ArrayList<EventRefund> erList) {
		StringBuilder sb = new StringBuilder();
		for (EventPay ep : epList2) {
		}
		for (EventRefund er : erList) {
		}
		return sb.toString();
	}

	public int er_days(String ep_dday, String er_rday) throws ParseException {
		int er_days = 0;
		System.out.println("ep_dday "+ep_dday);
		System.out.println("er_rday "+er_rday);
		String strStartDate = ep_dday;
	    String strEndDate = er_rday;
	    String strFormat = "yyyy-MM-dd";    
        SimpleDateFormat sdf = new SimpleDateFormat(strFormat);
        Date startDate = sdf.parse(strStartDate);
        Date endDate = sdf.parse(strEndDate);
        long diffDay = (startDate.getTime() - endDate.getTime()) / (24*60*60*1000);
        System.out.println(diffDay+"일");
		return (int) diffDay;
		
	}

	public String rBtnChk(String ep_code) {
		String str = "";
		String m_id =(String) session.getAttribute("id");
		if (payDao.rBtnChk(ep_code, m_id)!=null) {
			if(payDao.rBtnChk2(ep_code)==1) {
				if(payDao.rBtnChk3(ep_code)==100) {
					str = "환불거부";
				}else {
					str = "환불완료";
				}
			}else {//0
				str = "환불중";
			}
		} else {
			str = "등록 안됨";
		}
		return str;
	}
	public String rejectEvtPay(String ep_code) {
		String msg="";
		System.out.println("ep_code"+ep_code);
		if(payDao.refundInsert(ep_code)) {
			if(payDao.ceoRefundBtn(ep_code, 0)){
				msg="환불되었습니다";
			}else {
				msg="환불에 실패했습니다";
			}
		}else {
			msg="환불에 실패했습니다";
		}
		return msg;
	}
}
