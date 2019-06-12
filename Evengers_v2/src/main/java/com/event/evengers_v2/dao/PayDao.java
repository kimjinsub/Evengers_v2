package com.event.evengers_v2.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.event.evengers_v2.bean.BuySelectedOption;
import com.event.evengers_v2.bean.EventBuy;
import com.event.evengers_v2.bean.EventPay;
import com.event.evengers_v2.bean.EventPaySelectedOption;

public interface PayDao {

	boolean ebInsert(EventBuy eb);

	String getEb_code(EventBuy eb);

	boolean evtBuyOptionInsert(BuySelectedOption bs);

	EventBuy getEvtBuyInfo(String eb_code);

	ArrayList<BuySelectedOption> getEvtBuyOptions(String eb_code);

	int getEvtBuyOptionCount(String eb_code);

	boolean evtPay(EventPay ep);

	String getEpCode(@Param("m_id")String m_id, @Param("e_code")String e_code);

	boolean epsInsert(EventPaySelectedOption eps);

	EventPay memberEvtPay(EventPay ep);

	ArrayList<EventPaySelectedOption> memberEps(String ep_code);

	ArrayList<EventPay> memberPayList(String m_id);
	
	boolean bsDelete(String eb_code);

	boolean ebDelete(String eb_code);

	ArrayList<EventPay> ceoAllEvtPayList(String c_id);

	ArrayList<String> ceoEvtPayList(String e_code);

	EventPay getEpInfo(String ep_code);

	ArrayList<String> ceoEvtPayList2(@Param("e_codes1")ArrayList<String> e_codes);

}
