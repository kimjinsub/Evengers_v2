package com.event.evengers_v2.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import com.event.evengers_v2.dao.EventDao;
import com.event.evengers_v2.dao.PayDao;

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
		try {
			eb.setEb_dday(new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(dday));
		} catch (ParseException e) {
			e.printStackTrace();
		}
		boolean buy=payDao.ebInsert(eb);
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
}
