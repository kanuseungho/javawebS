<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>serveyManagement.jsp</title>
  <script src="${ctp}/ckeditor/ckeditor.js"></script>
 	<jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
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
	</style>
  <script>
   	'use strict';
    function fCheck(){
	    let qcontent = $("#questionInput").val();
	    let answerSw= $("#questionAnswerSw").val();
	    let idx="${vo.idx}";
    	$.ajax({
    		type:"post",
    		url:"serveyAnswerInput",
    		data:{qcontent:qcontent,answerSw:answerSw,sIdx:idx},
    		success: function(){location.reload();},
    		error: function(){alert("오류!!");}
    	});
    }
    function answerInput(idx){
      let acontent =$("#answerInput"+idx).val();
    	$.ajax({
    		type:"post",
    		url:"serveyAnswerInputOK",
    		data:{sIdx:"${vo.idx}",qIdx:idx,acontent:acontent},
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
</head>
<body class="bg-light">
<div class="row p-0 m-0 border shadow" style="background-color:#fff;border:1px solid gray;minHeight:90vh">
	<div class="col"><h2 class="pl-3" style="font-family:'ChosunNm', sans-serif;"><b>설문조사 관리</b></h2></div>
	<div class="col">
		<jsp:include page="/WEB-INF/views/admin/adminHeader.jsp"></jsp:include>
	</div>
</div>
<div class="container-fluid p-3">
	<div class="container-fluid p-5 mb-3 border shadow-sm" style="background-color:#fff">
		<table class="table text-center">
			<tr class="table-borderless">
				<td colspan="7" class="text-left">
					<h2 class="pb-5">설문조사 리스트</h2>
				</td>
			</tr>
			<tr class="table table-bordered table-dark">
				<th>제목</th>
				<th>작성날짜</th>
				<th>시작일</th>
				<th>마감일</th>
				<th>비고</th>
			</tr>
			<c:forEach var="vo" items="${vos}">
				<tr class=" table table-bordered" >
					<td>${vo.title}
						<c:if test="${vo.showSw==0}"><div class="badge badge-danger">종료</div></c:if> 
						<c:if test="${vo.showSw==1}"><div class="badge badge-success">진행중</div></c:if> 
					</td>
					<td>${fn:substring(vo.SDate,0,11)}</td>
					<td>${fn:substring(vo.startDate,0,11)}</td>
					<td>${fn:substring(vo.endDate,0,11)}</td>
					<td>
						<input type="button" class="btn btn-warning" value="수정" onclick="location.href='serveyUpdate?idx=${vo.idx}';"/>
						<input type="button" class="btn btn-success" value="통계보기"  onclick="location.href='serveyResult?idx=${vo.idx}';"/>
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>
</div>
<p><br/><br/></p>
</body>
</html>