package com.event.evengers_v2.dao;

import java.util.ArrayList;

import com.event.evengers_v2.bean.Department;
import com.event.evengers_v2.bean.Position;

public interface PersonnelDao {

	boolean addPosition(Position p);

	ArrayList<Position> getPositionList(String c_id);

	boolean addDept(Department dept);

	ArrayList<Department> getDeptList(String c_id);
	
}
