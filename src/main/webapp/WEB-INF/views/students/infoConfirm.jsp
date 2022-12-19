<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<title>수정 :: No.M University</title>

<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css"/>
<link rel="stylesheet" href="resources/css/loginCss.css" />
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<div class = "content-page">
	<div class = "wrapper fadeInDown">
		<div id = "formContent">
			<div class = "fadeIn first">
				<img src = "resources/assets/images/noM_logo2.png" alt = "No.M mark" style = "width: 130px; height: 130px;" />
				<!-- <img> 태그의 alt 속성은 이미지를 보여줄 수 없을 때 해당 이미지를 대체할 텍스트를 명시 -->
			</div>
			<div class = "fadeIn second" style = "margin-top: 20px; margin-botton: 20px;">
				본인 확인을 위해 학번과 비밀번호를 입력해 주세요
			</div>
			<form action="infoConfirm" name = "frm" method = "post" onsubmit = "return confirmUser()">
				<!-- JavaScript의 onsubmit 이벤트를 이용하면 폼의 값을 전송하기 전에 어떤 작업을 하게 할 수 있음 -->
				<sec:csrfInput/>
				<input type = "text" class = "fadeIn third" name = "sid" placeholder = "ID" maxlength = "20" />
				<input type = "password" class = "fadeIn fourth" name = "pwd" placeholder = "Password" maxlength = "20" />
				<input type = "submit" class = "fadeIn fourth" value = "확인" />
			</form>
		</div>
	</div>
</div>

<script>
	function confirmUser() {
		
		let id	= document.getElementsByName('sid')[0].value;
		let pwd	= document.getElementsByName('pwd')[0].value;
		
		if (id == '' || id == null) {
			alert('학번을 입력해 주세요');
			document.frm.sid.focus();
			return false;
		}
		
		if (pwd == '' || pwd == null) {
			alert('비밀번호를 입력해 주세요');
			document.frm.pwd.focus();
			return false;
		}
	}
</script>