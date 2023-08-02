package com.spring.javawebS.common;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.spring.javawebS.vo.MailVO;

@Component
public class ScheduleComponent {
	@Autowired
	JavaMailSender mailSender;
	
  // @Scheduled(cron = "0/1 * * * * *")  // 1초마다 실행
  // @Scheduled(cron = "0/60 * * * * *")	// 1분마다 실행
  @Scheduled(cron = "0 10 23 * * *")	// 매일 오후 23시 10분 0초에 실행
  public void CronScheduler() throws MessagingException {
  	LocalDateTime now = LocalDateTime.now();
    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.SSS");
    System.out.println("Cron 스케줄러 : " + now.format(dtf));
    
    MailVO vo = new MailVO();
    vo.setToMail("cjsk1126@hanmail.net");
    vo.setTitle("메일 연습");
    vo.setContent("스케줄 이용한 메일 연습");
        
  	// 메일 전송을 위한 준비하기
		String toMail = vo.getToMail();
		String title = vo.getTitle();
		String content = vo.getContent();
		
		// 메일 전송을 위한 객체 : MimeMessage(), MimeMessageHelper()
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
		
		// 메일보관함에 회원이 보내온 메세지들의 정보를 모두 저장시킨후 작업처리하자...
		messageHelper.setTo(toMail);
		messageHelper.setSubject(title);
		messageHelper.setText(content);
		
		// 메세지 보관함의 내용(content)에 필요한 정보를 추가로 담아서 전송시킬수 있도록 한다.
		content = content.replace("\n", "<br>");
		content += "<br><hr><h3>CJ Green에서 보냅니다.</h3><hr><br>";
		content += "<p><img src=\"cid:main.jpg\" width='500px'></p>";
		content += "<p>방문하기 : <a href='http://49.142.157.251:9090/cjgreen/'>CJ Green프로젝트</a></p>";
		content += "<hr>";
		messageHelper.setText(content, true);
		
		// 본문에 기재된 그림파일의 경로를 별도로 표시시켜준다. 그런후, 다시 보관함에 담아준다.
		FileSystemResource file = new FileSystemResource("D:\\javaweb\\springframework\\works\\javawebS\\src\\main\\webapp\\resources\\images\\main.jpg");
		messageHelper.addInline("main.jpg", file);
		
		// 첨부파일 보내기(서버 파일시스템에 존재하는 파일을 보내기)
		file = new FileSystemResource("D:\\javaweb\\springframework\\works\\javawebS\\src\\main\\webapp\\resources\\images\\chicago.jpg");
		messageHelper.addAttachment("chicago.jpg", file);

		// 메일 전송하기
		mailSender.send(message);
  }
}
