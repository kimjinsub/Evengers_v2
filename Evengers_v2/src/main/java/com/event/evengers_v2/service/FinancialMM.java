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
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			Date today = new Date();
			today = format.parse(format.format(today));
			String receiptdate = format.format(calb.getCal_receiptdate());
			System.out.println("receiptdate=" + receiptdate);
			Date receipt = format.parse(receiptdate);
			calb.setCal_receiptdate(format.parse(format.format(receipt)));
			System.out.println("cal_receiptdate=" + calb.getCal_receiptdate());
			if (receipt.compareTo(today) == -1) {
				calculate = fDao.calInsert(calb);
			}

		} catch (ParseException e) {
			e.printStackTrace();
		}
		if (calculate) {
			view = "ceoViews/accountingManage";
		} else {
			view = "ceoViews/accountingManage";
		}
		mav.setViewName(view);
		return mav;
	}

	public String validation(String day) {
		String msg = "";
		try {
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			Date today = new Date();
			today = format.parse(format.format(today));
			System.out.println("today=" + today);
			Date receipt = format.parse(day);
			System.out.println("과연?=" + receipt.compareTo(today));
			if (receipt.compareTo(today) == -1) {
				msg = "<p id='input'>입력 가능합니다.</p>";
			} else {
				msg = "<p id='noinput'> 입력 불가능 합니다.</p>";
			}

		} catch (ParseException e) {
			e.printStackTrace();
		}
		return msg;
	}

	public ModelAndView getCalList(Date choicedate, String c_id) {
		mav = new ModelAndView();
		ArrayList<String> calList = new ArrayList<>();
		String choice = null;
		SimpleDateFormat format = new SimpleDateFormat("yy/MM");
		choice = format.format(choicedate);
		System.out.println("choice2=" + choice);
		calList = fDao.getCalList(choice, c_id);
		mav.addObject("calList", calList);
		mav.addObject("makeHtml_getCalList", makeHtml_getCalList(calList,choice));
		mav.setViewName("ceoViews/calList");
		return mav;
	}

	private String makeHtml_getCalList(ArrayList<String> calList,String choice) {
		StringBuilder sb = new StringBuilder();
		sb.append(choice+"<br>정산 금액<br>");
		sb.append("<table border='1'>");
		sb.append("<tr>");
		sb.append("<td>금액</td><td>사용</td></tr>");
		for (int i = 0; i < calList.size(); i++) {
			String[] a = calList.get(i).split(",");
			for (int j = 0; j < a.length; j++) {
					sb.append("<td>" + a[j] + "</td>");
				}
				sb.append("</tr>");
	}
		sb.append("</table>");
		/* sb.append("<button onclick='allShowCal()'>상세보기</button>"); */
		return sb.toString();
	}

	public String allShowCal(Date choicedate, String c_id) {
		String json_calList = "";
		ArrayList<Calculate> allCalList = new ArrayList<>();
		String choice = null;
		SimpleDateFormat format = new SimpleDateFormat("yy/MM");
		choice = format.format(choicedate);
		allCalList = fDao.getAllCal(choice,c_id);
		json_calList = new Gson().toJson(allCalList);
		System.out.println("allcalList="+json_calList);
		return json_calList;
	}

}
