<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
	.slider img {
		margin: 0 auto;
	}
</style>

<title>수강신청 설명 :: No.M University</title>

<!-- bxslider 사용을 위함 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>

<div class = "slider">
	<div>
		<img src = "resources/image/slide/2.png" alt = "슬라이드이미지1">
	</div>
	<div>
		<img src = "resources/image/slide/3.png" alt = "슬라이드이미지2">
	</div>
	<div>
		<img src = "resources/image/slide/4.png" alt = "슬라이드이미지3">
	</div>
	<div>
		<img src = "resources/image/slide/5.png" alt = "슬라이드이미지4">
	</div>
	<div>
		<img src = "resources/image/slide/1.png" alt = "슬라이드이미지5">
	</div>
</div>

<script>
	$(document).ready(function(){
		$('.slider').bxSlider();
	});
</script>

<!--
	bxSlider: 제이쿼리 이미지 슬라이더
	참고: https://offbyone.tistory.com/148
-->