package com.last.prj.students.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.last.prj.professor.service.ProfessorVO;
import com.last.prj.students.service.StudentsService;
import com.last.prj.students.service.StudentsVO;

public class StudentsServiceImpl implements StudentsService {
	
	@Autowired
	private StudentsService map;

	@Override
	public StudentsVO studentInfo(StudentsVO vo) {
		// 학생 정보 조회
		return map.studentInfo(vo);
	}

	@Override
	public List<StudentsVO> scoreView(StudentsVO vo) {
		// 성적 조회
		return scoreView(vo);
	}

	@Override
	public List<StudentsVO> appliedLecture(StudentsVO vo) {
		// 수강 신청 과목 조회 
		return map.appliedLecture(vo);
	}

	@Override
	public List<StudentsVO> lectureLookUp(StudentsVO vo) {
		// 강의 시간표 조회
		return map.lectureLookUp(vo);
	}

	@Override
	public ProfessorVO professorSelect(ProfessorVO vo) {
		// 교수 정보 조회
		return map.professorSelect(vo);
	}

	@Override
	public StudentsVO selfAuthentication(StudentsVO vo) {
		// 본인 인증
		return map.selfAuthentication(vo);
	}

	@Override
	public int studentUpdate(StudentsVO vo) {
		// 학생 정보 수정
		return map.studentUpdate(vo);
	}

	@Override
	public StudentsVO chkSidEmail(StudentsVO vo) {
		// 비밀번호 변경을 위한 학번 이메일 체크
		return map.chkSidEmail(vo);
	}

	@Override
	public void studentPicUpdate(StudentsVO vo) {
		// 사진 변경
		map.studentPicUpdate(vo);
	}

	@Override
	public List<StudentsVO> proLectureList(StudentsVO vo) {
		// 지도 교수 강의 리스트
		return map.proLectureList(vo);
	}

	@Override
	public List<StudentsVO> whereRoom() {
		// 강의실 정보 불러오기
		return map.whereRoom();
	}

	@Override
	public List<StudentsVO> customDcode(StudentsVO vo) {
		// 학과명을 통해 전공코드 및 전공명 불러오기
		return map.customDcode(vo);
	}

	@Override
	public List<StudentsVO> divisionList(StudentsVO vo) {
		// 
		return map.divisionList(vo);
	}

	@Override
	public List<StudentsVO> confirmEvalCheck(StudentsVO vo) {
		// 체크 여부로 강의 평가 부르기
		return map.confirmEvalCheck(vo);
	}

	@Override
	public StudentsVO achievementView(StudentsVO vo) {
		// 성적 조회(4.5 만점 버전)
		return map.achievementView(vo);
	}

}
