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

	public Map<String, Object> getQuestionList(String id, Integer pageNum) {
		String jsonStr = "";
		ArrayList<Question> qList = new ArrayList<Question>();
		int num = (pageNum == null) ? 1 : pageNum;
		System.out.println("아이디:"+id);
		if(id.equals("admin")) {
			qList = qDao.getAllQuestionList(num);
			System.out.println("관리자qList:"+qList);
		}else {
		Map<String, Object> map = new HashMap<String, Object>(); // MAP을 이용해 담기
        map.put("id",id);
        map.put("num", num);
		qList = qDao.getQuestionList(map);
		}
		//Gson gson = new Gson();
		//jsonStr = gson.toJson(qList);
		Map<String,Object> map1= new HashMap<String,Object>();
		map1.put("qList",qList);
		map1.put("paging",getPaging(num));
		//System.out.println("jsonStr=" + jsonStr);
		return map1;
	}

	private Object getPaging(int pageNum) {
		int maxNum = qDao.getQuestionCount(); // 전체 글의 갯수
		System.out.println("전페" + maxNum);

		int listCount = 5; // 페이지당 글의 수
		int pageCount = 2; // 그룹당 페이지 수
		String boardName = "questionList"; // 게시판이 여러개 일떄

		Paging paging = new Paging(maxNum, pageNum, listCount, pageCount, boardName);

		return paging.makeHtmlPaging();
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
		
		
		
		
		mav.setViewName("memberViews/detailQuestion");
		
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
    
		@Transactional
		public ModelAndView questionDelete(String q_code) throws DBException {
			mav = new ModelAndView();
			boolean b = qDao.qfDelete(q_code);
			boolean r = qDao.replyDelete(q_code); // 댓글
			boolean a = qDao.questionDelete(q_code); // 원글 1000번 째 롤백확인
			System.out.println(b);
			System.out.println(r);
			System.out.println(a);

			if (a == false) {
				throw new DBException();
			}

			if (r && a) {
				System.out.println("삭제 트랜잭션 성공");
			} else {
				System.out.println("삭제 트랜잭션 실패");
			}

			mav.setViewName("redirect:/questionList");

			return mav;
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

