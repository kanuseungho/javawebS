package com.spring.javawebS.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javawebS.dao.ServeyDAO;
import com.spring.javawebS.vo.ServeyAnswerVO;
import com.spring.javawebS.vo.ServeyBasicServeyVO;
import com.spring.javawebS.vo.ServeyQuestionVO;
import com.spring.javawebS.vo.ServeyRealAnswerVO;
import com.spring.javawebS.vo.ServeyVO;

@Service
public class ServeyServiceImpl implements ServeyService {
	
	@Autowired
	ServeyDAO serveyDAO;
	
	@Override
	public List<ServeyVO> getServeys(int serveySw) {
		return serveyDAO.getServeys(serveySw);
	}

	@Override
	public ServeyVO getServey(int idx) {
		return serveyDAO.getServey(idx);
	}

	@Override
	public List<ServeyQuestionVO> getServeyQuestions(int idx) {
		return serveyDAO.getServeyQuestions(idx);
	}

	@Override
	public List<ServeyAnswerVO> getServeyAnswers(int idx,String part, String smallPart) {
		return serveyDAO.getServeyAnswers(idx,part,smallPart);
	}

	@Override
	public void setServeyInput(ServeyVO vo) {
		serveyDAO.setServeyInput(vo);
	}

	@Override
	public int getLastIdx() {
		return serveyDAO.getLastIdx();
	}

	@Override
	public void setServeyQuesionInput(ServeyQuestionVO vo) {
		serveyDAO.setServeyQuesionInput(vo);
	}

	@Override
	public void setServeyAnswerInput(ServeyAnswerVO vo) {
		serveyDAO.setServeyAnswerInput(vo);
	}

	@Override
	public void setServeyAnswerDelete(int idx) {
		serveyDAO.setServeyAnswerDelete(idx);
	}

	@Override
	public void setServeyQuestionDelete(int idx) {
		serveyDAO.setServeyQuestionDelete(idx);
	}

	@Override
	public void setServeyQuestionUpdate(ServeyQuestionVO vo) {
		serveyDAO.setServeyQuestionUpdate(vo);
	}

	@Override
	public int setBasicServeyInput(ServeyBasicServeyVO vo) {
		serveyDAO.setBasicServeyInput(vo);
		int idx = serveyDAO.getLastBasicIdx();
		return idx;
	}

	@Override
	public void setServeyRealAnswerInput(ServeyRealAnswerVO vo) {
		serveyDAO.setServeyRealAnswerInput(vo);
	}

	@Override
	public List<ServeyRealAnswerVO> getRealAnswer(int idx,String part, String smallPart) {
		return serveyDAO.getRealAnswer(idx,part,smallPart);
	}

	@Override
	public List<String> getRealAnswerSmallPart(int idx, String part) {
		return serveyDAO.getRealAnswerSmallPart(idx, part);
	}

	@Override
	public void setServeySwAutoUpdate() {
		serveyDAO.setServeySwAutoUpdate();
	}

	@Override
	public void setServeyUpdate(ServeyVO vo) {
		serveyDAO.setServeyUpdate(vo);
	}
}
