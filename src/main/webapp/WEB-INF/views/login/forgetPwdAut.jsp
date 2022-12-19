<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<title>뭐지</title>

<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css"/>
<link rel="stylesheet" href="resources/css/loginCss.css" />
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<div class="wrapper fadeInDown">
	<div id="formContent">
		<img src = "resources/assets/images/noM_logo2.png" id = "icon" alt = "No.M mark" style = "width: 130px; height: 130px;" />
	</div>
	<div class = "forgot">
		<h2>비밀번호 재설정</h2>
	</div>
	<form class = "card mt-4" action = "forgetPwdNew" method = "post" id = "forgetPwdNew">
		<div class = "card-body">
			<div class = "form-group">
				<label for = "email-for-pass">인증번호를 입력해 주세요</label>
				<input class = "form-control" name = "authNum" type = "text" id = "authNum" placeholder = "인증번호를 입력하세요" maxlength = "6" />
			</div>
			<input type = "hidden" name = "sid" value ="${sid }" />
		</div>
		<div class = "card-footer">
			<button class = "btn btn-success" type = "button" onclick = "authCheck('${num}')">인증하기</button>
			<button class = "btn btn-success" type = "button" onclick = "location.href = 'goLogin'">돌아가기</button>
		</div>
	</form>
</div>
<script src = "resources/js/forgetPwd.min.js"></script>