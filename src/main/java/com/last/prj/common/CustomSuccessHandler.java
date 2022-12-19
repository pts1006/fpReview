package com.last.prj.common;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;

public class CustomSuccessHandler extends SimpleUrlAuthenticationSuccessHandler {

	public CustomSuccessHandler() {
		
	}

	public CustomSuccessHandler(String defaultTargetUrl) {
		
		setDefaultTargetUrl(defaultTargetUrl);
	}

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		
		// 쿠키에 인증 토큰을 넣어준다
		super.onAuthenticationSuccess(request, response, authentication);
		
		// 세션ID 등록
		UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		HttpSession session = request.getSession();
		
		session.setAttribute("id", userDetails.getUsername());

		
		/*
		 * UserDetails
		 * Spring Security에서 사용자의 정보를 담는 인터페이스이다.
		 * 
		 * SecurityContextHolder - 누가 인증했는지에 대한 정보들을 저장하고 있음.
		 * SecurityContext - 현재 인증한 user에 대한 정보를 가지고 있음.
		 * Authentication - SecurityContext의 user, 인증 정보를 가지고 있으며, AuthenticationManager에 의해 제공됨.
		 * GrantedAuthority - 인증 주체에게 부여된 권한 (roles, scopes, etc.)
		 * AuthenticationManager - Spring Security의 필터에서 인증을 수행하는 방법을 정의하는 API.
		 * ProviderManager - AuthenticationManager의 구현체.
		 * AuthenticationProvider - 인증 수행을 위해 ProviderManager에 의해 사용됨.
		 * AbstractAuthenticationProcessingFilter - 인증에 사용되는 기본 Filter. 인증의 흐름이 어떻게 이루어 지는지 잘 보여줌.
		 * 
		 * principal - user를 식별하며 '누구?'에 대한 정보 UserDetailsService에 의해 반환된 UserDetails의 instance
		 * authorities - user에게 부여된 권한 (GrantedAuthority참고) ex) ROLE_ADMINISTRATOR, ROLE_HR_SUPERVISIOR, ROLE_USER 등등
		 * credentials - 주체가 올바르다는 것을 증명하는 자격 증명
		 * 				일반적으로 암호이지만 인증 관리자와 관련된 암호일 수 있다
		 * 
		 * 
		 * Authentication(인증): 해당 사용자가 본인이 맞는지를 확인하는 절차
		 * Authorization(인가): 인증된 사용자가 요청한 자원에 접근 가능한지를 결정하는 절차 
		 * Principal(접근 주체): 보호받는 Resource에 접근하는 대상
		 * Credential(비밀번호): Resource에 접근하는 대상의 비밀번호
		 * 출처: https://mangkyu.tistory.com/76 [MangKyu's Diary]
		 */
	}
}
