package com.spring.javawebS.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javawebS.vo.InquiryReplyVO;
import com.spring.javawebS.vo.InquiryVO;

public interface InquiryDAO {

	public int totRecCnt(@Param("part") String part, @Param("mid") String mid);

	public List<InquiryVO> getInquiryList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("part") String part, @Param("mid") String mid);

	public void setInquiryInputOk(@Param("vo") InquiryVO vo);

	public InquiryVO getInquiryView(@Param("idx") int idx);

	public InquiryReplyVO getInquiryReply(@Param("idx") int idx);

	public void setInquiryUpdate(@Param("vo") InquiryVO vo);

	public void setInquiryDelete(@Param("idx") int idx);

}
