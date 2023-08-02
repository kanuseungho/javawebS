package com.spring.javawebS;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javawebS.service.NotifyService;
import com.spring.javawebS.vo.NotifyVO;

@Controller
@RequestMapping("/notify")
public class NotifyController {
	String msgFlag = "";
	
	@Autowired
	NotifyService notifyService;
	
	@RequestMapping(value="/notifyList", method=RequestMethod.GET)
	public String nListGet(Model model) {
		List<NotifyVO> vos = notifyService.getNotifyList();
		model.addAttribute("vos", vos);
		
		return "admin/notify/notifyList";
	}
	
	@RequestMapping(value="/notifyInput", method=RequestMethod.GET)
	public String nInputGet() {
		return "admin/notify/notifyInput";
	}

	@RequestMapping(value="/notifyInput", method=RequestMethod.POST)
	public String nInputPost(NotifyVO vo) {
		notifyService.notifyInput(vo);
		msgFlag = "notifyInputOk";
		
		return "redirect:/message/" + msgFlag;
	}
	
	@ResponseBody
	@RequestMapping(value="/notifyDelete", method=RequestMethod.GET)
	public String notifyDeleteGet(int idx) {
		notifyService.setNotifyDelete(idx);
		return "1";
	}
	
	@RequestMapping(value="/notifyUpdate", method=RequestMethod.GET)
	public String notifyUpdateGet(int idx, Model model) {
		NotifyVO vo = notifyService.getNotifyUpdate(idx);
		model.addAttribute("vo", vo);
		
		return "admin/notify/notifyUpdate";
	}

	@RequestMapping(value="/notifyUpdate", method=RequestMethod.POST)
	public String notifyUpdatePost(NotifyVO vo) {
		notifyService.setNotifyUpdateOk(vo);
		msgFlag = "notifyUpdateOk";
		
		return "redirect:/message/" + msgFlag;
	}
	
	// 공지사항 팝업을 호출하는 메소드
	@RequestMapping(value="/popup", method=RequestMethod.GET)
	public String popupGet(int idx, Model model) {
		NotifyVO vo = notifyService.getNotifyUpdate(idx);  // idx로 검색된 공지사항의 정보를 가져온다.(가져온 정보는 무조건 popupSw가 'Y'로 되어 있다)
		model.addAttribute("vo", vo);
		return "admin/notify/popup";
	}
	
	// 여러개의 리턴값을 반환하는 경우....
	@ResponseBody
	@RequestMapping(value="/popupCheck", method=RequestMethod.GET)
	public Map<Object, Object> popupCheck(int idx, String popupSw) {
		Map<Object, Object> map = new HashMap<Object, Object>();
		notifyService.setPopupCheckUpdate(idx, popupSw);
		
		map.put("idx", idx);
		map.put("sw", popupSw);
		
		return map;
	}
	
	// 공지사항 리스트 보기-첫화면에서(사이트에 방문한 모든 사용자가 볼수 있다.)
	@RequestMapping(value="/topNoticeList", method=RequestMethod.GET)
	public String topNoticeListGet(Model model) {
		List<NotifyVO> vos = notifyService.getNotifyList();
		model.addAttribute("vos", vos);
		return "notify/topNoticeList";
	}
	
	// 공지사항 팝업으로 보기
	@RequestMapping(value="/notifyView", method=RequestMethod.GET)
	public String mnNotifyViewGet(int idx, Model model) {
		NotifyVO vo = notifyService.getNotifyView(idx);
		model.addAttribute("vo", vo);
		
		return "notify/notifyView";
	}
}
