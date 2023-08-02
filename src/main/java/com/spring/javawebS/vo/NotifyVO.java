package com.spring.javawebS.vo;

import lombok.Data;

@Data
public class NotifyVO {
	private int idx;
	private String name;
	private String title;
	private String content;
	private String startDate;
	private String endDate;
	private String popupSw;
}
