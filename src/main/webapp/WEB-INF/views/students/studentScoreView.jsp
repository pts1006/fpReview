<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- fmt 태그는 Formatting 태그로 포맷에 관련된 태그(날짜 관련) -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<title>성적 확인 :: No.M University</title>

<style>
	.tui-grid-cell
	.tui-grid-cell-content {
		text-align: center;
	}
	
	.pdfwrap {
		text-align: center;
		width: 1200px;
		margin: 40px auto;
		padding: 30px;
	}
	
	.form-control {
		width: 100px;
		display: inline;
		margin-right: 10px;
	}
	
	#resultBody > th {
		background-color: #f4f4f4;
	}
</style>

<!--
현재 년도 출력
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate var="year" value="${now}" pattern="yyyy" />
<p>Current year: ${year}</p>
<p>Previous year: ${year - 1}</p>
-->

<div class = "content-page">
	<div class = "card-body">
		<div align = "center">
			<button id = "createpdf" class = "btn btn-facebook m-b-10 m-l 10 waves-effect waves-light">pdf 생성</button>
		</div>
		<div id = "pdfwrap" class = "pdfwrap">
			<h2>학생 성적 확인</h2>
			<!-- 현재 년도 출력을 위한 설정 -->
			<c:set var = "now" value = "<%=new java.util.Date() %>" />
			<c:set var = "sysYear">
				<fmt:formatDate value="${now }" pattern = "yyyy"/>
			</c:set>
			<table class = "table table-bordered" style = "vertical-align: middel;">
				<tbody>
					<tr>
						<td colspan = "3">
							<input type = "number" name= "lyear" id = "year" value = "${sysYear }" class = "form-control">년
							<select name = "term" id = "term" class = "form-control">
								<option value = "1">1학기</option>
								<option value = "2">2학기</option>
							</select>
							<button class = "btn btn-facebook m-b-10 m-l-10 waves-effect waves-light" type = "button" onclick = "search()">검색</button>
						</td>
					</tr>
					<tr>
						<th>년도</th>
						<th>학기</th>
						<th>점수</th>
					</tr>
					<tr id = "resultBody">
						<th id = "getLyear">${sc.lyear }</th>
						<th id = "getTerm">${sc.term }</th>
						<c:choose>
							<c:when test = "${sc.evalcheck ne 0 }">
								<th id = "getTotal">${sc.totalscore }</th>
							</c:when>
							<c:otherwise>
								<th id = "getTotal" colspan = "3">강의평가 진행 요망</th>
							</c:otherwise>
						</c:choose>
					</tr>
				</tbody>
			</table>
			<h2>이수 구분별 취득 학점</h2>
			<div id = "grid"></div>
		</div>
	</div>
</div>

<script>
	var grid;
	var scrData = [];
	
	// 그리드
	scrData = [
		<c:forEach items = "${tt}" var = "tt"> {
			lyear 	: '${tt.lyear}',
   			term 	: '${tt.term}',
   			jp 		: '${tt.jp}',
   			js 		: '${tt.js}',
   			nk 		: '${tt.nk}',
   			pk 		: '${tt.pk}',
		}
		<c:if test = '${!empty tt.lyear}'>
		,
		</c:if>
		</c:forEach>
	];
	
	// 그리드를 보여 준다
	grid = new tui.Grid({
		
		el:	document.getElementById('grid'),
		data: scrData,
		columns: [
			{header: '년도', name: 'lyear'},
   			{header: '학기', name: 'term'},
   			{header: '전공필수', name: 'jp'},
   			{header: '전공선택', name: 'js'},
   			{header: '일반교양', name: 'nk'},
   			{header: '선택교양', name: 'pk'},
		]
	});
	
	// 그리드를 그려 놓고 데이터를 넣음
	grid.resetData(scrData);
	
	// pdf 다운로더
	$('#createpdf').click(function () {
		
		html2canvas($('#pdfwrap')[0]).then(function (canvas) {
			
			var filename = '성적' + Date.now() + '.pdf';
			var doc = new jsPDF('p', 'mm', 'a4');
			var imgData = canvas.toDataURL('image/png');
			var imgWidth = 210; 
			var pageHeight = 295; 
			var imgHeight = canvas.height * imgWidth / canvas.width; 
			var heightLeft = imgHeight; 
			var position = 0;
			doc.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
			heightLeft -= pageHeight; 
			
			while (heightLeft >= 0) { 
				  position = heightLeft - imgHeight; doc.addPage();
				  doc.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
				  heightLeft -= pageHeight;
			}
			
			doc.save(filename);
		});
	});
	
	function search() {
		
		const lyear = document.getElementsByName('lyear')[0].value;
		const term	= document.getElementsByName('term')[0].value;
		
		// 내용 지우기. 이거 안 해 주면 밑쪽 if문 안에 append시 우측으로 계속 쌓임
		$('#resultBody').empty();
		
		$.ajax({
			url: 'achievementView',
			data: {
				lyear	: lyear,
				term	: term
			},
			success: function(result) {
				
				if (result.lyear == undefined) {
					$('#resultBody').append(
						$("<th colspan = '3'>" + '기간이 잘못 설정되었습니다' + '</th>')
					);
					
					return false;
				}
				
				if (result != '' && result.evalcheck != 0) {
					$('#resultBody').append(
						$("<th>" + result.lyear + "</th>"),
						$("<th>" + result.term + "</th>"),
						$("<th>" + result.totalscore + "</th>")
					);
					
					return false;
				} else {
					$('#resultBody').append(
						$("<th colspan = '3'>" + '강의평가 진행 요망' + "</th>")
					);
					
					return false;
				}
			},
			error: function(err) {
				console.log(err);
			}
		});
	}
	
</script>