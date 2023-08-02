<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>mainImage.jsp</title>
	<%@ include file="/WEB-INF/views/include/bs4.jsp" %>
  <script src="${ctp}/ckeditor/ckeditor.js"></script>
</head>
<body>
<p><br/></p>
<div class="container">
  <h2>CK Editor를 이용한 이미지 등록하기</h2>
  <p>본문에 이미지로 사용될 그림들의 사이즈를 통일해서 여러장 올려주세요</p>
  <hr/><br/>
  <form name="myform" method="post">
    <div class="row">
	    <div class="col">어디에 사용할 메인 이미지인지 고르시오
	      <select name="part">
	        <option value="shop" selected>쇼핑몰</option>
	        <option value="event">이벤트</option>
	        <option value="photo">포토갤러리</option>
	      </select>
	    </div>
	    <div class="col text-right">
	      <input type="button" value="메인이미지보기" onclick="location.href='${ctp}/study/mainImageList';" class="btn btn-outline-secondary"/>
	    </div>
    </div>
    <br/>
    <div>
    	<textarea name="content" id="CKEDITOR" class="form-control" required></textarea>
    </div>
    <script>
    	CKEDITOR.replace("content",{
    		uploadUrl: "${ctp}/study/mainImage/imageUpload",							/* 여러개의 그림파일을 드래그&드롭으로 처리할 컨트롤러 호출 */
    		filebrowserUploadUrl : "${ctp}/study/mainImage/imageUpload",	/* 파일(이미지) 업로드시 처리할 컨트롤러 호출 */
    		height:460
    	});
    </script>
    <br/>
  	<div>
    	<input type="submit" value="메인이미지올리기" class="btn btn-success"/> &nbsp;
      <input type="reset" value="다시입력" class="btn btn-warning"/> &nbsp;
      <input type="button" value="메인이미지보기" onclick="location.href='${ctp}/';" class="btn btn-secondary"/>
  	</div>
  </form>
</div>
<p><br/></p>
</body>
</html>