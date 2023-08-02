package com.spring.javawebS.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javawebS.vo.ServeyAnswerVO;
import com.spring.javawebS.vo.ServeyBasicServeyVO;
import com.spring.javawebS.vo.ServeyQuestionVO;
import com.spring.javawebS.vo.ServeyRealAnswerVO;
import com.spring.javawebS.vo.ServeyVO;

public interface ServeyDAO {
	public List<ServeyVO> getServeys(@Param("showSw") int serveySw);

	public ServeyVO getServey(@Param("idx") int idx);

	public List<ServeyQuestionVO> getServeyQuestions(@Param("sIdx") int idx);

	public List<ServeyAnswerVO> getServeyAnswers(@Param("sIdx") int idx,@Param("part") String part,@Param("smallPart") String smallPart);

	public void setServeyInput(@Param("vo") ServeyVO vo);

	public int getLastIdx();

	public void setServeyQuesionInput(@Param("vo") ServeyQuestionVO vo);

	public void setServeyAnswerInput(@Param("vo") ServeyAnswerVO vo);

	public void setServeyAnswerDelete(@Param("idx") int idx);

	public void setServeyQuestionDelete(@Param("idx") int idx);

	public void setServeyQuestionUpdate(@Param("vo") ServeyQuestionVO vo);

	public void setBasicServeyInput(@Param("vo") ServeyBasicServeyVO vo);

	public void setServeyRealAnswerInput(@Param("vo") ServeyRealAnswerVO vo);

	public int getLastBasicIdx();

	public List<ServeyRealAnswerVO> getRealAnswer(@Param("idx") int idx,@Param("part") String part,@Param("smallPart") String smallPart);

	public List<String> getRealAnswerSmallPart(@Param("idx") int idx,@Param("part") String part);

	public void setServeySwAutoUpdate();

	public void setServeyUpdate(@Param("vo") ServeyVO vo);
}
