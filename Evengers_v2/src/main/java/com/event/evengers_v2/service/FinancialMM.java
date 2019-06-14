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
		String Total = null;
		SimpleDateFormat format = new SimpleDateFormat("yy/MM");
		choice = format.format(choicedate);
		calList = fDao.getCalList(choice, c_id);
		Total = fDao.getTotalPrice(choice,c_id);
		System.out.println("Total="+Total);
		mav.addObject("Total", Total);
		mav.addObject("calList", calList);
		mav.addObject("makeHtml_getCalList", makeHtml_getCalList(calList,choice,Total));
		mav.setViewName("ceoViews/calList");
		return mav;
	}

	private String makeHtml_getCalList(ArrayList<String> calList,String choice,String Total) {
		StringBuilder sb = new StringBuilder();
		sb.append("<br>정산 금액  (총 금액="+Total+")<br>");
		sb.append("<table border='1' id='getCal'>");
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
		return sb.toString();
	}

	public String allShowCal(Date choicedate, String c_id) {
		StringBuilder sb = new StringBuilder();
		System.out.println("여기?choice="+choicedate);
		ArrayList<Calculate> allCalList = new ArrayList<>();
		String choice = null;
		SimpleDateFormat format = new SimpleDateFormat("yy/MM");
		choice = format.format(choicedate);
		allCalList = fDao.getAllCal(choice,c_id);
		SimpleDateFormat format1 = new SimpleDateFormat("yyyy년MM월");
		sb.append("<h1>"+format1.format(choicedate)+"</h1>");
		sb.append("<input type='button' onclick='reset()' value='닫기'>");
		sb.append("<table border='1' id='calTable'><tr><th>날짜</th><th>카테고리</th><th>내용</th><th>가격</th>");
		
		for(Calculate cal : allCalList) {
			Date receipt = cal.getCal_receiptdate();
			String cal_receiptdate = new SimpleDateFormat("yyyy-MM-dd").format(receipt);
			
			sb.append("<tr><td>"+cal_receiptdate+"</td>"
					+ "<td>"+cal.getCal_category()+"</td>"
					+ "<td>"+cal.getCal_contents()+"</td>"
					+ "<td>"+cal.getCal_price()+"</td></tr>");
		}
		sb.append("</table>");
		
		return sb.toString();
	}

}
