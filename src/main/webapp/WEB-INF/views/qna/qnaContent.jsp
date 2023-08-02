<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>qnaContent.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script> -->
  <!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"> -->
  <style>
    td {text-align: center;}
    th {background-color: #eee;}
  </style>
  <script>
    'use strict';
    
    function answerCheck() {
    	let tempStr = '<br/>';
    	tempStr += '<h3 class="text-center">답 변 글 달 기</h3>';
    	tempStr += '<table class="table">';
    	tempStr += '<tr>';
  		tempStr += '    <th class="text-center">글쓴이</th>';
			tempStr += '  <td><input type="text" name="nickName" value="${sNickName}" readonly class="form-control"/></td>';
			tempStr += '</tr>';
    	tempStr += '<tr>';
    	tempStr += '  <th class="text-center">답변글제목</th>';
    	/* tempStr += '  <td><input type="text" name="title" value="(Re) ${vo.title}" size="60" required class="form-control"/></td>'; */
    	tempStr += '  <td class="text-left">(Re) ${vo.title}</td>';
    	tempStr += '</tr>';
    	tempStr += '<tr>';
    	tempStr += '<th class="text-center">이메일</th>';
    	tempStr += '  <td><input type="text" name="email" value="${email}" size="60" class="form-control" required/></td>';
    	tempStr += '  </tr>';
    	tempStr += '<tr>';
    	tempStr += '  <th class="text-center">글내용</th>';
    	tempStr += '  <td><textarea rows="6" name="content" required class="form-control"></textarea></td>';
    	tempStr += '</tr>';
    	tempStr += '<tr>';
    	tempStr += '<th class="text-center">비밀번호</th>';
    	tempStr += '  <td class="text-left">';
    	tempStr += '    <input type="checkbox" name="pwdCheck" id="pwdCheck" <c:if test="${!empty vo.pwd}">checked</c:if>/>';
    	tempStr += '		<label for="pwdCheck">비밀글로 등록</label> <font size="1"></font>';
  		tempStr += '    <input type="hidden" name="pwd" id="pwd" value="1234"/>';  // 이곳에서는 사용하지 않았음. 별 의미기 없기에...
  		tempStr += '  </td>';
  		tempStr += '</tr>';
    	tempStr += '<tr>';
    	tempStr += '  <td colspan="2" style="text-align:center">';
    	tempStr += '    <input type="button" value="답글올리기" onclick="fCheck()" class="btn btn-secondary"/> &nbsp;';
    	tempStr += '    <input type="button" value="취소" onclick="location.reload();" class="btn btn-secondary"/> &nbsp;';
    	tempStr += '  </td>';
    	tempStr += '</tr>';
    	tempStr += '</table>';
    	tempStr += '<input type="hidden" name="qnaSw" value="a"/>';
    	tempStr += '<input type="hidden" name="qnaIdx" value="${vo.qnaIdx}"/>';
    	tempStr += '<input type="hidden" name="title" value="(Re) ${vo.title}"/>';
			$("#reply").html(tempStr);
    }
    
    function fCheck() {
    	var nickName = myform.nickName.value;
    	var title = myform.title.value;
    	var pwdCheck = document.getElementById("pwdCheck");
    	var pwd = myform.pwd.value;
    	var content = myform.content.value;
    	
    	if(nickName=="") {
    		alert("글올린이 닉네임을 입력하세요");
    		myform.nickName.focus();
    	}
    	else if(title=="") {
    		alert("글제목을 입력하세요");
    		myform.title.focus();
    	}
    	else if(content=="") {
    		alert("글내용을 입력하세요");
    		myform.content.focus();
    	}
    	else {
    		if($("#pwdCheck").is(":checked")) myform.pwd.value = '1234';
    		else myform.pwd.value = "";
    		myform.submit();
    	}
    }
    
    function delCheck() {
    	let ans = "현재 글을 삭제하시겠습니까?";
    	if(!ans) return false;
    	
    	location.href = "${ctp}/qna/qnaDelete?idx=${vo.idx}";
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"/>
<div class="container">
  <p><br/></p>
  <h2 class="text-center">글 내 용 보 기</h2>
  <br/>
  <table class="table table-bordered">
    <tr>
      <th class="text-center">글쓴이</th>
      <td>${vo.nickName}</td>
      <th class="text-center">글쓴날짜</th>
      <td>${fn:substring(vo.WDate,0,fn:length(vo.WDate)-3)}</td>
    </tr>
    <tr>
      <th class="text-center">Email</th>
      <td colspan="3" class="text-left">${vo.email}</td>
    </tr>
    <c:if test="${vo.qnaSw == 'a'}">
	    <tr>
	      <th class="text-center">원본글제목</th>
	      <td colspan="3" style="text-align:left;">${title}</td>
	    </tr>
    </c:if>
    <tr>
      <th class="text-center">글제목</th>
      <td colspan="3" style="text-align:left;">${vo.title}</td>
    </tr>
    <tr>
      <th class="text-center">글내용</th>
      <td colspan="3" style="height:200px; text-align:left;">${fn:replace(vo.content,newLine,"<br/>")}</td>
    </tr>
    <%-- 
    <c:if test="${!empty vo.pwd}">
	    <tr>
	      <th class="text-center">비밀번호</th>
	      <td colspan="3" style="text-align:left;"><input type="password" name="pwd"/></td>
	    </tr>
    </c:if>
     --%>
    <tr>
      <td colspan="4" style="text-align:center;">
        <c:if test="${vo.qnaSw == 'q'}">
          <input type="button" value="답변" onclick="answerCheck()" class="btn btn-outline-secondary"/> &nbsp;
        </c:if>
        <c:if test="${sNickName eq vo.nickName}">
          <c:if test="${vo.qnaSw == 'q'}">
	        	<input type="button" value="수정" onclick="location.href='${ctp}/qna/qnaUpdate?idx=${vo.idx}';" class="btn btn-secondary"/> &nbsp;
	        </c:if>
	        <input type="button" value="삭제" onclick="delCheck(${vo.idx})" class="btn btn-secondary"/> &nbsp;
        </c:if>
        <input type="button" value="돌아가기" onclick="location.href='qnaList?pag=${pag}&pageSize=${pageSize}';" class="btn btn-secondary"/>
      </td>
    </tr>
  </table>
  <form name="myform" method="post" action="qnaInput">
    <div id="reply"></div>
	  <input type="hidden" name="pag" value="${pag}"/>
	  <input type="hidden" name="pageSize" value="${pageSize}"/>
	  <input type="hidden" name="idx" value="${vo.idx}"/>
	  <input type="hidden" name="mid" value="${vo.mid}"/>
  </form>
  <p></p>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>