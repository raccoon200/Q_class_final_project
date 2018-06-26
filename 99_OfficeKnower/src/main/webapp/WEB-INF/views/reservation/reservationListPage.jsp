<%@page import="com.kh.ok.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="예약" name="pageTitle"/>
</jsp:include>
<jsp:include page="/WEB-INF/views/common/nav.jsp">
	<jsp:param value="예약" name="pageTitle"/>
	<jsp:param value="직원 목록" name="selectMenu"/>
</jsp:include>
<strong>나의 예약 목록</strong>
<hr />
<strong>예약 목록</strong>
<br /><br />
<table class="table">
  <thead class="thead-light">
    <tr>
      <th scope="col">예약번호</th>
      <th scope="col">카테고리</th>
      <th scope="col">자원 이름</th>
      <th scope="col">사용 목적</th>
      <th scope="col">예약 날짜</th>
    </tr>
  </thead>
  <tbody>
	  <c:forEach var="list" items="${list}">
	<c:if test='${"Y" eq list.approval_status}'>
	  <tr>
		<td>${list.reservation_no}</td>
		<td>${list.category }</td>
		<td>${list.res_name }</td>
		<td>${list.purpose==null?'미기입':list.purpose}</td>
		<td>${list.startdate}</td>
	  </tr>
	 </c:if> 
	 <c:if test='${"Y" ne list.approval_status }'>
	 <tr>
	 	<td colspan="5">데이터가 없습니다!</td>
	 </tr>
	 </c:if>
	  </c:forEach> 
  </tbody>
</table>
<hr />	  
<br />
<strong>대기 목록</strong>
<br /><br />
<table class="table">
  <thead class="thead-light">
    <tr>
      <th scope="col">예약번호</th>
      <th scope="col">카테고리</th>
      <th scope="col">자원 이름</th>
      <th scope="col">사용 목적</th>
      <th scope="col">예약 날짜</th>
    </tr>
  </thead>
  <tbody>
	  <c:forEach var="list" items="${list}">
	<c:if test='${"N" eq list.approval_status}'>
	  <tr>
		<td>${list.reservation_no}</td>
		<td>${list.category }</td>
		<td>${list.res_name }</td>
		<td>${list.purpose==null?'미기입':list.purpose}</td>
		<td>${list.startdate}</td>
	  </tr>
	 </c:if> 
	 <c:if test='${"N" ne list.approval_status }'>
	 <tr>
	 	<td colspan="5">데이터가 없습니다!</td>
	 </tr>
	 </c:if>
	  </c:forEach> 
  </tbody>
</table>
<hr />
