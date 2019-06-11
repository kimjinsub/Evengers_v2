package com.event.evengers_v2;


import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.event.evengers_v2.bean.Ceo;
import com.event.evengers_v2.bean.Member;
import com.event.evengers_v2.service.CeoMM;
import com.event.evengers_v2.service.EventMM;
import com.event.evengers_v2.service.MemberMM;
import com.event.evengers_v2.service.RequestMM;

@Controller
public class Controller_Sung {

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
	RequestMM rm;
	
	@RequestMapping(value = "/sung", method = RequestMethod.GET)
	public String home() {
		return "home";
	}
	@RequestMapping(value = "/joinFrm", method = RequestMethod.GET)
	public ModelAndView joinFrm() {
		mav = new ModelAndView();
		mav.setViewName("commonViews/joinFrm");
		return mav;
	}
	
	@RequestMapping(value = "/memberJoin", method = RequestMethod.GET)
	public ModelAndView memberJoin() {
		mav = new ModelAndView();
		mav.setViewName("commonViews/memberJoin");
		return mav;
	}

	@RequestMapping(value = "/ceoJoin", method = RequestMethod.GET)
	public ModelAndView ceoJoin() {
		mav = new ModelAndView();
		mav.setViewName("commonViews/ceoJoin");
		return mav;
	}
	
	@RequestMapping(value = "/memberInsert", method = RequestMethod.POST)
	public ModelAndView memberInsert(Member mb) {

		mav = new ModelAndView();
		mav=mm.memberInsert(mb);

		return mav;
	}
	@RequestMapping(value = "/ceoInsert", method = RequestMethod.POST)
	public ModelAndView ceoInsert(Ceo cb) {
		mav = new ModelAndView();
		mav=cm.ceoInsert(cb);
		return mav;
	}

	@RequestMapping(value = "/memberDoubleChk", method = RequestMethod.POST)
	@ResponseBody
	public int memberDoubleChk(HttpServletRequest req) {
		String m_id = req.getParameter("m_id");
		int idCheck = mm.memberDoubleChk(m_id);
		int result = 0;

		if (idCheck > 0) {
			result = 1;
		}
		return result;
	}

	@RequestMapping(value = "/ceoDoubleChk", method = RequestMethod.POST)
	@ResponseBody
	public int ceoDoubleChk(HttpServletRequest req) {
		String c_id = req.getParameter("c_id");
		int idCheck = mm.memberDoubleChk(c_id);
		int result = 0;

		if (idCheck > 0) {
			result = 1;
		}
		return result;
	}

	@RequestMapping(value = "/ceoCheckNumber", method = RequestMethod.POST)
	@ResponseBody
	public int ceoCheckNumber(HttpServletRequest req) {
		String c_rn = req.getParameter("c_rn");
		int numCheck = cm.ceoCheckNumber(c_rn);
		int result = 0;

		if (numCheck > 0) {
			result = 1;
		}
		return result;
	}
	
	@RequestMapping(value = "/evtReqFrm", method = RequestMethod.GET)
	public ModelAndView evtReqFrm() {
		mav=new ModelAndView();
		mav.setViewName("memberViews/evtReqFrm");
		return mav;
	}
	
	@RequestMapping(value = "/evtReqInsert")
	public ModelAndView evtReqInsert(MultipartHttpServletRequest multi) {
		mav = rm.evtReqInsert(multi);
		return mav;
	}
	
	
	@RequestMapping(value = "/myReqList",produces = "application/json; charset=utf8")
	public @ResponseBody Map<String, Object> evtReqList(Integer pageNum) {
		String id =session.getAttribute("id").toString();
		Map<String, Object> map = rm.myReqList(id,pageNum);
		
		return map;
	}
	
	@RequestMapping(value = "/evtReqInfo", produces = "application/json; charset=utf8")
	public ModelAndView evtReqInfo(String req_code) {
		mav=new ModelAndView();
		String req_code1=req_code;
        mav = rm.evtReqInfo(req_code1);
		return mav;
	}
}
