package com.last.prj.studyPlan.service;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class StudyPlanVO {

	private String pid;

	private String w1; //주차
	private String w2;
	private String w3;
	private String w4;
	private String w5;
	private String w6;
	private String w7;
	private String w8; // 중간고사 주차
	private String w9;
	private String w10;
	private String w11;
	private String w12;
	private String w13;
	private String w14;
	private String w15;
	private String w16; // 기말고사 주차
	private String content; // 내용
	private String opennum; // 강의번호
}
