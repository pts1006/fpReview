package com.last.prj.professor.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.last.prj.professor.service.ProfessorLectureVO;
import com.last.prj.professor.service.ProfessorService;
import com.last.prj.professor.service.ProfessorVO;
import com.last.prj.students.service.StudentsVO;

public class ProfessorServiceImpl implements ProfessorService {

	@Autowired
	ProfessorService map;
	
	@Override
	public List<ProfessorVO> professorSelectList() {
		// 교수 목록
		return map.professorSelectList();
	}

	@Override
	public ProfessorVO professorSelect(ProfessorVO vo) {
		// 교수 하나 선택
		return map.professorSelect(vo);
	}

	@Override
	public int professorInsert(ProfessorVO vo) {
		// 
		return 0;
	}

	@Override
	public int professorUpdate(ProfessorVO vo) {
		// 교수 정보 수정
		return 0;
	}

	@Override
	public int professorDelete(ProfessorVO vo) {
		// 교수 삭제
		return 0;
	}

	@Override
	public List<ProfessorLectureVO> lectureList() {
		// 강의 리스트 불러 오기
		return map.lectureList();
	}

	@Override
	public ProfessorVO professorInfo(ProfessorVO vo) {
		// 교수 정보 보기
		return map.professorInfo(vo);
	}

	@Override
	public List<StudentsVO> guidanceStudent(String pid) {
		// 지도 학생
		return map.guidanceStudent(pid);
	}

}
