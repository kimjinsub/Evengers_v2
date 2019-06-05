package com.event.evengers_v2;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.event.evengers_v2.service.CeoMM;
import com.event.evengers_v2.service.EventMM;
import com.event.evengers_v2.service.MemberMM;

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
}
