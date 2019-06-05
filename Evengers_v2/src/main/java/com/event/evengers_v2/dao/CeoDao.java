package com.event.evengers_v2.dao;

import com.event.evengers_v2.bean.Ceo;

public interface CeoDao {
	
	boolean ceoInsert(Ceo cb);

	public int ceoDoubleChk(String m_id);

	public int ceoCheckNumber(String c_rn);
}
