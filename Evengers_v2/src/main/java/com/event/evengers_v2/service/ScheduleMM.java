package com.event.evengers_v2.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.event.evengers_v2.bean.Estimate;
import com.event.evengers_v2.bean.EstimatePay;
import com.event.evengers_v2.bean.EstimateSchedule;
import com.event.evengers_v2.bean.Event;
import com.event.evengers_v2.bean.EventPay;
import com.event.evengers_v2.bean.EventPaySelectedOption;
import com.event.evengers_v2.bean.EventSchedule;
import com.event.evengers_v2.bean.Member;
import com.event.evengers_v2.bean.Request;
import com.event.evengers_v2.dao.EventDao;
import com.event.evengers_v2.dao.MemberDao;
import com.event.evengers_v2.dao.PayDao;
import com.event.evengers_v2.dao.PersonnelDao;
import com.event.evengers_v2.dao.RequestDao;
import com.event.evengers_v2.dao.ScheduleDao;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

@Service
public class ScheduleMM {
	ModelAndView mav;
	@Autowired
	HttpSession session;
	@Autowired
	ScheduleDao sDao;
	@Autowired
	PayDao payDao;
	@Autowired
	EventDao eDao;
	@Autowired
	PersonnelDao pDao;
	@Autowired
	MemberDao mDao;
	@Autowired
	RequestDao rDao;
	
	public ModelAndView scheduleManage(Date date) {
	//public ModelAndView scheduleManage(Date date,int pageNum,int listCount) {
		if(date==null) {date=new Date();}
		mav=new ModelAndView();
		//c_id에 해당하는 ep_code를 전부 가져옴
		ArrayList<String> ep_codes=getEpCodeListByCeo();//**처음사용자면 null일수 있다
		if(ep_codes==null) {
			mav.addObject("msg", "예약된 이벤트가 없습니다");
			mav.setViewName("ceoViews/scheduleManage");
			return mav;
		}
		//일정에 있는 (수락된) 결제코드들을 뽑음
		ArrayList<String> assigned_codes=getAssigned_codes(ep_codes);
		
		//전부가져온 ep코드들중 일정에 있는 (수락된) ep코드들을 뺌
		for(String assigned_code:assigned_codes) {
			ep_codes.remove(assigned_code);//제외시키기
		}
		//일정에 없는(미수락된) 결제코드들의 eventpay들을 모음 -> epAllList
		ArrayList<EventPay> epAllList=new ArrayList<>();
		for(String ep_code:ep_codes) {
			EventPay ep = payDao.getEpInfo(ep_code);
			epAllList.add(ep);
		}
		/*여기부터
		SimpleDateFormat fm=new SimpleDateFormat("yyyyMMdd");
		Date today=new Date();
		try {
			today=fm.parse(fm.format(today));
		} catch (ParseException e) {
			e.printStackTrace();
		}
		int pageNum =1;
		int listCount=5;
		ArrayList<EventPay> epAllList2=new ArrayList<>();
		epAllList2=sDao.notScheduledEpList(ep_codes,today,pageNum,listCount);
		mav.addObject("epAllList2", epAllList2);
		*///여기까지는 페이징연습
		//일정에 있는 (수락된) 결제코드들로 일정리스트를 뽑음 -> esList
		ArrayList<EventSchedule> esList=new ArrayList<>();
		if(assigned_codes!=null) {
			for(String ep_code:assigned_codes) {
				EventSchedule es=sDao.getEvtScheduleList(ep_code);
				esList.add(es);
			}
		}
		
		mav.addObject("ep_codes", ep_codes);
		mav.addObject("epAllList", epAllList);
		mav.addObject("year", makeHtml_year(date));
		mav.addObject("month", makeHtml_month(date));
		mav.addObject("makeHtml_EpList", makeHtml_EpList(epAllList,esList));
		mav.setViewName("ceoViews/scheduleManage");
		
		/////////////견적결제 리스트..
		//해당ceo의 견적결제된 것들중에 환불안된 estp코드들을 추출
		ArrayList<String> assigned_estp_codes=getEstpCodeListByCeo();
		if(assigned_estp_codes==null) {
			mav.addObject("estMsg", "예약된 이벤트가 없습니다");
			return mav;
		}
		
		//전체 견적결제 리스트 -> estpAllList
		ArrayList<EstimatePay> estpAllList=new ArrayList<>();
		for(String estp_code:assigned_estp_codes) {
			//JOIN을 이용해 req_hopedate, estp_payday를 이용해 정렬
			EstimatePay estp = payDao.getEstpInfo(estp_code);
			estpAllList.add(estp);
		}
		//수락된 견적결제들 리스트 -> estsList
		ArrayList<EstimateSchedule> estsList=new ArrayList<>();
		ArrayList<EstimatePay> estpList=new ArrayList<>();
		if(assigned_estp_codes!=null) {
			for(String estp_code:assigned_estp_codes) {
				EstimateSchedule ests=sDao.getEstScheduleList(estp_code);
				if(ests!=null) {
					estsList.add(ests);//수락된 견적결제
				}else {
					estpList.add(payDao.getEstpInfo(estp_code));//미수락된 견적결제
				}
			}
		}
		mav.addObject("estpList", estpList);
		mav.addObject("estsList", estsList);
		mav.addObject("makeHtml_EstpList", makeHtml_EstpList(estpList,estsList));
		return mav;
	}


	private ArrayList<String> getAssigned_codes(ArrayList<String> ep_codes) {
		ArrayList<String> assigned_codes=new ArrayList<>();
		for(String ep_code:ep_codes) {
			int assigned = sDao.isAssigned(ep_code);//0:미수락 1:수락
			if(assigned==1) {//수락된것이라면
				/*if(ep_codes.remove(ep_code)) {//ep_codes에서 지우고
					//Q:반복문돌리는과정에서 지우면 에러가 발생할까?
					//A: 발생한다..ㅋㅋjava.util.ConcurrentModificationException
					assigned_codes.add(ep_code);//수락된 일정리스트에 추가한다
				}*/
				assigned_codes.add(ep_code);//수락된 일정리스트에 추가한다
			}
		}
		return assigned_codes;
	}

	private String makeHtml_EpList(ArrayList<EventPay> epAllList,ArrayList<EventSchedule> esList) {
		StringBuilder sb=new StringBuilder();
		SimpleDateFormat format = new SimpleDateFormat("yy년MM월dd일 HH:mm");
		sb.append("<table id='evt_noAssign' "
				+ "class='table table table-condensed table-hover table-bordered'>"
				+ "<tr><th align='center'>미수락</th></tr>");
		for(EventPay ep:epAllList) {
			Event e=eDao.getEvtInfo(ep.getE_code());
			sb.append("<tr><td class='unassigned' id='"+ep.getEp_code()+"'>"+ep.getEp_code()
					+" / "+format.format(ep.getEp_dday())+" / "+e.getE_category()+"</td></tr>");
		}
		sb.append("</table>");
		sb.append("<table id='evt_assign' "
				+ "class='table table-condensed table-hover table-bordered'>"
				+ "<tr><th align='center'>수락</th></tr>");
		for(EventSchedule es:esList) {
			//해당es의 dept코드로 department를 구함
			//String dept_name=pDao.getDeptInfo(es.getDept_code()).getDept_name();
			//해당es의 ep_code로 EventPay를 뽑고, 그걸로 e_code를 구함
			EventPay ep=payDao.getEpInfo(es.getEp_code());
			String e_code=ep.getE_code();
			//구한 e_code로 카테고리를 뽑아냄
			String e_category=eDao.getEvtInfo(e_code).getE_category();
			sb.append("<tr><td>"+es.getEp_code()+" / "+
					format.format(ep.getEp_dday())+" / "+e_category+"</td></tr>");
		}
		sb.append("</table>");
		return sb.toString();
	}
	
	private Object makeHtml_EstpList(ArrayList<EstimatePay> estpList, ArrayList<EstimateSchedule> estsList) {
		StringBuilder sb=new StringBuilder();
		SimpleDateFormat format = new SimpleDateFormat("yy년MM월dd일 HH:mm");
		sb.append("<table id='est_noAssign' "
				+ "class='table table table-condensed table-hover table-bordered'>"
				+ "<tr><th align='center'>미수락</th></tr>");
		for(EstimatePay estp:estpList) {
			Request req = rDao.getReqInfo(estp.getReq_code());
			try {
				sb.append("<tr><td class='unassignedEstp' id='"+estp.getEstp_code()+"'>"+estp.getEstp_code()
						+" / "+req.getReq_hopedate().substring(0, req.getReq_hopedate().indexOf(".")-3)
				//		+" / "+format.format(format.parse(req.getReq_hopedate()))  
						+" / "+req.getEc_name()+"</td></tr>");
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		sb.append("</table>");
		sb.append("<table id='est_assign' "
				+ "class='table table table-condensed table-hover table-bordered'>"
				+ "<tr><th align='center'>수락</th></tr>");
		System.out.println("estsListSize:"+estsList.size());
		//if(estsList.size()==0) {return sb.append("</table>");}
		for(EstimateSchedule ests:estsList) {
			EstimatePay estp=payDao.getEstpInfo(ests.getEstp_code());
			String req_code=estp.getReq_code();
			String e_category=rDao.getReqInfo(req_code).getEc_name();
			String hopedate=rDao.getReqInfo(req_code).getReq_hopedate();
			try {
				sb.append("<tr><td>"+ests.getEstp_code()
						+" / "+hopedate.substring(0,hopedate.indexOf(".")-3)
				//		+" / "+format.format(format.parse(rDao.getReqInfo(req_code).getReq_hopedate()))
						+" / "+e_category+"</td></tr>");
				System.out.println("hopedate:"+rDao.getReqInfo(req_code).getReq_hopedate());
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		sb.append("</table>");
		return sb.toString();
	}
	
	public ArrayList<String> getEpCodeListByCeo(){//c_id에 해당하는 ep_code를 전부 가져옴
		String c_id=session.getAttribute("id").toString();
		ArrayList<String> e_codes=eDao.getEvtCodeList(c_id);//**처음사용자면 null일수 있다
		//그냥 for문과 if문을썼기 때문에 e_code로 정렬된다음 다시 정렬되기에 정렬이 제대로 되지 않는다.
		//addAll을 써서 arrayList에 arrayList를 전부 추가해줄수 있다.
		/*ArrayList<String> ep_codes=new ArrayList<>();
		for(String e_code:e_codes) {
			if(payDao.ceoEvtPayList(e_code).size()>0) {
				ep_codes.addAll(payDao.ceoEvtPayList(e_code));
			}
		}*/
		//mybatis 로 foreach문 써서 dday와 payday로 정렬하기
		if(e_codes.size()==0) {return null;}
		ArrayList<String> ep_codes=new ArrayList<>();
		ep_codes=payDao.ceoEvtPayList2(e_codes);
		
		//환불된 것들 빼버리고 출력하기
		if(ep_codes.size()==0) {return null;}
		ArrayList<String> refundedEp_Codes=new ArrayList<>();
		refundedEp_Codes=payDao.isRefundedEp(ep_codes);
		for(String refundedEp_Code:refundedEp_Codes) {
			ep_codes.remove(refundedEp_Code);
		}
		return ep_codes; 
	}
	public ArrayList<String> getEstpCodeListByCeo(){//c_id에 해당하는 ep_code를 전부 가져옴
		String c_id=session.getAttribute("id").toString();
		//정렬까지 같이해버림
		ArrayList<String> estp_codes=rDao.getEstpListByCeo(c_id);//**처음사용자면 null일수 있다
		
		//환불된 것들 빼버리고 출력하기
		if(estp_codes.size()==0) {return null;}
		ArrayList<String> refundedEstp_Codes=new ArrayList<>();
		refundedEstp_Codes=payDao.isrefundedEstp(estp_codes);
		for(String refundedEstp_Code:refundedEstp_Codes) {
			estp_codes.remove(refundedEstp_Code);
		}
		return estp_codes; 
	}

	public String insertEvtSchedule(EventSchedule es) {
		String msg="";
		if(sDao.insertEvtSchedule(es)) {
			msg="등록되었습니다";
		}else {
			msg="등록에 실패했습니다";
		}
		return msg;
	}
	public String insertEstSchedule(EstimateSchedule ests) {
		String msg="";
		if(sDao.insertEstSchedule(ests)) {
			msg="등록되었습니다";
		}else {
			msg="등록에 실패했습니다";
		}
		return msg;
	}

	public ModelAndView calendar(Date date, String dept_code) {
		SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
		if(date==null) {
			try {
				date=format1.parse(format1.format(new Date()));
				System.out.println("date="+date);//Thu Jun 13 00:00:00 KST 2019
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		mav=new ModelAndView();
		if(dept_code!=null) {
			mav.addObject("calendar", makeHtml_calendar(date,dept_code));
		}
		mav.setViewName("ceoViews/calendar");
		return mav;
	}

	private String makeHtml_year(Date date) {
		StringBuilder sb= new StringBuilder();
		int year=Integer.parseInt(
				new SimpleDateFormat("yyyy").format(date));
		sb.append("<p id='past'>◀</p>"
				+ "<input id='year' type='number' "
				+ "		disabled='disabled' value='"+year+"'/>"
				+ "<p id='future'>▶</p>년");
		return sb.toString();
	}
	private String makeHtml_month(Date date) {
		StringBuilder sb= new StringBuilder();
		int month=Integer.parseInt(
				new SimpleDateFormat("MM").format(date));
		sb.append("<select id='month'>");
		for(int i=1;i<13;i++) {
			if(i==month) {
				sb.append("<option value='"+i+"' selected='selected'>"+i+"월</option>");
			}else {
				sb.append("<option value='"+i+"'>"+i+"월</option>");
			}
		}
		sb.append("</select>");
		return sb.toString();
	}
	private String makeHtml_calendar(Date date, String dept_code) {
		//c_id에 해당하는 ep_code를 전부 가져옴
		ArrayList<String> ep_codes=getEpCodeListByCeo();//**처음사용자면 null일수 있다
		//일정에 있는 (수락된) 결제코드들을 뽑음
		ArrayList<String> assigned_codes=new ArrayList<String>();
		if(ep_codes.size()!=0) {
			assigned_codes=getAssigned_codes(ep_codes);
		}
		ArrayList<String> assigned_estp_codes=new ArrayList<String>();
		assigned_estp_codes=getEstpCodeListByCeo();
		if(assigned_codes==null &&assigned_estp_codes==null) {
			return "<p style='font:italic'>해당 부서에 수락된 일정이 없습니다.</p>";
		}
		System.out.println("dept_code:"+dept_code);
		if(dept_code==null||dept_code=="") {
			return "<p style='font:italic'>등록된 부서가 없습니다. 부서를 등록해주세요.</p>";
		}
		
		//그 날짜의 첫번째 달 firstDay 구하기
		SimpleDateFormat format2=new SimpleDateFormat("yyyy-MM");
		Date firstDay = null;
		try {
			firstDay = format2.parse(format2.format(date));
		} catch (ParseException e) {
			e.printStackTrace();
		}
		Calendar f = Calendar.getInstance();
		f.setTime(firstDay);
		int firstDayOfTheWeek=f.get(Calendar.DAY_OF_WEEK);
		System.out.println("firstDayOfTheWeek="+firstDayOfTheWeek);//7(토)
		
		//그 날짜가 해당하는 달의 정보 구하기
		Calendar c = Calendar.getInstance();
		c.setTime(date);//Thu Jun 13 00:00:00 KST 2019
		System.out.println("getTime="+c.getTime());
		
		int int_year=c.get(Calendar.YEAR);
		System.out.println("int_year="+int_year);
		String str_year=String.valueOf(int_year);
		System.out.println("str_year="+str_year);
		
		int int_month=c.get(Calendar.MONTH)+1;//0:1월 11:12월이라 1씩 더해준다
		System.out.println("month="+int_month);
		String str_month=String.format("%02d", int_month);
		System.out.println("str_month="+str_month);
		
		int int_startDay = c.getActualMinimum(Calendar.DAY_OF_MONTH);
		System.out.println("int_startDay="+int_startDay);//1
		
		int int_endDay = c.getActualMaximum(Calendar.DAY_OF_MONTH);
		System.out.println("int_endDay="+int_endDay);//30
		
		String str_endDay=String.valueOf(int_endDay);
		System.out.println("str_endDay="+str_endDay);//30
		
		int dayOfTheWeek=c.get(Calendar.DAY_OF_WEEK);
		System.out.println("dayOfTheWeek="+dayOfTheWeek);//1:일 ~ 7:토
		
		int dayOfTheMonth=c.get(Calendar.DAY_OF_MONTH);
		System.out.println("dayOfTheMonth="+dayOfTheMonth);//13:13일
		
		//구한 정보들로 달력 출력하기
		StringBuilder sb= new StringBuilder();
		sb.append("<table class='table table table-condensed table-bordered' "
				+ "id='calendar_table'>"
				+ "<tr><th colspan=7><h2>"+int_year+"년 "+int_month+"월 ["+pDao.getDeptInfo(dept_code).getDept_name()+"]</th><tr>");
		sb.append("<tr><th>일</th><th>월</th><th>화</th><th>수</th><th>목</th><th>금</th><th>토</th></tr>");
		sb.append("<tr>");

		int dayNum=1;
		for(int i=dayNum;i<firstDayOfTheWeek;i++) {
			sb.append("<td></td>");
			if(dayNum==7) {
				sb.append("</tr>");
				dayNum=1;
			}
			dayNum++;
		}
		for(int i=int_startDay;i<int_endDay+1;i++) {
			//날짜형식 불러오기
			String calDate=str_year+str_month+String.format("%02d", i);
			
			//부서정보 가져오기
			
			//일정에 있는 (수락된) 결제코드들로 일정리스트를 뽑음 -> esList
			ArrayList<EventSchedule> esList=new ArrayList<>();
			if(assigned_codes.size()!=0) {
				ArrayList<String> checked_assigned_codes=sDao.dateCheck(assigned_codes,calDate);
				for(String ep_code:checked_assigned_codes) {
					EventSchedule es=sDao.howManyEvtSchedule(dept_code,ep_code);
					if(es!=null) {
						esList.add(es);
					}
				}
			}
			//정렬되고 환불 제거한 결제 리스트 dept와 날짜로 또 추출함
			//ArrayList<String> assigned_estp_codes=getEstpCodeListByCeo();
			ArrayList<EstimateSchedule> estsList=new ArrayList<>();
			if(assigned_estp_codes!=null) {
				ArrayList<String> checked_assigned_estp_codes=sDao.dateCheckEstp(assigned_estp_codes,calDate);
				for(String estp_code:checked_assigned_estp_codes) {
					EstimateSchedule ests=sDao.howManyEstSchedule(dept_code,estp_code);
					if(ests!=null) {
						estsList.add(ests);
					}
				}
			}
			String json_esList=new Gson().toJson(esList);//json으로 넘겨도 jsp에서 배열로 받음 
			String json_estsList=new Gson().toJson(estsList);//json으로 넘겨도 jsp에서 배열로 받음 
			if(esList.size()>0||estsList.size()>0) {
				sb.append("<td id='"+calDate+"'>"+i+"<br/>"
						+ "<a href='javascript:Ajax_showScheduleToday("+json_esList+","+json_estsList+","+calDate+")' "
						+ "class='scheduleAtag' "
						+ ">"+(esList.size()+estsList.size())+"건</a>"
						+ "</td>");
			}else {
				sb.append("<td id='"+calDate+"'>"+i+"</td>");
			}
			if(dayNum>=7) {
				sb.append("</tr>");
				dayNum=1;
			}else {
				dayNum++;
			}
		}
		for(int i=dayNum;i<8;i++) {
			sb.append("<td></td>");
			if(i==7) {
				sb.append("</tr>");
			}
		}
		sb.append("</table>");
		return sb.toString();
	}

	public String showScheduleToday(String json_esList, String json_estsList, String calDate) {
		System.out.println("json_esList");
		System.out.println(json_esList);
		System.out.println("json_estsList");
		System.out.println(json_estsList);
		ArrayList<EventSchedule> esList=new Gson().fromJson(json_esList
				, new TypeToken<ArrayList<EventSchedule>>(){}.getType());
		System.out.println("esList");
		System.out.println(esList);
		ArrayList<EstimateSchedule> estsList=new Gson().fromJson(json_estsList
				, new TypeToken<ArrayList<EstimateSchedule>>(){}.getType());
		System.out.println("estsList");
		System.out.println(estsList);
		System.out.println("calDate="+calDate);
		
		StringBuilder sb=new StringBuilder();
		sb.append("<table id='schedule_table' "
				+ "class='table table table-condensed table-bordered'>"
				+ "<tr><th></th><th>이벤트정보</th><th>구매자정보</th></tr>");
		for(EventSchedule es:esList) {
			EventPay ep=payDao.getEpInfo(es.getEp_code());
			Calendar c=Calendar.getInstance();
			c.setTime(ep.getEp_dday());
			int hour=c.get(Calendar.HOUR);
			int minute=c.get(Calendar.MINUTE);
			
			ArrayList<EventPaySelectedOption> epsList = payDao.memberEps(es.getEp_code());
			Member mb=mDao.mInfo(ep.getM_id());
			Event e=eDao.getEvtInfo(ep.getE_code());
			sb.append("<tr class='evt'>"
					+ "		<td><img src='upload/thumbnail/"+e.getE_sysfilename()+"' width='100%' height='auto'/></td>"
					+ "		<td>"
					+ "			<p>[이벤트구매]</p>"
					+ "			<p>"+hour+"시"+minute+"분</p>"
					+ "			<p>"+e.getE_name()+"</p>"
					+ "			<p>");
			int i=1;
			for(EventPaySelectedOption eps:epsList) {
				sb.append("옵션"+i+" : "+eDao.getEoInfo(eps.getEo_code()).getEo_name() +"<br/>");
				i++;
			}
			sb.append("			</p>"
					+ "		</td>"
					+ "		<td>"
					+ "			<p>"+mb.getM_name()+"</p>"
					+ "			<p>"+mb.getM_tel()+"</p>"
					+ "		</td>"
					+ "</tr>");
		}
		for(EstimateSchedule ests:estsList) {
			EstimatePay estp=payDao.getEstpInfo(ests.getEstp_code());
			Calendar c=Calendar.getInstance();
			SimpleDateFormat format = new SimpleDateFormat("yyyyMMddhhmm");
			String hopedate=rDao.getReqInfo(estp.getReq_code()).getReq_hopedate();
			try {
				c.setTime(format.parse(hopedate));
				System.out.println("hopedate:"+format.parse(hopedate));
			} catch (ParseException e) {
				e.printStackTrace();
			}
			Request req=rDao.getReqInfo(estp.getReq_code());
			Member mb = mDao.mInfo(req.getM_id());
			int hour=c.get(Calendar.HOUR);
			int minute=c.get(Calendar.MINUTE);
			String sysfilename=rDao.getEstpiImage(estp.getEstp_code())
					.getEstpi_sysfilename(); 
			sb.append("<tr class='est'>"
					+ "		<td><img src='upload/estimateImage/"+sysfilename+"' width='100%' height='auto'/></td>"
					+ "		<td>"
					+ "			<p>[의뢰견적구매]</p>"
					+ "			<p>"+req.getReq_title()+"</p>"
					+ "			<p>"+hour+"시"+minute+"분</p>"
					+ "			<p>["+req.getReq_hopearea()+"]"+req.getReq_hopeaddr()+"</p>"
					+ "		</td>"
					+ "		<td>"
					+ "			<p>"+mb.getM_name()+"</p>"
					+ "			<p>"+mb.getM_tel()+"</p>"
					+ "		</td>"
					+ "</tr>");
		}
		sb.append("</table>");
		sb.append("<p id='closerToday' "
					+"onclick='hideScheduleToday()'><img src=\"img/closer.png\" width=\"30\"/></p>");
		return sb.toString();
	}
}
