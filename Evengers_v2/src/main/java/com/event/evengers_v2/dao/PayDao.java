package com.event.evengers_v2.dao;

import java.util.ArrayList;

import com.event.evengers_v2.bean.BuySelectedOption;
import com.event.evengers_v2.bean.Department;
import com.event.evengers_v2.bean.EventBuy;
import com.event.evengers_v2.bean.Position;

public interface PayDao {

	boolean ebInsert(EventBuy eb);

	String getEb_code(EventBuy eb);

	boolean evtBuyOptionInsert(BuySelectedOption bs);

	EventBuy getEvtBuyInfo(String eb_code);

	ArrayList<BuySelectedOption> getEvtBuyOptions(String eb_code);

	int getEvtBuyOptionCount(String eb_code);

	
}
