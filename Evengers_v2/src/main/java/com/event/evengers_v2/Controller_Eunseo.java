package com.event.evengers_v2;

import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.event.evengers_v2.bean.Calculate;
import com.event.evengers_v2.service.CeoMM;
import com.event.evengers_v2.service.EventMM;
import com.event.evengers_v2.service.FinancialMM;
import com.event.evengers_v2.service.MemberMM;
import com.event.evengers_v2.service.PayMM;
import com.event.evengers_v2.service.PersonnelMM;
import com.event.evengers_v2.userClass.DBException;

@Controller
public class Controller_Eunseo {

	ModelAndView mav;
	@Autowired
	private HttpSession session;

	@Autowired
	MemberMM mm;
	@Autowired
	CeoMM cm;
	@Autowired
	EventMM em;
	@Autowired
	PersonnelMM pm;
	@Autowired
	PayMM paym;
	@Autowired
	FinancialMM fm;
	
	@RequestMapping(value = "/eunseo", method = RequestMethod.GET)
	public String home() {
		return "home";
	}
	@RequestMapping(value = "/introduce", method = RequestMethod.GET)
	public String introduce() {
		return "commonViews/introduce";
	}
	@RequestMapping(value = "/evtInfo", method = RequestMethod.GET)
	public ModelAndView evtInfo(String e_code) {
		mav = em.getEvtInfo(e_code);
		/* System.out.println(e_code); */
		return mav;
	}
	@RequestMapping(value = "/selectOption", produces = "application/json; charset=utf-8")
	public @ResponseBody String selectOption(String e_code) {
		String json_option = em.getOptionList(e_code);
		System.out.println("e_code=" + e_code);
		return json_option;
	}

	@RequestMapping(value = "/evtInsertFrm", method = RequestMethod.GET)
	public ModelAndView evtInsertFrm() {
		mav = new ModelAndView();
		mav.setViewName("ceoViews/evtInsertFrm");
		return mav;
	}

	@RequestMapping(value = "/selectPosition", produces = "application/json; charset=utf-8")
	public @ResponseBody String selectPosition() {
		String json_option = cm.getPositionList();
		return json_option;
	}

	@RequestMapping(value = "/selectDept", produces = "application/json; charset=utf-8")
	public @ResponseBody String selectDept() {
		String json_option = cm.getDeptList();
		return json_option;
	}

	@RequestMapping(value = "/performInsert", method = RequestMethod.POST)
	public ModelAndView performInsert(MultipartHttpServletRequest multi) {
		mav = pm.performInsert(multi);
		return mav;
	}

	@RequestMapping(value = "/rejectBuy", method = RequestMethod.POST)
	public ModelAndView rejectBuy(String eb_code) throws DBException {
		mav = paym.rejectBuy(eb_code);
		System.out.println("eb_code=" + eb_code);
		return mav;
	}
	@RequestMapping(value = "/performManage")
	public ModelAndView performManage() {
		String c_id = (String) session.getAttribute("id");
		mav = pm.getPerformList(c_id);
		return mav;
	}

	@RequestMapping(value = "/inputSalary")
	public ModelAndView inputSalary(Date date) {
		mav = fm.inputSalary(date);
		return mav;
	}
	@RequestMapping(value = "/selectSalary")
	public ModelAndView selectSalary(Date date) {
		mav = fm.selectSalary(date);
		return mav;
	}
	@RequestMapping(value = "/salary")
	public ModelAndView salary() {
		mav = new ModelAndView();
		mav.setViewName("ceoViews/salary");
		return mav;
	}
	@RequestMapping(value = "/salaryList")
	public ModelAndView salaryList() {
		mav = new ModelAndView();
		mav.setViewName("ceoViews/salaryList");
		return mav;
	}

	@RequestMapping(value = "/salaryManage")
	public ModelAndView salaryManage() {
		mav = new ModelAndView();
		mav.setViewName("ceoViews/salaryManage");
		return mav;
	}

	@RequestMapping(value = "/accountingManage")
	public ModelAndView accountingManage() {
		mav = new ModelAndView();
		mav.setViewName("ceoViews/accountingManage");
		return mav;
	}

	@RequestMapping(value = "/calList")
	public ModelAndView calList() {
		mav = new ModelAndView();
		mav.setViewName("ceoViews/calList");
		return mav;
	}

	@RequestMapping(value = "/calInsert")
	public ModelAndView calculateInsert(Calculate calb) {
		mav = new ModelAndView();
		mav = fm.calInsert(calb);
		return mav;
	}

	@RequestMapping(value = "/getCalList")
	public ModelAndView getCalList(Date choicedate) {
		String c_id = session.getAttribute("id").toString();
		System.out.println("choicedate왜?="+choicedate);
		mav = fm.getCalList(choicedate, c_id);
		return mav;
	}

	@RequestMapping(value = "/allShowCal", produces = "application/json; charset=utf-8")
	public @ResponseBody String allShowCal(Date choicedate) {
		String c_id = session.getAttribute("id").toString();
		System.out.println("c_id2=" + c_id);
		System.out.println("choicedate2=" + choicedate);
		return fm.allShowCal(choicedate, c_id);
	}

	@RequestMapping(value = "/validation", produces = "application/json; charset=utf-8;")
	public @ResponseBody String validation(String day) {
		System.out.println("day2=" + day);
		return fm.validation(day);
	}
	@RequestMapping(value = "/showRevenue")
	public ModelAndView showRevenue() {
		mav = new ModelAndView();
		mav.setViewName("ceoViews/showRevenue");
		return mav;
	}

	@RequestMapping(value = "/revenueList")
	public ModelAndView revenueList(Date choicedate) {
		System.out.println("choicedate는?="+choicedate);
		mav = fm.revenueList(choicedate);
		return mav;
	}
	@RequestMapping(value = "/revenue")
	public ModelAndView revenueList() {
		mav = new ModelAndView();
		mav.setViewName("ceoViews/revenue");
		return mav;
	}
	@RequestMapping(value = "/myPerModify",produces = "application/json; charset=utf8")
	public ModelAndView myPerModify(String emp_code) {
		mav=pm.myPerModify(emp_code);
		return mav;
	}
	@RequestMapping(value = "/performUpdate",produces = "application/json; charset=utf8")
	public @ResponseBody String performUpdate(String p_name,String dept_name,String emp_code) {
		System.out.println("p_name?"+p_name);
		System.out.println("dept_name?"+dept_name);
		System.out.println("emp_code?"+emp_code);
		String str = pm.performUpdate(p_name,dept_name,emp_code);
		return str;
	}
}
