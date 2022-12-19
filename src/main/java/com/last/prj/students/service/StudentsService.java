package com.last.prj.students.service;

import java.util.List;

import com.last.prj.professor.service.ProfessorVO;

public interface StudentsService {

	StudentsVO studentInfo(StudentsVO vo);				// 학적 조회
	List<StudentsVO> scoreView(StudentsVO vo);			// 성적 조회
	List<StudentsVO> appliedLecture(StudentsVO vo);		// 신청한 강의 조회
	List<StudentsVO> lectureLookUp(StudentsVO vo);		// 강의 시간표들 조회
	
	ProfessorVO professorSelect(ProfessorVO vo);		// 교수 정보 조회
	
	StudentsVO selfAuthentication(StudentsVO vo);		// 본인 인증
	int studentUpdate(StudentsVO vo);					// 학적 수정
	StudentsVO chkSidEmail(StudentsVO vo);				// 비밀번호 변경 학번 이메일 체크
	void studentPicUpdate(StudentsVO vo);				// 사진 수정
	List<StudentsVO> proLectureList(StudentsVO vo);		// 지도 교수 강의 정보
	
	List<StudentsVO> whereRoom();						// 강의실 정보 불러오기
	List<StudentsVO> customDcode(StudentsVO vo);		// 학과명을 통해 전공코드 및 전공명 불러오기
	
	List<StudentsVO> divisionList(StudentsVO vo);		// 영구 성적 조회	

	List<StudentsVO> confirmEvalCheck(StudentsVO vo);	// 체크 여부로 강의 평가 부르기
	StudentsVO achievementView(StudentsVO vo);			// 성적조회(4.5 만점 버전)
}
