package com.event.evengers_v2.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.event.evengers_v2.bean.Department;
import com.event.evengers_v2.bean.Employee;
import com.event.evengers_v2.bean.Position;
import com.event.evengers_v2.dao.PersonnelDao;
import com.event.evengers_v2.userClass.UploadFile;
import com.google.gson.Gson;

@Service
public class PersonnelMM {
	ModelAndView mav;
	@Autowired
	HttpSession session;
	@Autowired
	PersonnelDao pDao;
	@Autowired
	UploadFile file;

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
	public ModelAndView performInsert(MultipartHttpServletRequest multi) {
		mav = new ModelAndView();
		
		String enterdate = multi.getParameter("emp_enterdate");
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date emp_enterdate = null ;
		try {
			emp_enterdate = transFormat.parse(enterdate);
		} catch (ParseException e) {
			System.out.println("enterdate 오류");
			e.printStackTrace();
		}
		 
		System.out.println("p_name="+multi.getParameter("p_name"));
		String emp_name = multi.getParameter("emp_name");
		String c_id = (String) session.getAttribute("id");
		String p_code = pDao.getPCode(c_id,multi.getParameter("p_name"));
		String dept_code = pDao.getDeptCode(c_id,multi.getParameter("dept_name"));
		String emp_rrn = multi.getParameter("emp_rrn");
		String emp_tel = multi.getParameter("emp_tel");
		String emp_addr = multi.getParameter("emp_addr");
		String emp_email = multi.getParameter("emp_email");
		String emp_bank = multi.getParameter("emp_bank");
		String emp_acnumber = multi.getParameter("emp_acnumber");
		
	
		
		Map<String,String> fileMap = file.FileUp(multi,1);
		
		
		
		Employee emp = new Employee();
		emp.setEmp_name(emp_name);
		emp.setC_id(c_id);
		emp.setP_code(p_code);
		emp.setDept_code(dept_code);
		emp.setEmp_rrn(emp_rrn);
		emp.setEmp_enterdate(emp_enterdate);
		emp.setEmp_tel(emp_tel);
		emp.setEmp_addr(emp_addr);
		emp.setEmp_bank(emp_bank);
		emp.setEmp_email(emp_email);
		emp.setEmp_acnumber(emp_acnumber);
		System.out.println("emp_ori="+fileMap.get("emp_orifilename"));
		emp.setEmp_orifilename(fileMap.get("emp_orifilename"));
		emp.setEmp_sysfilename(fileMap.get("emp_sysfilename"));
		
		
		
		String view = null;
		if(pDao.performInsert(emp)) {
			view = "index";
		}else {
			view = "ceoViews/perform";
		}
		mav.setViewName(view);
		return mav;
	}
}
