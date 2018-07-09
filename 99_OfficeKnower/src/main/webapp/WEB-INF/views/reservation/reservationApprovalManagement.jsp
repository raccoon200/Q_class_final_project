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
	<jsp:param value="승인 관리" name="selectMenu" />
</jsp:include>

<strong>예약 관리</strong>
<hr />

<br />

<script>
function fn_reservationViewClick(reservationNo, flag){
	$.ajax({
		url : "selectOneReservationNo.do", 
        dataType : "json",
        data : {reservationNo:reservationNo},  
        contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
        success : function(data) {
        	console.log(data);
        	$("#res_name").text(data.res_name);
        	$("#reservation_date").text(data.startdate+' ~ '+data.quitdate);
        	$("#writer").text(data.writer);
        	$("#purpose").text(data.purpose);
        	$("#reservation_no").val(data.reservation_no);
        	
        	if(flag == '대기') {
        		$("#approval_status").text('승인 대기');
        		$("#delete_button").hide();
        	} else if (flag == '승인') {
        		$("#approval_status").text('승인');
        		$("#reservationViewFrm").attr("action", "${pageContext.request.contextPath}/reservation/reservationDeleteOne?flag="+'승인');
        		$("#delete_button").show();
        	} else if (flag == '반려') {
        		$("#approval_status").text('반려');
        		$("#reservationViewFrm").attr("action", "${pageContext.request.contextPath}/reservation/reservationDeleteOne?flag="+'반려');
        		$("#delete_button").show();
        	}
			
        }
     });
	}
function fn_validate() {
	return confirm("정말로 삭제하시겠습니까?")?true:false;
}

function fn_reservationYesClick(reservation_no) {
	if(confirm("해당 회원의 요청을 승인하시겠습니까?")) {
		location.href = '${pageContext.request.contextPath}/reservation/reservationYesClick?reservation_no='+reservation_no;
	}
}

function fn_reservationNotClick(reservation_no) {
	if(confirm("해당 회원의 요청을 반려하시겠습니까?")) {
		location.href = '${pageContext.request.contextPath}/reservation/reservationNotClick?reservation_no='+reservation_no;
	}
}
</script>
<ul class="nav nav-tabs" id="myTab" role="tablist">
  <li class="nav-item">
    <a class="nav-link active" id="listNull-tab" data-toggle="tab" href="#listNull" role="tab" aria-controls="listNull" aria-selected="true">승인 대기</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" id="listY-tab" data-toggle="tab" href="#listY" role="tab" aria-controls="listY" aria-selected="false">승인</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" id="listN-tab" data-toggle="tab" href="#listN" role="tab" aria-controls="listN" aria-selected="false">반려</a>
  </li>
</ul>
<div class="tab-content" id="myTabContent">
<div class="tab-pane fade show active" id="listNull" role="tabpanel" aria-labelledby="listNull-tab">
<br />
<strong>승인 대기 목록</strong>
<hr />
<table class="table">
	<thead class="thead-light">
		<tr>
			<th scope="col" style="white-space: nowrap;">요청자</th>
			<th scope="col" style="white-space: nowrap;">카테고리</th>
			<th scope="col" style="white-space: nowrap;">자원명</th>
			<th scope="col">예약 날짜</th>
			<th scope="col">설정</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="listN" items="${listNull}">
			<c:if test='${!empty listN}'>
				<tr>
					<td style="white-space: nowrap;">${listN.writer}</td>
					<td style="white-space: nowrap;">${listN.category }</td>
					<td style="white-space: nowrap;">${listN.res_name }</td>
					<fmt:parseDate var="startDate" value="${listN.startdate}" pattern="yyyy-MM-dd HH:mm"/>
					<fmt:parseDate var="quitDate" value="${listN.quitdate}" pattern="yyyy-MM-dd HH:mm"/>
					<td style="white-space: nowrap;"><fmt:formatDate value="${startDate}" pattern="yy/MM/dd HH:mm"/> ~ <fmt:formatDate value="${quitDate}" pattern="yy/MM/dd HH:mm"/></td>
					<td style="white-space: nowrap;">
					<button type="button" class="btn btn-light" value="${listN.reservation_no}" onclick="fn_reservationYesClick(this.value)">승인</button>
					<button type="button" class="btn btn-light" value="${listN.reservation_no}" onclick="fn_reservationNotClick(this.value)">반려</button>
					<button type="button" class="btn btn-light" data-toggle="modal"
				data-target="#reservationView" value="${listN.reservation_no}" onclick="fn_reservationViewClick(this.value, '대기')">상세보기</button></td>
				</tr>
			</c:if>
		</c:forEach>
		<c:if test='${empty listNull}'>
			<tr>
				<td colspan="5">데이터가 없습니다!</td>
			</tr>
		</c:if>
	</tbody>
</table>
<hr />
</div>

<div class="tab-pane fade" id="listY" role="tabpanel" aria-labelledby="listY-tab">
<br />
<strong>승인 목록</strong>
<hr />
<table class="table">
	<thead class="thead-light">
		<tr>
			<th scope="col" style="white-space: nowrap;">작성자</th>
			<th scope="col" style="white-space: nowrap;">카테고리</th>
			<th scope="col" style="white-space: nowrap;">자원명</th>
			<th scope="col">예약 날짜</th>
			<th scope="col">설정</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="list" items="${list}">
			<c:if test='${!empty list}'>
				<tr>
					<td style="white-space: nowrap;">${list.writer}</td>
					<td style="white-space: nowrap;">${list.category }</td>
					<td style="white-space: nowrap;">${list.res_name }</td>
					<fmt:parseDate value="${list.startdate}" var="startDate2" pattern="yyyy-MM-dd HH:mm"/>
					<fmt:parseDate value="${list.quitdate}" var="quitDate2" pattern="yyyy-MM-dd HH:mm"/>
					<td><fmt:formatDate value="${startDate2}" pattern="yy/MM/dd HH:mm"/>~ <fmt:formatDate value="${quitDate2}" pattern="yy/MM/dd HH:mm"/></td>
					<td><button type="button" class="btn btn-light" data-toggle="modal"
				data-target="#reservationView" value="${list.reservation_no}" onclick="fn_reservationViewClick(this.value, '승인')">상세보기</button></td>
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
</div>

<div class="tab-pane fade" id="listN" role="tabpanel" aria-labelledby="listN-tab">
<br />
<strong>반려 목록</strong>
<hr />
<table class="table">
	<thead class="thead-light">
		<tr>
			<th scope="col" style="white-space: nowrap;">작성자</th>
			<th scope="col" style="white-space: nowrap;">카테고리</th>
			<th scope="col" style="white-space: nowrap;">자원명</th>
			<th scope="col">예약 날짜</th>
			<th scope="col">설정</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="listN" items="${listN}">
			<c:if test='${!empty listN}'>
				<tr>
					<td style="white-space: nowrap;">${listN.writer}</td>
					<td style="white-space: nowrap;">${listN.category }</td>
					<td style="white-space: nowrap;">${listN.res_name }</td>
					<fmt:parseDate value="${listN.startdate}" var="startDate3" pattern="yyyy-MM-dd HH:mm"/>
					<fmt:parseDate value="${listN.quitdate}" var="quitDate3" pattern="yyyy-MM-dd HH:mm"/>
					<td><fmt:formatDate value="${startDate3}" pattern="yy/MM/dd HH:mm"/>~ <fmt:formatDate value="${quitDate3}" pattern="yy/MM/dd HH:mm"/></td>
					<td><button type="button" class="btn btn-light" data-toggle="modal"
				data-target="#reservationView" value="${listN.reservation_no}" onclick="fn_reservationViewClick(this.value, '반려')">상세보기</button></td>
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
<hr />
</div>
</div>
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
				action="${pageContext.request.contextPath}/reservation/reservationDeleteOne"
				onsubmit="return fn_validate();"
				method="post"
				id="reservationViewFrm">
				<div class="modal-body">
					<input type="hidden" name="reservation_no" id="reservation_no"/>
					<table class="table">
					<tr>
					<th>자원명</th>
					<td><label id="res_name"/></td>
					</tr>
					<tr>
					<th>예약 시간</th>
					<td><label id="reservation_date"/></td>
					</tr>
					<tr>
					<th>등록자</th>
					<td><label id="writer"/></td>
					</tr>
					<tr>
					<th>사용 용도</th>
					<td><label id="purpose"/></td>
					</tr>
					<tr>
					<th>예약 상태</th>
					<td><label id="approval_status"/></td>
					</tr>
					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-light"
						data-dismiss="modal">확인</button>
   					<input type="submit" value="삭제" class="btn btn-secondary" id="delete_button"/>    		
				</div>
			</form>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/reservation/reservationModal.jsp"/>
