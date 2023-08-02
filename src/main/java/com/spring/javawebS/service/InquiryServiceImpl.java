package com.spring.javawebS.service;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javawebS.common.JavawebProvide;
import com.spring.javawebS.dao.InquiryDAO;
import com.spring.javawebS.vo.InquiryReplyVO;
import com.spring.javawebS.vo.InquiryVO;

@Service
public class InquiryServiceImpl implements InquiryService {
	@Autowired
	InquiryDAO inquiryDAO;

	@Override
	public List<InquiryVO> getInquiryList(int startIndexNo, int pageSize, String part, String mid) {
		return inquiryDAO.getInquiryList(startIndexNo, pageSize, part, mid);
	}

	@Override
	public void setInquiryInput(MultipartFile file, InquiryVO vo) {
		// 사진작업 처리후 DB에 저장
		try {
			String oFileName = file.getOriginalFilename();
			if(oFileName != null && !oFileName.equals("")) {
				UUID uid = UUID.randomUUID();
				String saveFileName = uid + "_" + oFileName;
				JavawebProvide ps = new JavawebProvide();
				ps.writeFile(file, saveFileName,"inquiry");
				vo.setFName(oFileName);
				vo.setFSName(saveFileName);
			}
			inquiryDAO.setInquiryInputOk(vo);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@Override
	public InquiryVO getInquiryView(int idx) {
		return inquiryDAO.getInquiryView(idx);
	}

	@Override
	public InquiryReplyVO getInquiryReply(int idx) {
		return inquiryDAO.getInquiryReply(idx);
	}

	@Override
	public void setInquiryUpdate(MultipartFile file, InquiryVO vo) {
	  // 사진을 변경처리 했다면 사진작업 처리후 DB에 갱신작업처리한다.
		try {
			String oFileName = file.getOriginalFilename();
			if(oFileName != null && !oFileName.equals("")) {
				// 기존에 존재하는 파일을 삭제
				HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
				String realPath = request.getSession().getServletContext().getRealPath("/resources/data/inquiry/");
				File deleteFile = new File(realPath + vo.getFSName());
				if(deleteFile.exists()) deleteFile.delete();
				
				// 새로 업로드되는 파일의 이름을 부여후 저장시키고, vo에 set시킨다.
				UUID uid = UUID.randomUUID();
				String saveFileName = uid + "_" + oFileName;
				JavawebProvide ps = new JavawebProvide();
				ps.writeFile(file, saveFileName,"inquiry");
				vo.setFName(oFileName);
				vo.setFSName(saveFileName);
			}
			else {
				vo.setFName(vo.getFName());
				vo.setFSName(vo.getFSName());
			}
			inquiryDAO.setInquiryUpdate(vo);
		} catch (IOException e) {
			e.printStackTrace();
		}
//		inquiryDAO.setInquiryUpdate(vo);
	}

	@Override
	public void setInquiryDelete(int idx, String fSName) {
		// 올려진 사진이 있으면 먼저 지우고 DB의 내용을 삭제처리한다.
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/inquiry/");
		File deleteFile = new File(realPath + fSName);
		if(deleteFile.exists()) deleteFile.delete();
		
		inquiryDAO.setInquiryDelete(idx);
	}
}
