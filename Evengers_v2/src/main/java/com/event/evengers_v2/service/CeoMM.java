package com.event.evengers_v2.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.event.evengers_v2.bean.Ceo;
import com.event.evengers_v2.dao.CeoDao;


@Service
public class CeoMM {
	private ModelAndView mav;

	@Autowired
	private CeoDao cDao;
	
	public ModelAndView ceoInsert(Ceo cb) {
		mav = new ModelAndView();
		String view = null;
		BCryptPasswordEncoder pwEncoder = new BCryptPasswordEncoder();
		cb.setC_pw(pwEncoder.encode(cb.getC_pw()));
		cb.setC_email(cb.getC_email()+cb.getC_email1());
		
		if (cDao.ceoInsert(cb)) {
			view = "index";
			mav.addObject("check", 1); //회원가입 성공
		} else {
			view = "joinFrm";
		}
		mav.setViewName(view);
		return mav;
	}
	
	public int ceoCheckNumber(String c_rn) {
		int numCheck = cDao.ceoCheckNumber(c_rn);
		System.out.println("존재?"+numCheck);
		int chkNum = 0;
		
		if(numCheck>0) {
			chkNum = 1;
		}
		return chkNum;
	}
}
