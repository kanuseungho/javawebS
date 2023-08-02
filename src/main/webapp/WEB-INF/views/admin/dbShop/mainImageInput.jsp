<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>mainImageInput.jsp</title>
	<%@ include file="/WEB-INF/views/include/bs4.jsp" %>
  <script>
    'use strict';
    // 이미지 여러장 미리보기
    $(document).ready(function(){
    	$("#fName").on("change", multiImageCheck);		// 파일속성에 그림이 들어오게되면 multiImageCheck함수를 호출한다.
    });
    
    function multiImageCheck(e) {
    	// 그림파일 체크
    	let files = e.target.files;
    	let filesArr = Array.prototype.slice.call(files);
    	
    	filesArr.forEach(function(f){
    		if(!f.type.match("image.*")) {
    			alert("업로드할 파일은 이미지파일만 가능합니다.");
    			//return false;
    		}
    	});
    	
    	// 멀티파일 이미지 미리보기
    	let i = e.target.files.length;
    	for(let image of e.target.files) {
    		let img = document.createElement("img");
    		let reader = new FileReader();
    		reader.onload = function(e) {
    			img.setAttribute("src", e.target.result);
    			img.setAttribute("width", 200);
    		}
    		reader.readAsDataURL(e.target.files[--i]);
    		document.querySelector(".imgDemo").appendChild(img);
    	}
    }
    
    // 상품 입력창에서 대분류 선택(onChange)시 중분류를 가져와서 중분류 선택박스에 뿌리기
    function categoryMainChange() {
    	var categoryMainCode = myform.categoryMainCode.value;
			$.ajax({
				type : "post",
				url  : "${ctp}/dbShop/categoryMiddleName",
				data : {categoryMainCode : categoryMainCode},
				success:function(data) {
					var str = "";
					str += "<option value=''>중분류</option>";
					for(var i=0; i<data.length; i++) {
						str += "<option value='"+data[i].categoryMiddleCode+"'>"+data[i].categoryMiddleName+"</option>";
					}
					$("#categoryMiddleCode").html(str);
				},
				error : function() {
					alert("전송오류!");
				}
			});
  	}
    
    // 중분류 선택시 소분류항목 가져오기
    function categoryMiddleChange() {
    	var categoryMainCode = myform.categoryMainCode.value;
    	var categoryMiddleCode = myform.categoryMiddleCode.value;
			$.ajax({
				type : "post",
				url  : "${ctp}/dbShop/categorySubName",
				data : {
					categoryMainCode : categoryMainCode,
					categoryMiddleCode : categoryMiddleCode
				},
				success:function(data) {
					var str = "";
					str += "<option value=''>소분류</option>";
					for(var i=0; i<data.length; i++) {
						str += "<option value='"+data[i].categorySubCode+"'>"+data[i].categorySubName+"</option>";
					}
					$("#categorySubCode").html(str);
				},
				error : function() {
					alert("전송오류!");
				}
			});
  	}
    
    // 소분류 선택시 상품모델명 가져오기
    function categorySubChange() {
    	var categoryMainCode = myform.categoryMainCode.value;
    	var categoryMiddleCode = myform.categoryMiddleCode.value;
    	var categorySubCode = myform.categorySubCode.value;
			$.ajax({
				type : "post",
				url  : "${ctp}/dbShop/categoryProductName",
				data : {
					categoryMainCode : categoryMainCode,
					categoryMiddleCode : categoryMiddleCode,
					categorySubCode : categorySubCode
				},
				success:function(data) {
					var str = "";
					str += "<option value=''>상품모델명</option>";
					for(var i=0; i<data.length; i++) {
						str += "<option value='"+data[i].productCode+"'>"+data[i].productName+"</option>";
					}
					$("#productCode").html(str);
				},
				error : function() {
					alert("전송오류!");
				}
			});
  	}
  </script>
</head>
<body>
<p><br/></p>
<div class="container">
  <form name="myform" method="post" enctype="multipart/form-data">
    <h2 class="text-center">메인 이미지 올리기</h2>
    <br/>
    <div class="form-group">
      <label for="categoryMainCode">대분류</label>
      <select id="categoryMainCode" name="categoryMainCode" class="form-control" onchange="categoryMainChange()">
        <option value="">대분류를 선택하세요</option>
        <c:forEach var="mainVO" items="${mainVOS}">
        	<option value="${mainVO.categoryMainCode}">${mainVO.categoryMainName}</option>
        </c:forEach>
      </select>
    </div>
    <div class="form-group">
      <label for="categoryMiddleCode">중분류</label>
      <select id="categoryMiddleCode" name="categoryMiddleCode" class="form-control" onchange="categoryMiddleChange()">
        <option value="">중분류명</option>
      </select>
    </div>
    <div class="form-group">
      <label for="categorySubCode">소분류</label>
      <select id="categorySubCode" name="categorySubCode" class="form-control" onchange="categorySubChange()">
        <option value="">소분류명</option>
      </select>
    </div>
    <div class="form-group">
      <label for="productCode">상품모델명</label>
      <select id="productCode" name="productCode" class="form-control">
        <option value="">상품모델명</option>
      </select>
    </div>
    <div>
      <input type="file" name="file" id="fName" multiple class="form-control-file border mb-2"/>
    </div>
  	<div class="imgDemo mt-3 mb-3"></div>
    <div class="mb-2">
      <input type="submit" value="자료올리기" class="btn btn-primary"/> &nbsp;
      <input type="reset" value="다시쓰기" class="btn btn-warning"/> &nbsp;
      <input type="button" value="돌아가기" onclick="location.href='${ctp}/dbShop/mainImageList';" class="btn btn-secondary"/>
    </div>
  </form>
</div>
<p><br/></p>
</body>
</html>