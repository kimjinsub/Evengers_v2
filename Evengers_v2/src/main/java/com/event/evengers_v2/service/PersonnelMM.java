package com.event.evengers_v2.service;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.event.evengers_v2.bean.Department;
import com.event.evengers_v2.bean.Position;
import com.event.evengers_v2.dao.PersonnelDao;
import com.google.gson.Gson;

@Service
public class PersonnelMM {
	@Autowired
	HttpSession session;
	@Autowired
	PersonnelDao pDao;

	public String addPosition(Position p) {
		String msg="";
		p.setC_id(session.getAttribute("id").toString());
		if(pDao.addPosition(p)) {
			msg="직책 등록 성공";
		}else {
			msg="직책 등록 실패";
		}
		return msg;
	}
	public String getPositionList() {
		String json_pList="";
		String c_id=session.getAttribute("id").toString();
		ArrayList<Position> pList=new ArrayList<>();
		pList=pDao.getPositionList(c_id);
		json_pList=new Gson().toJson(pList);
		return json_pList;
	}
	public String addDept(Department dept) {
		String msg="";
		dept.setC_id(session.getAttribute("id").toString());
		if(pDao.addDept(dept)) {
			msg="부서 등록 성공";
		}else {
			msg="부서 등록 실패";
		}
		return msg;
	}
	public String getDeptList() {
		String json_deptList="";
		String c_id=session.getAttribute("id").toString();
		ArrayList<Department> deptList=new ArrayList<>();
		deptList=pDao.getDeptList(c_id);
		json_deptList=new Gson().toJson(deptList);
		return json_deptList;
	}
}
