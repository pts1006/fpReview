package com.last.prj.preEnrolment.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.last.prj.preEnrolment.service.PreEnrolmentService;
import com.last.prj.preEnrolment.service.PreEnrolmentVO;
import com.last.prj.students.service.StudentsVO;

public class PreEnrolmentServiceImpl implements PreEnrolmentService {

	@Autowired
	PreEnrolmentService map;
	
	@Override
	public StudentsVO preStudentSelect(String sid) {
		// TODO Auto-generated method stub
		return map.preStudentSelect(sid);
	}

	@Override
	public List<PreEnrolmentVO> preLectureList(StudentsVO vo) {
		// TODO Auto-generated method stub
		return map.preLectureList(vo);
	}

	@Override
	public List<PreEnrolmentVO> preDepartments() {
		// TODO Auto-generated method stub
		return map.preDepartments();
	}

	@Override
	public List<PreEnrolmentVO> getMajorList(PreEnrolmentVO vo) {
		// TODO Auto-generated method stub
		return map.getMajorList(vo);
	}

	@Override
	public List<PreEnrolmentVO> enrolmentPackage(String sid) {
		// TODO Auto-generated method stub
		return map.enrolmentPackage(sid);
	}

	@Override
	public int preEnrolmentLimitCheck(String sid) {
		// TODO Auto-generated method stub
		return map.preEnrolmentLimitCheck(sid);
	}

	@Override
	public int preEnrolmentInsert(List<PreEnrolmentVO> vo) {
		// TODO Auto-generated method stub
		int count = 0;
		
		for (int i = 0; i < vo.size(); i++) {
			map.preEnrolmentInsert((List<PreEnrolmentVO>) vo.get(i));
			count++;
		}
		
		return count;
	}

	@Override
	public int preEnrolmentDelete(List<PreEnrolmentVO> vo) {
		// TODO Auto-generated method stub
		int count = 0;
		
		for (int i = 0; i < vo.size(); i++) {
			map.preEnrolmentDelete((List<PreEnrolmentVO>) vo.get(i));
			count++;
		}
		
		return count;
	}

}
