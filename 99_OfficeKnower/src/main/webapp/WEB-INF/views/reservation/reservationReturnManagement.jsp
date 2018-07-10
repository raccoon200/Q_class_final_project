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
	<jsp:param value="반납 관리" name="selectMenu" />
</jsp:include>
<strong>반납 관리</strong>
<hr />
<br />
<ul class="nav nav-tabs" id="myTab" role="tablist">
  <li class="nav-item">
    <a class="nav-link active" id="returnListN-tab" data-toggle="tab" href="#returnListN" role="tab" aria-controls="returnListN" aria-selected="true">반납 대기</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" id="returnListY-tab" data-toggle="tab" href="#returnListY" role="tab" aria-controls="returnListY" aria-selected="false">반납 완료</a>
  </li>
</ul>
<div class="tab-content" id="myTabContent">
  <div class="tab-pane fade show active" id="returnListN" role="tabpanel" aria-labelledby="returnListN-tab">
<br />
<strong>반납 대기</strong>
<hr />
  <table class="table">
	<thead class="thead-light">
		<tr id = "th_catcher">
			<th scope="col" style="white-space: nowrap;">요청자</th>
			<th scope="col">카테고리</th>
			<th scope="col" style="white-space: nowrap;">자원명<th>
			<th scope="col">예약날짜<th>
			<th scope="col">설정</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="returnListN" items="${returnListN}">
			<c:if test='${!empty returnListN}'>
				<tr>
					<td>${returnListN.writer}</td>
					<td>${returnListN.category}</td>
					<td>${returnListN.res_name}</td>
					<fmt:parseDate var="startDate" value="${returnListN.startdate}" pattern="yyyy-MM-dd HH:mm"/>
					<fmt:parseDate var="quitDate" value="${returnListN.quitdate}" pattern="yyyy-MM-dd HH:mm"/>
					<td style="white-space: nowrap;"><fmt:formatDate value="${startDate}" pattern="yy/MM/dd HH:mm"/> ~ <fmt:formatDate value="${quitDate}" pattern="yy/MM/dd HH:mm"/></td>
					<td style="white-space: nowrap;">
					<button type="button" class="btn btn-light" value="${returnListN.reservation_no}" onclick="fn_reservationReturnClick(this.value)">반납 확인</button>
					<button type="button" class="btn btn-light" data-toggle="modal"
				data-target="#reservationView" value="${returnListN.reservation_no}" onclick="fn_reservationViewClick(this.value, '반납 대기')">상세보기</button></td>
				</tr>
			</c:if>
		</c:forEach>
		<c:if test='${empty returnListN}'>
			<tr>
				<td colspan="4">데이터가 없습니다!</td>
			</tr>
		</c:if>
	</tbody>
</table>
</div>
<div class="tab-pane fade" id="returnListY" role="tabpanel" aria-labelledby="returnListY-tab">
<br />
<strong>반납 완료</strong>
<hr />
<table class="table">
	<thead class="thead-light">
		<tr>
			<th scope="col">요청자</th>
			<th scope="col">자원명</th>
			<th scope="col">예약 날짜</th>
			<th scope="col">설정</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="returnListY" items="${returnListY}">
			<c:if test='${!empty returnListY}'>
				<tr>
					<td>${returnListY.writer}</td>
					<td>${returnListY.res_name }</td>
					<fmt:parseDate var="startDate" value="${returnListY.startdate}" pattern="yyyy-MM-dd HH:mm"/>
					<fmt:parseDate var="quitDate" value="${returnListY.quitdate}" pattern="yyyy-MM-dd HH:mm"/>
					<td style="white-space: nowrap;"><fmt:formatDate value="${startDate}" pattern="yy/MM/dd HH:mm"/> ~ <fmt:formatDate value="${quitDate}" pattern="yy/MM/dd HH:mm"/></td>
					<td style="white-space: nowrap;">
					<button type="button" class="btn btn-light" data-toggle="modal"
				data-target="#reservationView" value="${returnListY.reservation_no}" onclick="fn_reservationViewClick(this.value, '반납 승인')">상세보기</button></td>
				</tr>
			</c:if>
		</c:forEach>
		<c:if test='${empty returnListY}'>
			<tr>
				<td colspan="5">데이터가 없습니다!</td>
			</tr>
		</c:if>
	</tbody>
</table>
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
					<button type="button" class="btn btn-outline-primary"
						data-dismiss="modal">확인</button>
				</div>
			</form>
		</div>
	</div>
</div>
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
        	
        	if(flag == '반납 대기') $("#approval_status").text('반납 대기');
        	else if (flag == '반납 승인') $("#approval_status").text('반납 승인');
        }
     });
	}
function fn_reservationReturnClick(reservation_no) {
	if(confirm("반납내역을 확인하셨습니까?")) {
		location.href = '${pageContext.request.contextPath}/reservation/reservationReturnClick?reservation_no='+reservation_no;
	}
}
$(function(){
	$("#th_catcher").children("th:eq(3)").remove();
 	$("#th_catcher").children("th:eq(4)").remove(); 
});
</script>
<jsp:include page="/WEB-INF/views/reservation/reservationModal.jsp"/>
