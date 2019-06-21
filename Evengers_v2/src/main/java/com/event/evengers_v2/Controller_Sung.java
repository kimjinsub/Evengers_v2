package com.event.evengers_v2;


import java.text.ParseException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.event.evengers_v2.bean.Ceo;
import com.event.evengers_v2.bean.Member;
import com.event.evengers_v2.service.CeoMM;
import com.event.evengers_v2.service.EventMM;
import com.event.evengers_v2.service.MemberMM;
import com.event.evengers_v2.service.RequestMM;
import com.event.evengers_v2.userClass.DBException;

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

	@RequestMapping(value = "/memberEmailChk",produces = "application/json; charset=utf-8;")
	public @ResponseBody String memberEmailChk(String email, String email1) {
		System.out.println("email="+email);
		System.out.println("email1="+email1);
		return mm.memberEmailChk(email,email1);
	}
	
	@RequestMapping(value = "/ceoEmailChk",produces = "application/json; charset=utf-8;")
	public @ResponseBody String ceoEmailChk(String email, String email1) {
		System.out.println("email="+email);
		System.out.println("email1="+email1);
		return mm.ceoEmailChk(email,email1);
	}
	
	@RequestMapping(value = "/memberDoubleChk", method = RequestMethod.POST)
	@ResponseBody
	public int memberDoubleChk(HttpServletRequest req) {
		String m_id = req.getParameter("m_id");
		int idCheck = mm.memberDoubleChk(m_id);		//존재시 1 미존재시 0  널값일때 -1
		int result=-1;

		if (idCheck > 0) {	//존재
			result = 1;
		}else if(idCheck == 0) {	//미입력
			result =0;
		}else result = -1;	//사용가능
		
		System.out.println("result = " +result);
		
		return result;
	}

	@RequestMapping(value = "/ceoDoubleChk", method = RequestMethod.POST)
	@ResponseBody
	public int ceoDoubleChk(HttpServletRequest req) {
		String c_id = req.getParameter("c_id");
		int idCheck = mm.memberDoubleChk(c_id);
		int result=-1;

		if (idCheck > 0) {	//존재
			result = 1;
		}else if(idCheck == 0) {	//미입력
			result =0;
		}else result = -1;	//사용가능
		return result;
	}

	@RequestMapping(value = "/ceoCheckNumber", method = RequestMethod.POST)
	@ResponseBody
	public int ceoCheckNumber(HttpServletRequest req) {
		String c_rn = req.getParameter("c_rn");
		int numCheck = cm.ceoCheckNumber(c_rn);
		int result = -1;

		if (numCheck > 0) {
			result = 1;
		}else if(numCheck == 0) {	//미입력
			result =0;
		}else result = -1;	//사용가능
		
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
	public @ResponseBody Map<String, Object> evtReqList(Integer pageNum, Integer listCount) {
		String id =session.getAttribute("id").toString();
		Map<String, Object> map = rm.myReqList(id,pageNum,listCount);
		
		return map;
	}
	
	@RequestMapping(value = "/evtReqInfo", produces = "application/json; charset=utf8")
	public ModelAndView evtReqInfo(String req_code) {
		mav=new ModelAndView();
		String req_code1=req_code;
        mav = rm.evtReqInfo(req_code1);
		return mav;
		
	}
	
	@RequestMapping(value = "/download1", method = RequestMethod.GET) 
	public void download(
			@RequestParam Map<String,Object> params,
			HttpServletResponse response ,HttpServletRequest req) throws Exception { // int를 쓰면 null값이 올 수 없기 때문에
		System.out.println("of = " + params.get("oriFileName"));
		System.out.println("sf = " + params.get("sysFileName"));
		
		params.put("root", req.getSession().getServletContext().getRealPath("/"));
		params.put("response",response);
		rm.download(params);
	}  
	
	@RequestMapping(value = "/myReqDelete", method = RequestMethod.GET) 
	public ModelAndView evtReqDelete(String req_code) throws DBException{
		mav = rm.myReqDelete(req_code);
		System.out.println("req_code="+req_code);
		return mav;
	} 
	
	
	@RequestMapping(value = "/estPay", method = RequestMethod.GET) 
	public ModelAndView estPay(String est_code) throws DBException, ParseException{
		mav = rm.estPay(est_code);
		return mav;
	}
	
	
	@RequestMapping(value = "/receivedEstDenial", method = RequestMethod.GET) 
	public ModelAndView receivedEstDenial(String est_code) throws DBException{
		mav = rm.receivedEstDenial(est_code);
		return mav;
	}
	
	@RequestMapping(value = "/estSell", produces = "application/json; charset=utf8") 
	public @ResponseBody Map<String, Object> estSell(int pageNum,int listCount) {
		String id = session.getAttribute("id").toString();
		Map<String, Object> map = rm.estSell(id,pageNum,listCount);
		return map;
	}
	
	@RequestMapping(value = "/estSellPage", method = RequestMethod.GET)
	public ModelAndView evtSellPage() {
		mav=new ModelAndView();
		mav.setViewName("ceoViews/estSellPage");
		return mav;
	}
	
	
	@RequestMapping(value = "/reqSearch",produces = "application/json; charset=utf8")
	public @ResponseBody Map<String, Object> reqSearch(String words) {
		String id = session.getAttribute("id").toString();
		Map<String, Object> map = rm.reqSearch(words,id);
		return map;
	}
	
}
