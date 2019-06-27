package com.event.evengers_v2.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.ResultMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.event.evengers_v2.bean.Calculate;
import com.event.evengers_v2.bean.Employee;
import com.event.evengers_v2.bean.EventPay;
import com.event.evengers_v2.bean.MonthlySalary;
import com.event.evengers_v2.bean.Position;
import com.event.evengers_v2.dao.EventDao;
import com.event.evengers_v2.dao.FinancialDao;
import com.event.evengers_v2.dao.PayDao;
import com.event.evengers_v2.dao.PersonnelDao;
import com.event.evengers_v2.dao.RequestDao;
import com.google.gson.Gson;

@Service
public class FinancialMM {
	private ModelAndView mav;

	@Autowired
	private FinancialDao fDao;
	@Autowired
	HttpSession session;
	@Autowired
	private PersonnelDao pDao;
	@Autowired
	private PayDao payDao;
	@Autowired
	private EventDao eDao;
	@Autowired
	private RequestDao reqDao;

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
			Date receipt = format.parse(day);
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
		int Total = 0;
		SimpleDateFormat format = new SimpleDateFormat("yy/MM");
		choice = format.format(choicedate);
		calList = fDao.getCalList(choice, c_id);
	    if(fDao.getTotalCount(choice, c_id) == 0) {
	         mav.addObject("msg", "<p>정산할 금액이 없습니다</p>");
	         mav.setViewName("ceoViews/calList");
	         return mav;
	      }
	    Total = fDao.getTotalPrice(choice, c_id);
		mav.addObject("Total", Total);
		mav.addObject("calList", calList);
		mav.addObject("makeHtml_getCalList", makeHtml_getCalList(calList, choice, Total));
		mav.setViewName("ceoViews/calList");
		return mav;
	}

	private String makeHtml_getCalList(ArrayList<String> calList, String choice, int Total) {
		StringBuilder sb = new StringBuilder();
		sb.append("<br><div><b>정산 금액  (총 금액=" + Total + ")</b><div><br>");
		sb.append("<table id='getCal' class='table table-striped'>");
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
		ArrayList<Calculate> allCalList = new ArrayList<>();
		String choice = null;
		SimpleDateFormat format = new SimpleDateFormat("yy/MM");
		choice = format.format(choicedate);
		allCalList = fDao.getAllCal(choice, c_id);
		SimpleDateFormat format1 = new SimpleDateFormat("yyyy년MM월");
		sb.append("<h3 id='choicedate'>" + format1.format(choicedate) + "</h3>");
		sb.append("<input type='button' onclick='reset()' value='닫기'class='btn btn-outline-primary btn-rounded waves-effect'><br>");
		sb.append("<table id='calTable' class='table table-striped'><tr><th>날짜</th><th>카테고리</th><th>내용</th><th>가격</th>");

		for (Calculate cal : allCalList) {
			Date receipt = cal.getCal_receiptdate();
			String cal_receiptdate = new SimpleDateFormat("yyyy-MM-dd").format(receipt);

			sb.append("<tr><td>" + cal_receiptdate + "</td>" 
						+ "<td>" + cal.getCal_category() + "</td>"
						+ "<td>"+ cal.getCal_contents() + "</td>" 
						+ "<td>" + cal.getCal_price() + "</td></tr>");
		}
		sb.append("</table>");

		return sb.toString();
	}

	public ModelAndView selectSalary(Date date) {
		mav = new ModelAndView();
		System.out.println("date2=" + date);
		SimpleDateFormat format = new SimpleDateFormat("yy/MM");
		Date today = new Date();
		String choice = format.format(date);
		try {
			today = format.parse(format.format(today));
			Date choicedate = format.parse(choice);
			if (choicedate.compareTo(today) != 1) {
				ArrayList<MonthlySalary> msList = new ArrayList<MonthlySalary>();
				ArrayList<Employee> empList = new ArrayList<>();
				String c_id = session.getAttribute("id").toString();
				msList = fDao.selectSalary(choice, c_id);
				if (msList.size() != 0) {
					mav.addObject("makeHtml_salary", makeHtml_salary(msList,choice));
				} else {
					empList = pDao.getEmpList(c_id);
					mav.addObject("empList", empList);
					mav.addObject("makeHtml_input", makeHtml_input(empList));
					mav.setViewName("ceoViews/salary");
				}
			} else {
				mav.addObject("msg", "입력 및 검색이 불가능 합니다.");
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}

		mav.setViewName("ceoViews/salary");
		return mav;
	}

	private Object makeHtml_salary(ArrayList<MonthlySalary> msList,String choice) {
		StringBuilder sb = new StringBuilder();
		int i=0;
		sb.append("<div>");
		sb.append("<h3><i class='far fa-calendar-check'></i>&nbsp"+choice+"</h3>");
		sb.append("<table class='table table-striped'><tr><th>#</th><th>사번</th><th>성명</th><th>직책</th><th>급여</th>");
		for (MonthlySalary ms : msList) {
			i += 1;
			sb.append("<tr><td>"+i+"</td>"
						+ "<td>" + ms.getMs_emp_code() + "</td>" 
						+ "<td>" + ms.getMs_emp_name() + "</td>" 
						+ "<td>"+ ms.getMs_p_name() + "</td>" 
						+ "<td>" + ms.getMs_p_salary() + "</td></tr>");
		}
		sb.append("</table></div>");
		return sb.toString();
	}

	private Object makeHtml_input(ArrayList<Employee> empList) {
		StringBuilder sb = new StringBuilder();
		int i = 0;
		sb.append("<div id='inputbtn'><button onclick='inputSalary()' class='btn btn-outline-primary btn-rounded waves-effect'>입력</button></div>");
		sb.append("<table class='table table-striped' id='input'><tr><th>#</th><th>사번</th><th>성명</th><th>직책</th><th>급여</th></tr>");
		for (Employee emp : empList) {
			i += 1;
			sb.append("<tr><td>"+i+"</td>"
					    + "<td>" + emp.getEmp_code() + "</td>" 
						+ "<td>" + emp.getEmp_name() + "</td>" 
						+ "<td>"+ pDao.getPositionInfo(emp.getP_code()).getP_name() + "</td>" 
						+ "<td>"+ pDao.getPositionInfo(emp.getP_code()).getP_salary() + "</td></tr>");
		}
		sb.append("</table>");
		return sb.toString();
	}

	public ModelAndView inputSalary(Date date) {
		MonthlySalary ms = new MonthlySalary();
		String c_id = session.getAttribute("id").toString();
		ArrayList<Employee> empList = pDao.getEmpList(c_id);

		System.out.println("empList=" + empList);
		SimpleDateFormat format = new SimpleDateFormat("yy/MM");
		String choicedate = format.format(date);
		Date inputDate;

		String view = null;
		try {
			inputDate = format.parse(choicedate);
			for (Employee emp : empList) {
				ms.setMs_date(inputDate);
				ms.setMs_c_id(c_id);
				ms.setMs_emp_code(emp.getEmp_code());
				ms.setMs_emp_name(emp.getEmp_name());
				ms.setMs_p_code(emp.getP_code());
				ms.setMs_p_name(pDao.getPositionInfo(emp.getP_code()).getP_name());
				ms.setMs_p_salary(pDao.getPositionInfo(emp.getP_code()).getP_salary());
				fDao.salaryInsert(ms);
			}
			{
				view = "ceoViews/salaryManage";
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}
		mav.setViewName(view);
		return mav;
	}

	public ModelAndView revenueList(Date choicedate) {
		mav = new ModelAndView();
		int evtRe_total = 0;
		int estRe_total = 0;
		Date today = new Date();
		SimpleDateFormat format = new SimpleDateFormat("yy/MM");
		String choice = format.format(choicedate);
		String id = session.getAttribute("id").toString();
		EventPay ep = new EventPay();
		ArrayList<String> e_codes = new ArrayList<>();
		e_codes = eDao.getEvtCodeList(id); // e_codes 출력
		
		ArrayList<String> req_codes = new ArrayList<>();
		req_codes = reqDao.getReqCodeList();
		
		try {
			today = format.parse(format.format(today));
			Date choiceDate = format.parse(choice);
			if (choiceDate.compareTo(today) != 1) {
		if (e_codes.size() == 0 || req_codes.size() ==0) {
			return null;
		} else {
			ArrayList<String> ep_codes = new ArrayList<>();
			ep_codes = payDao.ceoEvtPayList2(e_codes);
			//위약금(이벤트)
			ArrayList<Double> er_penalty = new ArrayList<>();
			ArrayList<Double> ep_total = new ArrayList<>();
			//위약금(견적)
			ArrayList<Double> estr_penalty = new ArrayList<>();
			ArrayList<Double> estp_total = new ArrayList<>();
		
			// 환불된 것들 빼버리고 출력하기(이벤트 결제)
			ArrayList<String> refundedEp_Codes = new ArrayList<>();
			refundedEp_Codes = payDao.isRefundedEp(ep_codes);
			for (String refundedEp_Code : refundedEp_Codes) {
				er_penalty = fDao.getEvtPenalty(refundedEp_Code,choice);
				ep_total = payDao.getEvtTotal(refundedEp_Code,choice);
				ep_codes.remove(refundedEp_Code);
			}
			System.out.println("er_penalty="+er_penalty);
			System.out.println("ep_total="+ep_total);
			
			for(int i=0;i<er_penalty.size();i++) {
			evtRe_total += (int) (ep_total.get(i) - Math.ceil(ep_total.get(i) * er_penalty.get(i)/ 100));
			}
			System.out.println("re_total="+evtRe_total);
			mav.addObject("re_total", evtRe_total); //위약금
			mav.addObject("ep_codes", ep_codes);
			//견적 부분
			ArrayList<String> estp_codes = new ArrayList<>();
			estp_codes = payDao.estPayList(req_codes);
			//환불된 것들 빼버리고 출력하기(견적 결제)
			ArrayList<String> refundEstp_codes =new ArrayList<>();
			refundEstp_codes = payDao.isrefundedEstp(estp_codes);
			for(String refundEstp_code : refundEstp_codes) {
				estr_penalty = fDao.getEstPenalty(refundEstp_code,choice);
				estp_total = payDao.getEstTotal(refundEstp_code,choice);
				estp_codes.remove(refundEstp_code);
			}
			for(int i=0;i<estr_penalty.size();i++) {
				estRe_total += (int) (estp_total.get(i) - Math.ceil(estp_total.get(i) * estr_penalty.get(i)/ 100));
			}
			System.out.println("estRe_total="+estRe_total);
			System.out.println("estr_penalty="+estr_penalty);
			System.out.println("estp_total="+estp_total);
			
			mav.addObject("estp_codes", estp_codes);
		}
		List<Map<String,Object>> evtReList = new ArrayList<>(); 
		evtReList = fDao.getEvtRevenue(choice);
		System.out.println("evtReList=" + evtReList);
		List<Map<String,Object>> estpReList = new ArrayList<>();
		estpReList = fDao.getEstpRevenue(choice);
		System.out.println("estpReList="+estpReList);
		mav.addObject("evtReList", evtReList);
		mav.addObject("estpReList", estpReList);
		mav.addObject("makeHtml_revenue", makeHtml_revenue(evtRe_total,evtReList,estpReList,choicedate,estRe_total));
			}else {
				mav.addObject("msg", "수익을 확인할 수 없습니다.");
			}
			
			} catch (ParseException e) {
				e.printStackTrace();
		}
		mav.setViewName("ceoViews/revenue");
		return mav;
	}

	private Object makeHtml_revenue(int evtRe_total,List<Map<String,Object>> evtReList,List<Map<String,Object>> estpReList,Date choicedate,int estRe_total) {
		StringBuilder sb= new StringBuilder();
		String c_id = session.getAttribute("id").toString();
		MonthlySalary ms = new MonthlySalary();
		String ep_total = null;
		String e_category = null;
		String estp_total = null;
		String estp_category = null;
		int allestp_total = 0;
		int allevt_total = 0;
		int revenue = 0;
		
		SimpleDateFormat format = new SimpleDateFormat("yy/MM");
		String choice = format.format(choicedate);
		int totalMonth = fDao.getTotalMonth(choice,c_id); //급여 
		System.out.println("totalMonth="+totalMonth);
		int totalCal = fDao.getTotalPrice(choice, c_id); //정산 금액
		System.out.println("totalCal="+totalCal);
		
		sb.append("<div>");
		sb.append("<table class='table table-hover'><tr bgcolor='skyblue' align ='center'><p><td colspan = '3' span style='color:white'>이번달 수입/지출</td></p></tr>");
		sb.append("<tr><th>내용</th><th>지출</th><th>수입</th>");
	    
		for(int i=0;i<evtReList.size();i++) {
			sb.append("<tr><td>이벤트 수입(");
			ep_total = evtReList.get(i).get("ep_total").toString();
			e_category = evtReList.get(i).get("category").toString();
			int evtTotal = Integer.parseInt(ep_total);
			evtTotal *= 1;
			allevt_total += evtTotal;
			sb.append(e_category+")</td>");
			sb.append("<td></td>");
			sb.append("<td>"+"+"+evtTotal+"</td>");
		}
		sb.append("</tr>");//이벤트
		sb.append("<tr><td>이벤트 위약금</td>");
		evtRe_total *= 1;
		sb.append("<td></td>");
		sb.append("<td>"+"+"+evtRe_total+"</td></tr>"); //이벤트 위약금
		
		for(int i=0;i<estpReList.size();i++) {
			sb.append("<tr><td>견적 수입(");
			estp_total = estpReList.get(i).get("estp_total").toString();
			estp_category = estpReList.get(i).get("category").toString();
			int estpTotal = Integer.parseInt(estp_total);
			estpTotal *= 1;
			allestp_total += estpTotal;
			sb.append(estp_category+")</td>");
			sb.append("<td></td>");
			sb.append("<td>"+"+"+estpTotal+"</td>");
		}
		System.out.println("allestp="+allestp_total);
		System.out.println("allep="+allevt_total);
		sb.append("</tr>");//견적
		
		sb.append("<tr><td>견적 위약금</td>");
		estRe_total *= 1;
		sb.append("<td></td>");
		sb.append("<td>"+"+"+estRe_total+"</td></tr>"); //견적 위약금
		
		sb.append("<tr><td>총 급여</td>");
		totalMonth *= -1;
		sb.append("<td>"+totalMonth+"</td>");
		sb.append("<td></td></tr>");//급여
		
		sb.append("<tr><td>정산 금액</td>");
		totalCal *= -1;
		sb.append("<td>"+totalCal+"</td>");
		sb.append("<td></td></tr>"); //정산

		revenue = allestp_total + allevt_total + totalMonth + totalCal +evtRe_total;
		
		sb.append("<tr><td><b>순이익</b></td>"
				+ "<td colspan='2'><b>"+revenue+"</b></td></tr>");
		
		sb.append("</table></div>"); 
		return sb.toString();
	}
}
