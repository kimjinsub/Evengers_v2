package com.event.evengers_v2.dao;

import java.util.ArrayList;
import java.util.Date;

import org.apache.ibatis.annotations.Param;

import com.event.evengers_v2.bean.Calculate;
import com.event.evengers_v2.bean.MonthlySalary;
import java.util.List;
import java.util.Map;

public interface FinancialDao {

	boolean calInsert(Calculate calb);

	ArrayList<String> getCalList(@Param("choice") String choice, @Param("c_id") String c_id);

	ArrayList<Calculate> getAllCal(@Param("choice") String choice,@Param("c_id") String c_id);

	int getTotalPrice(@Param("choice")String choice, @Param("c_id") String c_id);
	
	ArrayList<MonthlySalary> selectSalary(@Param("choice")String choice,@Param("c_id") String c_id);

	boolean salaryInsert(MonthlySalary ms);
	
	List<Map<String, Object>> getEvtRevenue(@Param("choice") String choice);

	List<Map<String, Object>> getEstpRevenue(@Param("choice") String choice);
	
	ArrayList<Double> getEvtPenalty(@Param("refundedEp_Code") String refundedEp_Code,@Param("choice")String choice);

	int getTotalMonth(@Param("choice")String choice,@Param("c_id") String c_id);

	ArrayList<Double> getEstPenalty(@Param("refundedEstp_Code") String refundedEstp_Code,@Param("choice")String choice);

	int getTotalCount(@Param("choice")String choice, @Param("c_id")String c_id);

	
}
