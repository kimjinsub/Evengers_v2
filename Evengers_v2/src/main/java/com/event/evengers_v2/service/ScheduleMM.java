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

import com.event.evengers_v2.bean.Event;
import com.event.evengers_v2.bean.EventPay;
import com.event.evengers_v2.bean.EventSchedule;
import com.event.evengers_v2.dao.EventDao;
import com.event.evengers_v2.dao.PayDao;
import com.event.evengers_v2.dao.PersonnelDao;
import com.event.evengers_v2.dao.ScheduleDao;

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
	
	public ModelAndView scheduleManage() {
		mav=new ModelAndView();
		//c_id에 해당하는 ep_code를 전부 가져옴
		ArrayList<String> ep_codes=getEpCodeListByCeo();//**처음사용자면 null일수 있다
		mav.addObject("ep_codes", ep_codes);
		ArrayList<String> assigned_codes=new ArrayList<>();
		//일정에 있는 (수락된) 결제코드들은 제외함
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
		for(String assigned_code:assigned_codes) {
			ep_codes.remove(assigned_code);//제외시키기
		}
		//일정에 없는(미수락된) 결제코드들의 eventpay들을 모음 -> epAllList
		ArrayList<EventPay> epAllList=new ArrayList<>();
			for(String ep_code:ep_codes) {
				EventPay ep = payDao.getEpInfo(ep_code);
				epAllList.add(ep);
			}
		mav.addObject("epAllList", epAllList);
		//일정에 있는 (수락된) 결제코드들로 일정리스트를 뽑음 -> esList
		ArrayList<EventSchedule> esList=new ArrayList<>();
		if(assigned_codes!=null) {
			for(String ep_code:assigned_codes) {
				EventSchedule es=sDao.getEvtScheduleList(ep_code);
				esList.add(es);
			}
		}
		mav.addObject("makeHtml_EpList", makeHtml_EpList(epAllList,esList));
		mav.setViewName("ceoViews/scheduleManage");
		return mav;
	}

	private String makeHtml_EpList(ArrayList<EventPay> epAllList,ArrayList<EventSchedule> esList) {
		StringBuilder sb=new StringBuilder();
		SimpleDateFormat format = new SimpleDateFormat("yy년MM월dd일 HH:mm");
		sb.append("<table 'border='1'>"
				+ "<tr><th>미수락</th></tr>");
		for(EventPay ep:epAllList) {
			Event e=eDao.getEvtInfo(ep.getE_code());
			sb.append("<tr><td class='unassigned' id='"+ep.getEp_code()+"'>"+ep.getEp_code()
					+" / "+format.format(ep.getEp_dday())+" / "+e.getE_category()+"</td></tr>");
		}
		sb.append("</table>");
		sb.append("<table 'border='1'>"
				+ "<tr><th>수락</th></tr>");
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
		ArrayList<String> ep_codes2=new ArrayList<>();
		ep_codes2=payDao.ceoEvtPayList2(e_codes);
		return ep_codes2; 
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

	public ModelAndView calendar(Date date) {
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
		mav.addObject("year", makeHtml_year(date));
		mav.addObject("month", makeHtml_month(date));
		mav.addObject("calendar", makeHtml_calendar(date));
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
	private String makeHtml_calendar(Date date) {
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
		sb.append("<table border='1' id='calendar_table'>");
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
			sb.append("<td>"+i+"</td>");
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
}
