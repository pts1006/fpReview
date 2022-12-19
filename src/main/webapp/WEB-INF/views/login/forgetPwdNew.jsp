<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri = "http://www.springframework.org/security/tags" prefix="sec" %>

<title>비밀번호 변경 페이지</title>

<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css"/>
<link rel="stylesheet" href="resources/css/loginCss.css" />
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<div class = "wrapper fadeInDown">
	<div id = "formContent">
		<div class = "fadeIn first">
			<img src = "resuorces/assets/images/noM_logo2.png" id = "icon" alt = "No.M mark" style = "width: 130px; height: 130px;" />
		</div>
	</div>
	<div class = "card-body">
		<div class = "form-group">
			<label for = "email-for-pass">변경하실 비밀번호를 입력해 주세요</label>
			<input class = "form-control" name = "pwd" type = "password" id = "pwd" placeholder = "비밀번호" maxlength = "15" />
		</div>
		<div class = "form-group">
			<label for = "email-for-pass">변경하실 비밀번호를 다시 입력해 주세요 (확인)</label>
			<input class = "form-control" name = "pwdChk" type = "password" id = "pwdChk" placeholder = "비밀번호 확인" maxlength = "15" />
		</div>
	</div>
	<div class = "card-footer">
		<button class = "btn btn-success" type = "button" onclick = "newPwdCheck('${sid}')">비밀번호 변경하기</button>
		<button class = "btn btn-success" type = "button" onclick = "location.href = 'goLogin'">돌아가기</button>
	</div>
</div>
<script src="resources/js/forgetPwd.min.js"></script>