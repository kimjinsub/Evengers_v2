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
import com.event.evengers_v2.service.QuestionMM;

@Controller
public class Controller_Bin {
	
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
	QuestionMM qm;
	
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
	public @ResponseBody String getEvtList(String ec_name) {
		System.out.println("ec_name=" + ec_name);
		String json_evtList = em.getEvtList(ec_name);
		System.out.println(json_evtList);
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
		System.out.println("홈 문의제목" + multi.getParameter("q_title"));
		System.out.println("홈 문의내용" + multi.getParameter("q_contents"));
		System.out.println("홈 문의첨부파일" + multi.getParameter("q_files"));
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
	public @ResponseBody String getQuestionList() {
		String id = session.getAttribute("id").toString();
		String jsonStr = qm.getQuestionList(id);
		return jsonStr;
	}

	@RequestMapping(value = "/showQuestion", produces = "application/json; charset=utf8")
	public ModelAndView showQuestion(String q_Code) {
		mav=new ModelAndView();
		System.out.println("q_code=" + q_Code);
		String q_code=q_Code;
        mav = qm.showQuestion(q_code);
		return mav;
	}
}
