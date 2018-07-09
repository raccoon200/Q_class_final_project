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
	<jsp:param value="${SelectCategory}" name="selectMenu" />
</jsp:include>
<strong>${SelectCategory} 카테고리의 예약 내역</strong>
<hr />
<br />
<script>
function fn_reservationNoClick(reservationNo, flag){
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
        	if(flag=='확인') {
        		$("#approval_status").text('승인 대기중');
        		$("#return_button").hide();
        		$("#delete_button").show();
        		$("#reservationViewFrm").attr("action", "${pageContext.request.contextPath}/reservation/reservationDeleteOne");
        	} else {
        		$("#approval_status").text('예약 승인');
        		$("#delete_button").hide();
        		$("#return_button").show();
        		$("#reservationViewFrm").attr("action", "${pageContext.request.contextPath}/reservation/reservationReturn");
        	}
		}
     });
	}
</script>
<table class="table">
	<thead class="thead-light">
		<tr>
			<th scope="col">카테고리</th>
			<th scope="col">자원명</th>
			<th scope="col">사용 목적</th>
			<th scope="col">예약 날짜</th>
			<th scope="col">상태</th>
		</tr>
	</thead>
	<tbody>
	<c:forEach var="CList" items="${CList}">
			<c:if test='${!empty CList}'>
				<tr>
					<td>${CList.category}</td>
					<td>${CList.res_name}</td>
					<td>${CList.purpose==null?'미기입':CList.purpose}</td>
					<td>${CList.startdate}~ ${CList.quitdate}</td>
					<td><button type="button" class="btn btn-light" data-toggle="modal"
				data-target="#reservationView" value="${CList.reservation_no}" onclick="fn_reservationNoClick(this.value, '반납')">상세보기</button></td>
				</tr>
			</c:if>
		</c:forEach>
		<c:if test='${empty CList}'>
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
			<th scope="col">카테고리</th>
			<th scope="col">자원명</th>
			<th scope="col">사용 목적</th>
			<th scope="col">예약 날짜</th>
			<th scope="col">상태</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="CListNull" items="${CListNull}">
			<c:if test='${!empty CListNull}'>
				<tr>
					<td>${CListNull.category }</td>
					<td>${CListNull.res_name }</td>
					<td>${CListNull.purpose==null?'미기입':CListNull.purpose}</td>
					<td>${CListNull.startdate}~ ${CListNull.quitdate}</td>
					<td><button type="button" class="btn btn-light" data-toggle="modal"
				data-target="#reservationView" value="${CListNull.reservation_no}" onclick="fn_reservationNoClick(this.value, '확인')">승인 대기중</button></td>
				</tr>
			</c:if>
		</c:forEach>
		<c:if test='${empty CListNull}'>
			<tr>
				<td colspan="5">데이터가 없습니다!</td>
			</tr>
		</c:if>
	</tbody>
</table>

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
					<button type="submit" class="btn btn-warning" id="return_button" >반납</button>
				</div>
			</form>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/reservation/reservationModal.jsp"/>