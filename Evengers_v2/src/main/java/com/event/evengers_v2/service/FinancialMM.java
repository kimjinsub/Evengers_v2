package com.event.evengers_v2.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.event.evengers_v2.bean.Calculate;
import com.event.evengers_v2.dao.FinancialDao;
import com.google.gson.Gson;

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
			boolean calculate = false;
			String c_id = session.getAttribute("id").toString();
			calb.setC_id(c_id);
			try {
				SimpleDateFormat format = new SimpleDateFormat("yyyy년MM월dd일");
				Date today = new Date();
				today = format.parse(format.format(today));
				Date receipt = calb.getCal_receiptdate();
				calb.setCal_receiptdate(format.parse(format.format(receipt)));
				System.out.println("cal_receiptdate="+calb.getCal_receiptdate());
				if(receipt.compareTo(today) == -1) {
					calculate=fDao.calInsert(calb);
				}
				
			} catch (ParseException e) {
				e.printStackTrace();
			}
			if(calculate) {
				view = "ceoViews/accountingManage";
			}else {
				view = "ceoViews/accountingManage";
			}
			mav.setViewName(view);
			return mav;
	  }


	public String validation(String day) {
		String msg="";
		try {
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			Date today = new Date();
			today = format.parse(format.format(today));
			System.out.println("today="+today);
			Date receipt = format.parse(day);
			System.out.println("과연?="+receipt.compareTo(today));
			if(receipt.compareTo(today) == -1){
				msg="<p id='input'>입력 가능합니다.</p>";
			}else {
				msg="<p id='noinput'> 입력 불가능 합니다.</p>";
			}
			
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return msg;
	}

	/*
	 * public String getCalList() { String json_calList =""; String c_id =
	 * session.getAttribute("id").toString(); ArrayList<Calculate> calList = new
	 * ArrayList<>(); calList = fDao.getCalList(c_id); json_calList = new
	 * Gson().toJson(calList); for(Calculate cal:calList) { SimpleDateFormat format
	 * = new SimpleDateFormat("yyyy-MM-dd");
	 * format.format(cal.getCal_receiptdate()); } return json_calList; }
	 */
}
