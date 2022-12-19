package com.last.prj.professor.service;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class ProfessorVO {

	private String pid;		// 교수 아이디
	private String mcode;	// 전공 코드
	private String pname;	// 교수 이름
	private String pstatus;	// 교수 상태
	private String email;	// 교수 이메일
	private String pphone;	// 교수 연락처
	private String position;// 직책
	private String pbirth;	// 생년월일
	private String pgender;	// 성별
	private int dcode;		// 학과 코드
	
	private String dname;	// 학과 이름
	private String mname;	// 전공 이름
}
