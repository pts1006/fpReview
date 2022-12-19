<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 
해결 과제
	1. 모달창
		- 스크롤 내린 뒤 닫고 새 모달창을 열면 닫은 시점에서 열림
			~> 모달창 스크롤 위치 초기화 ( 포기 )
	
	2. 그리드
		- 강의 평가 버튼
	
	3. 검색창
		- css 통일 문제 ( 지노 씨가 해 준다 하셨음 )
 -->
<style>
	.tui-grid-cell .tui-grid-cell-content {
		text-align: center;
	}

	/* 교수 정보 모달 */
	#my_offer {
		display: none;
		width: 80%;
		height: 30%;
		padding: 30px 60px;
		background-color: #fefefe;
		border: 1px solid #888;
		border-radius: 3px;
	}

	#my_offer .modal_close_btn, 
	#modal_offer .modal_close_btn, 
	#modal_evaluation .modal_close_btn {
		position: absolute;
		top: 10px;
		right: 10px;
	}

	.modal-body {
		font-size: 10pt;
	}
		
	td[data-column-name="lnum"] {
		color : skyblue;
	}
	
	td[data-column-name="pname"] {
		color : skyblue;
	}
	
	td[data-column-name="lname"] {
		color : skyblue;
	}
	
	/********************************************************************/
	/* 강의 계획서 모달에 쓰이는 스타일 */
	.container23 {
		width: 1200px;
		margin: 40px;
		padding: 30px;
	}
	
	.longform-control {
		height: 30px;
		width: 100%;
	    font-size: 14px;
	    display: block;
	    padding: .375rem .75rem;
	    font-size: 1rem;
	    font-weight: 400;
	    line-height: 1.5;
	    color: #495057;
	    background-color: #fff;
	    background-clip: padding-box;
	    border: 1px solid #ced4da;
	    border-radius: .25rem;
	    transition: border-color .15s ease-in-out,box-shadow .15s ease-in-out;
	}
	
	textarea {
		word-break: break-all;
	}
	
	.form-control:disabled, .form-control[readonly] {
		background-color: white;
	}

	/* 모달창 강의 계획서 */
	#modal_offer {
		/* overflow-y: initial !important; */
		display: none;
		width: 80%;
		height: 80%;
		padding: 30px 60px;
		background-color: #fefefe;
		border: 1px solid #888;
		border-radius: 3px;
	}
	
	/* 모달창 강의 평가 */
	#modal_evaluation {
		/* overflow-y: initial !important; */
	 	display: none;
		width: 80%;
		height: 50%;
		padding: 30px 60px;
		background-color: #fefefe;
		border: 1px solid #888;
		border-radius: 3px;
	}
	
	/* 모달 스크롤 */
	#modal_offer .modal-body,
	 #modal_evaluation .modal-body {
	    height: 100%;
	    overflow-y: auto;
	}
	
	/* 그리드 클릭 이벤트 방해하고 있던 것 */
	.tui-grid-cell-header.tui-grid-cell-selected {
		background-color: unset;
	}
	
	.tui-grid-layer-selection {
		display: none;	
	}
	input[type="radio"] {
		margin-left: 20px
	}
</style>

<title>강의 검색 :: No.M University</title>

<!-- 본체 -->
<div class="content-page">
	<div class="card-body">
		<div align="center">
		<h2>강의 조회</h2>
			<table class="table table-bordered" style="vertical-align: middle;">
				<tbody>
					<tr>
						<th>학과</th>		<td><select name="dname" id="dname" class="form-control">
												<option value="">전체</option>
												<c:forEach items="${depart }" var="depart">
													<option value="${depart.dname }">${depart.dname }</option>
												</c:forEach>
											</select>
										</td>
						<th>전공</th>		<td><select name="mcode" id="mcode" class="form-control">
												<option value="">전체</option>
											</select>
										</td>
												<th>요일</th>		<td><select name="day" class="form-control">
												<option value="">전체</option>
												<option value="월">월</option>
												<option value="화">화</option>
												<option value="수">수</option>
												<option value="목">목</option>
												<option value="금">금</option>
											</select>
										</td>
						<th>교시</th>		<td><select name="time" class="form-control">
												<option value="">전체</option>
												<option value="1">1교시</option>
												<option value="2">2교시</option>
												<option value="3">3교시</option>
												<option value="4">4교시</option>
												<option value="5">5교시</option>
												<option value="6">6교시</option>
												<option value="7">7교시</option>
												<option value="8">8교시</option>
												<option value="9">9교시</option>
											</select>
										</td>
					</tr>
					<tr>
						<th>강의실</th>		<td><select name="location" class="form-control">
												<option value="">전체</option>
												<c:forEach items="${room }" var="room">
													<option value="${room.location }">${room.location }</option>
												</c:forEach>
											</select>
										</td>
						<th>학년</th>		<td><select name="grade" class="form-control">
												<option value="">전체</option>
												<option value="1">1</option>
												<option value="2">2</option>
												<option value="3">3</option>
												<option value="4">4</option>
											</select>
										</td>
						<th>구분</th>		<td colspan="2">
												<input type="radio" id= "all" name="division" value="" checked />
													<label for ="all">전체</label>
												<input type="radio" id="gyo" name="division" value="교양" />
													<label for ="gyo">교양</label>
												<input type="radio" id="jeon" name="division" value="전공" />
													<label for ="jeon">전공</label>
												<input type="radio" id="dae" name="division" value="대학원" /> <!-- 없음 -->
													<label for ="dae">대학원</label>
										</td>
						<td><button id="searchBtn" class="btn btn-facebook m-b-10 m-l-10 waves-effect waves-light">검색</button></td>
					</tr>
				</tbody>
			</table>
			<br><br>
			<div id="grid"></div>
		</div>
	</div>
<!-- 본체 끝 -->

<!-- 모달 뷰 _ 교수 정보 보기 -->
<div id="my_offer" align="center">
	<a class="modal_close_btn">닫기</a>
	<div class="modal-body">
		<h2>교수 정보</h2>
		<table class="table table-bordered" id="professorInfo" border="1">
			<thead>
			<tr>
				<th>교수</th>
				<th>연락처</th>
				<th>이메일</th>
			</tr>
			</thead>
			<tbody></tbody>
		</table>
	</div>
</div>
<!-- 모달 끝 -->


<!-- 모달 뷰2 _ 강의 계획서 보기 -->
<div class="modal_offer" id="modal_offer" align="center">
	<a class="modal_close_btn">닫기</a>
	<div class="modal-body">
		<button id="createpdf" class="btn btn-facebook m-b-10 m-l-10 waves-effect waves-light" style="float: right">PDF 생성</button>
		
		<div class="container23" id="pdfwrap">
			<h1 align="center" class="ns23">강 의 계 획 서</h1>
			<p id="plan_term"></p>
			<div class="innercontainer23">
				<table class="table table-bordered">
					<tbody>
						<tr>
							<td><b>교과목</b></td>		<td><input type="text" name="plan_lname" class="form-control" readonly></td>
							<td><b>교수명</b></td>		<td><input type="text" name="plan_pname" class="form-control" readonly></td>
							<td><b>이메일</b></td>		<td><input type="text" name="plan_email" class="form-control" readonly></td>
							<td><b>연락처</b></td>		<td><input type="text" name="plan_pphone" class="form-control" readonly></td>
						</tr>
					</tbody>
				</table>

				<table class="table table-bordered">
					<tbody>
						<tr>
							<td><b>수강학과</b></td>		<td><input type="text" class="form-control" name="plan_mname" readonly></td>
							<td><b>수강학부</b></td>		<td><input type="text" class="form-control" name="plan_dname" readonly></td>
							<td><b>강의실</b></td>		<td><input type="text" class="form-control" name="plan_lrname" readonly></td>
							<td><b>교재</b></td> 			<td><input type="text" class="form-control" name="plan_book" readonly></td>
						</tr>
						<tr>
							<td><b>강의코드</b></td> 		<td colspan="3"><input type="text" class="longform-control" name="plan_lnum" readonly></td>
							<td><b>강의시간</b></td>		<td colspan="3"><input type="text" class="longform-control" name="plan_schedule" readonly>
						</tr>
						<tr>
							<td><b>학점</b></td>			<td><input type="text" name="plan_credit"	class="form-control" readonly></td>
							<td><b>대상학년</b></td> 		<td><input type="text" name="plan_grade" class="form-control" readonly></td>
							<td><b>정원</b></td> 			<td><input type="text" name="plan_newlimitcount" class="form-control" readonly></td>
							<td><b>이수구분</b></td> 		<td><input type="text" name="plan_division" class="form-control" readonly></td>
						</tr>
					</tbody>
				</table>
				
				<div class="col-sm-6 col-md-4 col-lg-3">
					<h5><i class="ion-compose"></i>과목개요</h5>
				</div>
				
				<table class="table table-bordered">
					<thead>
						<tr>
							<td><b>1. 교과목 개요</b></td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><textarea name="plan_content" id="limit" rows="3" required class="form-control" style="resize: none; width: 100%;" readonly></textarea></td>
						</tr>
					</tbody>
				</table>
				<br />
				<table class="table table-bordered">
					<thead>
						<tr>
							<td><b style = "font-size:14px">2. 주차별 강의 진행 과정</b><span style="color: #aaa;"> (최대 300자) </span></td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td style="text-align: left">1주차 강의</td>
						</tr>
						<tr>
							<td><textarea name="w1" id="limit" rows="3" class="form-control" style="resize: none; width: 100%;" readonly></textarea></td>
						</tr>
						<tr>
								<td style="text-align: left">2주차 강의</td>
						</tr>
						<tr>
							<td><textarea name="w2" id="limit" rows="3" class="form-control" style="resize: none; width: 100%;" readonly></textarea></td>
						</tr>
						<tr>
							<td style="text-align: left">3주차 강의</td>
						</tr>
						<tr>
							<td><textarea name="w3" id="limit" rows="3" class="form-control" style="resize: none; width: 100%;" readonly></textarea></td>
						</tr>
						<tr>
							<td style="text-align: left">4주차 강의</td>
						</tr>
						<tr>
							<td><textarea name="w4" id="limit" rows="3" class="form-control" style="resize: none; width: 100%;" readonly></textarea></td>
						</tr>
						<tr>
							<td style="text-align: left">5주차 강의</td>
						</tr>
						<tr>
							<td><textarea name="w5" id="limit" rows="3" class="form-control" style="resize: none; width: 100%;" readonly></textarea></td>
						</tr>
						<tr>
							<td style="text-align: left">6주차 강의</td>
						</tr>
						<tr>
							<td><textarea name="w6" id="limit" rows="3"	class="form-control" style="resize: none; width: 100%;" readonly></textarea></td>
						</tr>
						<tr>
							<td style="text-align: left">7주차 강의</td>
						</tr>
						<tr>
							<td><textarea name="w7" id="limit" rows="3" class="form-control" style="resize: none; width: 100%;" readonly></textarea></td>
						</tr>
						<tr>
							<td style="text-align: left">8주차 강의</td>
						</tr>

						<tr>
							<td><textarea name="w8" id="limit" rows="3" class="form-control" style="resize: none; width: 100%;" readonly></textarea></td>
						</tr>
					</table>
					<br><br><br><br><br>
					<table class="table table-bordered">
					<tbody>
						<tr>
							<td style="text-align: left">9주차 강의</td>
						</tr>
						<tr>
							<td><textarea name="w9" rows="3" id="limit"	class="form-control" style="resize: none; width: 100%;" readonly></textarea></td>
						</tr>
						<tr>
							<td style="text-align: left">10주차 강의</td>
						</tr>
						<tr>
							<td><textarea name="w10" rows="3" id="limit" class="form-control" style="resize: none; width: 100%;" readonly></textarea></td>
						</tr>
						<tr>
							<td style="text-align: left">11주차 강의</td>
						</tr>
						<tr>
							<td><textarea name="w11" rows="3" id="limit" class="form-control" style="resize: none; width: 100%;" readonly></textarea></td>
						</tr>
						<tr>
							<td style="text-align: left">12주차 강의</td>
						</tr>
						<tr>
							<td><textarea name="w12" rows="3" id="limit" class="form-control" style="resize: none; width: 100%;" readonly></textarea></td>
						</tr>
						<tr>
							<td style="text-align: left">13주차 강의</td>
						</tr>
						<tr>
							<td><textarea name="w13" rows="3" id="limit" class="form-control" style="resize: none; width: 100%;" readonly></textarea></td>
						</tr>
						<tr>
							<td style="text-align: left">14주차 강의</td>
						</tr>
						<tr>
							<td><textarea name="w14" rows="3" id="limit" class="form-control" style="resize: none; width: 100%;" readonly></textarea></td>
						</tr>
						<tr>
							<td style="text-align: left">15주차 강의</td>
						</tr>

						<tr>
							<td><textarea name="w15" rows="3" id="limit" class="form-control" style="resize: none; width: 100%;" readonly></textarea></td>
						</tr>
						<tr>
							<td style="text-align: left">16주차 강의</td>
						</tr>
						<tr height="20">
							<td><textarea name="w16" id="limit" rows="3" class="form-control" style="resize: none; width: 100%;" readonly>}</textarea></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>

<!-- 모달3 _ 강의 평가 보기 -->
<div id="modal_evaluation" align="center">
	<a class="modal_close_btn">닫기</a>
	<div class="modal-body">
		<h1>강의 만족도 결과 공개</h1>
		<table class = "table table-bordered" border="1" style = "align: center">
			<thead>
			<tr>
				<th>년도/학기</th> 
				<th>강의번호</th>
				<th>강의 명</th>
				<th>담당교수</th>
				<th>평점</th>
			</tr>
			</thead>
			<tbody id = "resultBody">
			</tbody>
		</table>
	</div>
</div>
</div>
<script>
	// boolean
	let isEmpty = 0;
	
	// 강의 평가에 필요한 값
	let lnum;
	
	// 강의 계획서 모달에 필요한 값
	let pid;
	let opennum;
		
	// 비동기 결과 값 담기용 변수
	let p_term = document.getElementById("plan_term");
	let p_lname = document.getElementsByName("plan_lname")[0];
	let p_pname = document.getElementsByName("plan_pname")[0];
	let p_email = document.getElementsByName("plan_email")[0];
	let p_pphone = document.getElementsByName("plan_pphone")[0];
	let p_mname = document.getElementsByName("plan_mname")[0];
	let p_dname = document.getElementsByName("plan_dname")[0];
	let p_lrname = document.getElementsByName("plan_lrname")[0];
	let p_book = document.getElementsByName("plan_book")[0];
	let p_lnum = document.getElementsByName("plan_lnum")[0];
	let p_schedule = document.getElementsByName("plan_schedule")[0];
	let p_credit = document.getElementsByName("plan_credit")[0];
	let p_grade = document.getElementsByName("plan_grade")[0];
	let p_newlimitcount = document.getElementsByName("plan_newlimitcount")[0];
	let p_division = document.getElementsByName("plan_division")[0];
	let p_content = document.getElementsByName("plan_content")[0];
	let p_week = [
		"w1",
		"w2",
		"w3",
		"w4",
		"w5",
		"w6",
		"w7",
		"w8",
		"w9",
		"w10",
		"w11",
		"w12",
		"w13",
		"w14",
		"w15",
		"w16",
	];
		
	for (let i = 1; i <= p_week.length; i++) {
		p_week[i - 1] = document.getElementsByName("w" + [i])[0];
	}
		
	// 그리드를 보여준다
	const grid = new tui.Grid({
		el: document.getElementById("grid"),
		data: {
			api: {
				readData: {
					url: "wantLectureList",
	      			method: "POST",
	    		},
	  		},
			contentType: "application/json",
			headers: { "x-custom-header": "custom-header" },
		},
		//rowHeaders: ['checkbox'],
		pagination: true, //페이징 처리
		pageOptions: {
			useClient: true, //페이징 처리
			perPage: 10, //페이징 갯수
		},
		columns: [
			//{header: ' ', name: 'seq'},
			{ header: "강의코드", name: "lnum" },
			{ header: "강의명", name: "lname" },
			{ header: "학과", name: "dname" },
			{ header: "전공", name: "mname" },
			{ header: "이수구분", name: "division" },
			{ header: "학점", name: "credit" },
			{ header: "대상학년", name: "target" },
			{ header: "교수", name: "pname" },
			{ header: "강의시간", name: "timetable" },
			{ header: "강의실", name: "lrname" },
			{ header: "수강정원", name: "limitcount" },
			//{header:'강의평가',name:'evaluation'}
		], //컬럼갯수
	});
	// grid.readData(1, lec, true);
	// grid.resetData(lecData) //그리드를 그려놓고 데이터를 넣음
	// 그리드 끝
	
	// 그리드 클릭 이벤트
	/*
		click 이벤트는 grid 전체 이벤트 클릭이다.
		ev.targetType을 보면 columnHeader와 cell이 있다.
		cell: 데이터들
		근데 헤더를 누르면
		cell 데이터에 tui-grid-layer-selection 이라는 div가 생겨서 클릭을 막고있었다.
		css에서 display none 으로 숨겨서 클릭되게 했음.
		document.querySelector()
	*/
	grid.on("click", (ev) => {
		var data = grid.getRow(ev.rowKey);
		const isHeader = ev.targetType === "columnHeader";

		// 강의 평가 보기
		if (ev.columnName == "lnum" && !isHeader) {
			
			evaluationData(data);
			
			if (isEmpty == -1) {
				alert("신설된 강의입니다. 평가 내용이 없습니다.");
				isEmpty = 0;
			} else if (isEmpty == 1) {
				modal("modal_evaluation");
				isEmpty = 0;
			}
		}

		// 교수 정보 보기
		if (ev.columnName == "pname" && !isHeader) {
			showOffer(data);
		}
		
		// 강의 계획서 보기
		if (ev.columnName == "lname" && !isHeader) {
			planData(data);
			if (isEmpty == -1) {
				alert("강의 계획서가 작성되어 있지 않은 강의입니다.");
				isEmpty = 0;
			} else if (isEmpty == 1) {
				modal("modal_offer");
				isEmpty = 0;
			}
		}
	});

	// 아이디가 searchBtn인 버튼을 누르면 searchLecture function을 실행한다.
	document.getElementById("searchBtn").addEventListener("click", searchLecture);
	
	// 검색 기능
	function searchLecture() {
		
		let mc = document.getElementsByName("mcode")[0].value;
		let dn = document.getElementsByName("dname")[0].value;
			
		let divi_value;
		let divi = document.getElementsByName("division");
		
		for (let i = 0; i < divi.length; i++) {
			if (divi[i].checked) {
				divi_value = divi[i].value;
			}
		}
			
		let loca = document.getElementsByName("location")[0].value;
		let gra = Number(document.getElementsByName("grade")[0].value);
		let day = document.getElementsByName("day")[0].value;
		let time = document.getElementsByName("time")[0].value;
			
		let timetable = day + time;
			
		let data = {
			mcode: mc,
			dname: dn,
			division: divi_value,
			location: loca,
			grade: gra,
			timetable: timetable,
		};
			
		grid.readData(1, data, true);
	}
	
	// 그리드
	// api 쓰게 되면서 얘 의미 없게 되긴 했는데, 주석 처리하자니 교수 이름 때문에 걸리네?
	// seq 값도 못 받음
	/* var lecData = [
		<c:forEach items = "${lec}" var = "lec" varStatus = "seq">{
			// 실질적 값
			seq			: '${seq.count}',
			lnum 		: '${lec.lnum}' + '-' + '${lec.dividenum}',
			lname 		: '${lec.lname}',
			division 	: '${lec.division}',
			credit 		: '${lec.credit}',
			target 		: '${lec.target}',
			pname		: '${lec.pname}',
			timetable 	: '${lec.timetable}',
			lrname 		: '${lec.lrname}',
			limitcount	: '${lec.limitcount}',
			
			// 필요에 의한 값 땡겨오기.
			// email		: '${lec.email}',
			// pphone		: '${lec.pphone}',
			// pid			: '${lec.pid}',
			// opennum		: '${lec.opennum}',
			// evaluation: '<button id="openbtn${lec.opennum}" onclick="openpage(${lec.opennum})">확인</button>'
			
		}
		<c:if test='${!empty lec.lnum}'>
		,
		</c:if>
		</c:forEach>
		]; */
	
	// 강의 계획서 정보 불러오기
	function planData(data) {
		// 비동기로 쓸 받은 값
		pid = data.pid;
		opennum = data.opennum;
			
		$.ajax({
			url: "planView",
			async: false,
			data: {
				pid: pid,
				opennum: opennum,
			},
			success: function (result) {
				if (result.content != null) {
					//$('#plan_lname').attr("value", result.lname);
					p_term.innerHTML = result.lyear + "년도 " + result.term + "학기";
					p_lname.value = result.lname;
					p_pname.value = result.pname;
					p_email.value = result.email;
					p_pphone.value = result.pphone;
					p_mname.value = result.mname;
					p_dname.value = result.dname;
					p_lrname.value = result.lrname;
					p_book.value = result.book;
					p_lnum.value = result.lnum + '-' + result.dividenum;
					p_schedule.value = result.schedule;
					p_credit.value = result.credit;
					p_grade.value = result.grade;
					p_newlimitcount.value = result.newlimitcount;
					p_division.value = result.division;
					p_content.value = result.content;
					
					for (let i = 1; i <= p_week.length; i++) {
						p_week[i - 1].value = result["w" + i];
					}
					
					isEmpty = 1;
					
				} else {
					isEmpty = -1;
				}
			},
			error: function (err) {
				console.log(err);
			}
		});
	}
	
		
	/*
		[Deprecation] Synchronous XMLHttpRequest on the main thread is deprecated because of its detrimental effects to the end user's experience. For more help, check
		 jQuery 가 1.8 버전부터 async 옵션이 폐기
		 대신에 jqXHR.done(), jqXHR.fail(), jqXHR.always() 을 사용할 수 있다.
		 반복문과도 연관있는 문제인 듯하다.
		 https://doogle.link/%EA%B2%BD%EA%B3%A0-%ED%95%B4%EA%B2%B0-deprecation-synchronous-xmlhttprequest-on-the-main-thread-is-deprecated-because-of-its-detrimental-effects-to-the-end-users-experience-for-more-help-check/
	*/
		
	// 강의 평가 정보 불러오기
	function evaluationData(data) {
		//let rBody = document.getElementById('RESULTBODY');
		lnum = data.lnum.substring(0,5);
		opennum = data.opennum;
		
		console.log('lnum : ' + lnum);
		console.log('opennum : ' + opennum);
		
		$("#resultBody").empty();
			  
		$.ajax({
			url: "EresultSt",
			async: false,
			data: {
				opennum : opennum,
				lnum	: lnum
			},
			success: function (result) {
				// console.log(result);
				// console.log(result[0].a1);
				if (result != '') {
					isEmpty = 1;
					// 데이터 변수들 담기
					for (let i = 0; i < result.length; i++) {
						let tr = $('<tr />');
							tr.append(
								$('<td>' + result[i].lyear + " - " + result[i].term + '</td>'),
								$('<td />').html(result[i].lnum), // + " - " + result[i].dividenum 분반 필요하나
								$('<td />').html(result[i].lname),
								$('<td />').html(result[i].pname),
								$('<td />').html(result[i].a1)
							); 
						$("#resultBody").append(tr);	        	  
					}
					
				/* let yearArr = [];
				yearArr.length = result.length;
				console.log(yearArr.length);
				for (let i = 0; i < result.length; i++) {
					yearArr[i] = [result[i].lyear];
					console.log('년도 배열 값 : ' + yearArr[i]);
					console.log('리절트 값 확인 : ' + result[i].lyear);
				}
				
				for (let i = 0; i < result.length; i++) {
					if (i != 0 && result[i].lyear == result[i - 1].lyear) {
						yearArr[i] = "";
					} else {
						yearArr[i] = result[i].lyear;
					}
				 
				 
					if ((i + 1) = result.length) {
						yearArr[i] = `<td rowspan=${i}></td>`;
					}
					
					let tr = $(`<tr>`);
				 	tr.append($(`<td>`).html(result[i].lyear - result[i].term));
					tr.append($(`<td>`).html(result[i].lnum - result[i].dividenum));
					tr.append($(`<td>`).html(result[i].lname));
					tr.append($(`<td>`).html(result[i].a1)); 
				}
				*/
				} else {
				  isEmpty = -1;
				}
			},
			error: function (err) {
			  console.log(err);
			}
		});
	}
	
	// 교수 정보 불러오고 모달 띄우기
	function showOffer(data) {
		
		modal("my_offer");
		
		var pname = data.pname;
		var email = data.email;
		var pphone = data.pphone;
		
		$("#professorInfo tbody").empty();
		$("<tr>")
			.append($("<td>").html(pname))
			.append($("<td>").html(pphone))
			.append($("<td>").html(email))
			.appendTo("#professorInfo tbody");
	}
		
	function modal(mm) {
		
		var zIndex = 9999;
		var modal = document.getElementById(mm);
		// 모달 div 뒤에 희끄무레한 레이어
		var bg = document.createElement("div");
		bg.setStyle({
			position: "fixed",
			zIndex: zIndex,
			left: "0px",
			top: "0px",
			width: "100%",
			height: "100%",
			overflow: "auto",
			// 레이어 색갈은 여기서 바꾸면 됨
			backgroundColor: "rgba(0,0,0,0.4)",
		});
		
		document.body.append(bg);
		
		// 닫기 버튼 처리, 시꺼먼 레이어와 모달 div 지우기
		modal.querySelector(".modal_close_btn").addEventListener("click", function () {
			bg.remove();
			modal.style.display = "none";
			// $('#modal_offer').scrollTop(0);	// 스크롤 위치 초기화
			// window.scrollTo(0, 300);
			// $('.modal-body').scrollTop(0);
			// $(this).find('form')[0].reset();	초기화?
		});
			
		// 스크롤 초기화 씨발
		/* $("#modal_offer").on("shown", function () {
			$(".modal-body").scrollTop(0);
			// $('#modal_offer').scrollTop(0);
		}); */
		
		modal.setStyle({
			position: "fixed",
			display: "block",
			boxShadow: "0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)",
			// 시꺼먼 레이어 보다 한칸 위에 보이기
			zIndex: zIndex + 1,
		
			// div center 정렬
			top: "50%",
			left: "50%",
			transform: "translate(-50%, -50%)",
			msTransform: "translate(-50%, -50%)",
			webkitTransform: "translate(-50%, -50%)",
		});
	}
		
	// Element 에 style 한번에 오브젝트로 설정하는 함수 추가
	Element.prototype.setStyle = function (styles) {
		for (var k in styles) this.style[k] = styles[k];
		return this;
	};
	
	function openpage(data) {
		var opennum = data;
		location.href = "Eresultst?opennum=" + opennum;
	}
	
	// 검색 컬럼 변화
	$("#dname").change(function () {
		
		let v_dname = $(this).val();
		let v_mcode = `<option value = "">전체</option>`;
			
		if (v_dname != "") {
			//$("select[name = 'mcode']" option).remove();
			$(`select[name = mcode] option`).remove();
			
			$.ajax({
				url: "customDcode",
				type: "GET",
				data: { dname: v_dname },
				success: function (result) {
					$.each(result, function (i, v) {
						//v_mcode += `<option value = ${v.mcode}>${v.mname}</option>`;
						v_mcode += '<option value="' + v.mcode + '">' + v.mname + "</option>";
					});
					$("#mcode").append(v_mcode);
				},
			});
		} else {
			$(`select[name = mcode] option`).remove();
			$("#mcode").append(v_mcode);
		}
	});
	
	// pdf 다운로드
	$("#createpdf").click(function () {
		
		html2canvas($("#pdfwrap")[0]).then(function (canvas) {
			
			var filename = "LecturePlan_" + Date.now() + ".pdf";
			var doc = new jsPDF("p", "mm", "a4");
			var imgData = canvas.toDataURL("image/png");
			var imgWidth = 210;
			var pageHeight = 295;
			var imgHeight = (canvas.height * imgWidth) / canvas.width;
			var heightLeft = imgHeight;
			var position = 0;
			doc.addImage(imgData, "PNG", 0, position, imgWidth, imgHeight);
			
			heightLeft -= pageHeight;
			
			while (heightLeft >= 0) {
				position = heightLeft - imgHeight;
				doc.addPage();
				doc.addImage(imgData, "PNG", 0, position, imgWidth, imgHeight);
				heightLeft -= pageHeight;
			}
			doc.save(filename);
		});
	});
</script>