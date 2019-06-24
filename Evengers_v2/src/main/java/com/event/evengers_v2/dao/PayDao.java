package com.event.evengers_v2.dao;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.event.evengers_v2.bean.BuySelectedOption;
import com.event.evengers_v2.bean.EstimatePay;
import com.event.evengers_v2.bean.Event;
import com.event.evengers_v2.bean.EventBuy;
import com.event.evengers_v2.bean.EventOption;
import com.event.evengers_v2.bean.EventPay;
import com.event.evengers_v2.bean.EventPaySelectedOption;
import com.event.evengers_v2.bean.EventRefund;

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
	
	boolean refundEvt(@Param("ep_code")String ep_code, @Param("m_id")String m_id);

	boolean refundInsert(String ep_code);


	EventRefund ceoRefundList(String ep_code);

	String refundChk(String ep_code);

	String ceoEvtpayChk(String ep_code);

	EventPay eptableChk(String ep_code);

	Event evttableChk(String e_code);
	
	boolean ceoRefundBtn(@Param("ep_code")String ep_code, @Param("ep_penalty")int ep_penalty);

	EventRefund ceoRefundCompleteList(String ep_code);

	EventPay rBtnChk(@Param("ep_code")String ep_code, @Param("m_id")String m_id);

	int rBtnChk2(@Param("ep_code")String ep_code);

	int rBtnChk3(@Param("ep_code")String ep_code);

	ArrayList<String> isRefundedEp(@Param("ep_codes")ArrayList<String> ep_codes);

	ArrayList<EventPay> epListPayList(String e_code);
	
	ArrayList<String> estPayList(@Param("req_codes1")ArrayList<String> req_codes);

	ArrayList<String> isrefundedEstp(@Param("estp_codes")ArrayList<String> estp_codes);

	ArrayList<Double> getEvtTotal(@Param("refundedEp_Code") String refundedEp_Code,@Param("choice") String choice);

	ArrayList<Double> getEstTotal(@Param("refundedEstp_Code") String refundedEstp_Code,@Param("choice") String choice);

	EstimatePay getEstpInfo(String estp_code);

	boolean refundInsertEstp(String estp_code);

	boolean ceoRefundBtnEstp(@Param("estp_code")String estp_code, @Param("estp_penalty")int estp_penalty);

	boolean updateEstpRefundState(@Param("estp_code")String estp_code, @Param("estp_refundstate")int estp_refundstate);

	List<Event> myEvtList(@Param("c_id")String id);

	ArrayList<EventPaySelectedOption> epsList(@Param("ep_code")String ep_code);

	EventOption eoList(@Param("eo_code")String eo_code);

	ArrayList< EventPay> epOneList(String e_code);

}
