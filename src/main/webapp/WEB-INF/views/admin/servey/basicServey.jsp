<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>basicServey.jsp(설문조사)</title>
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
		.cli {
			cursor:pointer;
		}
		.cli:hover {
			background-color:#ccc;
		}
  </style>
  <script>
  	'use strict';
  	
  	function noShow(){
			setCookie("servey${idx}","N",1);
	    // 유효시간 1일 : todayDate.setTime(todayDate.getTim() + (expiredays * 24 * 60 * 60 * 1000))
	    // 유효시간 1분 : todayDate.setMinutes(todayDate.getMinutes() + expiredays)
	    // setCookie(쿠키명, 쿠키값, 쿠키유효시간)
	    function setCookie(name, value, expiredays) {
	    	var date = new Date();
	    	date.setDate(date.getDate() + expiredays);
	    	document.cookie = escape(name) + "=" + escape(value) + "; expires="+date.toUTCString()+"; path=${ctp}";
	    }
	    //alert("");
  		window.close();
  	}
  </script>
</head>
<body>
<form name="myform" method="post">
	<p><br/></p>
	<div class="container-fluid message">
	  <h3 style="font-family:'ChosunNm'" class=" mb-5"><b><img src="${ctp}/images/servey.png" style="width:80px"/>&nbsp;&nbsp; ${vo.title}</b></h3>
	  <hr/>
	  <table class="table table-borderless">
	  	<tr>
	  		<td>
				  <h5>기본 정보에 체크해주세요.</h5>
	  		</td>
	  	</tr>
		  	<tr><th>1. 귀하의 성별을 알려주세요.</th></tr>
  			<tr><td><input type="radio" name="gender" value="남자" checked/> 남자</td></tr>
  			<tr><td><input type="radio" name="gender" value="여자"/> 여자</td></tr>
		  	<tr><th>2. 귀하의 연령대는 어디에 속합니까?</th></tr>
  			<tr><td><input type="radio" name="age" value="19세 이하" checked/> 19세 이하</td></tr>
  			<tr><td><input type="radio" name="age" value="20~29세"/> 20~29세</td></tr>
  			<tr><td><input type="radio" name="age" value="30~39세"/> 30~39세</td></tr>
  			<tr><td><input type="radio" name="age" value="40~49세"/> 40~49세</td></tr>
  			<tr><td><input type="radio" name="age" value="50~59세"/> 50~59세</td></tr>
  			<tr><td><input type="radio" name="age" value="60세 이상"/> 60세 이상</td></tr>
  			<tr><th>3. 귀하의 거주지는 어디입니까?</th></tr>
  			<tr><td><input type="radio" name="address" value="강원도" checked/> 강원도</td></tr>
  			<tr><td><input type="radio" name="address" value="서울/경기"/> 서울/경기</td></tr>
  			<tr><td><input type="radio" name="address" value="충청도(대전,세종)"/> 충청도(대전,세종)</td></tr>
  			<tr><td><input type="radio" name="address" value="전라도(광주)"/> 전라도(광주)</td></tr>
  			<tr><td><input type="radio" name="address" value="경상도(울산,부산)"/> 경상도(울산,부산)</td></tr>
  			<tr><td><input type="radio" name="address" value="제주도"/> 제주도</td></tr>
	  </table>
	  <input type="submit" class="form-control btn btn-dark" value="다음으로 넘어가기">
	  <h6 class="text-right"><input type="checkbox" id="noshow" onclick="noShow()"/><label for="noshow"> 일주일동안 보지 않기</label></h6>
	</div>
	<input type="hidden" name="sIdx" value="${idx}"/>
</form>
</body>
</html>