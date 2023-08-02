<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>inquiryUpdate.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
    <script type="text/javascript">
    var sel_files = [];

    $(document).ready(function() {
        $("#file").on("change", handleImgsFileSelect);
    }); 

    function handleImgsFileSelect(e) {
        var files = e.target.files;		// 파일의 정보를 담아온다.
        var filesArr = Array.prototype.slice.call(files);	// 여러개의 파일일경우는 배열로 저장되어 있다. 각 파일객체별로 잘라서 정보를 filesArr배열에 담는다.
        $(".imgs_wrap").html('');	// 기존에 존재하는것들 clear시킨후 아래쪽에서 append시켜준다.

        filesArr.forEach(function(f) {
            if(!f.type.match("image.*")) {
                alert("확장자는 이미지 확장자만 가능합니다.");
                return;
            }

            sel_files.push(f);

            var reader = new FileReader();
            
            reader.onload = function(e) {
                var img_html = "<img src=\"" + e.target.result + "\" /> &nbsp;";
                $(".imgs_wrap").append(img_html);
            }
            reader.readAsDataURL(f);
        });
    }
 
		function fCheck() {
			var title = myForm.title.value;
			var part = myForm.part.value;
			var content = myForm.content.value;
			
			if(title=="") {
				alert("제목을 입력하세요.");
				myForm.title.focus();
				return false;
			}
			else if(part=="") {
				alert("분류를 선택하세요.");
				return false;
			}
			else if(content=="") {
				alert("내용을 입력하세요.");
				myForm.content.focus();
				return false;
			}
			else {
				myForm.submit();
			}
		}
	</script>
	<style type="text/css">
	  th {
	    background-color: #ddd;
	    text-align: center;
	  }
    .imgs_wrap {
        width: 600px;
        margin-top: 50px;
    }
    .imgs_wrap img {
        max-width: 200px;
    }
  </style>	
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"/>
<p><br/></p>
<div class="container">
	<form name="myForm" method="post" enctype="Multipart/form-data">
		<h2 style="font-weight: 600">1:1 문의 작성하기</h2>
		<br/>
		<table class="table table-bordered">
			<tr> 
				<th>제목</th>
				<td><input type="text" name="title" value="${vo.title}" class="form-control" maxlength="100" placeholder="제목을 입력하세요." autofocus /></td>
			</tr>
			<tr> 
				<th>분류</th>
				<td>
					<select name="part" class="form-control" style="width: 200px;">
						<option value="배송지연/불만" ${vo.part == '배송지연/불만' ? 'selected' : ''}>배송지연/불만</option>
						<option value="반품문의"	   ${vo.part == '반품문의' ? 		 'selected' : ''}>반품문의</option>
						<option value="환불문의"		 ${vo.part == '환불문의' ? 		 'selected' : ''}>환불문의</option>
						<option value="회원정보문의"	 ${vo.part == '회원정보문의' ?  'selected' : ''}>회원정보문의</option>
						<option value="기타문의"		 ${vo.part == '기타문의' ? 		 'selected' : ''}>기타문의</option>
					</select>
				</td>
			</tr>
			<tr> 
				<th>주문번호</th>
				<td><input type="text" name="jumunNo" value="${vo.jumunNo}" class="form-control" maxlength="100"/></td>
			</tr>
			<tr> 
				<th>내용</th>
				<td>
					<b>1:1문의 작성 전 확인해주세요!</b><br/><br/>
					현재 문의량이 많아 답변이 지연되고 있습니다. 문의 남겨주시면 2일 이내 순차적으로 답변 드리겠습니다.<br/>
					제품 하자 혹은 이상으로 반품(환불)이 필요한 경우 사진과 함께 구체적인 내용을 남겨주세요.<br/><br/>
					<textarea name="content" rows="5" class="form-control">${vo.content}</textarea>
				</td>
			</tr>
			<tr> 
				<th>이미지</th>
				<td>
					<!-- multiple로 처리할 경우 jsp에서는 여러개의 파일 업로드는 가능하지만, 파일명을 알아오지 못한다. 따라서 이곳에서는 한개 파일만 업로드하는것으로 처리한다. -->
					<!-- <input type="file" multiple="multiple" name="file" id="file" accept=".zip,.jpg,.gif,.png"/><br/><br/> -->
					<input type="file" name=file id="file" accept=".zip,.jpg,.gif,.png"/><br/><br/>
					- 파일 형식은 zip / jpg / gif / png만 허용합니다.(<font color="red">사진을 변경하시면 기존 사진은 삭제됩니다.</font>)
				</td>
			</tr>
			<tr>
			  <th class="m-0 p-0"></th>
			  <td class="m-0 p-0">
				  <span class="imgs_wrap"><c:if test="${!empty vo.FSName}"><img src="${ctp}/inquiry/${vo.FSName}" width="200px"/></c:if></span>
			  </td>
			</tr>
			<tr>
			  <td colspan='2' class="text-center">
			    <input type="button" value="수 정" onclick="fCheck()" class="btn btn-secondary w-25"/> &nbsp;
			    <input type="reset" value="다시입력" class="btn btn-secondary w-25"/> &nbsp;
			    <input type="button" value="돌아가기" onclick="location.href='${ctp}/inquiry/inquiryList?pag=${pag}';" class="btn btn-secondary w-25"/>
			  </td>
			</tr>
		</table>
		<p><br/></p>
		<input type="hidden" name="idx" value="${vo.idx}"/>
		<input type="hidden" name="pag" value="${pag}"/>
		<input type="hidden" name="fName" value="${vo.FName}"/>
		<input type="hidden" name="fSName" value="${vo.FSName}"/>
	</form>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>