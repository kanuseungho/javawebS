package com.spring.javawebS.common;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint("/chatserver")
public class ChatServer {
	// 현재 채팅 서버에 접속한 클라이언트(WebSocket Session) 목록들을 저장하기위한 객체생성(list)
	private static List<Session> list = new ArrayList<Session>();
	
	// 현재 채팅서버에 접속한 클라이언트들을 출력해본다.
	private void print(String msg) {
		System.out.printf("[%tT] %s\n", Calendar.getInstance(), msg);
	}
	
	// 각각의 브라우저에서 실행시, 웹소켓 생성시에 각각의 브라우저에서는 처음 1회만 수행된다.
	@OnOpen
	public void handleOpen(Session session) {
		print("클라이언트 연결 : sessionID : " + session.getId());
		list.add(session); // 접속자 관리(****) - user명으로 접속시 모든 user들은 세션으로 저장된다.(세션이름은 16진수 값으로 저장된다.)
	}
	
	
	// 클라이언트에서 ws.send() 호출시에 무조건 아래 핸들러(handleMessage)가 감지후 수행된다.
	@OnMessage
	public void handleMessage(String msg, Session session) {
		// 로그인할때는: '1#유저명#' 또는 '1#유저명#메세지@색상' 으로 넘어온다.
		// 대화할때는 : '2#유저명:메세지' 로 넘어온다. 또는 메세지와 색상을 넘길때는 '2#유저명:메세지@색상'이 넘어온다.
		
		int index = msg.indexOf("#", 2);
		String no = msg.substring(0, 1);
		String user = msg.substring(2, index);
		
		String txt = msg.substring(index + 1);
		if(txt.indexOf("@") != -1) {		// 메세지 이외에 색상이 들어왔는지를 체크하고 있다.
			txt = txt.substring(0, txt.lastIndexOf("@"));
			
			String chatColor = msg.substring(msg.lastIndexOf("@")+1);
			chatColor = chatColor.substring(1);
			
			txt = " <font color='"+chatColor+"'>"+txt+"</font>";
		}
		if (no.equals("1")) {  // 누군가 처음 접속했을때이다. > 1#아무개
			for (Session s : list) {
				if (s != session) { // 현재 접속자가 아닌 나머지 사람들
					try {
						s.getBasicRemote().sendText("1#" + user + "#"); // 접속된 다른 user들에게 현재접속자(user)를 알려주게 한다.
																														// 이명령어에 의해 ws.send()를 호출해서 처음 접속한 사용자들을 기존 접속 사용자들에게 알려주게 한다.
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
			
		} else if (no.equals("2")) {  // 접속된 누군가가 '메세지'를 전송할때
			for (Session s : list) {
				if (s != session) { // 현재 접속자(메세지를 보낸 접속자)가 아닌 나머지 접속자들한테 아래 메세지를 보낼 수 있도록 한다.
					try {
						s.getBasicRemote().sendText("2#" + user + ":" + txt);	// 현재 접속자가 아닌 다른 접속자들에게 현재 접속자의 user명과 메세지를 전송시킨다.(ws.send()호출)
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
				
			} 
		} else if (no.equals("3")) { // 종료버튼 클릭시 > 3#아무개
			for (Session s : list) {
				if (s != session) { // 현재 접속자가 아닌 나머지 접속자들에게 현재 접속한 사용자를 띄워주게 한다.
					try {
						s.getBasicRemote().sendText("3#" + user + "#");
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
			list.remove(session);	// 클라이언트가 최초 서버에 접속시 세션이 저장되어 있었기에 종료시 생성되어 있던 세션을 삭제한다.
		}
		
	}

	// 접속 종료시 실행되는 메소드...
	@OnClose
	public void handleClose(Session session) {
		System.out.println("Websocket Close");
		list.remove(session);	// 현재 생성된 세션을 List객체에서 제거시킨다.
	}
	
	// 웹소켓 에러시 수행될 내용들..
	@OnError
	public void handleError(Throwable t) {
		System.out.println("웹소켓 전송 에러입니다.");
	}
}
