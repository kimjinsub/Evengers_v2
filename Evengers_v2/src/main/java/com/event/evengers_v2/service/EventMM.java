package com.event.evengers_v2.service;

import java.sql.Array;
import java.util.ArrayList;
import java.util.Locale.Category;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.event.evengers_v2.bean.Event;
import com.event.evengers_v2.bean.EventImage;
import com.event.evengers_v2.bean.EventOption;
import com.event.evengers_v2.dao.EventDao;
import com.event.evengers_v2.userClass.UploadFile;
import com.google.gson.Gson;

@Service
public class EventMM {
	ModelAndView mav;
	@Autowired
	EventDao eDao;
	@Autowired
	UploadFile file;
	@Autowired
	private HttpSession session;
	
	public String addCategory(String ec_name) {
		boolean result=eDao.addCategory(ec_name);
		String msg="";
		if(result) {
			msg="성공";
		}
		return msg;
	}
	
	public String getCategoryList() {
		String json_categories="";
		System.out.println("gggg");
		ArrayList<Category> categoryList=eDao.getCategories();
		System.out.println("categoryList="+categoryList);
		Gson gson = new Gson();
		json_categories=gson.toJson(categoryList);
		return json_categories;
	}

	public String deleteCategory(String ec_name) {
		boolean result=eDao.deleteCategory(ec_name); 
		String msg="";
		if(result) {
			msg="성공";
		}
		return msg;
	}
	@Transactional(rollbackFor = Exception.class)
	public ModelAndView evtInsert(MultipartHttpServletRequest multi) {
		mav = new ModelAndView();
		
		String e_name = multi.getParameter("e_name");
		String c_id = session.getAttribute("id").toString();
		int e_price = Integer.parseInt(multi.getParameter("e_price"));
		String e_category = multi.getParameter("e_category");
		int e_reservedate = Integer.parseInt(multi.getParameter("e_reservedate"));
		int e_refunddate = Integer.parseInt(multi.getParameter("e_refunddate"));
		String e_contents = multi.getParameter("e_contents");
		String eo_name = multi.getParameter("eo_name");
		String eo_price = multi.getParameter("eo_price");
		
		Map<String, String> fileMap = file.singleFileUp(multi, 1);
		Event eb = new Event();
		eb.setE_name(e_name);
		eb.setC_id(c_id);
		eb.setE_price(e_price);
		eb.setE_category(e_category);
		eb.setE_reservedate(e_reservedate);
		eb.setE_refunddate(e_refunddate);
		eb.setE_contents(e_contents);
		eb.setE_orifilename(fileMap.get("e_orifilename"));
		eb.setE_sysfilename(fileMap.get("e_sysfilename"));
		
		String view = null;
		if (eDao.evtInsert(eb)) {
			String e_code = eDao.getEvtCode(eb.getC_id()); //이벤트 코드 값 가져오기
			String[] eo_names = eo_name.split(",");
			String[] eo_prices = eo_price.split(",");
			int cnt1=0;
			for(int i=0;i<eo_names.length;i++) {
				EventOption eob = new EventOption();
				eob.setEo_name(eo_names[i]);
				eob.setEo_price(Integer.parseInt(eo_prices[i]));
				eob.setE_code(e_code);
				if(eDao.evtOptionInsert(eob)) {
					cnt1++;
				}
			}
			ArrayList<String[]> fileList=file.multiFileUp(multi, 1);
			int cnt2=0;
			for(int i=0;i<fileList.size();i++) {
				EventImage ei = new EventImage();
				ei.setEi_orifilename(fileList.get(i)[0]);
				ei.setEi_sysfilename(fileList.get(i)[1]);
				ei.setE_code(e_code);
				if(eDao.evtImageInsert(ei)) {
					cnt2++;
				}
			}
			if(cnt1==eo_names.length && cnt2==fileList.size()) {
				view = "index";
			}
		} else {
			view = "evtInsertFrm";
		}
		mav.setViewName(view);
		return mav;
	}

	public String getEvtList(String ec_name) {
        String json_evtList="";
        ArrayList<Event> evtList=eDao.getEvtList(ec_name);
        Gson gson=new Gson();
        json_evtList=gson.toJson(evtList);
      return json_evtList;
   }

	public String getPath(HttpServletRequest req) {
		String root=req.getSession().getServletContext().getRealPath("/");
		String path=root+"resources\\upload";
		return path;
	}

	public ModelAndView getEvtInfo(String e_code) {
		mav = new ModelAndView();
		String view = null;
		Event eb=new Event();
		eb=eDao.getEvtInfo(e_code);
		 
		mav.addObject("eb", eb);
		view = "commonViews/evtInfo";
		mav.setViewName(view);
		return mav;
	}

	public String getOptionList(String e_code) {
		String json_option="";
		ArrayList<EventOption> optionList=eDao.getOption(e_code);
		Gson gson = new Gson();
		json_option=gson.toJson(optionList);
		return json_option;
	}
	
	public int getTotalPrice(String[] options, String def) {
		System.out.println("def="+Integer.valueOf(def));
		int totalPrice=Integer.valueOf(def);
		if(options!=null) {
			for(String eo_code:options) {
				System.out.println(eo_code);
				totalPrice += eDao.getEoPrice(eo_code);
			}
		}
		return totalPrice;
	}
}
