package com.last.prj.preEnrolment.service;

import java.util.List;

import com.last.prj.students.service.StudentsVO;

public interface PreEnrolmentService {

	StudentsVO preStudentSelect(String sid);
	List<PreEnrolmentVO> preLectureList(StudentsVO vo);
	List<PreEnrolmentVO> preDepartments();
	List<PreEnrolmentVO> getMajorList(PreEnrolmentVO vo);
	List<PreEnrolmentVO> enrolmentPackage(String sid);
	int preEnrolmentLimitCheck(String sid);
	int preEnrolmentInsert(List<PreEnrolmentVO> vo);
	int preEnrolmentDelete(List<PreEnrolmentVO> vo);
}
