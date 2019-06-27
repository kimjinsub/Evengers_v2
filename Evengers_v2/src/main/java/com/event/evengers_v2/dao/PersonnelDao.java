package com.event.evengers_v2.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;
import com.event.evengers_v2.bean.Department;
import com.event.evengers_v2.bean.Employee;
import com.event.evengers_v2.bean.Position;

public interface PersonnelDao {

	boolean addPosition(Position p);

	ArrayList<Position> getPositionList(String c_id);

	boolean addDept(Department dept);

	ArrayList<Department> getDeptList(String c_id);
	
	String getPCode(@Param("c_id") String c_id,@Param("p_name") String p_name);

	String getDeptCode(@Param("c_id") String c_id,@Param("dept_name") String dept_name);

	boolean performInsert(Employee emp);

	ArrayList<Employee> getEmpList(String c_id);

	void getEmp_code(String c_id);

	Position getPositionInfo(String p_code);

	Department getDeptInfo(String dept_code);
	
	ArrayList<Employee> getSalaryEmp(@Param("c_id")String c_id);

	ArrayList<Position> getSalaryP(@Param("c_id") String c_id);

	Employee myPerModify(String emp_code);

	String emp_sysfilename(String emp_code);

	Employee getEmpInfo(String emp_code);

	boolean p_codeUpdate(@Param("emp_code")String emp_code, @Param("p_code")String p_code);

	boolean dept_codeUpdate(@Param("emp_code")String emp_code,@Param("dept_code") String dept_code);

}
