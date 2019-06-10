package com.event.evengers_v2;


import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.event.evengers_v2.bean.Email;
import com.event.evengers_v2.service.CeoMM;
import com.event.evengers_v2.service.EventMM;
import com.event.evengers_v2.service.MemberMM;
import com.event.evengers_v2.userClass.EmailSender;
import com.event.evengers_v2.userClass.TempKey;

@Controller
public class Controller_Chun {

	ModelAndView mav;
	@Autowired
	MemberMM mm;
	@Autowired

	private HttpSession session;
	@Autowired
	CeoMM cm;

	@Autowired
	EventMM em;

	@RequestMapping(value = "/loginFrm", method = RequestMethod.GET)
	public ModelAndView loginFrm() {
		mav = new ModelAndView();
		mav.setViewName("commonViews/loginFrm");
		return mav;
	}

	@RequestMapping(value = "/find", method = RequestMethod.GET)
	public ModelAndView find() {
		mav = new ModelAndView();
		mav.setViewName("commonViews/find");
		return mav;
	}

	@RequestMapping(value = "/access", method = RequestMethod.POST)
	public ModelAndView access(String id, String pw) {
		mav = mm.access(id, pw);
		return mav;
	}

	@RequestMapping(value = "/idFind", method = RequestMethod.GET)
	public ModelAndView idFind() {
		mav = new ModelAndView();
		mav.setViewName("commonViews/idFind");
		return mav;
	}

	@RequestMapping(value = "/pwFind", method = RequestMethod.GET)
	public ModelAndView pwFind() {
		mav = new ModelAndView();
		mav.setViewName("commonViews/pwFind");
		return mav;
	}

	@RequestMapping(value = "/sendId", method = RequestMethod.GET)
	public @ResponseBody String sendId(String email) {
		String id = mm.sendId(email);
		System.out.println(email);
		return id;
	}

	@RequestMapping(value = "/sendNumber", method = RequestMethod.GET)
	public @ResponseBody String sendNumber(String id, String email) {
		String sendEmail = mm.sendNumber(id, email);
		System.out.println("sendEmail" + sendEmail);
		return sendEmail;
	}

	@Autowired
	private EmailSender emailSender;
	@Autowired
	private Email email;

	@RequestMapping("/sendpw.do")
	public @ResponseBody boolean sendEmailAction(@RequestParam Map<String, Object> paramMap, ModelMap model)
			throws Exception {

		String id = (String) paramMap.get("id");
		String e_mail = (String) paramMap.get("email");
		System.out.println(id);
		System.out.println(e_mail);

		String pw = mm.sendNumber(id, e_mail);
		System.out.println("pw"+pw);
		if (pw != null) {
			int rankey = new TempKey().getKey(50, false);
			email.setContent("인증번호는 " + rankey + " 입니다.");
			email.setReceiver(e_mail);
			email.setSubject(id + "님 비밀번호 찾기 메일입니다.");
			session.setAttribute("rankey", rankey);
			emailSender.SendEmail(email);
			return true;
		} else {
			return false;
		}
	}

	@RequestMapping(value = "/matchNum", method = RequestMethod.GET)
	public @ResponseBody boolean matchNum(String matchNum) {

		String rankey = String.valueOf(session.getAttribute("rankey"));
		if (rankey.equals(matchNum)) {
			return true;
		} else {
			return false;
		}

	}

	@RequestMapping(value = "/pwChange", method = RequestMethod.GET
			,produces = "application/json;charset=utf-8")
	public @ResponseBody String pwChange(String id,String pwMo1,String pwMo2) {
		System.out.println("id"+id);
		System.out.println("pwMo1"+pwMo1);
		System.out.println("pwMo2"+pwMo2);
		String msg= mm.pwChange(id,pwMo1,pwMo2);
			 
		return msg;
	}


	@RequestMapping(value = "/mInfo", method = RequestMethod.GET)
	public ModelAndView mInfo() {
		mav = new ModelAndView();
		mav = mm.mInfo();
		return mav;
	}
	
	@RequestMapping(value = "/memberMyPage", method = RequestMethod.GET)
	public ModelAndView memberMyPage() {
		mav = new ModelAndView();
		String id= (String) session.getAttribute("id");
		String view= null;
		id=mm.memberMyPageChk(id);
		if(id==null) {
			String id2= (String) session.getAttribute("id");
			if(id2==null) {
				view="commonViews/loginFrm";
			}else {
				view="index";
			}
		}else {
		view="memberViews/memberMyPage";
		}
		mav.setViewName(view);
		return mav;
	}
	@RequestMapping(value = "/mInfoModify", method = RequestMethod.GET)
	public ModelAndView mInfoModify() {
		mav = new ModelAndView();
		mav.setViewName("memberViews/mInfoModify");
		return mav;
	}
	@RequestMapping(value = "/mModifyMainSee", method = RequestMethod.GET, produces = "application/json; charset=utf8")
	public @ResponseBody String mModifyMainSee(String pwCheck) {
		if (pwCheck != null) {
		String msg = mm.mModifyMainSee(pwCheck);
		System.out.println(msg);
		return msg;
		}
		return null;
	}
	
	@RequestMapping(value = "/mModifyList", produces = "application/json; charset=utf-8")
	public @ResponseBody String mModifyList() {
		String json_mModifyList = mm.mModifyList();
		return json_mModifyList;
	}
	
	@RequestMapping(value = "/payList", method = RequestMethod.GET)
	public ModelAndView payList() {
		mav = new ModelAndView();
		mav.setViewName("memberViews/payList");
		return mav;
	}
	@RequestMapping(value = "/choiceList", method = RequestMethod.GET)
	public ModelAndView choiceList() {
		mav = new ModelAndView();
		mav.setViewName("memberViews/choiceList");
		return mav;
	}
	@RequestMapping(value = "/receivedList", method = RequestMethod.GET)
	public ModelAndView receivedList() {
		mav = new ModelAndView();
		mav.setViewName("memberViews/receivedList");
		return mav;
	}
	@RequestMapping(value = "/receivedEstList", method = RequestMethod.GET)
	public ModelAndView receivedEstList() {
		mav = new ModelAndView();
		mav.setViewName("memberViews/receivedEstList");
		return mav;
	}
	@RequestMapping(value = "/myReqList", method = RequestMethod.GET)
	public ModelAndView myReqList() {
		mav = new ModelAndView();
		mav.setViewName("memberViews/myReqList");
		return mav;
	}
	@RequestMapping(value = "/modifyMemInfo", method = RequestMethod.GET)
	public ModelAndView modifyMemInfo(String pw,String name,String tel,String email,String area) {
		mav = new ModelAndView();
		mav = mm.modifyMemInfo(pw,name,tel,email,area);
		return mav;
	}
	
	@RequestMapping(value = "/ceoMyPage", method = RequestMethod.GET)
	public ModelAndView ceoMyPage() {
		mav = new ModelAndView();
		String id= (String) session.getAttribute("id");
		String view= null;
		id=mm.ceoMyPageChk(id);
		if(id==null) {
			String id2 = (String) session.getAttribute("id");
			if (id2 == null) {
				view = "commonViews/loginFrm";
			} else {
				view = "index";
			}
		}else {
		view="ceoViews/ceoMyPage";
		}
		mav.setViewName(view);
		return mav;
	}
	@RequestMapping(value = "/ceoInfo", method = RequestMethod.GET)
	public ModelAndView ceoInfo() {
		mav = new ModelAndView();
		mav = mm.ceoInfo();
		return mav;
	}
	@RequestMapping(value = "/ceoInfoModify", method = RequestMethod.GET)
	public ModelAndView ceoInfoModify() {
		mav = new ModelAndView();
		mav.setViewName("ceoViews/ceoInfoModify");
		return mav;
	}
	@RequestMapping(value = "/ceoModifyMainSee", method = RequestMethod.GET, produces = "application/json; charset=utf8")
	public @ResponseBody String ceoModifyMainSee(String pwCheck) {
		if (pwCheck != null) {
		String msg = mm.ceoModifyMainSee(pwCheck);
		System.out.println(msg);
		return msg;
		}
		return null;
	}
	@RequestMapping(value = "/sellInfo", method = RequestMethod.GET)
	public ModelAndView sellInfo() {
		mav = new ModelAndView();
		mav.setViewName("ceoViews/sellInfo");
		return mav;
	}
	@RequestMapping(value = "/ceoRefundList", method = RequestMethod.GET)
	public ModelAndView ceoRefundList() {
		mav = new ModelAndView();
		mav.setViewName("ceoViews/ceoRefundList");
		return mav;
	}
	@RequestMapping(value = "/refundCompleteList", method = RequestMethod.GET)
	public ModelAndView refundCompleteList() {
		mav = new ModelAndView();
		mav.setViewName("ceoViews/refundCompleteList");
		return mav;
	}
	@RequestMapping(value = "/myEvtManagement", method = RequestMethod.GET)
	public ModelAndView myEvtManagement() {
		mav = new ModelAndView();
		mav.setViewName("ceoViews/myEvtManagement");
		return mav;
	}
	@RequestMapping(value = "/sentEstList", method = RequestMethod.GET)
	public ModelAndView sentEstList() {
		mav = new ModelAndView();
		mav.setViewName("ceoViews/sentEstList");
		return mav;
	}
	@RequestMapping(value = "/ceoModifyList", produces = "application/json; charset=utf-8")
	public @ResponseBody String ceoModifyList() {
		String json_ceoModifyList = mm.ceoModifyList();
		return json_ceoModifyList;
	}
	
	@RequestMapping(value = "/ceoModifyInfo", method = RequestMethod.GET)
	public ModelAndView ceoModifyInfo(String pw,String name,String tel,String email) {
		mav = new ModelAndView();
		mav = mm.ceoModifyInfo(pw,name,tel,email);
		return mav;
	}
	@RequestMapping(value = "/logout")
	public String logout() {
		session.invalidate();
		return "index";	
	}
	@RequestMapping(value = "/review",  produces = "application/json; charset=utf8")
	public @ResponseBody String review(String e_code, int star, String r_contents) {
		String str="";
		String id=(String) session.getAttribute("id");
		if (id != null) {
			if (e_code != null) {
				str = em.review(e_code, star, r_contents);
				return str;
			}
		}else {
			str="로그인을 해주세요.";
		}
		return str;
	}

	@RequestMapping(value = "/reviewModifyBtn", produces = "application/json; charset=utf8")
	public @ResponseBody String reviewModifyBtn(String e_code, int star, String r_contents) {
		String str = "";
		System.out.println("E_CODE:"+e_code);
		System.out.println("STAR:"+star);
		System.out.println("CONTENTS:"+r_contents);
		if (e_code != null) {
			str = em.reviewModifyBtn(e_code, star, r_contents);
			return str;
		}

		return str;
	}
	@RequestMapping(value = "/reviewDelete", produces = "application/json; charset=utf8")
	public @ResponseBody String reviewDelete(String e_code) {
		String str = "";
		System.out.println("E_CODE222222:"+e_code);
		if (e_code != null) {
			str = em.reviewDelete(e_code);
			return str;
		}
		return str;
	}
	
	@RequestMapping(value = "/choice", produces = "application/json; charset=utf8")
	public @ResponseBody String choice(String e_code) {
		String str = "";
		if (e_code != null) {
			str = em.choice(e_code);
			return str;
		}
		return str;
	}
	
	@RequestMapping(value = "/choiceDelete", produces = "application/json; charset=utf8")
	public @ResponseBody String choiceDelete(String e_code) {
		String str = "";
		if (e_code != null) {
			str = em.choiceDelete(e_code);
			return str;
		}
		return str;
	}
}
