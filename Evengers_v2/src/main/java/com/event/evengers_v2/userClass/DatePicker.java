package com.event.evengers_v2.userClass;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DatePicker {
	public String datePicker(Date date,String type) {
		if(date==null) {date=new Date();}
		String result="";
		switch(type) {
		case "yyyyMM":
			result=yyyy(date)+"년"+MM(date)+"월";
			break;
		case "yyyyMMddhhmm":
			result=yyyy(date)+"년"+MM(date)+"월"+dd(date)+"일"+hh(date)+"시"+mm(date)+"분";
			break;
		}
		return result;
	}
	public String yyyy(Date date) {
		StringBuilder sb= new StringBuilder();
		SimpleDateFormat yyyyFrm=new SimpleDateFormat("yyyy");
		int yyyy=0;
		yyyy=Integer.parseInt(yyyyFrm.format(date));
		sb.append("<select id='yyyy'>");
		for(int i=yyyy-10;i<=yyyy+10;i++) {
			if(i==yyyy) {
				sb.append("<option value="+i+" selected='selected'>"+i+"</option>");
			}else {
				sb.append("<option value="+i+">"+i+"</option>");
			}
		}
		sb.append("</select>");
		return sb.toString();
	}
	public String MM(Date date) {
		StringBuilder sb= new StringBuilder();
		SimpleDateFormat MMFrm=new SimpleDateFormat("MM");
		int MM=0;
		MM=Integer.parseInt(MMFrm.format(date));
		sb.append("<select id='MM'>");
		for(int i=1;i<=12;i++) {
			if(i==MM) {
				sb.append("<option value="+i+" selected='selected'>"+i+"</option>");
			}else {
				sb.append("<option value="+i+">"+i+"</option>");
			}
		}
		sb.append("</select>");
		return sb.toString();
	}
	public String dd(Date date) {
		StringBuilder sb= new StringBuilder();
		SimpleDateFormat ddFrm=new SimpleDateFormat("dd");
		int dd=0;
		dd=Integer.parseInt(ddFrm.format(date));
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		int maxDay=c.getActualMaximum(Calendar.DAY_OF_MONTH);
		sb.append("<select id='dd'>");
		for(int i=1;i<=maxDay;i++) {
			if(i==dd) {
				sb.append("<option value="+i+" selected='selected'>"+i+"</option>");
			}else {
				sb.append("<option value="+i+">"+i+"</option>");
			}
		}
		sb.append("</select>");
		return sb.toString();
	}
	public String hh(Date date) {
		StringBuilder sb= new StringBuilder();
		SimpleDateFormat hhFrm=new SimpleDateFormat("hh");
		int hh=0;
		hh=Integer.parseInt(hhFrm.format(date));
		sb.append("<select id='hh'>");
		for(int i=00;i<=23;i++) {
			if(i==hh) {
				sb.append("<option value="+i+" selected='selected'>"+i+"</option>");
			}else {
				sb.append("<option value="+i+">"+i+"</option>");
			}
		}
		sb.append("</select>");
		return sb.toString();
	}
	public String mm(Date date) {
		StringBuilder sb= new StringBuilder();
		SimpleDateFormat mmFrm=new SimpleDateFormat("mm");
		int mm=0;
		mm=Integer.parseInt(mmFrm.format(date));
		mm=(mm/10)*10;
		sb.append("<select id='mm'>");
		for(int i=00;i<=50;i+=10) {
			if(i==mm) {
				sb.append("<option value="+i+" selected='selected'>"+i+"</option>");
			}else {
				sb.append("<option value="+i+">"+i+"</option>");
			}
		}
		sb.append("</select>");
		return sb.toString();
	}
	
}
/*function test(){
	var yyyy=$("#datepicker #yyyy").val();
	console.log("yyyy:",yyyy);
	var MM=$("#datepicker #MM").val();
	console.log("MM:",MM);
	var dd=$("#datepicker #dd").val();
	console.log("dd:",dd);
	var hh=$("#datepicker #hh").val();
	console.log("hh:",hh);
	var mm=$("#datepicker #mm").val();
	console.log("mm:",mm);
}
function datePicker(){
	var date = new Date();
	$.ajax({
		url:"datePicker",
		data:{date:date,type:"yyyyMMddhhmm"},
		dataType:"text",
		success:function(result){
			$("#datepicker").html(result);
			$("#datepicker").append("<button onclick='test()'>확인하기</button>");
		},
		error:function(error){
			console.log(error);
		}
	})
}*/