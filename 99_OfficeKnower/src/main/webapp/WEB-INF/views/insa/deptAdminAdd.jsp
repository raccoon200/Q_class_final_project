<%@page import="com.kh.ok.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="인사관리" name="pageTitle"/>
</jsp:include>
<jsp:include page="/WEB-INF/views/common/nav.jsp">
	<jsp:param value="인사관리" name="pageTitle"/>
	<jsp:param value="조직 관리" name="selectMenu"/>
</jsp:include>

<div class="insa_management" style="width: 95%;">
	<h5 style="display: inline;">조직 관리</h5> 
	<div style="float: right!important">
		<span style="right: 0px; margin-right: 20px">사용자   ${boardCnt}</span>
	</div>
	<hr />
	<!-- <p id="admin-add" onclick="fn_newMemberAdd()">+ 사용자 초대</p> -->
	<br />
	
	
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>