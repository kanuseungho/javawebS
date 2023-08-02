<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>notifyList.jsp</title>
  <%@ include file="/WEB-INF/views/include/bs4.jsp" %>
  <script>
    $(document).ready(function() {
    	$(".popupSw").click(function() {
    		var popupCheck = $(this).is(":checked");  // 결과는 True 또는 False 가 발생한다.
    		var popupSw = popupCheck ? "Y" : "N";
    		var idx = $(this).next().val();
    		var query = {
    				idx : idx,
    				popupSw : popupSw
    		};
    		
    		$.ajax({
    			url : "${ctp}/notify/popupCheck",
    			type : "get",
    		  data : query,
    			success : function(data) {
    				if(popupSw == "Y") {
    					alert(data.idx+"("+data.sw+")번 공지사항이 초기화면에 팝업창으로 열립니다.");
    				}
    				else {
    					alert(data.idx+"("+data.sw+")번 공지사항은 초기화면에 팝업창에서 닫힙니다.");
    				}
    				//location.reload();
    				$("").load("${ctp}/notify/notifyList");
    			},
    			error : function(data) {
    				alert("수행 실패!!!");
    			}
    		});  // ajax종료
    	});
    });
  
    function notifyDelCheck(idx) {
    	var ans = confirm("공지사항을 삭제하시겠습니까?");
    	if(!ans) return false;
    	var query = {idx : idx};
    	$.ajax({
    		url : "${ctp}/notify/notifyDelete",
    		type : "get",
    		data : query,
    		success : function(data) {
    			if(data == "1") {
	    			alert("공지사항 삭제 완료!");
	    			//location.reload();
	    			$("#notifyContent").load("${ctp}/notify/notifyList #notifyContent");
    			}
    			else {
    				alert("삭제 실패~");
    			}
    		},
    		error : function(data) {
    			alert("서버 오류(삭제 실패)~");
    		}
    	});
    }
  </script>
  <style>
    
  </style>
</head>
<body>
<p><br/></p>
<div class="container">
  <table class="table table-borderless">
    <tr>
      <td align="center" colspan=2><font size=5><b>공 지 사 항 리 스 트</b></font></td>
    </tr>
    <tr>
      <td style="width:90%;border:0px;" class="tblr">
        <button type="button" class="btn btn-secondary" onClick="location.href='${ctp}/notify/notifyInput'">공지사항작성</button>
      </td>
    </tr>
  </table>
  <div id="notifyContent">
	  <form name="myform" method="get">
	    <ul>
	      <c:set var="num" value="${curScrStartNo}"/>	<!-- 아직 미사용중. -->
	      <c:forEach var="vo" items="${vos}">
	        <li><hr>
	          <span>
	            <div class="container mt-3">
	              <div class="d-flex justify-content-between mb-3">
	                <div class="p-2">
	                  <h5><b>[${vo.idx}.공지] ${vo.title}</b></h5>&nbsp; &nbsp;
	                </div>
	                <div class="p-2">
	                  &nbsp; &nbsp;
	                  <button type="button" class="btn btn-secondary" onclick="location.href='${ctp}/notify/notifyUpdate?idx=${vo.idx}';">수정</button>
	                  <button type="button" class="btn btn-secondary" onclick="notifyDelCheck('${vo.idx}')">삭제</button>
	                  <br/><br/>☞ 초기화면 표시 유뮤 :
	                  <input type="checkbox" name="popupSw" id="popupSw${num}" class="popupSw" <c:if test="${vo.popupSw eq 'Y'}"> checked </c:if> />
	                  <input type="hidden" name="idx" id="idx" value="${vo.idx}" />
	                </div>
	              </div>
	            </div>
	          </span>
	          <ul style="background-color:#fff5ee" class="ml-2 pt-2 pb-2">
	            <c:set var="content" value="${fn:replace(vo.content,newLine,'<br/>')}"/>
	            <li>${content}</li><br/>
	            <li>게시일 : ${fn:substring(vo.startDate,0,10)} ~ ${fn:substring(vo.endDate,0,10)}</li>
	          </ul>
	        </li>
	        <c:set var="num" value="${num-1}"/>
	      </c:forEach>
	    </ul>
	  </form>
  </div>
</div>
</body>
</html>