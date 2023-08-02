<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>환불 신청 완료</title>
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
  </style>
  <script>
  	'use strict';
  	
  	function fLoca(){
  		opener.location.href = "${ctp}/member/memberMain";
  		window.close();
  	}
  	
  	$(function(){
    		setCookie("servey${idx}","N",7);
  	    // 유효시간 1일 : todayDate.setTime(todayDate.getTim() + (expiredays * 24 * 60 * 60 * 1000))
  	    // 유효시간 1분 : todayDate.setMinutes(todayDate.getMinutes() + expiredays)
  	    // setCookie(쿠키명, 쿠키값, 쿠키유효시간)
  	    function setCookie(name, value, expiredays) {
  	    	var date = new Date();
  	    	date.setDate(date.getDate() + expiredays);
  	    	document.cookie = escape(name) + "=" + escape(value) + "; expires="+date.toUTCString()+"; path=${ctp}";
  	    }
  		
  	});
  </script>
</head>
<body class=" bg-light">
<form name="myform" method="post">
	<br/>
	<div class="container-fluid message">
	  <h1 style="font-family:'ChosunNm'" class="mb-3">
	    <b>
	      <img src="${ctp}/images/consulting.jpg" style="width:80px"/>
	      &nbsp;&nbsp; 설문조사 완료
	    </b>
	  </h1>
	  <div class=" text-center p-4" >
	  	<img src="${ctp}/images/chicago.jpg" style="width:100%" class="jb-box"><br/>
	  	<img src="${ctp}/images/sanfran.jpg" style="width:100%" class="jb-box">
	  	<h5 class="mt-5">소중한 의견 감사드립니다.<input type="button" value="창닫기" onclick="window.close()" class="btn btn-success btn-sm ml-2"/></h5>
	  	(제출하신 답변은 본 사이트의 발전을 위해 사용됩니다.)
	  </div>
	</div>
	<p><br/></p>
	<input type="hidden" name="delItems" value="${param.del}"/>
</form>
</body>
</html>