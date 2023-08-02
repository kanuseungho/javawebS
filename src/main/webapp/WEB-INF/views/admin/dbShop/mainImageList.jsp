<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>mainImageList.jsp</title>
  <%@ include file="/WEB-INF/views/include/bs4.jsp" %>
  <script>
    'use strict';
    
    function partCheck(sw) {
    	let productCode = "";
    	if(sw == 1) productCode = partForm.productCode1.value;
    	else productCode = partForm.productCode2.value;
	   	location.href = "${ctp}/dbShop/mainImageList?productCode="+productCode;
    }
    
    function mainImageDelete() {
    	let ans = confirm("현재 이미지들을 삭제 하시겠습니까?");
    	if(!ans) return false;
    	
    	if('${productCode}'=='') {
    		alert("삭제할 메인 이미지를 오른쪽 샘플고르기창에서 선택한후 삭제하시오");
    		return false;
    	}
    	
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/dbShop/mainImageDelete",
    		data : {productCode : '${productCode}'},
    		success:function() {
    			alert("삭제되었습니다.");
    			location.href = "${ctp}/dbShop/mainImageList";
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    }
  </script>
  <style type="text/css">
    #left {float: left;}
    #right {
      float: left;
      margin-left: 60px;
    }
    #footer {clear: both;}
    img {border: 1px solid #ddd;}
  </style>
</head>
<body>
<p><br/></p>
<div class="container">
  <h3>메인 이미지 선택하기</h3>
  <div class="row">
    <div class="col">
  		<button type="button" onclick="javascript:mainImageDelete()" class="btn btn-danger">현재메인이미지삭제</button>
  	</div>
    <div class="col">
  		<button type="button" onclick="location.href='${ctp}/dbShop/mainImageInput';" class="btn btn-success">메인이미지등록하기</button>
  	</div>
  </div>
  <hr/>
  <c:if test="${empty vos}"><h4>자료를 등록해 주세요.</h4></c:if>
  <c:if test="${!empty vos}">
    <div class="mb-3"><b>상품모델명 :
      <c:if test="${!empty productName}">${productName}</c:if>
      <c:if test="${empty productName}">최근 상품사진 4건</c:if>
      </b>
    </div>
	  <div id="left" class="text-center bordered">
	    <c:forEach var="vo" items="${mainImageVOS}" begin="0" end="${fn:length(mainImageVOS)-1}" varStatus="st">
	      <img src="${ctp}/dbShop/mainImage/${vo.mainFName}" width="90px" 
	        onmouseover="document.getElementById('mainImage').innerHTML='<img src=${ctp}/dbShop/mainImage/${vo.mainFName} width=500px>'" style="border:1px solid #ccc"/> &nbsp;
	    </c:forEach>
	    <br/><br/>
	    <p id="mainImage"><img src="${ctp}/dbShop/mainImage/${mainImageVOS[0].mainFName}" width="500px"/></p>
	  </div>
	  <div id="right">
	    <h4>샘플 고르기1</h4>
	    <form name="partForm">
		    <select name="productCode1" onchange="partCheck(1)" class="form-control">
		      <c:forEach var="vo" items="${vos}">
		        <option value="${vo.productCode}" ${productCode==vo.productCode ? 'selected' : ''}>${vo.idx} / ${vo.productName}</option>
		      </c:forEach>
		    </select>
		    <br/><hr/><br/>
		    <h4>샘플 고르기2</h4>
		    <select name="productCode2" size="${fn:length(vos)}" onchange="partCheck(2)" class="form-control">
		      <c:forEach var="vo" items="${vos}">
		        <option value="${vo.productCode}" ${productCode==vo.productCode ? 'selected' : ''}>${vo.idx} / ${vo.productName}</option>
		      </c:forEach>
		    </select>
	    </form>
	  </div>
  </c:if>
</div>
<p id="footer"><br/></p>
</body>
</html>