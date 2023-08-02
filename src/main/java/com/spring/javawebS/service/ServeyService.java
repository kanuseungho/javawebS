package com.spring.javawebS.service;

import java.util.List;

import com.spring.javawebS.vo.ServeyAnswerVO;
import com.spring.javawebS.vo.ServeyBasicServeyVO;
import com.spring.javawebS.vo.ServeyQuestionVO;
import com.spring.javawebS.vo.ServeyRealAnswerVO;
import com.spring.javawebS.vo.ServeyVO;

public interface ServeyService {
	public List<ServeyVO> getServeys(int serveySw);

	public ServeyVO getServey(int idx);

	public List<ServeyQuestionVO> getServeyQuestions(int idx);

	public List<ServeyAnswerVO> getServeyAnswers(int idx,String part, String smallPart);

	public void setServeyInput(ServeyVO vo);

	public int getLastIdx();

	public void setServeyQuesionInput(ServeyQuestionVO vo);

	public void setServeyAnswerInput(ServeyAnswerVO vo);

	public void setServeyAnswerDelete(int idx);

	public void setServeyQuestionDelete(int idx);

	public void setServeyQuestionUpdate(ServeyQuestionVO vo);

	public int setBasicServeyInput(ServeyBasicServeyVO vo);

	public void setServeyRealAnswerInput(ServeyRealAnswerVO vo);

	public List<ServeyRealAnswerVO> getRealAnswer(int idx, String part, String smallPart);

	public List<String> getRealAnswerSmallPart(int idx, String part);

	public void setServeySwAutoUpdate();

	public void setServeyUpdate(ServeyVO vo);
}
