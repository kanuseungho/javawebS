<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>adInquiryReply.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script>
		/*
		$(document).ready(function() {
			$('#insertBtn').hide(); 
			
			$('#updateBtn').click(function(){
				$('#insertBtn').show(); 
				$('#updateBtn').hide(); 
				$('#reContent').removeAttr('readonly');				
			});
		});
		*/
		function inquiryReply() {
			var inquiryIdx = "${vo.idx}";
			var reContent = replyForm.reContent.value;
			if(reContent == "") {
				alert("답변을 입력하세요!");
				replyForm.reContent.focus();
				return false;
			}
			var query = {
					inquiryIdx : inquiryIdx,
					reContent : reContent
			}
			$.ajax({
				url : "${ctp}/admin/adInquiryReplyInput",
				type : "post",
				data : query,
				success : function(data) {
					alert("답변글이 등록되었습니다.");
					location.reload();
				}
			});
		}
		
		// 답변글 삭제하기
		function deleteReplyCheck() {
			var ans = confirm("답변글을 삭제하시겠습니까?");
			if(!ans) return false;
			
			//var idx = ${vo.idx};
			var reIdx = '${reVO.reIdx}';
			var inquiryIdx = '${reVO.inquiryIdx}';
			var query = {
					//idx : idx,
					reIdx : reIdx,
					inquiryIdx : inquiryIdx
			}
			$.ajax({
				type : "post",
				url  : "${ctp}/admin/adInquiryReplyDelete",
				data : query,
				success:function() {
					alert("삭제 되었습니다.");
					location.reload();
				}
			});
		}
		
		// 답변글 수정폼 호출하기(replySw값을 1을 보내어서 그 값이 1이면 textarea창의 readonly속성을 풀어준다.)
		/* 
		function updateReplyCheck() {
			location.href = "${ctp}/admin/adInquiryReply?idx=${vo.idx}&replySw=U";
		}
		 */
		
		// 답변글 수정하기
		function updateReplyCheck() {
			var reIdx = '${reVO.reIdx}';	// 현재글에 달려있는 답변글의 고유번호(수정시에 필요하다)
			var reContent = document.getElementById("reContent").value;
			var query = {
					reIdx : reIdx,
					reContent : reContent
			}
			$.ajax({
				type : "post",
				url  : "${ctp}/admin/adInquiryReplyUpdate",
				data : query,
				success:function() {
					alert("수정되었습니다.");
					// location.reload();	// 수정버튼을 다시 readonly 처리위해서는 location.reload가 아닌, 해당 프로그램을 다시 호출해야한다. 즉, location.href처리한다.
					// location.href = "${ctp}/admin/adInquiryReply?idx=${vo.idx}";
					location.reload();
				}
			});
		}
		 
		// 게시글 삭제하기
		function deleteCheck() {
			var ans = confirm("삭제하시겠습니까?");
			if(!ans) return false;
			location.href="${ctp}/admin/adInquiryDelete?idx=${vo.idx}&fSName=${vo.FSName}&reIdx=${reVO.reIdx}&pag=${pag}";
		}
	</script>
	<style>
	  th {background-color: #ccc; text-align:center;}
	</style>
</head>
<body>
<p><br/></p>
<div class="container">
  <h3>1:1문의 상세보기</h3>
	<table class="table table-bordered">
		<tr>
			<th>제목</th>
			<td colspan="3">[${vo.part}] ${vo.title}</td>
		</tr>
		<tr>
			<th>작성ID</th>
			<td colspan="3">${vo.mid}</td>
		</tr>
		<tr>
			<th>상태</th>
			<td colspan="3">
				<c:if test="${vo.reply=='답변대기중'}">
					<span class="badge badge-pill badge-secondary">${vo.reply}</span>						
				</c:if>
				<c:if test="${vo.reply=='답변완료'}">
					<span class="badge badge-pill badge-danger">${vo.reply}</span>						
				</c:if>
			</td>
		</tr>
		<tr>
			<th>작성일</th>
			<td style="width:200px">${fn:substring(vo.WDate,0,10)}</td>
			<th>주문번호</th>
			<td>
				<c:if test="${!empty vo.jumunNo}">${vo.jumunNo}</c:if>
				<c:if test="${empty vo.jumunNo}">없음</c:if>	
			</td>
		</tr>
		<tr>
			<td colspan="4" class="view-content">
	      <c:if test="${!empty vo.FSName}"><img src="${ctp}/inquiry/${vo.FSName}" width="400px"/><br/></c:if>
	      <br/>
	      <p>${fn:replace(vo.content,newLine,"<br/>")}<br/></p>
		    <hr/>
			</td>
		</tr>
	</table>
	
	
	<div style="text-align: right">
		<c:if test="${sMid==vo.mid || sLevel == 0}">	<!-- 작성글이 자신의 글이거나 관리자라면 삭제처리할수 있다. -->
			<input type="button" value="삭제" onclick="deleteCheck()" class="btn btn-danger btn-sm"/>
		</c:if>
		<input type="button" value="목록" onclick="location.href='${ctp}/admin/adInquiryList.ad?pag=${pageVo.pag}'" class="btn btn-secondary btn-sm"/>
	</div>
	
	<hr/>
	<!-- 답변서가 작성되어 있을때 수행하는 곳 -->
	<c:if test="${!empty reVO.reContent}">
		<form name="replyForm">
			<label for="reContent"><h5>답변내용</h5></label>
			<c:if test="${empty sReplySw || sReplySw != '1'}">	<!-- 답변서 작성되어 있고, 수정가능상태는 readonly로 처리후 '수정'버튼 누르면 'readonly'해제후 '수정완료'버튼으로 바꾼다. -->
				<%-- <textarea name="reContent" rows="5"  id="reContent" readonly="readonly" class="form-control" >${reVO.reContent}</textarea> --%>
				<textarea name="reContent" rows="5"  id="reContent" class="form-control bg-light" >${reVO.reContent}</textarea>
				<div style="text-align: right">		<!-- 수정을 위해서는 현재 답변글의 글번호(reIdx)를 넘겨야하지만, 현재는 답변글이 항상 1개이기에 넘기지않아도 알수 있다. -->
					<input type="button" value="수정" id="updateBtn" onclick="updateReplyCheck()" class="btn btn-secondary btn-sm mt-2"/>
					<input type="button" value="삭제" id="deleteBtn" onclick="deleteReplyCheck()" class="btn btn-danger btn-sm mt-2"/>
				</div>
			</c:if>
			<c:if test="${!empty sReplySw && sReplySw == '1'}">
				<textarea name="reContent" rows="5"  id="reContent" class="form-control" >${reVO.reContent}</textarea>
				<div style="text-align: right">
					<input type="button" value="수정완료" id="updateOkBtn" onclick="updateReplyCheckOk()" class="btn btn-secondary btn-sm mt-2"/>
					<input type="button" value="삭제" id="deleteBtn" onclick="deleteReplyCheck()" class="btn btn-secondary btn-sm mt-2"/>
				</div>
			</c:if>
		</form>
	</c:if>

	<!-- 답변서가 작성되어 있지 않을때 수행하는 곳 -->
	<c:if test="${empty reVO.reContent}">
		<form name="replyForm">
			<label for="reContent">답변글 작성하기</label>
			<textarea name="reContent" rows="5" class="form-control" placeholder="답변글 작성하기"></textarea>
			<div style="text-align: right">
				<input type="button" value="등록" onclick="inquiryReply()" class="btn btn-secondary btn-sm mt-2"/>
			</div>
		</form>
	</c:if>
</div>
<p><br/></p>
</body>
</html>