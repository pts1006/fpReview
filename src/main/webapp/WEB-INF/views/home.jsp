<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<title>Home</title>
<h1>${id }</h1>
<div>
	<form action = "uploadTest" method = "post" enctype = "multipart/form-data">
		<input type = "file" name= "file"><br>
		<input type = "file" name= "file2"><br>
		이름: <input type = "text" name = "name"><br>
		나이: <input type = "text" name = "age"><br>
		성별: <input type = "text" name = "gender"><br>
		<input type = "submit" value = "업로드">		
	</form>
	<sec:authorize access = "isAuthenticated()">
		로그인 유저 ${id }
		<form action = "logout" method = "post">
			<sec:csrfInput/>
			<button>로그아웃</button>
		</form>
	</sec:authorize>
</div>
<!--
enctype
	<form> 태그의 enctype 속성은 폼 데이터(form data)가 서버로 제출될 때 해당 데이터가 인코딩되는 방법을 명시
	이 속성은 <form> 요소의 method 속성값이 “post”인 경우에만 사용 가능
	
	모든 문자를 인코딩하지 않음을 명시함.
	이 방식은 <form> 요소가 파일이나 이미지를 서버로 전송할 때 주로 사용함.
	
	
	method는 전송 방식,
	action은 전송 목적지,
	enctype은 전송되는 데이터 형식을 설정한다.

 -->