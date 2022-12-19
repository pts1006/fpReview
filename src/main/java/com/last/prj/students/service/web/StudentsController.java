package com.last.prj.students.service.web;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.last.prj.preEnrolment.service.PreEnrolmentService;
import com.last.prj.professor.service.ProfessorService;
import com.last.prj.professor.service.ProfessorVO;
import com.last.prj.students.service.StudentsService;
import com.last.prj.students.service.StudentsVO;
import com.last.prj.studyPlan.service.StudyPlanJoinVO;
import com.last.prj.studyPlan.service.StudyPlanService;

@Controller
public class StudentsController {

	@Autowired
	private StudentsService stService;
	
	@Autowired
	private ProfessorService pfService;
	
	@Autowired
	private PreEnrolmentService preService;
	
	@Autowired
	private StudyPlanService planService;
	
	//////////////////////////////////////

	// 학생 정보 조회 페이지로 이동 및 한 학생 정보 조회
	@RequestMapping(value = "/studentInfo")
	public String studentInfo(StudentsVO svo, Model model, HttpSession session, ProfessorVO pvo) {
		
		svo.setSid((String) session.getAttribute("id"));
		
		// 학생 정보
		model.addAttribute("st", stService.studentInfo(svo));
		
		pvo.setPid(stService.studentInfo(svo).getPid());
		
		// 지도 교수 정보
		model.addAttribute("pro", pfService.professorSelect(pvo));
		
		// 지도 교수 강의 정보
		model.addAttribute("al", stService.proLectureList(svo));
		
		return "students/studentInfo.tiles";
	}
	
	// grid api 값 받아오기
	@ResponseBody
	@RequestMapping(value = "/scoreGetList")
	public Map<String, Object> scoreGetList(
			HttpSession session,
			@RequestBody Map<String, String> map,
			StudentsVO vo)
	{
		
		vo.setSid((String) session.getAttribute("id"));
		
		if (map.get("year") != null) {
			vo.setLyear((String) map.get("year"));
			vo.setTerm(Integer.parseInt(map.get("term")));
		}
		
		/* 시험 점수 리스트 보내주기 */
		Map<String, Object> data	= new HashMap<String, Object>();
		Map<String, Object> datas	= new HashMap<String, Object>();
		
		data.put("result", true);
		datas.put("contents", stService.scoreView(vo));
		data.put("data", datas);
		
		return data;
	}
	
	// 본인 확인 페이지로 이동
	@RequestMapping(value = "/infoConfirmPage")
	public String infoConfirm() {
		
		return "students/infoConfirm";
	}
	
	// 본인 확인 과정 > 학생 정보(비밀번호) 수정 페이지로 이동
	@RequestMapping(value = "/infoConfirm")
	public String confirmingInfo(StudentsVO vo, Model model, HttpSession session) {
		
		String path = null;
		String realID = (String) session.getAttribute("id");
		vo.setSid(realID);
		
		StudentsVO result = stService.selfAuthentication(vo);
		
		Boolean chk = BCrypt.checkpw(vo.getPwd(), result.getPwd());
		
		if (chk == false) {
			path = "students/infoConfirm";
		} else {
			path = "students/infoModify";
		}
		
		return path;
	}
	
	// 성적 조회 페이지
	@RequestMapping(value = "/scoreView")
	public String coreView(StudentsVO vo, Model model, HttpSession session) {
		
		vo.setSid((String) session.getAttribute("id"));
		
		vo.setLyear("2021");
		vo.setTerm(1);
		
		model.addAttribute("sc", stService.achievementView(vo));
		model.addAttribute("tt", stService.divisionList(vo));
		
		return "students/studentScoreView.tiles";
	}
	
	@ResponseBody
	@RequestMapping(value = "/achievementView")
	public StudentsVO achievementView(StudentsVO vo, HttpSession session) {
		
		vo.setSid((String) session.getAttribute("id"));
		
		return stService.achievementView(vo);
	}
	
	// 수강 신청한(했던) 과목 조회
	@RequestMapping(value = "/appliedLecture")
	public String appliedLecture(StudentsVO vo, Model model, HttpSession session) {
		
		vo.setTerm(1);
		vo.setSid((String) session.getAttribute("id"));
		
		model.addAttribute("sts", stService.appliedLecture(vo));
		
		return "students/appliedLecture.tiles";
	}
	
	// 강의 시간표들 조회(수강 신청 과정)
	@RequestMapping(value = "/lectureLookUp")
	public String lectureLookUp(StudentsVO vo, Model model) {
		
		vo.setTerm(1);
		
		model.addAttribute("lec", stService.lectureLookUp(vo));
		model.addAttribute("room", stService.whereRoom());
		model.addAttribute("depart", preService.preDepartments());
		
		return "students/lectureLookUp.tiles";
	}
	
	// 학생 정보 수정
	@RequestMapping(value = "/studentUpdate")
	public String studentUpdate(StudentsVO vo, Model model, HttpSession session, BCryptPasswordEncoder encoder) {
		
		String path = null;
		
		vo.setSid((String) session.getAttribute("id"));
		
		String securePwd = encoder.encode(vo.getPwd());
		vo.setPwd(securePwd);
		
		int result = stService.studentUpdate(vo);
		
		if (result != 0) {
			System.out.println("비밀번호 변경됨");
			model.addAttribute("st", stService.studentInfo(vo));
			path = "students/studentInfo.tiles";
		} else {
			System.out.println("비밀번호 변경 안 됨");
			path = "students/infoModify";
		}
		
		return path;
	}
	
	// 학과명으로 전공코드 및 전공명 조회
	@ResponseBody
	@GetMapping(value = "/customDcode")
	public List<StudentsVO> customDcode(StudentsVO vo) {
		
		return stService.customDcode(vo);
	}
	
	// 강의 계획서 조회
	@ResponseBody
	@GetMapping(value = "/planView")
	public StudyPlanJoinVO planView(StudyPlanJoinVO vo) {
		
		System.out.println("\n" + planService.selectResult(vo) + "\n");
		
		return planService.selectResult(vo);
	}
	
	// 강의 정보 조회
	@ResponseBody
	@RequestMapping(value = "/wantLectureList")
	public Map<String, Object> wantLectureList(
			HttpSession session, 
			@RequestBody Map<String, String> map, 
			StudentsVO vo)
	{
		vo.setSid((String) session.getAttribute("id"));
		vo.setTerm(1);
		
		vo.setMcode(map.get("mcode"));
		vo.setDname(map.get("dname"));
		vo.setDivision(map.get("division"));
		vo.setLocation(map.get("locataion"));
		vo.setTimetable(map.get("timetable"));
		
		if (map.get("grade") != null) {
			vo.setGrade(Integer.parseInt(map.get("grade")));
		}
		
		/* 리스트 보내주기 */
		Map<String, Object> data	= new HashMap<String, Object>();
		Map<String, Object> datas	= new HashMap<String, Object>();
		
		data.put("result", true);
		datas.put("contents", stService.lectureLookUp(vo));
		data.put("data", datas);
		
		return data;
	}
	
	@RequestMapping(value = "/imageUpload")
	public String imgUpload(
			@RequestParam("pic") MultipartFile file,
			Model model,
			HttpSession session,
			StudentsVO vo)
	throws IllegalStateException, IOException
	{
		String path = session.getServletContext().getRealPath("resources/image/students");
		String sid = (String) session.getAttribute("id");
		vo.setSid(sid);
		vo = stService.studentInfo(vo);
		
		if (vo.getPicture() != null && !vo.getPicture().isEmpty()) {
			File orgFile = new File(path + File.separator + vo.getPicture());
			orgFile.delete();
			System.out.println("파일 삭제 성공");
		}
		
		if (!file.getOriginalFilename().isEmpty()) {
			file.transferTo(new File(path, file.getOriginalFilename()));
			System.out.println("경로 ====" + path);
			System.out.println("파일 이름 ===" + file.getOriginalFilename());
			System.out.println("성공");
			
			vo.setPicture(file.getOriginalFilename());
			stService.studentPicUpdate(vo);
		}
		
		return "redirect:studentInfo";
	}
}

/* 각종 정리 */

/*

Response: 반응
Request: 요청

@ResponseBody: 자바 객체를 HTTP 요청 몸체로 변환
	리턴값을 쓸 때 매핑 URL 이름이 아니라, 그 자체의 String이 결과가 된다.
	즉, 이 어노테이션을 쓰면 return "/result"는 컨트롤러에서
	/result라는 url을 찾으라는 의미가 아니라,
	"result"라는 String을 반환하라는 것이다. 
	즉, 내가 어떤 상황으로 인해 url을 통해 뷰로 가는 게 아니라,
	String 자체를 반환하고 싶을 때 쓰면 된다.

@RequestBody: HTTP 요청 몸체를 자바 객체로 변환
	ajax 통신과 같은 경우에 쓴다
	ajax와 통신할 때
		var param = {"memberId": memberId, "memberPass": inputPass}와 같은
		파라미터를 컨트롤러에 보내면
		이 어노테이션을 통해 자바 객체로 바꿔 쓸 수 있다.
	MemberVO와 알아서 자동으로 바인딩된다는 의미
	즉, ajax에서 파라미터를 받아올 때 컨토를러에서 이 어노테이션을 쓰면 된다.
	
---------------------

@GetMapping (메소드에만 적용)
: GET 요청 방식의 API를 만들때,
	@RequestMapping(method = RequestMethod.Get ...)방식과 같은 동일한 효과. (클래스 레벨에서 사용)	

@PoastMapping

@RequestParam
: 단일 파라미터를 전달 받을 때 사용하는 어노테이션
	jsp로부터 전달된 key를 작성
	ex)
	@RequestParam("가져올 데이터의 이름") [데이터타입] [가져온 데이터를 담을 변수]
굳이 안 적어도 된다. 평범하게 String처럼 타입을 선언만 하여도 전달 받을 수 있다.

*/