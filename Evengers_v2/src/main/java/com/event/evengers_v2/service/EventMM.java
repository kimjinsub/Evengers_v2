package com.event.evengers_v2.service;

import java.sql.Array;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
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
import com.event.evengers_v2.bean.Review;
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
		String id=(String) session.getAttribute("id");
		String view = null;
		float starAverage;
		String choiceChk;
		Event eb=new Event();
		List<Review> rList=null;
		eb=eDao.getEvtInfo(e_code);
		rList=eDao.getReview(e_code);
		choiceChk=eDao.getChoiceChk(e_code,id);
		starAverage=eDao.getStarAverage(e_code);
		DecimalFormat format = new DecimalFormat(".#");
		String str =format.format(starAverage);
		System.out.println("starAverage:"+str);
		mav.addObject("eb", eb);
		mav.addObject("id", id);
		mav.addObject("rList", rList);
		mav.addObject("starAverage", str);
		mav.addObject("choiceChk", choiceChk);
		
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
	public String review(String e_code, int star, String r_contents) {
		String str="";
		String id=(String) session.getAttribute("id");
		System.out.println(id);
		System.out.println("ecode11111111"+e_code);
		Review review=new Review();
		review.setE_code(e_code);
		review.setM_id(id);
		review.setRe_contents(r_contents);
		review.setRe_stars(star);
		/*if (eDao.reviewMemberCheck(id) != null) {*/
			if (eDao.reviewCheck(id, e_code) == null) {
				if (eDao.review(review)) {
					str = "리뷰가 등록 되었습니다.";
					return str;
				}
			} else {
				str = "이미 등록된 리뷰가 있습니다.";
			}
		/* } else { str = "개인 회원만 작성 가능합니다."; } */
		return str;
	}

	public String reviewModifyBtn(String e_code, int star, String r_contents) {
		String str="";
		String id=(String) session.getAttribute("id");
		Review review=new Review();
		review.setE_code(e_code);
		review.setM_id(id);
		review.setRe_contents(r_contents);
		review.setRe_stars(star);
		if (eDao.reviewModifyBtn(review)) {
			str = "리뷰가 수정 되었습니다.";
			return str;
		}else {
			str = "수정안됨.";
		}
		return str;
	}

	public String reviewDelete(String e_code) {
		String str="";
		String id=(String) session.getAttribute("id");
		Review review=new Review();
		review.setE_code(e_code);
		review.setM_id(id);
		if (eDao.reviewDelete(review)) {
			str = "리뷰가 삭제 되었습니다.";
			return str;
		}else {
			str = "삭제 안됨.";
		}
		return str;
	}

	public String choice(String e_code) {
		String str="";
		String id=(String) session.getAttribute("id");
		if (id != null) {
			if (eDao.choice(e_code, id)) {
				str = "찜 추가됨";
				return str;
			} else {
				str = "찜 안됨.";
			}
		} else {
			str = "로그인 해주세요";
		}
		return str;
	}

	public String choiceDelete(String e_code) {
		String str="";
		String id=(String) session.getAttribute("id");
		if (id != null) {
			if (eDao.choiceDelete(e_code, id)) {
				str = "찜 삭제 됨";
				return str;
			} else {
				str = "찜 삭제 안됨.";
			}
		} else {
			str = "로그인 해주세요";
		}
		return str;
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
	public String effectiveness(String dday, String e_code) {
		String msg="";
		try {
			Event e=eDao.getEvtInfo(e_code);
			SimpleDateFormat format1= new SimpleDateFormat("yyyy-MM-dd");
			Date selected_dday= format1.parse(dday.substring(0, dday.indexOf("T")));
			Date today = new Date();
			today=format1.parse(format1.format(today));
			long diff=selected_dday.getTime()-today.getTime();
			long diffDays=diff/(24*60*60*1000);
			System.out.println("날짜차이:"+diffDays+"일");
			System.out.println("누가먼저?:"+selected_dday.compareTo(today));
			if(selected_dday.compareTo(today)>=1) {
				//입력날짜가 현재보다 미래면 +1 과거면 -1 같으면0
				if(diffDays>=e.getE_reservedate()) {
					msg="<p id='possible'>가능한 날짜입니다</p>";
				}
				else {
					msg="<p id='impossible'>불가능한 날짜입니다</p>";
				}
			}else {
				msg="<p id='impossible'>불가능한 날짜입니다</p>";
			}
		} catch (ParseException e1) {
			e1.printStackTrace();
		}
		return msg;
	}
}
