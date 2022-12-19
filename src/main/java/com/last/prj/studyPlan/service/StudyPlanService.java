package com.last.prj.studyPlan.service;

import java.util.List;

public interface StudyPlanService {

	List<StudyPlanJoinVO> studyPlanList(StudyPlanJoinVO vo);	// 강의 계획서 내용
	
	int studyplanInsert(StudyPlanJoinVO vo);			// 강의 계획서 등록하기
	int studyplanUpdate(StudyPlanJoinVO vo);			// 강의 계획서 수정하기
	
	StudyPlanJoinVO selectResult(StudyPlanJoinVO vo);	// 값 하나 받아오기
	StudyPlanJoinVO readOnly(StudyPlanJoinVO vo);		// 강의 계획서 읽기 전용 (학생)
	
	List<StudyPlanJoinVO> Lname(StudyPlanJoinVO vo);	// 강의명 select
	List<StudyPlanJoinVO> ySelect(StudyPlanJoinVO vo);	// 강의 년도 selct
}
