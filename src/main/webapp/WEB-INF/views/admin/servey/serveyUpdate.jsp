<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>serveyUpdate.jsp</title>
  <script src="${ctp}/ckeditor/ckeditor.js"></script>
 	<jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
  <script>
	 	'use strict';
	  function fCheck(){
		  let qcontent = $("#questionInput").val();
		  let answerSw= $("#questionAnswerSw").val();
		  let idx="${vo.idx}";
		  //alert(idx);
	  	$.ajax({
	  		type:"post",
	  		url:"serveyAnswerInput",
	  		data:{qcontent : qcontent,
	  			answerSw : answerSw,
	  			sIdx : idx},
	  		success: function(){location.reload();},
	  		error: function(){alert("오류!!");}
	  	});
	  }
	  function answerInput(idx){
	    let acontent =$("#answerInput"+idx).val();
	  	$.ajax({
	  		type:"post",
	  		url:"serveyAnswerInputOK",
	  		data:{sIdx:"${vo.idx}",
	  			qIdx:idx,
	  			acontent:acontent},
	  		success: function(){location.reload();},
	  		error: function(){alert("오류!!");}
	  	});
	  }
	  function answerDelete(idx){
	  	$.ajax({
	  		type:"post",
	  		url:"serveyAnswerDeleteOK",
	  		data:{idx:idx},
	  		success: function(){location.reload();},
	  		error: function(){alert("오류!!");}
	  	});
	  }
	  function questionUpdate(idx){
		  let qcontent = $("#qcontent"+idx).val();
	  	$.ajax({
	  		type:"post",
	  		url:"serveyQuestionUpdateOK",
	  		data:{idx:idx,qcontent:qcontent},
	  		success: function(){location.reload();},
	  		error: function(){alert("오류!!");}
	  	});
	  }
	  function questionDelete(idx){
	  	$.ajax({
	  		type:"post",
	  		url:"serveyQuestionDeleteOK",
	  		data:{idx:idx},
	  		success: function(){location.reload();},
	  		error: function(){alert("답변을 먼저 삭제해주세요.");}
	  	});
	  }
  </script>
  <style>
	  @font-face {
	    font-family: 'ChosunNm';
	    font-weight: normal;
	    font-style: normal;
	    src: url('https://cdn.jsdelivr.net/gh/webfontworld/ChosunNm/ChosunNm.eot');
	    src: url('https://cdn.jsdelivr.net/gh/webfontworld/ChosunNm/ChosunNm.eot?#iefix') format('embedded-opentype'),
	         url('https://cdn.jsdelivr.net/gh/webfontworld/ChosunNm/ChosunNm.woff2') format('woff2'),
	         url('https://cdn.jsdelivr.net/gh/webfontworld/ChosunNm/ChosunNm.woff') format('woff'),
	         url('https://cdn.jsdelivr.net/gh/webfontworld/ChosunNm/ChosunNm.ttf') format("truetype");
	    font-display: swap;
		}
		.badge:hover{
		  cursor:pointer;
		}
		th {
		  text-align: center;
		  background-color: #eee;
		}
  </style>
</head>
<body class="bg-light">
<form name="myform" method="post" action="${ctp}/servey/serveyUpdate">
	<div class="row p-0 m-0 border shadow" style="background-color:#fff;border:1px solid gray">
		<div class="col"><h2 class="pl-3" style="font-family:'ChosunNm', sans-serif;"><b>설문조사 관리</b></h2></div>
		<div class="col">
			<jsp:include page="/WEB-INF/views/admin/adminHeader.jsp"></jsp:include>
		</div>
	</div>
	<div class="container-fluid p-3">
		<div class="container-fluid p-5 mb-3 border shadow-sm" style="background-color:#fff">
			<table class="table table-borderless">
				<tr>
					<td><font size="6"><b>설문조사 등록창</b></font> (설문조사에 관한 주제 내용을 기록합니다.)</td>
					<td class="text-right"><input type="checkbox" name="showSw" ${vo.showSw == '1' ? 'checked' : ''} /> 홈화면에 설문지 띄우기<br/>
					  <input type="button" value="통계창으로돌아가기" onclick="location.href='serveyManagement';" class="btn btn-info mt-2 p-1"/>
					</td>
				</tr>
			</table>
			<table class="table table-bordered">
				<tr>
					<th>설문조사명</th>
					<td><input type="text" name="title" value="${vo.title}" class="form-control"/></td>
				</tr>
				<%-- 
				<tr>
					<td>부제</td>
					<td><input type="text" name="content" value="${vo.content}" class="form-control"/></td>
				</tr>
				 --%>
				<tr>
					<th>기간설정</th>
					<td>시작일시 <input type="date" name="startDate" value="${fn:substring(vo.startDate,0,10)}" class="form-control" style="display:inline;width:33%"/> 
					- 마감일시 <input type="date" name="endDate" value="${fn:substring(vo.endDate,0,10)}" class="form-control" style="display:inline;width:33%"/>
					<input type="submit" class="btn btn-warning"  value="수정" style="display:inline;width:18%"/></td> 
				</tr>
			</table>
			<hr/>
			<div class="container mb-4 bg-light text-secondary p-3">
			  <!-- <font color="#510"> -->
			  - <b>사용법</b> -<br/>
			  설문주제에 따른 질문항목을 등록하셔야 합니다.<br/>
			  답변지는 '선택형'과 '서술형'으로 제공되며,
			  '선택형'의 경우는 '라디오버튼(1개선택)'과 체크박스버튼(다중선택)'지로 만들수 있습니다.<br/>
			  1. 선택형을 고른후, 설문내용을 입력하고, '설문항목 등록/추가'버튼을 누른다.<br/>
			  2. 1번 문항에 답변할수 있는 각각의 '보기항목'을 등록한다. 내용을 입력후 '보기항목 등록/추가'버튼을 클릭한다.<br/>
			  3. 등록된 보기항목을 삭제하려면 '보기항목삭제'버튼을 클릭한다.<br/>
			  4. 보기항목을 더 등록하려면 '보기항목'에 내용을 입력후 '보기항목등록/추가'버튼을 클릭한다.<br/>
			  5. 새로운 설문항목을 더 등록하려면 1번의 과정을 반복해서 처리한다.<br/>
			  6. 만약 등록된 내용을 삭제하려면, 다음으로 진행하지말고 '보기항목'을 먼저 삭제후, 앞의 '설문 문항지 항목'을 '삭제'처리한다.<br/>
			  7. 앞의 방법을 반복진행하시면 설문지가 완성됩니다.
			  <!-- </font> -->
			</div>
			<table class="table table-borderless">
				<tr class="border-top">
					<td><h3>설문항목 관리</h3></td>
					<td>
						<table class="table table-borderless">
					  	<c:set var="cnt" value="1"/>
						  <c:forEach var="questionVo" items="${questionVos}">
						  	<tr>
						  		<th>
						  			${cnt}. <input type="text" class="form-control" style="width:80%;display:inline" id="qcontent${questionVo.idx}" value="${questionVo.qcontent}"/>
						  			<input type="button" class="btn btn-warning" value="현 설문항목수정" onclick="questionUpdate(${questionVo.idx})"/>
						  			<input type="button" class="btn btn-danger" value="삭제" onclick="questionDelete(${questionVo.idx})"/>
					  			</th>
					  		</tr>
						  	<c:forEach var="answerVo" items="${answerVos}">
						  		<c:if test="${questionVo.idx==answerVo.QIdx}">
							  		<tr>
							  			<td>
							  				&nbsp;&nbsp;&nbsp;
							  				<input type="text"  value="${answerVo.acontent}" class="form-control" style="width:30%;display:inline"/>
						  					<span class="btn btn-outline-warning" style="color:gray" onclick="answerDelete(${answerVo.idx})">보기항목삭제</span>
							  			</td>
							  		</tr>
						  		</c:if>
						  	</c:forEach>
					  		<c:set var="cnt" value="${cnt+1}"/>
					  		<c:if test="${questionVo.answerSw!=0}">
					  			<tr>
					  				<td>
					  					&nbsp;&nbsp;&nbsp;<input type="text" class="form-control" id="answerInput${questionVo.idx}" style="width:30%;display:inline"/>
					  					<span class="btn btn-outline-info" style="color:gray" onclick="answerInput(${questionVo.idx})">보기항목등록/추가</span>
					  				</td>
					  			</tr>
					  		</c:if>
					  		<c:if test="${questionVo.answerSw==0}">
					  				<tr><td>&nbsp;&nbsp;&nbsp;서술형 설문조사 입니다.</td></tr>
					  			</c:if>
						  </c:forEach>
						</table>
						<c:if test="${!empty questionVos}"><hr/></c:if>
						<select class="form-control" id="questionAnswerSw" name="questionAnswerSw" style="display:inline;width:20%">
							<option value="2">선택형(복수응답 불가)</option>
							<option value="1">선택형(복수응답 가능)</option>
							<option value="0">서술형</option>
						</select>
						<input type="text" id="questionInput" name="questionInput" class="form-control" style="display:inline;width:50%"/>
						<input type="button" class="form-control btn btn-dark"  onclick="fCheck()"  value="설문항목 등록/추가" style="display:inline;width:18%"/>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<p><br/></p>
	<input type="hidden" name="idx" value="${vo.idx}"/>
	</form>
</body>
</html>