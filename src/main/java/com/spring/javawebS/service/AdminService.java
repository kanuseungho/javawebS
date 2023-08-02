package com.spring.javawebS.service;

import java.util.ArrayList;

import com.spring.javawebS.vo.InquiryReplyVO;
import com.spring.javawebS.vo.InquiryVO;
import com.spring.javawebS.vo.QrCodeVO;

public interface AdminService {
	
	public ArrayList<QrCodeVO> getInquiryListAdmin(int startIndexNo, int pageSize, String part);

	public InquiryVO getInquiryContent(int idx);

	public void setInquiryInputAdmin(InquiryReplyVO vo);

	public InquiryReplyVO getInquiryReplyContent(int idx);

	public void setInquiryReplyUpdate(InquiryReplyVO reVO);

	public void setInquiryReplyDelete(int reIdx);

	public void setInquiryUpdateAdmin(int inquiryIdx);

	public void setInquiryUpdateAdmin2(int inquiryIdx);

}
