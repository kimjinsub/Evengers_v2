package com.event.evengers_v2;


import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.event.evengers_v2.userClass.DBException;
import com.event.evengers_v2.bean.QuestionReply;
import com.event.evengers_v2.service.CeoMM;
import com.event.evengers_v2.service.EventMM;
import com.event.evengers_v2.service.MemberMM;
import com.event.evengers_v2.service.QuestionMM;
import com.event.evengers_v2.service.RequestMM;

@Controller
public class Controller_Bin {
	
	ModelAndView mav;
	@Autowired
	private HttpSession session;
	HttpServletRequest request;
	HttpServletRequest response;
	
	@Autowired
	MemberMM mm;
	@Autowired
	CeoMM cm;
	@Autowired
	EventMM em;
	@Autowired
	QuestionMM qm;
	@Autowired
	RequestMM rm;
	@RequestMapping(value = "/bin", method = RequestMethod.GET)
	public String home() {
		return "home";
	}
	@RequestMapping(value = "/sessionTest", method = RequestMethod.GET, produces = "application/json; charset=utf8")
	public @ResponseBody String sessionTest(String testcode) {
		String msg = mm.memberTest(testcode);
		return msg;
	}

	@RequestMapping(value = "/getEvtCategory", method = RequestMethod.GET)
	public ModelAndView getEvtCategory() {
		mav = new ModelAndView();
		mav.setViewName("category");
		return mav;
	}

	@RequestMapping(value = "/getEvtList", produces = "application/json; charset=utf-8")
	public @ResponseBody String getEvtList(String ec_name,int pageNum,int listCount) {
		String json_evtList = em.getEvtList(ec_name,pageNum,listCount);
		return json_evtList;
	}
	@RequestMapping(value = "/getCategoryList", produces = "application/json; charset=utf-8")
	public @ResponseBody String getCategoryList() {
		String json_categories = em.getCategoryList();
		return json_categories;
	}
	@RequestMapping(value = "/serviceCenter", method = RequestMethod.GET)
	public ModelAndView serviceCenter() {
		mav = new ModelAndView();
		mav.setViewName("memberViews/serviceCenter");
		return mav;
	}

	@RequestMapping(value = "/questionInsert", produces = "application/json; charset=utf8")
	public ModelAndView questionInsert(MultipartHttpServletRequest multi) {
		mav = new ModelAndView();
		mav = qm.questionInsert(multi);
		return mav;
	}

	@RequestMapping(value = "/questionList")
	public ModelAndView questionList() {
		mav = new ModelAndView();
		mav.setViewName("memberViews/questionList");
		return mav;
	}

	@RequestMapping(value = "/getQuestionList", produces = "application/json; charset=utf8")
	public @ResponseBody Map<String, Object> getQuestionList(Integer pageNum) {
		String id = session.getAttribute("id").toString();
		Map<String, Object> map1 = qm.getQuestionList(id,pageNum);
		return map1;
	}

	@RequestMapping(value = "/showQuestion", produces = "application/json; charset=utf8")
	public ModelAndView showQuestion(String q_Code) {
		mav=new ModelAndView();
		String q_code=q_Code;
        mav = qm.showQuestion(q_code);
		return mav;
	}
	@RequestMapping(value = "/replyInsert", produces = "application/json; charset=utf8")
	public @ResponseBody String replyInsert(QuestionReply qr) {
		String m_id=session.getAttribute("id").toString();
		qr.setM_id(m_id);
		return qm.replyInsert(qr);
	}
	
	@RequestMapping(value = "/questionDelete", method = RequestMethod.GET) // get,post 모두 가능
	public ModelAndView questionDelete(String q_code) throws DBException{
		mav = qm.questionDelete(q_code);
		System.out.println("q_code="+q_code);
		return mav;
	} 
	@RequestMapping(value = "/download2", method = RequestMethod.GET) // get,post 모두 가능
	public void download(
			@RequestParam Map<String,Object> params,
			HttpServletResponse response ,HttpServletRequest req) throws Exception { // int를 쓰면 null값이 올 수 없기 때문에
		System.out.println("of = " + params.get("oriFileName"));
		System.out.println("sf = " + params.get("sysFileName"));
		
		params.put("root", req.getSession().getServletContext().getRealPath("/"));
		params.put("response",response);
		rm.download1(params);
	}
	@RequestMapping(value = "/estPageFrm", produces = "application/json; charset=utf8")
	public ModelAndView estPageFrm(HttpServletRequest req) {
		String req_code=req.getParameter("req_code");
		System.out.println(req_code);
		mav = new ModelAndView();
		mav.addObject("req_code",req_code);
		mav.setViewName("ceoViews/estPageFrm");
		return mav; 
	}
	
	@RequestMapping(value = "/estInsert", produces = "application/json; charset=utf8")
	public ModelAndView estInsert(MultipartHttpServletRequest multi) {
		mav = new ModelAndView();
		mav = rm.estInsert(multi);
		return mav;
	}
	@RequestMapping(value = "/getEstList", produces = "application/json; charset=utf8")
	public @ResponseBody Map<String, Object> getEstList(Integer pageNum) {
		String id = session.getAttribute("id").toString();
		Map<String, Object> map1 = rm.getEstList(id,pageNum);
		return map1;
	}
	@RequestMapping(value = "/showEstimate", produces = "application/json; charset=utf8")
	public ModelAndView showEstimate(String est_code) {
		mav=new ModelAndView();
        mav = rm.showEstimate(est_code);
		return mav;
	}
	@RequestMapping(value = "/EstimateDelete", method = RequestMethod.GET) // get,post 모두 가능
	public ModelAndView EstimateDelete(String est_code) throws DBException{
		mav = rm.estimateDelete(est_code);
		return mav;
	} 
	@RequestMapping(value = "/getRecivedEstList", produces = "application/json; charset=utf8")
	public @ResponseBody Map<String, Object> getRecivedEstList(Integer pageNum) {
		String id = session.getAttribute("id").toString();
		Map<String, Object> map1 = rm.getRecivedEstList(id,pageNum);
		return map1;
	}

	@RequestMapping(value = "/estimatePayList")
	public ModelAndView estimatePayList() {
		mav = new ModelAndView();
		mav.setViewName("memberViews/estimatePayList");
		return mav;
	}
	
	@RequestMapping(value = "/getEstPayList", produces = "application/json; charset=utf8")
	public @ResponseBody Map<String, Object> getEstPayList(Integer pageNum) {
		String id = session.getAttribute("id").toString();
		Map<String, Object> map1 = rm.getEstPayList(id,pageNum);
		return map1;
	}
	
	@RequestMapping(value = "/showEstpDetail", produces = "application/json; charset=utf8")
	public ModelAndView showEstpDetail(String estp_code) {
		mav=new ModelAndView();
		System.out.println("estp_code="+estp_code);
        mav = rm.showEstpDetail(estp_code);
		return mav;
	}
	@RequestMapping(value = "/download3", method = RequestMethod.GET) // get,post 모두 가능
	public void download3(
			@RequestParam Map<String,Object> params,
			HttpServletResponse response ,HttpServletRequest req) throws Exception { // int를 쓰면 null값이 올 수 없기 때문에
		System.out.println("of = " + params.get("oriFileName"));
		System.out.println("sf = " + params.get("sysFileName"));
		
		params.put("root", req.getSession().getServletContext().getRealPath("/"));
		params.put("response",response);
		rm.download1(params);
	}
	@RequestMapping(value = "/estpRefundRequest",method = RequestMethod.GET)
	public ModelAndView estpRefundRequest(HttpServletRequest req) {
		mav=new ModelAndView();
		String estp_code=req.getParameter("estp_code");
		System.out.println("estp_code="+estp_code);
		mav=rm.estRefundRequest(estp_code);
		mav.setViewName("memberViews/estimatePayList");
		return mav;
	}
	
	
}