package com.last.prj.professor.service.web;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.last.prj.professor.service.ProfessorLectureVO;
import com.last.prj.professor.service.ProfessorService;
import com.last.prj.professor.service.ProfessorVO;

@Controller
public class ProfessorController {

	@Autowired
	ProfessorService service;
	
	// 내 강의 리스트 출력하기
	@RequestMapping("lectureList")
	public String studyPlanList(Model model, ProfessorLectureVO vo, HttpSession session) {
		
		vo.setPid((String) session.getAttribute("id"));
		System.out.println(vo.getPid());
		
		model.addAttribute("spList", service.lectureList());
		
		return "professor/lecturelist.tiles";
	}
	
	@RequestMapping("professorInfo")
	public String professorInfo(Model model, HttpSession session, ProfessorVO vo) {
		
		String pid = (String) session.getAttribute("id");
		vo.setPid(pid);
		
		model.addAttribute("pro", service.professorInfo(vo));
		model.addAttribute("guide", service.guidanceStudent(pid));
		
		return "professor/professorInfo.tiles";
	}
}
