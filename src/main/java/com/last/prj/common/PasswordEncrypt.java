package com.last.prj.common;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class PasswordEncrypt {

	public static String bcryTest(String pwd) {
		
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		String result = encoder.encode(pwd);	// encode(): pwd를 암호화하고 result에 담는다
		
		System.out.println(result);

		/* 복호화
		 * if (encoder.matches(pwd, result)) {
		 * 
		 * }
		 */
		
		return result;
	}
}
/*
BCryptPasswordEncoder?
	스프링 시큐리티 프레임워크에서 제공하는 클래스 중 하나로, 비밀번호를 암호화하는 데 사용할 수 있는 메서드를 가진 클래스
	
		스프링 시큐리티란,
		자바 서버 개발을 위해 필요한 인증, 권한 부여 및 기타 보안 기능을 제공하는 프레임워크(클래스와 인터페이스 모임).
		
	- BCryptPasswordEncoder는
		BCrypt 해싱 함수를 사용해서 비밀번호를 인코딩해주는 메서드와
		사용자에 의해 제출된 비밀번호와 저장소에 저장되어 있는 비밀번호의 일치 여부를 확인해주는 메서드를 제공
	- PasswordEncoder 인터페이스를 구현한 클래스
	- 생성자의 인자 값(verstion, strength, SecureRandom instance)을 통해서 해시의 강도를 조절할 수 있다.
*/

/*
비밀번호 복호화
	DB에 저장되는 암호키와 로그인 혹은 입력 수정 삭제 작업 요청을 할 때 입력한 비밀번호를 똑같은 형태로 암호화하여
	암호화된 두 값을 비교하여 일치하면 로그인을 성공시켜주지만 그것은 HashCode를 사용하여 비교할 때이며
	Spring Security에서는 이 방법이 먹히지 않는다
	
	Spring Security는 매번 랜덤키를 부여하기 때문에 따로 디코딩 작업을 추가해야 한다.
	
	matches()라는 메서드를 사용하여
	입력받은 비밀번호를 굳이 다시 암호화 하지 않고
	내부적으로 이미 저장되어 있는 security방식의 암호화 키를 복호화하여 비교해주고
	일치하면 true 일치하지 않는다면 false를 때려 확인 결과를 논리값으로 반환해 준다.
*/