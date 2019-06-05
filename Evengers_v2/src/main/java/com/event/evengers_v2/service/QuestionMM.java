package com.event.evengers_v2.service;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.event.evengers_v2.bean.Question;
import com.event.evengers_v2.bean.QuestionImage;
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

	public String getQuestionList(String id) {
		String jsonStr = "";
		ArrayList<Question> qList = new ArrayList<Question>();
		qList = qDao.getQuestionList(id);
		Gson gson = new Gson();
		jsonStr = gson.toJson(qList);
		System.out.println("jsonStr=" + jsonStr);
		return jsonStr;
	}

	public ModelAndView showQuestion(String q_code) {
		mav=new ModelAndView();
		Question question=qDao.getDetailQuestion(q_code);
		mav.addObject("question",question);
		mav.setViewName("memberViews/detailQuestion");
		
		return mav;
	}

}

