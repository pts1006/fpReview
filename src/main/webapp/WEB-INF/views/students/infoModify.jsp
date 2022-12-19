<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<title>수정 :: No.M University</title>

<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css"/>
<link rel="stylesheet" href="resources/css/loginCss.css" />
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<!--
제이쿼리 이용을 위함
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
 -->

<style>
	#explanation {
		color: red;
		padding-top: 30px;
		margin-bottom: 0px;
	}
</style>

<div class = "content-page">
	<form name = "frmPwd" method = "POST" action = "studentUpdate">
		<!-- form 태그 안에 위치해야 함 -->
		<sec:csrfInput />
		<div class = "wrapper fadeInDown">
			<div id = "formContent">
				<div class = "fadeIn first">
					<img src = "resources/assets/images/noM_logo2.png" id = "icon" alt = "No.M mark" style = "width: 130px; height: 130px;" />
					<p id = "explanation">비밀번호는 숫자 대소문자 특수문자를 각각 하나씩 포함시킨 6~12자리 글자여야 합니다</p>
				</div>
				<div class = "card-body">
					<div class = "form-group">
						<input type = "password" name = "nPwd" placeholder = "New Password" maxlength="12" onkeyup="keyEvent()">
					</div>
					<div class = "form-group">
						<input type = "password" name = "pwd" placeholder = "Confirm New Password" maxlength="12" onkeyup="keyEvent()">
						<p id = "check"></p>
					</div>
				</div>
				<div class = "card-footer">
					<button type = "button" class = "btn btn-success" id = "updateBtn">수정</button>
					<button type = "button" class = "btn btn-danger">돌아가기</button>
				</div>
			</div>
		</div>
	</form>
</div>

<!-- 
onkeypress, onkeyup, onkeydown 사용법
https://crivius.tistory.com/3
-->

<script>
	var bool = false;
	const idReg = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{6,}/;
	
	document.getElementById('updateBtn').addEventListener('click', studentUpdate);
	document.getElementsByClassName('btn btn-danger')[0].addEventListener('click', goBack);
	
	// 비번 변경
	function studentUpdate() {
		
		if (!idReg.test(frmPwd.nPwd.value)) {
			alert('비밀번호 조건이 맞지 않습니다');
			document.frmPwd.nPwd.focus();
			return;
			
		} else if (bool == false) {
			alert('비밀번호가 일치하지 않습니다');
			document.frmPwd.pwd.focus();
			return;
			
		} else {
			alert('비밀번호가 변경되었습니다');
			document.frmPwd.submit();
		}
	}
	
	// 돌아가기
	function goBack() {
		
		location.href = 'studentInfo';
	}
	
	// 비밀번호 일치 여부 실시간 검사
	// $('#pwd, #nPwd').on('propertychange change keyup paste input', function() {
	// input change keyup paste: input 변화 감지하기
	function keyEvent() {
		
		let nPwd	= document.getElementsByName('nPwd')[0].value;
		let cPwd	= document.getElementsByName('pwd')[0].value;
		let write	= document.getElementById('check');
		
		if (nPwd == '' || cPwd =='') {
			write.innerText = '';
			bool = false;
		}
		
		if (nPwd != '' && cPwd != '') {
			if (nPwd != cPwd) {
				write.innerText = '비밀번호가 일치하지 않습니다';
				write.style.color = 'hotpink';
				bool = false;
			} else {
				write.innerText = '비밀번호가 일치합니다';
				write.style.color = 'skyblue';
				bool = true;
			}
		}
	}
</script>