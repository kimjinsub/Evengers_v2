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
import com.event.evengers_v2.bean.EstimateRefund;
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

	public Collection<? extends EstimatePay> getEstPayList(Map<String, Object> map);

	public EstimatePay getEstpDetail(String estp_code);

	public String getEstpCode();

	public boolean insertEstpi(EstimatePayImage estpi);

	public EstimatePayImage getEstpiImage(String estp_code);
	
	public ArrayList<EstimatePay> getEstSell(Map<String, Object> map);

	public EstimatePay getPayday(String id);

	public int estpStateChange(String estp_code);

	//public ArrayList<Request> reqSearch(String words, String id);

	public ArrayList<Request> reqSearch(Map<String, Object> map);

	public ArrayList<Request> allReqSearch(Map<String, Object> map);

	public boolean insertRefund(String estp_code);

	public ArrayList<EstimatePay> RefundAcceptList(String id);
	
	public ArrayList<EstimatePay> RefundAcceptList1(String id);

	public Request getRefundInfo(String req_code);

	public EstimateRefund getEstr(String estp_code);

	public int insertPenalty(EstimateRefund estr);

	public int changeState(EstimateRefund estr);

	public EstimateRefund getCompleteEstr(Map<String, Object> map);
	
	public String gethopedate(String req_code);

	public ArrayList<Request> getReqList(Estimate est);

	public Request getReqTitle(Estimate est);

	public Request getReqTitle1(EstimatePay estp);

	public ArrayList<String> getReqCodeList();
	
	public int getAllReqCount(Map<String, Object> map);

	public int getMyReqCount(Map<String, Object> map);

	public int getEstpCount(Map<String, Object> map);
	
	public int getEstpCount(String id);
	
	public int getReceivedEstCount(String id);

	public int getEstPayCount(Map<String, Object> map);

	public ArrayList<EstimatePayImage> estSellImageList(EstimatePay estimatePay);






}