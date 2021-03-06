package com.event.evengers_v2.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
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
	public ModelAndView getPerformList(String c_id) {
		mav = new ModelAndView();
		ArrayList<Employee> empList = new ArrayList<Employee>();
		System.out.println("c_id2=" + c_id);
		empList = pDao.getEmpList(c_id);

		ArrayList<Position> pList = new ArrayList<Position>();

		mav.addObject("empList", empList);
		mav.addObject("makeHtml_getPerformList", makeHtml_getPerformList(empList));
		mav.setViewName("ceoViews/performManage");

		return mav;
	}

	private Object makeHtml_getPerformList(ArrayList<Employee> empList) {
		StringBuilder sb = new StringBuilder();
		int i=0;
		sb.append("<div align='center'>");
		sb.append("<table class='table table-striped' align='center' ><tr><th>#</th><th>사번</th><th>성명</th><th>주소</th><th>입사일자</th><th>이메일</th><th>직책</th><th>부서</th><th></th>");
		for(Employee emp:empList) {
			i += 1;
			Date enterdate = emp.getEmp_enterdate();
			String emp_enterdate = new SimpleDateFormat("yyyy-MM-dd").format(enterdate);
			Position p = new Position();
			p = pDao.getPositionInfo(emp.getP_code());
			String p_name = p.getP_name();
			Department dept = new Department();
			dept = pDao.getDeptInfo(emp.getDept_code());
			String dept_name = dept.getDept_name();
			sb.append("<tr><td>"+i+"</td>"
					+ "<td>"+emp.getEmp_code()+"</td>"
					+ "<td>"+emp.getEmp_name()+"</td>"
					+ "<td>"+emp.getEmp_addr()+"</td>"
					+ "<td>"+emp_enterdate+"</td>"
					 + "<td>"+emp.getEmp_email()+"</td>" 
					+ "<td>"+p_name+"</td>"
					+ "<td>"+dept_name+"</td>"
					+ "<td><button class='emp_code btn btn-outline-primary btn-rounded waves-effect' name="+emp.getEmp_code()+">수정</button></td></tr>");
		}
		sb.append("</table></div>");
		
		return sb.toString();
	}
	public ModelAndView myPerModify(String emp_code) {
		mav = new ModelAndView();
		String c_id = session.getAttribute("id").toString();
		String view = null;
		Employee emp = pDao.myPerModify(emp_code);
		System.out.println("emp2="+emp);
		String emp_sysfilename = pDao.emp_sysfilename(emp_code);
		System.out.println("emp_sysfilename2="+emp_sysfilename);
		
		Position p = new Position();
		p = pDao.getPositionInfo(emp.getP_code());
		String p_name = p.getP_name();
		Department dept = new Department();
		dept = pDao.getDeptInfo(emp.getDept_code());
		String dept_name = dept.getDept_name();
		
		mav.addObject("emp", emp);
		mav.addObject("emp_sysfilename", emp_sysfilename);
		mav.addObject("p_name", p_name);
		mav.addObject("dept_name", dept_name);
		
		view = "ceoViews/myPerModify";
		mav.setViewName(view);
		return mav;
	}
	/*
	 * public String myPerModifyBtn(MultipartHttpServletRequest multi) { mav = new
	 * ModelAndView(); String str=""; String emp_name =
	 * multi.getParameter("emp_name");
	 * 
	 * } return null;
	 */
	public String performUpdate(String p_name, String dept_name,String emp_code) {
		String str = "";
		
		String c_id = session.getAttribute("id").toString();
		
		Employee emp = new Employee();
		Position p = new Position();
		Department dept = new Department();
		
		emp = pDao.getEmpInfo(emp_code);
		
		String p_code = pDao.getPCode(c_id, p_name);
		String dept_code = pDao.getDeptCode(c_id, dept_name);
		
		
		boolean position = true;
		boolean d = true;
		
		if(!emp.getP_code().equals(p_code)) {
			position = false;
			if(position=pDao.p_codeUpdate(emp_code,p_code)) {
				
			}
		}
		if(!emp.getDept_code().equals(dept_code)) {
			d=false;
			if(d = pDao.dept_codeUpdate(emp_code,dept_code)) {
				
			}
		}
		
		if(position && d ) {
			str = "수정되었습니다.";
		}else {
			str = "수정 실패.";
		}
		return str;
	}
	public String deletePosition(String p_code) {
		if(pDao.deletePosition(p_code)) {
			return "yes";
		}else {
			return "no";
		}
	}
	public String deleteDept(String dept_code) {
		if(pDao.deleteDept(dept_code)) {
			return "yes";
		}else {
			return "no";
		}
	}
}
