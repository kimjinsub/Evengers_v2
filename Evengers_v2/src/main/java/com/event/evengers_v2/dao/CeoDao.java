package com.event.evengers_v2.dao;

import com.event.evengers_v2.bean.Ceo;
import com.event.evengers_v2.bean.Department;
import com.event.evengers_v2.bean.Position;
import java.util.ArrayList;

public interface CeoDao {
	
	boolean ceoInsert(Ceo cb);

	public int ceoDoubleChk(String m_id);

	public int ceoCheckNumber(String c_rn);
	
	ArrayList<Position> getPosition(String c_id);

	ArrayList<Department> getDept(String c_id);
}
