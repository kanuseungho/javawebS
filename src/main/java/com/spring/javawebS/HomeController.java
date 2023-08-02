package com.spring.javawebS;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javawebS.service.NotifyService;
import com.spring.javawebS.service.ServeyService;
import com.spring.javawebS.vo.NotifyVO;
import com.spring.javawebS.vo.ServeyVO;

@Controller
public class HomeController {
	
	@Autowired
	NotifyService notifyService;
	
	@Autowired
	ServeyService serveyService;

	@RequestMapping(value = {"/","/h"}, method = RequestMethod.GET)
	public String home(Locale locale, Model model, HttpServletRequest request) {
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		// 첫화면에 공지사항 팝업으로 띄우기
		List<NotifyVO> popupVOS = notifyService.getNotifyPopup();
		model.addAttribute("popupVOS", popupVOS);
		
		// 첫화면에 설문지 문항 띄우기
		List<ServeyVO> serveyVOS = serveyService.getServeys(1);
		Cookie[] cookies = request.getCookies();
		
		if(serveyVOS.size()!=0) {
			for(int i=0;i<serveyVOS.size();i++) {
				if(cookies!=null) {
					for(int j =0;j<cookies.length;j++) {
						String imsi = "servey"+serveyVOS.get(i).getIdx();
						if(cookies[j].getName().equals(imsi)) {
							serveyVOS.remove(i);
							break;
						}
					}
				}
				model.addAttribute("serveyVos",serveyVOS);
			}
		}
		
		return "home";
	}
	
	@RequestMapping(value = "/imageUpload")
	public void imageUploadGet(MultipartFile upload,
			HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/");
		String oFileName = upload.getOriginalFilename();
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		oFileName = sdf.format(date) + "_" + oFileName;
		
		// ckeditor에서 올린(전송)한 파일을 서버 파일시스템에 실제로 저장처리시켜준다.
		byte[] bytes = upload.getBytes();
		FileOutputStream fos = new FileOutputStream(new File(realPath + oFileName));
		fos.write(bytes);
		
		// 서버 파일시스템에 저장되어 있는 그림파일을 브라우저 편집화면(textarea)에 보여주는 처리
		PrintWriter out = response.getWriter();
		String fileUrl = request.getContextPath() + "/data/ckeditor/" + oFileName;
		out.println("{\"originalFilename\":\""+oFileName+"\",\"uploaded\":1,\"url\":\""+fileUrl+"\"}");
		
		out.flush();
		fos.close();
	}
	
	@RequestMapping(value = "/webSocket", method = RequestMethod.GET)
	public String webSocketGet(HttpServletRequest req, HttpServletResponse resp, HttpSession session) {
		return "webSocket/webSocket";
	}
	
	
}
