package com.event.evengers_v2.service;

import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.event.evengers_v2.bean.Calculate;
import com.event.evengers_v2.dao.FinancialDao;

@Service
public class FinancialMM {
	private ModelAndView mav;
	
	@Autowired
	private FinancialDao fDao;
	@Autowired
	HttpSession session;
	

	public ModelAndView calInsert(Calculate calb) {
		mav = new ModelAndView();
		String view = null;

		
		String c_id = session.getAttribute("id").toString();
		Date cal_receiptdate = calb.getCal_receiptdate();
		String cal_category = calb.getCal_category();
		String cal_contents = calb.getCal_contents();
		int cal_price = calb.getCal_price();
		
		System.out.println("c_id3="+c_id);
		calb.setC_id(c_id);
		calb.setCal_receiptdate(cal_receiptdate);
		calb.setCal_category(cal_category);
		calb.setCal_contents(cal_contents);
		calb.setCal_price(cal_price);
		
		
		if(fDao.calInsert(calb)) {
			view = "index";
		}else {
			view = "ceoViews/accountingManage";
		}
		mav.setViewName(view);
		return mav;
	}

}
