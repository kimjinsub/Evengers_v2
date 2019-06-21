package com.event.evengers_v2.service;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.event.evengers_v2.bean.Ceo;
import com.event.evengers_v2.bean.Department;
import com.event.evengers_v2.bean.Position;
import com.event.evengers_v2.dao.CeoDao;
import com.google.gson.Gson;

@Service
public class CeoMM {
	private ModelAndView mav;

	@Autowired
	private CeoDao cDao;
	@Autowired
	HttpSession session;
	
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
		int chkNum = -1;
		if(c_rn == "" || c_rn ==null) {		
			chkNum = 0;		//아이디가 널값일때 0리턴
		}else{
			int numCheck = cDao.ceoCheckNumber(c_rn);
			
			if(numCheck>0) {
				chkNum = 1;
			}
		}
		return chkNum;
	}
	
	public String getPositionList() {
		String c_id = (String) session.getAttribute("id");
		String json_position="";
		ArrayList<Position> positionList=cDao.getPosition(c_id);
		Gson gson = new Gson();
		json_position = gson.toJson(positionList);
		return json_position;
	}

	public String getDeptList() {
		String c_id = (String) session.getAttribute("id"); //세션에 저장된 id 가져오기
		String json_dept="";
		ArrayList<Department> deptList=cDao.getDept(c_id);
		Gson gson = new Gson();
		json_dept = gson.toJson(deptList);
		return json_dept;
	}
}
