package com.event.evengers_v2;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.event.evengers_v2.service.CeoMM;
import com.event.evengers_v2.service.EventMM;
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
	
	@RequestMapping(value = "/eunseo", method = RequestMethod.GET)
	public String home() {
		return "home";
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
		System.out.println("e_code="+e_code);
		return json_option;
	}
	
	@RequestMapping(value = "/evtInsertFrm", method = RequestMethod.GET)
	public ModelAndView evtInsertFrm() {
		mav=new ModelAndView();
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
		System.out.println("eb_code="+eb_code);
		return mav;
	}
	@RequestMapping(value = "/performManage")
	public ModelAndView performManage() {
		String c_id = (String) session.getAttribute("id");
		System.out.println("c_id2="+c_id);
		mav = pm.getPerformList(c_id);
		return mav;
	}
}
