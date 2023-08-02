<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>serveyInput.jsp</title>
  <script src="${ctp}/ckeditor/ckeditor.js"></script>
 	<jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
  <script>
 	  'use strict';
 	
 	  function fCheck() {
 		  if("${idx}"==0) alert("설문조사를 먼저 생성해주세요.");
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
		.badge:hover {
			cursor:pointer;
		}
		th {
		  text-align: center;
		  background-color: #eee;
		}
	</style>
</head>
<body class="bg-light">
<form name="myform" method="post">
<div class="row p-0 m-0 border shadow" style="background-color:#fff;border:1px solid gray">
	<div class="col"><h2 class="pl-3" style="font-family:'ChosunNm', sans-serif;"><b>설문조사 등록</b></h2></div>
	<div class="col">
		<jsp:include page="/WEB-INF/views/admin/adminHeader.jsp"></jsp:include>
	</div>
</div>
<div class="container-fluid p-3">
	<div class="container-fluid p-5 mb-3 border shadow-sm" style="background-color:#fff">
		<table class="table table-borderless">
			<tr>
				<td><font size="6"><b>설문조사 등록창</b></font> (설문조사에 관한 주제 내용을 기록합니다.)</td>
				<td class="text-right"><input type="checkbox" name="showSw" checked /> 홈화면에 설문지 띄우기</td>
			</tr>
		</table>
		<table class="table table-bordered">
			<tr>
				<th>설문조사명</th>
				<td><input type="text" name="title" placeholder="설문할 주제를 입력하세요." class="form-control" autofocus /></td>
			</tr>
			<%-- 
			<tr>
				<td>부제</td>
				<td><input type="text" name="content" value="${vo.content}" class="form-control"/></td>
			</tr>
			 --%>
			<tr>
				<th>기간설정</th>
				<td>시작일시 <input type="date" name="startDate" value="<%=java.time.LocalDate.now() %>" class="form-control" style="display:inline;width:33%"/> 
				- 마감일시 <input type="date" name="endDate" value="<%=java.time.LocalDate.now() %>" class="form-control" style="display:inline;width:33%"/>
				<input type="submit" class="btn btn-success"  value="설문조사지생성" style="display:inline;width:18%"/></td> 
			</tr>
		</table>
	</div>
</div>
</form>
<p><br/><br/></p>
</body>
</html>