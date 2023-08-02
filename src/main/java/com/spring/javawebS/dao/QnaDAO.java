package com.spring.javawebS.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javawebS.vo.QnaVO;

public interface QnaDAO {

	public String getEmail(@Param("mid") String mid);

	public int getCountIdx();

	public int getMaxIdx();

	public void qnaInputOk(@Param("vo") QnaVO vo);
	
	public int totRecCnt();

	public List<QnaVO> getQnaList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public QnaVO getQnaContent(@Param("idx") int idx);

	public void setQnaDelete(@Param("idx") int idx);

	public void setQnaContentUpdate(@Param("vo") QnaVO vo);

	public List<QnaVO> getQnaIdxCheck(@Param("qnaIdx") String qnaIdx);

	public void setQnaCheckUpdate(@Param("idx") int idx, @Param("title") String title);

}
