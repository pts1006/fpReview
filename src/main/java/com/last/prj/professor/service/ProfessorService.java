package com.last.prj.professor.service;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.last.prj.students.service.StudentsVO;

public interface ProfessorService {

	@Select("select * from professor")
	List<ProfessorVO> professorSelectList();
	
	ProfessorVO professorSelect(ProfessorVO vo);
	
	int professorInsert(ProfessorVO vo);
	int professorUpdate(ProfessorVO vo);
	int professorDelete(ProfessorVO vo);
	
	List<ProfessorLectureVO> lectureList();
	
	ProfessorVO professorInfo(ProfessorVO vo);
	List<StudentsVO> guidanceStudent(String pid);
}
