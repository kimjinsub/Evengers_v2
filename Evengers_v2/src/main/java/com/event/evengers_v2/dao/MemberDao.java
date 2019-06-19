package com.event.evengers_v2.dao;



import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.event.evengers_v2.bean.Ceo;
import com.event.evengers_v2.bean.Member;


public interface MemberDao {

	boolean memberInsert(Member mb);
	
	public int memberDoubleChk(String m_id);
	
	String testDao(String testcode);

	String mAccess(@Param("m_id")String id);
	
	String cAccess(@Param("c_id")String id);
	
	String sendCId(@Param("c_email")String email);
	
	String sendMId(@Param("m_email")String email);
	
	String sendNumber(@Param("m_id")String id);
	
	String sendCeoNumber(@Param("c_id")String id);
	
	String getPw(String id);
	
	boolean pwChange(@Param("m_id")String id, @Param("m_pw")String pwMo1);

	boolean pwCeoChange(@Param("c_id")String id, @Param("c_pw")String pwMo1);

	String findEmail(@Param("m_id")String id);

	String findCeoEmail(@Param("c_id")String id);

	
	
	
	
	Member mInfo(@Param("m_id")String id);

	String mModifyMainSee(@Param("m_id")String id);

	ArrayList<Member> mModifyList(@Param("m_id")String id);

	boolean modifyMemInfo(@Param("m_id")String id, @Param("m_pw")String pw, @Param("m_name")String name, @Param("m_tel")String tel, @Param("m_email")String email, @Param("m_area")String area);

	ArrayList<Member> mPayList(@Param("m_id")String id);

	Ceo ceoInfo(@Param("c_id")String id);

	String ceoModifyMainSee(@Param("c_id")String id);

	ArrayList<Ceo> ceoModifyList(@Param("c_id")String id);

	boolean ceoModifyInfo(@Param("c_id")String id, @Param("c_pw")String pw,@Param("c_name") String name,@Param("c_tel") String tel, @Param("c_email")String email);

	String ceoMyPageChk(@Param("c_id")String id);

	String memberMyPageChk(@Param("m_id")String id);

	boolean ceoModifyInfo2(@Param("c_id")String id, @Param("c_name")String name,@Param("c_tel") String tel, @Param("c_email")String email);

	boolean memberDelete(@Param("m_id")String id);

	boolean ceoDelete(@Param("c_id")String id);
	
	boolean chatIn(@Param("sessionId")String sessionId, @Param("id")String id);

	String getSessionId(String id);

	int chatInCheck(String id);

	boolean chatOut(String sessionId);

}
