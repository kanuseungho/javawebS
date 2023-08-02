package com.spring.javawebS.vo;

import lombok.Data;

@Data
public class ServeyAnswerVO {
	private int idx;
	private int sIdx;
	private int qIdx;
	private String acontent;
	private int realAnswerCnt;
}
