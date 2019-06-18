package com.event.evengers_v2.dao;

import java.util.ArrayList;
import java.util.Date;

import org.apache.ibatis.annotations.Param;

import com.event.evengers_v2.bean.Calculate;
import com.event.evengers_v2.bean.MonthlySalary;

public interface FinancialDao {

	boolean calInsert(Calculate calb);

	ArrayList<String> getCalList(@Param("choice") String choice, @Param("c_id") String c_id);

	ArrayList<Calculate> getAllCal(@Param("choice") String choice,@Param("c_id") String c_id);

	String getTotalPrice(@Param("choice")String choice, @Param("c_id") String c_id);
	
	ArrayList<MonthlySalary> selectSalary(@Param("choice")String choice,@Param("c_id") String c_id);

	boolean salaryInsert(MonthlySalary ms);

}
