package com.last.prj.professor.service;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class ProfessorLectureVO {

	private String	division;		//이수 구분
	private int 	credit;			// 학점
	private String	pName;			// 교수 이름
	private String	email;			// 교수 이메일
	private String	pPhone;			// 교수 연락처
	private String	dName;			// 학과 이름
	private String 	lrName;			// 강의실 이름
	private String	mName;			// 전공 이름
	private String	pStauts;		// 교수 상태
	private String	lYear;			// 년도
	private String	term;			// 학기
	private String	schedule;		// 강의 시간
	private String	dividenum;		// 강의 구분 코드
	private String	book;			// 교제
	private String	pid;			// 교수 아이디
	
	private String	lNum;			// 강의 번호
	private String	dCode;			// 이수 코드
	private String	mCode;			// 전공 코드
	private int		lCode;			// 과목 코드
	
	private String	grade;			// 학년
	private int		newlimitCount;	// 정원
	private String	lName;			// 강의 이름
	
	private String	w1;				// 주차
	private String	w2;
	private String	w3;
	private String	w4;
	private String	w5;
	private String	w6;
	private String	w7;
	private String	w8;				// 중간고사 주차
	private String	w9;
	private String	w10;
	private String	w11;
	private String	w12;
	private String	w13;
	private String	w14;
	private String	w15;
	private String	w16;			// 기말고사 주차
	private String	content;		// 내용
	private String	opennum;		// 강의 번호
	
}
