<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="예약" name="pageTitle" />
</jsp:include>
<jsp:include page="/WEB-INF/views/common/nav.jsp">
	<jsp:param value="예약" name="pageTitle" />
	<jsp:param value="카테고리 관리" name="selectMenu" />
</jsp:include>
<strong>카테고리 관리</strong>
<hr />
<br />
<strong>카테고리 목록</strong>
<a href=""><span class="sms_plus"></span>추가하기</a>
<br />
<br />
<table class="table">
	<thead class="thead-light">
	<tr>
	<th>카테고리 이름</th>
	<th>자원수</th>
	<th>관리</th>
	</tr>
	</thead>
	<c:forEach var="list" items="${categoryListCnt}">		
	<tr>
	<td>${list.CATEGORY}</td>
	<td>${list.RES_CNT}</td>
	<td><button type="button" class="btn btn-light">수정</button>
	<button type="button" class="btn btn-light">삭제</button>
	</td>
	</tr>
	</c:forEach>
</table>