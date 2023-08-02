package com.spring.javawebS.vo;

import lombok.Data;

@Data
public class InquiryVO {
	private int idx;
	private String mid;
	private String title;
	private String part;
	private String wDate;
	private String jumunNo;
	private String content;
	private String fName;
	private String fSName;
	private String reply;
	
	private int wNDate;		// 날짜를 숫자로 변환후 계산하기위한 필드
}
