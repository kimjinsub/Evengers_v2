package com.event.evengers_v2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.event.evengers_v2.bean.Department;
import com.event.evengers_v2.bean.Position;
import com.event.evengers_v2.service.CeoMM;
import com.event.evengers_v2.service.EventMM;
import com.event.evengers_v2.service.MemberMM;
import com.event.evengers_v2.service.PayMM;
import com.event.evengers_v2.service.PersonnelMM;

@Controller
public class Controller_Jinsub {
	
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
	
	@RequestMapping(value = "/jinsub", method = RequestMethod.GET)
	public String home() {
		return "home";
	}
	
	@RequestMapping(value = "/categoryFrm", method = RequestMethod.GET)
	public String categoryFrm() {
		return "adminViews/categoryFrm";
	}

	@RequestMapping(value = "/carryOption")
	public ModelAndView carryOption(HttpServletRequest multi) {
		mav = new ModelAndView();
		System.out.println("hi");
		System.out.println(multi.getParameter("eo_name").split(",")[0]);
		System.out.println(multi.getParameter("eo_price").split(",")[1]);
		System.out.println(multi.getParameter("eo_price").split(",").length);
		mav.setViewName("home");
		return mav;
	}

	@RequestMapping(value = "/addCategory", produces = "application/json; charset=utf-8")
	public @ResponseBody String addCategory(String ec_name) {
		String msg = em.addCategory(ec_name);
		return msg;
	}



	@RequestMapping(value = "/deleteCategory", produces = "application/json; charset=utf-8")
	public @ResponseBody String deleteCategory(String ec_name) {
		String msg = em.deleteCategory(ec_name);
		return msg;
	}

	@RequestMapping(value = "/selectCategory", produces = "application/json; charset=utf-8")
	public @ResponseBody String selectCategory() {
		String json_categories = em.getCategoryList();
		return json_categories;
	}

	@RequestMapping(value = "/evtInsert")
	public ModelAndView evtInsert(MultipartHttpServletRequest multi) {
		mav = em.evtInsert(multi);
		return mav;
	}
	
	
	@RequestMapping(value = "/api", method = RequestMethod.GET)
	public ModelAndView pwFind() {
		mav = new ModelAndView();
		mav.setViewName("addrApi");
		return mav;
	}
	@RequestMapping(value = "/position")
	public String position() {
		return "ceoViews/position";
	}
	@RequestMapping(value = "/dept")
	public String dept() {
		return "ceoViews/dept";
	}
	@RequestMapping(value = "/perform")
	public String perform() {
		return "ceoViews/perform";
	}
	@RequestMapping(value = "/addPosition", 
			produces = "application/json; charset=utf-8;")
	public @ResponseBody String addPosition(Position p) {
		String msg=pm.addPosition(p);
		return msg;
	}
	@RequestMapping(value = "/getPositionList", 
			produces = "application/json; charset=utf-8;")
	public @ResponseBody String getPositionList() {
		String json_pList=pm.getPositionList();
		return json_pList;
	}
	@RequestMapping(value = "/addDept", 
			produces = "application/json; charset=utf-8;")
	public @ResponseBody String addDept(Department dept) {
		String msg=pm.addDept(dept);
		return msg;
	}
	@RequestMapping(value = "/getDeptList", 
			produces = "application/json; charset=utf-8;")
	public @ResponseBody String getDeptList() {
		String json_pList=pm.getDeptList();
		return json_pList;
	}
	@RequestMapping(value = "/getSessionId", 
			produces = "application/json; charset=utf-8;")
	public @ResponseBody String getSessionId() {
		String iam="";
		if(session.getAttribute("id")!=null) {
			iam=session.getAttribute("id").toString();
		}else {
			iam="none";
		}
		iam=mm.whoRU(iam);
		return iam;
	}
	@RequestMapping(value = "/getTotalPrice", 
			produces = "application/json; charset=utf-8;")
	public @ResponseBody int getTotalPrice(String[] options,String def) {
		System.out.println(options);
		System.out.println(def);
		return em.getTotalPrice(options,def);
	}
	@RequestMapping(value = "/evtBuy", method = RequestMethod.POST
			,produces = "application/json;charset=utf-8")
	public @ResponseBody String evtBuy(HttpServletRequest request) {
		return paym.evtBuy(request);
	}
	@RequestMapping(value = "/getEvtBuyInfo", method = RequestMethod.POST)
	public ModelAndView getEvtBuyInfo(String eb_code) {
		mav=paym.getEvtBuyInfo(eb_code);
		return mav;
	}
	/*@RequestMapping(value = "/sessionChk", 
			produces = "application/json; charset=utf-8;")
	public @ResponseBody String sessionChk(HttpServletRequest req) {
		SessionCheck sc= new SessionCheck(); 
		String kind=sc.getSessionId(req);
		return kind;
	}*/
}
