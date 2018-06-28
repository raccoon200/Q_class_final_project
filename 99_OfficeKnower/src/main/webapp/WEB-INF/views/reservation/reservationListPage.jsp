<%@page import="com.kh.ok.member.model.vo.Member"%>
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
	<jsp:param value="나의 예약 목록" name="selectMenu" />
</jsp:include>

<strong>나의 예약 목록</strong>
<hr />
<strong>예약 목록</strong>
<br />
<br />
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
			<c:if test='${!empty list}'>
				<tr>
					<td>${list.reservation_no}</td>
					<td>${list.category }</td>
					<td>${list.res_name }</td>
					<td>${list.purpose==null?'미기입':list.purpose}</td>
					<td>${list.startdate}~ ${list.quitdate}</td>
				</tr>
			</c:if>
		</c:forEach>
		<c:if test="${empty list}">
			<tr>
				<td colspan="5">데이터가 없습니다!</td>
			</tr>
		</c:if>
	</tbody>
</table>
<hr />
<br />
<strong>대기 목록</strong>
<br />
<br />
<table class="table">
	<thead class="thead-light">
		<tr>
			<th scope="col">예약번호</th>
			<th scope="col">카테고리</th>
			<th scope="col">자원 이름</th>
			<th scope="col">사용 목적</th>
			<th scope="col">예약 날짜</th>
			<th scope="col">상태</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="listN" items="${listN}">
			<c:if test='${!empty listN}'>
				<tr>
					<td>${listN.reservation_no}</td>
					<td>${listN.category }</td>
					<td>${listN.res_name }</td>
					<td>${listN.purpose==null?'미기입':listN.purpose}</td>
					<td>${listN.startdate}~ ${listN.quitdate}</td>
					<td><button type="button" class="btn btn-light" data-toggle="modal"
				data-target="#reservationView" value="${listN.reservation_no}" onclick="fn_reservationNoClick(this.value)">승인 대기중</button></td>
				</tr>
			</c:if>
		</c:forEach>
		<c:if test='${empty listN}'>
			<tr>
				<td colspan="5">데이터가 없습니다!</td>
			</tr>
		</c:if>
	</tbody>
</table>
<script>
function fn_reservationNoClick(val){
<c:set var="reservationNoClick" value="val"></c:set> 
}
</script>

<hr />
<div class="modal fade" id="reservationView" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">예약 확인</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<form
				action="${pageContext.request.contextPath}/reservation/reservationEnroll"
				method="post">
				<div class="modal-body">
					<table class="table">
					<tr>
					<th>${reservationNoClick}</th>
					</tr>
					</table>
				</div>
				<div class="modal-footer">
					<button type="submit" class="btn btn-outline-success">예약</button>
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">취소</button>
				</div>
			</form>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/reservation/reservationModal.jsp"/>
