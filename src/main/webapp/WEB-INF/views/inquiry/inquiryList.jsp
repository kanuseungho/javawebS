<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>inquiryList.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<style>
	  th, td {text-align: center};
	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"/>
<p><br/></p>
<div class="container">
	<h3 style="text-align:center">1:1 문의 리스트</h3>
	<br/>
	<c:if test="${!empty sMid}">
		<div style="text-align: right;" class="p-1">
			<input type="button" onclick="location.href='${ctp}/inquiry/inquiryInput'" value="1:1 문의쓰기" class="btn btn-outline-secondary w-15"/>
		</div>
	</c:if>
	<div class="section">
		<table class="table table-hover">
			<tr class="table-dark text-dark"> 
				<th class="text-left pl-5">제 목</th>
				<th>문의자</th>
				<th>작성일</th>
				<th>답변상태</th>
			</tr>
			<c:if test="${empty vos}">
				<tr>
					<td colspan="4" style="text-align: center">
						1:1문의 내역이 존재하지 않습니다.
					</td>
				</tr>
			</c:if>
			<c:if test="${!empty vos}">
				<c:forEach var="vo" items="${vos}">
					<tr>
						<td style="text-align:left"><a href="${ctp}/inquiry/inquiryView?idx=${vo.idx}&pag=${pageVO.pag}">[${vo.part}] ${vo.title}</a></td>
						<td>${vo.mid}</td>
						<td>${fn:substring(vo.WDate,0,10)}</td>
						<td>
							<c:if test="${vo.reply=='답변대기중'}">
								<span class="badge badge-pill badge-secondary">${vo.reply}</span>						
							</c:if>
							<c:if test="${vo.reply=='답변완료'}">
								<span class="badge badge-pill badge-danger">${vo.reply}</span>						
							</c:if>
						</td>
					</tr>
				</c:forEach>
				<tr><td colspan="4" class="p-0"></td></tr>
			</c:if>
		</table>
		<br/>
	</div>
</div>

<c:if test="${!empty vos}">
<!-- 블록 페이징 처리 시작 -->
<div class="text-center">
  <ul class="pagination justify-content-center">
	  <c:if test="${pageVO.pag > 1}">
	    <li class="page-item"><a href="inquiryList?pag=1&pageSize=${pageVO.pageSize}" class="page-link text-secondary">◁◁</a></li>
	  </c:if>
	  <c:if test="${pageVO.curBlock > 0}">
	    <li class="page-item"><a href="inquiryList?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}" class="page-link text-secondary">◀</a></li>
	  </c:if>
	  <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}">
	    <c:if test="${i <= pageVO.totPage && i == pageVO.pag}">
	      <li class="page-item active"><a href="inquiryList?pag=${i}&pageSize=${pageVO.pageSize}" class="page-link text-light bg-secondary border-secondary">${i}</a></li>
	    </c:if>
	    <c:if test="${i <= pageVO.totPage && i != pageVO.pag}">
	      <li class="page-item"><a href='inquiryList?pag=${i}&pageSize=${pageVO.pageSize}' class="page-link text-secondary">${i}</a></li>
	    </c:if>
	  </c:forEach>
	  <c:if test="${pageVO.curBlock < pageVO.lastBlock}">
	    <li class="page-item"><a href="inquiryList?pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}" class="page-link text-secondary">▶</a></li>
	  </c:if>
	  <c:if test="${pageVO.pag != pageVO.totPage}">
	    <li class="page-item"><a href="inquiryList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}" class="page-link text-secondary">▷▷</a></li>
	  </c:if>
  </ul>
</div>
<!-- 블록 페이징 처리 끝 -->
</c:if>

<br/>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>