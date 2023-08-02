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
				<td colspan="2">
					<h2>설문조사 등록</h2>
				</td>
			</tr>
			<tr>
				<td>설문조사명</td>
				<td><input type="text" name="title" class="form-control"/></td>
			</tr>
			<!-- 
			<tr>
				<td>설문상세내역</td>
				<td><input type="text" name="content" class="form-control"/></td>
			</tr>
			 -->
			<tr>
				<td>기간설정</td>
				<td>시작일시
				  <input type="date" name="startDate" class="form-control" style="display:inline;width:33%"/> - 마감일시 <input type="date" name="endDate" class="form-control" style="display:inline;width:33%"/>
				  <input type="submit" class="btn btn-success ml-2" value="생성" style="display:inline;width:15%"/>
				</td> 
			</tr>
			<tr><td colspan="2"><hr/></td></tr>
			<!-- 
			<tr>
				<td>설문항목 관리</td>
				<td>
					<input type="text" class="form-control" style="display:inline;width:80%"/>
					<input type="button" class="form-control btn btn-dark" onclick="fCheck()" value="+새 설문항목 추가" style="display:inline;width:18%"/>
				</td>
			</tr>
			 -->
		</table>
	</div>
</div>
</form>
<p><br/><br/></p>
</body>
</html>