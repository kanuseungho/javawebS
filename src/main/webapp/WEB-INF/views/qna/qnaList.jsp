<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>bList.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.14.0/css/all.css" integrity="sha384-HzLeBuhoNPvSl5KYnjx0BT+WB0QEEqLprO+NBkkk5gbc67FTaL7XIGa2w1L0Xbgc" crossorigin="anonymous">
  <script>
    function sChange() {
    	searchForm.searchString.focus();
    }
    
    function sCheck() {
    	var searchString = searchForm.searchString.value;
    	if(searchString == "") {
    		alert("검색어를 입력하세요");
    		searchForm.searchString.focus();
    	}
    	else {
    		searchForm.submit();
    	}
    }
    
    // 비밀번호 처리때 사용하려했는데, 이곳에서는 사용하지 않음.
    function contentCheck(idx, title, pwd) {
    	if(pwd == '') {
    		location.href = "qnaContent?pag=${pageVO.pag}&idx="+idx+"&title="+title;
    	} 
    	else {
    		tempStr = '';
    		tempStr += '비밀번호 : ';
    		tempStr += '<input type="password" name="pwd"/>';
    		tempStr += '<input type="button" value="확인" onclick="movingCheck('+idx+')"/>';
    		tempStr += '<input type="button" value="닫기" onclick="location.reload()"/>';
    		alert("tempStr : " + tempStr);
    		$("#qna"+idx).html(tempStr);
    	}
    }
  </script>
  <style>
    td {text-align: center};
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<div class="container">
  <p><br/></p>
  <form name="tempForm">
	  <table class="table table-borderless">
	    <tr>
	      <td colspan="3"><h2>QnA 게시판 리스트</h2></td>
	    </tr>
	    <tr>
	      <td style="text-align:right;padding:10px 0px">
	        <input type="button" value="글올리기" onclick="location.href='qnaInput?qnaSw=q';" class="btn btn-secondary"/>
	      </td>
	    </tr>
	  </table>
	  <table class="table table-hover">
	    <tr class="table-dark text-dark text-center">
	      <th>글번호</th>
	      <th>글제목</th>
	      <th>글쓴이</th>
	      <th>글쓴날자</th>
	    </tr>
	    <c:set var="curScrStartNo" value="${pageVO.curScrStartNo}"/>
	    <c:set var="cnt" value="0"/>
	    <c:set var="tempSw" value="0"/>
	    <c:forEach var="vo" items="${vos}">
	      <c:set var="tempPreName" value="${vos[cnt-1].nickName}"/>
	      <c:if test="${cnt != 0}"><c:set var="tempPreQnaIdx" value="${fn:substring(vos[cnt-1].qnaIdx,0,fn:indexOf(vo.qnaIdx,'_'))}"/></c:if>
	      <c:if test="${cnt == 0}"><c:set var="tempPreQnaIdx" value="${fn:substring(vo.qnaIdx,0,fn:indexOf(vo.qnaIdx,'_'))}"/></c:if>
	      <c:set var="tempQnaIdx" value="${fn:substring(vo.qnaIdx,0,fn:indexOf(vo.qnaIdx,'_'))}"/>
		    <tr>
		      <td>${curScrStartNo}</td>
		      <td style="text-align:left;">
		        <c:if test="${vo.qnaSw == 'a'}"> &nbsp;&nbsp; └</c:if>
		        <c:if test="${!empty vo.pwd}"><i class="fas fa-lock"></i></c:if>
		        <c:if test="${vo.pwd == ''}"><a href="qnaContent?pag=${pageVO.pag}&idx=${vo.idx}&title=${vo.title}">${vo.title}</a></c:if> <!-- 비밀글이 아니면 모두가 볼 수 있다. -->
		        <c:if test="${vo.pwd != '' && (vo.nickName==sNickName || sLevel == 0)}">  <!-- 비밀글이면 '나'와 '관리자'만 볼 수 있다.(질문글은 당연히 본인 확인 가능) -->
		          <a href="qnaContent?pag=${pageVO.pag}&idx=${vo.idx}&title=${vo.title}">${vo.title}</a>
		          <c:set var="tempName" value="${vo.nickName}"/>
		          <c:set var="tempSw" value="1"/>
		        </c:if>
		        <c:if test="${vo.pwd != '' && tempSw != 1}">
			        <c:if test="${vo.qnaSw == 'a' && tempPreQnaIdx == tempPreQnaIdx && tempName==tempPreName}">  <!--  && (vo.qnaSw=='a' && tempPreQnaIdx==tempQnaIdx)}"> -->  <!-- 비밀글이면서 답글이라면 원본글의 qnaIdx의 앞의 값이 같으면 답글의 qnaIdx앞의값과 같다면 글을 볼수 있게 처리한다. -->
			          <a href="qnaContent?pag=${pageVO.pag}&idx=${vo.idx}&title=${vo.title}">${vo.title}</a>
			          <c:set var="tempSw" value="1"/>
			        </c:if>
			        <c:if test="${fn:split(vo.qnaIdx,'_')[1]=='2' || vo.qnaSw=='a'}">${vo.title}
			        </c:if>
		        </c:if>
		        <c:if test="${vo.diffTime <= 24}"><img src="${ctp}/images/new.gif"/></c:if>
		      </td>
		      <td>${vo.nickName}</td>
		      <td>
		        <c:if test="${vo.diffTime <= 24}">${fn:substring(vo.WDate,11,19)}</c:if>
		        <c:if test="${vo.diffTime > 24}">${fn:substring(vo.WDate,0,10)}</c:if>
		      </td>
		    </tr>
		    <%-- <tr><td colspan="4"><div id="qna${vo.idx}"></div></td></tr> --%>
		    <c:set var="curScrStartNo" value="${curScrStartNo-1}"/>
		    <c:set var="cnt" value="${cnt+1}"/>
        <c:set var="tempSw" value="0"/>
        <c:set var="tempPreName" value=""/>
	    </c:forEach>
	    <tr><td colspan="4" class="p-0"></td></tr>
	  </table>
  </form>
  <br/>
</div>
  
<!-- 블록페이징처리 시작 -->
<div class="container" style="text-align:center;">
<c:if test="${pageVO.totPage == 0}"><p style="text-align:center"><font color="red"><b>자료가 없습니다.</b></font></p></c:if>
<c:if test="${pageVO.totPage != 0}">
  <ul class="pagination justify-content-center">
	  <c:set var="startPageNum" value="${pageVO.pag - (pageVO.pag-1)%pageVO.blockSize}"/>
	  <c:if test="${pageVO.pag != 1}">
	    <li class="page-item"><a href="qnaList?pag=1&pageSize=${pageVO.pageSize}" class="page-link" style="color:#666">◁◁</a></li>
	    <li class="page-item"><a href="qnaList?pag=${pageVO.pag-1}&pageSize=${pageVO.pageSize}" class="page-link" style="color:#666">◀</a></li>
	  </c:if>
	  <c:forEach var="i" begin="0" end="${pageVO.blockSize-1}">
	    <c:if test="${(startPageNum+i) <= pageVO.totPage}">
		  	<c:if test="${pageVO.pag == (startPageNum+i)}">
		  	  <li class="page-item active"><a href="qnaList?pag=${startPageNum+i}&pageSize=${pageVO.pageSize}" class="page-link btn btn-secondary active" style="color:#666"><font color="#fff">${startPageNum+i}</font></a></li>
		  	</c:if>
		  	<c:if test="${pageVO.pag != (startPageNum+i)}">
		  	  <li class="page-item"><a href="qnaList?pag=${startPageNum+i}&pageSize=${pageVO.pageSize}" class="page-link" style="color:#666">${startPageNum+i}</a></li>
		  	</c:if>
	  	</c:if>
	  </c:forEach>
	  <c:if test="${pageVO.pag != pageVO.totPage}">
	    <li class="page-item"><a href="qnaList?pag=${pageVO.pag+1}&pageSize=${pageVO.pageSize}" class="page-link" style="color:#666">▶</a></li>
	    <li class="page-item"><a href="qnaList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}" class="page-link" style="color:#666">▷▷</a></li>
	  </c:if>
  </ul>
</c:if>
</div>
<!-- 블록페이징처리 끝 -->
<br/>
<!-- 검색기 처리 시작 -->
<div class="container" style="text-align:center">
  <form name="searchForm" method="get" action="qnaSearch">
    <b>검색 : </b>
    <select name="search" onchange="sChange()">
    	<option value="title" selected>글제목</option>
    	<option value="nickName">글쓴이</option>
    	<option value="content">글내용</option>
    </select>
    <input type="text" name="searchString"/>
    <input type="button" value="검 색" onclick="sCheck()"/>
    <input type="hidden" name="pag" value="${pageVO.pag}"/>
    <input type="hidden" name="pageSize" value="${pageVO.pageSize}"/>
  </form>
</div>
<!-- 검색기 처리 끝 -->
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>