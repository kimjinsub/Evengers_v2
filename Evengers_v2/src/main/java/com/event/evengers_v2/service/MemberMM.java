package com.event.evengers_v2.service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.event.evengers_v2.bean.Ceo;
import com.event.evengers_v2.bean.Event;
import com.event.evengers_v2.bean.Member;
import com.event.evengers_v2.dao.CeoDao;
import com.event.evengers_v2.dao.EventDao;
import com.event.evengers_v2.dao.MemberDao;
import com.google.gson.Gson;


@Service
public class MemberMM {
	private ModelAndView mav;
	@Autowired
	private MemberDao mDao;
	@Autowired
	private CeoDao cDao;
	@Autowired
	private EventDao eDao;
	@Autowired
	private HttpSession session;

	public ModelAndView memberInsert(Member mb) {
		mav = new ModelAndView();

		String view = null; // 포워딩 주소
		// 비번을 암호화(Encoding)할 수 있지만 복호화(Decoding)는 불가능
		BCryptPasswordEncoder pwEncoder = new BCryptPasswordEncoder();
		mb.setM_pw(pwEncoder.encode(mb.getM_pw()));
		mb.setM_email(mb.getM_email()+mb.getM_email1());
		
		if (mDao.memberInsert(mb)) {
			view = "index";
			mav.addObject("check", 1); //회원가입 성공
		} else {
			view = "index";
		}
		mav.setViewName(view);
		return mav;
	}
	
	/*
	 * public ModelAndView ceoInsert(Member mb) { mav = new ModelAndView(); String
	 * view = null; BCryptPasswordEncoder pwEncoder = new BCryptPasswordEncoder();
	 * mb.setC_pw(pwEncoder.encode(mb.getC_pw()));
	 * mb.setC_email(mb.getC_email()+mb.getC_email1());
	 * 
	 * if (cDao.ceoInsert(mb)) { view = "index"; mav.addObject("check", 1); //회원가입
	 * 성공 } else { view = "joinFrm"; } mav.setViewName(view); return mav; }
	 */


	public int memberDoubleChk(String m_id) {
		int mbChk = mDao.memberDoubleChk(m_id);
		int ceoChk = cDao.ceoDoubleChk(m_id);
		int chkNum = 0;
		//System.out.println(mbChk);
		//System.out.println(ceoChk);
		
		if(mbChk>0 || ceoChk>0) {
			chkNum = 1;
		}
		
		return chkNum;
	}

	
public String memberTest(String testcode) {
		//mav=new ModelAndView();
		 System.out.println("testcode="+testcode);
		String msg="";
		String result=mDao.testDao(testcode);
		if(result!=null) {
			msg="일반회원";
		}
		System.out.println("result="+result);
		/*
		 * if(result==testcode) { mav.addObject("check",1); }else {
		 * mav.addObject("check",0); }
		 */
		return msg;
	}

	public ModelAndView access(String id, String pw) {
		mav = new ModelAndView();
		String view = null;

		BCryptPasswordEncoder pwdEncoder = new BCryptPasswordEncoder();
		String mPwdEncode = mDao.mAccess(id);
		String cPwdEncode = mDao.cAccess(id);
		System.out.println(mPwdEncode);
		System.out.println(cPwdEncode);
		if (mPwdEncode != null) {
			if (pwdEncoder.matches(pw, mPwdEncode)) {
				session.setAttribute("id", id);
				System.out.println("멤버");
				view = "index";
				mav.setViewName(view);
				return mav;
			} else {
				view = "commonViews/loginFrm";
			}
		} else {
			view = "commonViews/loginFrm";
			System.out.println("안됨1");
		}
		if (cPwdEncode != null) {
			if (pwdEncoder.matches(pw, cPwdEncode)) {
				session.setAttribute("id", id);
				System.out.println("회사");
				view = "index";
				mav.setViewName(view);
				return mav;
			} else {
				view = "commonViews/loginFrm";
			}
		} else {
			view = "commonViews/loginFrm";
			System.out.println("안됨2");
		}
		mav.setViewName(view);
		return mav;
	}

	public String sendId(String email) {
		System.out.println(email);
		String id = mDao.sendMId(email);
		if (id != null) {
			return id;

		} else {
			id = mDao.sendCId(email);
		}
		return id;
	}

	public String sendNumber(String id, String email) {
		String pw=null;
		String me=mDao.findEmail(id);
		String ce=mDao.findCeoEmail(id);
		System.out.println("email"+email);
		System.out.println("me" + me);
		System.out.println("ce" + ce);
		if (me != null) {
			if (me.equals(email)) {
				pw = mDao.sendNumber(id);
				System.out.println("me");
			}
		}
		if (ce != null) {
			if (ce.equals(email)) {
				pw = mDao.sendCeoNumber(id);
				System.out.println("ce");
			}
		}
		return pw;

	}

	public String pwChange(String id, String pwMo1, String pwMo2) {
		String str = "";
		BCryptPasswordEncoder pwdEncoder = new BCryptPasswordEncoder();
		
		if (pwMo1.equals(pwMo2)) {
			pwMo1 = pwdEncoder.encode(pwMo1);
			if (mDao.pwChange(id, pwMo1) || mDao.pwCeoChange(id, pwMo1)) {
				str = "비밀번호가 변경되었습니다";
			} 
		}else {
			str = "비밀번호가 일치 하지않습니다.";
		}
		return str;
	}

	public ModelAndView mInfo() {
		String id= (String) session.getAttribute("id");
		Member mb= null;
		mb=	mDao.mInfo(id);
		String m_rrn= mb.getM_rrn();
		m_rrn=m_rrn.substring(0, 6); 
		mav.addObject("m_rrn",m_rrn+"-*******");
		mav.addObject("mb", mb);
		mav.setViewName("memberViews/mInfo");
		return mav;
	}
	public String mModifyMainSee(String pwCheck) {
		String id = (String) session.getAttribute("id");
		String str = "";
		BCryptPasswordEncoder pwdEncoder = new BCryptPasswordEncoder();
		String mPwdEncode = mDao.mModifyMainSee(id);
		System.out.println("id=" + id);
		System.out.println("pwdEncoder=" + pwdEncoder);
		if (mPwdEncode != null) {
			if (pwdEncoder.matches(pwCheck, mPwdEncode)) {
				str = "비밀번호가 맞았습니다.";
				return str;
			} else {
				str = "비밀번호가 틀렸습니다.";
				return str;
			}
		}
		return mPwdEncode;
	}

	public String mModifyList() {
		String json_mModifyList="";
		String id= (String) session.getAttribute("id");
		System.out.println(id);
		ArrayList<Member> mModifyList=mDao.mModifyList(id);
		System.out.println("mModifyList="+mModifyList);
		Gson gson = new Gson();
		json_mModifyList=gson.toJson(mModifyList);
		return json_mModifyList;
	}

	public ModelAndView modifyMemInfo(String pw, String name, String tel, String email, String area) {
		BCryptPasswordEncoder pwdEncoder = new BCryptPasswordEncoder();
		String id= (String) session.getAttribute("id");
		pw = pwdEncoder.encode(pw);
		if (mDao.modifyMemInfo(id,pw,name,tel,email,area)) {
		mav.setViewName("memberViews/memberMyPage");
		}
		return mav;
	}

	public String mPayList() {
		String json_mPayList="";
		String id= (String) session.getAttribute("id");
		System.out.println(id);
		ArrayList<Member> mPayList=mDao.mPayList(id);
		System.out.println("mModifyList="+mPayList);
		Gson gson = new Gson();
		json_mPayList=gson.toJson(mPayList);
		return json_mPayList;
	}

	public ModelAndView ceoInfo() {
		String id= (String) session.getAttribute("id");
		Ceo ceo= null;
		ceo=mDao.ceoInfo(id);
		System.out.println("ceoId"+id);
		System.out.println("cedRn"+ceo.getC_rn());
		mav.addObject("ceo", ceo);
		mav.setViewName("ceoViews/ceoInfo");
		return mav;
	}

	public String ceoModifyMainSee(String pwCheck) {
		String id = (String) session.getAttribute("id");
		String str = "";
		BCryptPasswordEncoder pwdEncoder = new BCryptPasswordEncoder();
		String ceoPwdEncode = mDao.ceoModifyMainSee(id);
		System.out.println("id=" + id);
		System.out.println("pwdEncoder=" + pwdEncoder);
		if (ceoPwdEncode != null) {
			if (pwdEncoder.matches(pwCheck, ceoPwdEncode)) {
				str = "비밀번호가 맞았습니다.";
				return str;
			} else {
				str = "비밀번호가 틀렸습니다.";
				return str;
			}
		}
		return ceoPwdEncode;
	}

	public String ceoModifyList() {
		String json_ceoModifyList="";
		String id= (String) session.getAttribute("id");
		System.out.println(id);
		ArrayList<Ceo> ceoModifyList=mDao.ceoModifyList(id);
		System.out.println("ceoModifyList="+ceoModifyList);
		Gson gson = new Gson();
		json_ceoModifyList=gson.toJson(ceoModifyList);
		return json_ceoModifyList;
	}

	public ModelAndView ceoModifyInfo(String pw, String name, String tel, String email) {
		BCryptPasswordEncoder pwdEncoder = new BCryptPasswordEncoder();
		String id= (String) session.getAttribute("id");
		pw = pwdEncoder.encode(pw);
		if (mDao.ceoModifyInfo(id,pw,name,tel,email)) {
		mav.setViewName("ceoViews/ceoMyPage");
		}
		return mav;
	}

	public String ceoMyPageChk(String id) {
		
		id=mDao.ceoMyPageChk(id);
		System.out.println("CeoCheck"+id);
		return id;
	}

	public String memberMyPageChk(String id) {
		id=mDao.memberMyPageChk(id);
		System.out.println("MemberCheck"+id);
		return id;
	}
	
	public String whoRU(String id) {
		String iam="";
		if(id.equals("none")) {return "common";}
		String result=mDao.testDao(id);
		if(result!=null) {
			if(result.equals("admin")) {
				iam="admin";
			}else {
				iam="member";
			}
		}else {
			iam="ceo";
		}
		return iam;
	}

	public ModelAndView myEvtManagement(String id) {
		if(eDao.myEvtManagement(id)!=null) {
			List<Event> eList = eDao.myEvtManagement(id);  
			mav.addObject("eList", eList);
		}else {
			mav.addObject("eList", "등록한 상품이 없습니다");
		}
		mav.setViewName("ceoViews/myEvtManagement");
		return mav;
	}
}
