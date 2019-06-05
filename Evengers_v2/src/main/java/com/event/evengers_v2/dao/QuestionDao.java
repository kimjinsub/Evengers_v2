package com.event.evengers_v2.dao;

import java.util.ArrayList;

import com.event.evengers_v2.bean.Question;
import com.event.evengers_v2.bean.QuestionImage;

public interface QuestionDao {


	boolean questionInsert(Question question);

	ArrayList<Question> getQuestionList(String id);

	String getQcode(String m_id);

	 boolean questionImageInsert(QuestionImage qi);

	Question getDetailQuestion(String q_code);

}
