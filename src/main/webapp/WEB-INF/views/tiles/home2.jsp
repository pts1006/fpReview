<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<title>어서 오니라</title>

<sec:authorize access="hasRole('ROLE_STD')">
	<script>
		window.open("showSlide", "수강 신청 기간", "width=750, height=700");
	</script>
</sec:authorize>
<div class = "content-page">
	<img src="${pageContext.request.contextPath }/resources/assets/images/noM_logo5.png" style = "height: 817px; width: ">
</div>

<!-- 
	window.open: 웹브라우저에서 새창을 엶
	var ret = window.open(url, name, specs, replace);

	참고: https://offbyone.tistory.com/312
-->



<!--
	${pageContext.request.contextPath }: 웹에서 상대적인 경로를 나타낸다
	pageContext 객체는 javax.servlet.jsp.PageContext 클래스를 상속해 웹 컨테이너가 JSP 실행시 자동으로 생성해서 제공하는 내장 객체이다.
-->
 
 