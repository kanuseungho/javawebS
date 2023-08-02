package com.spring.javawebS;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javawebS.service.ServeyService;
import com.spring.javawebS.vo.ServeyAnswerVO;
import com.spring.javawebS.vo.ServeyBasicServeyVO;
import com.spring.javawebS.vo.ServeyQuestionVO;
import com.spring.javawebS.vo.ServeyRealAnswerVO;
import com.spring.javawebS.vo.ServeyVO;

@Controller
@RequestMapping("/servey")
public class ServeyController {

	@Autowired
	ServeyService serveyService;
	
	@RequestMapping(value="/serveyInput",method = RequestMethod.GET)
	public String adminServeyInputGet(Model model,
			@RequestParam(name="idx" ,defaultValue = "0" ,required=false) int idx) {
		
		model.addAttribute("idx", idx);
		return "admin/servey/serveyInput";
	}
	
	@RequestMapping(value="/serveyUpdate",method = RequestMethod.GET)
	public String adminServeyUpdateGet(Model model,
			@RequestParam(name="idx" ,defaultValue = "0" ,required=false) int idx) {
		
		model.addAttribute("idx", idx);
	  model.addAttribute("vo",serveyService.getServey(idx)) ;
	  
  	List<ServeyQuestionVO> questionVos =  serveyService.getServeyQuestions(idx);
  	model.addAttribute("questionVos", questionVos);
  	
  	List<ServeyAnswerVO> answerVos = serveyService.getServeyAnswers(idx,"","");
  	model.addAttribute("answerVos", answerVos);
	  
		return "admin/servey/serveyUpdate";
	}	
	
	@RequestMapping(value="/serveyInput",method = RequestMethod.POST)
	public String adminServeyInputPost(Model model,ServeyVO vo) {
		if(vo.getShowSw() == null) vo.setShowSw("0");
		else vo.setShowSw("1");
		serveyService.setServeyInput(vo);
		int idx = serveyService.getLastIdx();
		return "redirect:/message/serveyInput?flag="+idx;
	}	
	
	@ResponseBody
	@RequestMapping(value="/serveyAnswerInput",method = RequestMethod.POST)
	public String serveyAnswerInputPost(ServeyQuestionVO vo) {
		serveyService.setServeyQuesionInput(vo);
		return "";
	}
	@ResponseBody
	@RequestMapping(value="/serveyAnswerInputOK",method = RequestMethod.POST)
	public String serveyAnswerInputOKPost(ServeyAnswerVO vo) {
		serveyService.setServeyAnswerInput(vo);
		return "";
	}
	
	@ResponseBody
	@RequestMapping(value="/serveyAnswerDeleteOK",method = RequestMethod.POST)
	public String serveyAnswerDeleteOKPost(int idx) {
		serveyService.setServeyAnswerDelete(idx);
		return "";
	}
	@ResponseBody
	@RequestMapping(value="/serveyQuestionDeleteOK",method = RequestMethod.POST)
	public String serveyQuestionDeleteOKPost(int idx) {
		serveyService.setServeyQuestionDelete(idx);
		return "";
	}
	
	@ResponseBody
	@RequestMapping(value="/serveyQuestionUpdateOK",method = RequestMethod.POST)
	public String serveyQuestionUpdateOKPost(ServeyQuestionVO vo) {
		serveyService.setServeyQuestionUpdate(vo);
		return "";
	}
	
	@RequestMapping(value="/serveyManagement",method = RequestMethod.GET)
	public String adminServeyListGet(Model model) {
		List<ServeyVO> vos =  serveyService.getServeys(99);
		model.addAttribute("vos",vos);
		
		return "admin/servey/serveyManagement";
	}
	
	@RequestMapping(value="/serveyResult",method = RequestMethod.GET)
	public String adminServeyResultGet(int idx, Model model,
			@RequestParam(name="part",defaultValue = "") String part,
			@RequestParam(name="smallPart",defaultValue = "")String smallPart) {
		
		model.addAttribute("idx", idx);
	  model.addAttribute("vo",serveyService.getServey(idx)) ;
	  
  	List<ServeyQuestionVO> questionVos =  serveyService.getServeyQuestions(idx);
  	model.addAttribute("questionVos", questionVos); 
  	
  	List<ServeyAnswerVO> answerVos = serveyService.getServeyAnswers(idx,part,smallPart);
  	model.addAttribute("answerVos", answerVos); 
		
  	//선택지가 없는경우도 있다
  	List<ServeyRealAnswerVO> realAnswerVos = serveyService.getRealAnswer(idx,part,smallPart);
  	
  	model.addAttribute("realAnswerVos", realAnswerVos); 
  	model.addAttribute("part", part); 
  	model.addAttribute("smallPart", smallPart); 
		
  	if(!part.equals("")) {
	  	List<String> smalls = serveyService.getRealAnswerSmallPart(idx,part);
	  	model.addAttribute("smalls", smalls); 
  	}
  	
		return "admin/servey/serveyResult";
	}
	
	@ResponseBody
	@RequestMapping(value="/serveyGetSmallpart",method =RequestMethod.POST,produces="application/text; charset=utf8")
	public String serveyGetSmallPart(int idx, String part) {
		List<String> smalls = serveyService.getRealAnswerSmallPart(idx,part);
		
		String str ="";
		for(String small:smalls) {
			str+=small+"_";
		}
		
		return str.substring(0, str.length()-1);
	}
	
	@RequestMapping(value="/serveyUpdate",method = RequestMethod.POST)
	public String serveyUpdatePost(ServeyVO vo) {
		//System.out.println("vo.showSw : " + vo.getShowSw());
		if(vo.getShowSw() == null) vo.setShowSw("0");
		//if(vo.getShowSw().equals("on")) vo.setShowSw("1");
		else vo.setShowSw("1");
		serveyService.setServeyUpdate(vo);
		
		return "redirect:/message/serveyUpdateOK?flag="+vo.getIdx();
	}

	@RequestMapping(value="/servey",method = RequestMethod.GET)
	public String serveyGet(int idx,Model model) {
		//System.out.println("통과...idx : " + idx);
		ServeyVO vo =  serveyService.getServey(idx);
		model.addAttribute("vo",vo);
		
  	List<ServeyQuestionVO> questionVos =  serveyService.getServeyQuestions(idx);
  	model.addAttribute("questionVos", questionVos);
  	
  	List<ServeyAnswerVO> answerVos = serveyService.getServeyAnswers(idx,"","");
  	model.addAttribute("answerVos", answerVos);
		
		return "admin/servey/servey";
	}
	
	@RequestMapping(value="/basicServey",method = RequestMethod.GET)
	public String basicServeyGet(int idx,Model model) {
		ServeyVO vo =  serveyService.getServey(idx);
		model.addAttribute("vo",vo);
		
		return "admin/servey/basicServey";
	}
	
	@RequestMapping(value="/basicServey",method = RequestMethod.POST)
	public String basicServeyPost(int idx,ServeyBasicServeyVO vo,HttpSession session) {
		session.setAttribute("basicServeyVo", vo);
		return "redirect:/servey/servey?idx="+idx;
	}
	
	@Transactional
	@RequestMapping(value="/servey",method = RequestMethod.POST)
	public String serveyPost(String answer,HttpServletRequest request,ServeyRealAnswerVO vo,HttpServletResponse response,HttpSession session,Model model) {
		String detailAnswer = vo.getDetailAnswer();
		ServeyBasicServeyVO  basicServeyVo =  (ServeyBasicServeyVO) session.getAttribute("basicServeyVo");
		int bIdx = serveyService.setBasicServeyInput(basicServeyVo);
		List<ServeyQuestionVO> qvos = serveyService.getServeyQuestions(vo.getSIdx());
		
		vo.setBIdx(bIdx);
		if(answer!=null) {
			for(String ans : answer.split(",")) {
				
				 vo.setQIdx(Integer.parseInt(ans.split("/")[0])); 
				 vo.setAIdx(Integer.parseInt(ans.split("/")[1])); 
				 vo.setDetailAnswer("");
				 System.out.println("1.vo:"+vo);
				 serveyService.setServeyRealAnswerInput(vo);
			}
		}
		for(ServeyQuestionVO qvo : qvos) {
			if(qvo.getAnswerSw()==2) {
				int radioAnswer = Integer.parseInt(request.getParameter("radioAnswer"+qvo.getIdx()));
				vo.setQIdx(qvo.getIdx());
				vo.setAIdx(radioAnswer);
				vo.setDetailAnswer("");
				System.out.println("2.vo:"+vo);
				serveyService.setServeyRealAnswerInput(vo);
			}
		}	
		for(String datail : detailAnswer.split(",")) {
			vo.setQIdx(Integer.parseInt(datail.split("/")[0]));
			vo.setDetailAnswer(datail.split("/")[1]);
			vo.setAIdx(0);
			if(vo.getQIdx()==0) continue;
			System.out.println("3.vo:"+vo);
			serveyService.setServeyRealAnswerInput(vo);
		}
		model.addAttribute("idx",vo.getSIdx());		
		
		return "admin/servey/serveySuccess";
	}
	
}
