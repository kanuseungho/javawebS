<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<ul class="nav headernav justify-content-end m-2" >
	<li class="nav-item">
		<font class="headericon" size="4em"></font>
		<div onclick="location.reload()" style="display:inline-block" class="border"><h3> <i class='bx bx-loader'></i> </h3></div> 관리자 접속시간 : ${sTime} 
	</li>
	<li class="nav-item">
	  <a class="nav-link btn btn-sm btn-outline-info ml-2" href="${ctp}/admin/adminContent">
	  	<font class="headericon" size="4em"></font>HOME
    </a>
  </li>
</ul>