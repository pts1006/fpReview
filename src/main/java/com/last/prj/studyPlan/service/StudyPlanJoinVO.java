package com.last.prj.studyPlan.service;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class StudyPlanJoinVO {

	private String	division; 		//이수구분
	private int		credit; 		//학점 
	private String	pname; 			//교수이름
	private String	email; 			// 교수 이메일
	private String	pphone; 		//교수 번호
	private String	dname; 			//학과이름
	private String	lrname;  		//강의실 이름
	private String	mname; 			// 전공이름
	private String	pstaus;			//교수 상태 
	private String	lyear;			//년도
	private int		term;			//학기
	private String	schedule;		//강의 시간
	private String	dividenum;		//강의 구분코드
	private String	book;			//교재
	private String	pid;			//교수 아이디
	
	private String	lnum; 			// 강의번호
	private String	dcode; 			// 이수코드
	private String	mcode; 			// 전공코드
	private int		lcode; 			// 과목코드

	private String	grade; 			//학년
	private int		newlimitcount; 	//정원
	private String	lname; 			//강의 이름
	
	
	private String	w1; 			//주차
	private String	w2;
	private String	w3;
	private String	w4;
	private String	w5;
	private String	w6;
	private String	w7;
	private String	w8; 			// 중간고사 주차
	private String	w9;
	private String	w10;
	private String	w11;
	private String	w12;
	private String	w13;
	private String	w14;
	private String	w15;
	private String	w16; 			// 기말고사 주차
	private String	content; 		// 내용
	private String	opennum; 		// 강의번호
}
