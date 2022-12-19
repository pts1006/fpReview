package com.last.prj;

import java.net.InetAddress;
import java.net.UnknownHostException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.last.prj.common.PasswordEncrypt;
import com.last.prj.students.service.StudentsService;
import com.last.prj.students.service.StudentsVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	// 필요한 의존 객체의 "타입"에 해당하는 빈을 찾아 주입한다 (생성자, setter, 필드는 Autowired 사용 가능)
	@Autowired	// 기본값은 true이기 때문에 의존성 주입할 대상을 찾지 못한다면 애플리케이션 구동에 실패함
	private StudentsService studentsService;
	
	@RequestMapping(value = "/home2")
	public String home() {

		try {
			InetAddress inetAddress = InetAddress.getLocalHost();
			System.out.println(inetAddress.getHostAddress());
			System.out.println(InetAddress.getLocalHost());
		} catch (UnknownHostException e) {
			e.printStackTrace();
		}

		return "tiles/home2.tiles";
	}

	// 로그인페이지
	@RequestMapping(value = "/goLogin")
	public String goLogin() {
	
		return "login/login";
	}

	// 비번 찾기 페이지
	@RequestMapping(value = "/forgetPwd")
	public String forgetPwd() {
		
		return "login/forgetPwd";
	}
	
	// 인증 번호 인증
	@RequestMapping(value = "/forgetPwdAut")
	public String forgetPwdAut(
			@RequestParam("email") String email,
			@RequestParam("sname") String sname,
			@RequestParam("sid") String sid,
			Model model)
	{
	
		return "login/forgetPwdAut";
	}
	
	// 이메일 학번 있는지 확인
	@ResponseBody
	@RequestMapping(value = "/forgetChkEmail")
	public StudentsVO chkEmail(
			@RequestParam("email") String email,
			@RequestParam("sid") String sid,
			StudentsVO vo)
	{
		vo.setSid(sid);
		vo.setEmail(email);
		
		return studentsService.chkSidEmail(vo);
	}
	
	// 비밀번호 변경 페이지
	@RequestMapping(value = "/forgetPwdNew")
	public String forgetPwdNew(@RequestParam("sid") String sid, Model model) {
		
		model.addAttribute("sid", sid);
		
		return "login/forgetPwdNew";
	}
	
	// 비밀번호 변경
	@RequestMapping(value = "/forgetNewPwd")
	@ResponseBody
	public String forgetNewPwd(
			@RequestParam("pwd") String pwd, 
			@RequestParam("sid") String sid, 
			StudentsVO vo) 
	{
		vo.setSid(sid);
		vo.setPwd(PasswordEncrypt.bcryTest(pwd));
		
		if (studentsService.studentUpdate(vo) > 0) {
			return "yes";
		} else {
			return "no";
		}
	}
	
	
	// 슬라이드 html (제이쿼리 bxSlider)
	@RequestMapping(value = "/showSlide")
	public String showSlide() {
		
		return "popUp";
	}
}
/*
스프링 컨네이너란?
	자바 객체의 생명 주기를 관리하며, 생성된 자바 객체들에게 추가적인 기능을 제공하는 역할을 함.
	여기서 말하는 자바 객체를 스프링에서는 빈(Bean)이라고 한다.
*/

/*
model.addAttribute("이름", 객체)
	Model 객체에 특정 이름을 지정하여 뷰에서 이름을 이용해 객체를 처리할 수 있게 한다.
	model.addAttribute(객체) 로도 사용 가능한데,
	이럴 경우 객체 명의 맨 앞 글자를 소문자로 처리한 것을 이름으로 해서 사용 가능하다.

	ex) 
	MemberVO member = new MemberVO
	model.addAttribute(member)

	뷰에서 사용하려면 memberVO 라는 이름으로 객체를 사용할 수 있다.
*/


/* https://velog.io/@msriver/Spring-Model-%EA%B0%9D%EC%B2%B4
	String
	: jsp를 이용하는 경우 jsp파일의 이름을 나타냄
	
	void
	: 호출하는 URL과 동일한 이름의 jsp를 나타냄
	
	VO, DTO타입
	: 주로 json타입의 데이터를 만들어서 반환하는 용도
	
	ResponseEntity
	: reponse할때 HTTP헤더 정보와 내용을 가공
	
	Model, ModelAndView
	: Model로 데이터를 반환하거나 화면까지 지정
	
	HttpHeaders
	: 응답에 내용없이 HTTP헤더 메세지만 전달하는 용도로 사용
*/