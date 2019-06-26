package com.event.evengers_v2.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.event.evengers_v2.userClass.DBException;
import com.event.evengers_v2.userClass.Paging;
import com.event.evengers_v2.bean.Question;
import com.event.evengers_v2.bean.QuestionImage;
import com.event.evengers_v2.bean.QuestionReply;
import com.event.evengers_v2.dao.QuestionDao;
import com.event.evengers_v2.userClass.UploadFile;
import com.google.gson.Gson;

@Service
public class QuestionMM {
	private ModelAndView mav;
	@Autowired
	QuestionDao qDao;
	@Autowired
	HttpSession session;
	@Autowired
	UploadFile file;
	

	public ModelAndView questionInsert(MultipartHttpServletRequest multi) {
		mav = new ModelAndView();
		System.out.println("문의내용:" + multi.getParameter("q_contents"));
		Question question = new Question();
		question.setQ_title(multi.getParameter("q_title"));
		question.setQ_contents(multi.getParameter("q_contents"));
		// question.setM_id(session.getAttribute("m_id").toString()); String
		String m_id = session.getAttribute("id").toString();
		System.out.println("세션아이디:" + m_id);
		question.setM_id(m_id);
		System.out.println("빈 데이터=" + (question.getM_id()));
		boolean q = qDao.questionInsert(question);
		String q_code = qDao.getQcode(m_id);

		String view = null;

		ArrayList<String[]> qfileList = file.multiFileUp(multi, 2);

		int cnt2 = 0;
		for (int i = 0; i < qfileList.size(); i++) {
			QuestionImage qi = new QuestionImage();
			qi.setQ_orifilename(qfileList.get(i)[0]);
			qi.setQ_sysfilename(qfileList.get(i)[1]);
			System.out.println("qi_ori=" + qi.getQ_orifilename());
			System.out.println("qi_sys=" + qi.getQ_sysfilename());
			qi.setQ_code(q_code);
			if (qDao.questionImageInsert(qi)) {
				cnt2++;
			}
		}
		if (cnt2 == qfileList.size()) {
			view = "memberViews/questionList";

		} else {
			view = "index";
		}
		mav.setViewName(view);
		return mav;
	}

	public Map<String, Object> getQuestionList(Integer pageNum,Integer listCount) {
		String id=session.getAttribute("id").toString();
		System.out.println("id="+id);
		ArrayList<Question> qList = new ArrayList<Question>();
		Map<String,Object> map1= new HashMap<String,Object>();
		int check=0;
		if(id.equals("admin")) {
			qList = qDao.getAllQuestionList(pageNum);
			  String paging=new Paging(qDao.getQuestionCount(), pageNum, listCount, 2, "getQuestionList").makeHtmlAjaxPaging();
			System.out.println("관리자qList:"+qList);
			check=2;
			map1.put("paging",paging);
			map1.put("check",check);
		}else {
			check=1;
		Map<String, Object> map = new HashMap<String, Object>(); // MAP을 이용해 담기
        map.put("id",id);
        map.put("pageNum", pageNum);
		qList = qDao.getQuestionList(map);
		 String paging1=new Paging(qDao.getQuestionCount1(id), pageNum, listCount, 2, "getQuestionList").makeHtmlAjaxPaging();
		 map1.put("paging",paging1);
		 map1.put("check",check);
		}
		map1.put("qList",qList);
		return map1;
	}

	

	public ModelAndView showQuestion(String q_code) {
		mav=new ModelAndView();
		Question question=qDao.getDetailQuestion(q_code);
		mav.addObject("question",question);
		
		List<QuestionImage> qfList = qDao.getQuestionFileList(q_code);
		System.out.println("size = " + qfList.size());
		mav.addObject("qfList", qfList);
		
		List<QuestionReply> qrList = qDao.getReplyList(q_code);
		mav.addObject("qrList",qrList);
		
		
		
		
		mav.setViewName("adminViews/detailQuestion1");
		
		return mav;
	}

	//public Map<String, List<QuestionReply>> replyInsert(QuestionReply qr) {
	public String replyInsert(QuestionReply qr) {
		String jsonStr="";
		Map<String, List<QuestionReply>> qrMap=null;
		boolean qrr=qDao.replyInsert(qr);
		String json_qrList="";
		if(qrr==true) {
			ArrayList<QuestionReply> qrList=qDao.getReplyList(qr.getQ_code());
			json_qrList=new Gson().toJson(qrList);
			//qrMap = new HashMap<String, List<QuestionReply>>();
			
			//qrMap.put("qrList",qrList);
			//System.out.println("Qrmap"+qrMap);
			
		}
		else {
			qrMap=null;
		}
		System.out.println("댓글 목록:"+jsonStr);
		return json_qrList;
	}
    
		@Transactional(rollbackFor = Exception.class)
		public String questionDelete(String q_code) throws DBException {
			String msg="";
			boolean b=true;
			boolean r=true;
			boolean a=true;
			int fi=qDao.getQuestionFileList(q_code).size();
			int re =qDao.getReplyList(q_code).size();
			System.out.println("fe:"+fi);
			System.out.println("re:"+re);
			if(fi>0) {
			 b = qDao.qfDelete(q_code);}
			if(re>0) {
			 r = qDao.replyDelete(q_code);}
			// 댓글
			 a = qDao.questionDelete(q_code); // 원글 1000번 째 롤백확인
			System.out.println(b);
			System.out.println(r);
			System.out.println(a);
		
		 // if (a == false) { throw new DBException(); }
		 
			if (r && a) {
				System.out.println("삭제 트랜잭션 성공");
				msg="글 삭제 완료";
			} else {
				System.out.println("삭제 트랜잭션 실패");
				msg="글 삭제 실패";
			}

 
			return msg;
		}
		public void download(Map<String, Object> params) throws Exception {
			String root = (String) params.get("root");
			String sysFileName = (String) params.get("sysFileName");
			String oriFileName = (String) params.get("oriFileName");
			String fullPath = root + "upload/questionImage/" + sysFileName;

			HttpServletResponse resp = (HttpServletResponse) params.get("response");
			// 실제 다운로드
			file.download(fullPath, oriFileName, resp);

		}

}

