package com.last.prj.preEnrolment.service;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PreEnrolmentVO {

	private String	sid;		// 학번
	private String	opennum;	// 강의 개설 번호
	private String	retake;		// 재수강 여부
	
	private String	lnum;		// 강의번호
	private String	lname;		// 강의명
	private int		credit;		// 학점
	private String	division;	// 이수 구분
	private String	timetable;	// 강의 시간 강의명
	private int		grade;		// 학년
	
	private String	mcode;		// 전공 번호
	private String	dcode;		// 학과 번호
	private String	mname;		// 전공명
	private String	dname;		// 학과명
	
	private String	time;
}
