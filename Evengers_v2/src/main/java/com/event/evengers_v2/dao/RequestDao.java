package com.event.evengers_v2.dao;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import com.event.evengers_v2.bean.Estimate;
import com.event.evengers_v2.bean.EstimateImage;
import com.event.evengers_v2.bean.EstimatePay;
import com.event.evengers_v2.bean.EstimatePayImage;
import com.event.evengers_v2.bean.Request;
import com.event.evengers_v2.bean.RequestImage;

public interface RequestDao {

	public boolean evtReqInsert(Request rq);

	public boolean evtReqImageInsert(RequestImage ri);
	
	public String getReqCode();

	public boolean estInsert(Estimate est);

	public String getEstCode(String c_id);

	public boolean estImageInsert(EstimateImage ei);

	public ArrayList<Estimate> getEstList(Map<String, Object> map);

	public int getEstCount();

	public ArrayList<Request> getReqList();

	public Estimate showEstimate(String est_code);

	public EstimateImage getEstimateImage(String est_code);

	public Request getIdTitle(String req_code);

	public boolean estiDelete(String est_code);

	public boolean estDelete(String est_code);

	public ArrayList<Request> AllReqList(Map<String, Object> map);

	public ArrayList<Request> myReqList(Map<String, Object> map);

	public Request getReqInfo(String req_code1);

	public List<RequestImage> getReqImageInfo(String req_code1);

	public boolean reqImageDelete(String req_code);

	public boolean reqDelete(String req_code);

	public int ceoChk(String id);
	
	public ArrayList<Request> getRecivedEstList(String id);

	public ArrayList<Estimate> getRecivedEstList1(Request req);

	public Estimate getEstInfo(String est_code);

	public boolean estPay(EstimatePay estimatepay);

	public ArrayList<Request> getReqCodes(String id);

	public Collection<? extends EstimatePay> getEstPayList(Request req);

	public EstimatePay getEstpDetail(String estp_code);

	public String getEstpCode();

	public boolean insertEstpi(EstimatePayImage estpi);

	public EstimatePayImage getEstpiImage(String estp_code);
	
	public ArrayList<EstimatePay> getEstSell(String id);

	public EstimatePay getPayday(String id);




}