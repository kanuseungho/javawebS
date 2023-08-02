package com.spring.javawebS;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javawebS.pagination.PageProcess;
import com.spring.javawebS.pagination.PageVO;
import com.spring.javawebS.service.InquiryService;
import com.spring.javawebS.vo.InquiryReplyVO;
import com.spring.javawebS.vo.InquiryVO;

@Controller
@RequestMapping("/inquiry")
public class InquiryController {
	@Autowired
	InquiryService inquiryService;
	
	@Autowired
	PageProcess pageProcess;
	
	@RequestMapping(value = "/inquiryList", method = RequestMethod.GET)
	public String inquiryListGet(HttpSession session,
			@RequestParam(name="pag", defaultValue="1", required=false) int pag,
			@RequestParam(name="pageSize", defaultValue="5", required=false) int pageSize,
			@RequestParam(name="part", defaultValue="전체", required=false) String part,
			Model model) {
		String mid = (String) session.getAttribute("sMid");
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "inquiry", part, mid);
		List<InquiryVO> vos = inquiryService.getInquiryList(pageVO.getStartIndexNo(), pageSize, part, mid);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("part", part);
		
		return "inquiry/inquiryList";
	}
	
	@RequestMapping(value = "/inquiryInput", method = RequestMethod.GET)
	public String inquiryInputGet() {
		return "inquiry/inquiryInput";
	}
	
	@RequestMapping(value = "/inquiryInput", method = RequestMethod.POST)
	public String inquiryInputPost(MultipartFile file, InquiryVO vo) {
		inquiryService.setInquiryInput(file, vo);
		
		return "redirect:/message/inquiryInputOk";
	}
	
	@RequestMapping(value = "/inquiryView", method = RequestMethod.GET)
	public String inquiryViewGet(
			int idx,
			@RequestParam(name="pag", defaultValue="1", required=false) int pag,
			Model model) {
		InquiryVO vo = inquiryService.getInquiryView(idx);
		
		// 해당 문의글의 답변글 가져오기
		InquiryReplyVO reVO = inquiryService.getInquiryReply(idx);
		
		model.addAttribute("vo", vo);
		model.addAttribute("reVO", reVO);
		model.addAttribute("pag", pag);
		
		return "inquiry/inquiryView";
	}
	
	@RequestMapping(value = "/inquiryUpdate", method = RequestMethod.GET)
	public String inquiryUpdateGet(int idx,
			@RequestParam(name="pag", defaultValue="1", required=false) int pag,
			Model model) {
		InquiryVO vo = inquiryService.getInquiryView(idx);
		
		// 해당 문의글의 답변글 가져오기
		InquiryReplyVO reVO = inquiryService.getInquiryReply(idx);
		
		model.addAttribute("vo", vo);
		model.addAttribute("reVO", reVO);
		model.addAttribute("pag", pag);
		model.addAttribute("idx", idx);
		
		return "inquiry/inquiryUpdate";
	}
	
	@RequestMapping(value = "/inquiryUpdate", method = RequestMethod.POST)
	public String inquiryUpdatePost(MultipartFile file,  InquiryVO vo,
			@RequestParam(name="pag", defaultValue="1", required=false) int pag,
			Model model) {
		inquiryService.setInquiryUpdate(file, vo);
		
		model.addAttribute("idx",vo.getIdx());
		return "redirect:/message/inquiryUpdateOk";
	}

	// 1:1문의 내용 삭제처리
	@RequestMapping(value = "/inquiryDelete", method = RequestMethod.GET)
	public String inquiryDeleteGet(int idx,
			@RequestParam(name="fSName", defaultValue="", required=false) String fSName,
			@RequestParam(name="pag", defaultValue="1", required=false) int pag,
			Model model) {
		inquiryService.setInquiryDelete(idx, fSName);
		model.addAttribute("pag", pag);
		
		return "redirect:/message/inquiryDeleteOk";
	}
	
}
