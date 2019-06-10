package com.event.evengers_v2.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.event.evengers_v2.bean.Question;
import com.event.evengers_v2.bean.QuestionImage;
import com.event.evengers_v2.bean.QuestionReply;

public interface QuestionDao {


	boolean questionInsert(Question question);

	ArrayList<Question> getQuestionList(Map<String, Object> map);

	String getQcode(String m_id);

	 boolean questionImageInsert(QuestionImage qi);

	Question getDetailQuestion(String q_code);

	List<QuestionImage> getQuestionFileList(String q_code);

	boolean replyInsert(QuestionReply qr);

	ArrayList<QuestionReply> getReplyList(String q_code);

	boolean qfDelete(String q_code);

	boolean replyDelete(String q_code);

	boolean questionDelete(String q_code);

	int getQuestionCount();

	ArrayList<Question> getAllQuestionList(int num);

}
