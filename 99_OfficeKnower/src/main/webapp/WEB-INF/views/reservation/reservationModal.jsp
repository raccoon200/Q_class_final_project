<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<script>
$(function() {
$("#datepicker1").datepicker(
		{
			dateFormat : 'yy-mm-dd',
			prevText : '이전 달',
			nextText : '다음 달',
			monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월',
					'8월', '9월', '10월', '11월', '12월' ],
			monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월',
					'7월', '8월', '9월', '10월', '11월', '12월' ],
			dayNames : [ '일', '월', '화', '수', '목', '금', '토' ],
			dayNamesShort : [ '일', '월', '화', '수', '목', '금', '토' ],
			dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
			showMonthAfterYear : true,
			changeMonth : true,
			changeYear : true,
			yearSuffix : '년',
			minDate : 0,
			beforeShowDay: noSundays
		});
//일요일만 선택 막기  
function noSundays(date) {  
 return [date.getDay() != 0, ''];  
} 

var date = new Date();

var year = date.getFullYear(); //년도
var month = date.getMonth() + 1; //월
var day = date.getDate(); //일

if ((day + "").length < 2) { // 일이 한자리 수인 경우 앞에 0을 붙여주기 위해
	day = "0" + day;
}
if ((month + "").length < 2) { // 일이 한자리 수인 경우 앞에 0을 붙여주기 위해
	month = "0" + month;
}
var getToday = year + "-" + month + "-" + day; // 오늘 날짜 (2017-02-07)

$("#datepicker1").val(getToday);
});

function fn_enrollValidate() {
	
	if($("#selectpicker").val()==null) {
		alert('자원을 선택하지 않았습니다\r\n카테고리, 자원을 만든 뒤 다시 시도하세요.');
		return false;
	}
	if($("[name=start] option:selected").val().substring(0,2)+$("[name=start] option:selected").val().substring(3,5)>
	$("[name=end] option:selected").val().substring(0,2)+$("[name=end] option:selected").val().substring(3,5)){
		alert("시간을 잘못 입력하셨습니다.");
		return false;
	}
	if($("[name=start] option:selected").val().substring(0,2)+$("[name=start] option:selected").val().substring(3,5)==
	$("[name=end] option:selected").val().substring(0,2)+$("[name=end] option:selected").val().substring(3,5)){
		alert("시간을 잘못 입력하셨습니다.");
		return false;
	}
	return true;
}
</script>

<div class="modal fade" id="reservation" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">예약하기</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<form
					action="${pageContext.request.contextPath}/reservation/reservationEnroll"
					method="post"
					onsubmit="return fn_enrollValidate();">
					<div class="modal-body">
						<table class="table">
							<tr>
								<td>자원명</td>
								<td><select class="selectpicker" name="res_name" id="selectpicker">
										<%-- <c:if test="${!empty resources }"> --%>
											<%-- <c:forEach var="a" begin="0" end="${fn:length(resources)}"
												step="1"> --%>
												<c:forEach var="category" items="${category}">	
												<optgroup label="${category.CATEGORY}">
													<c:forEach items="${resources}" var="resource">
														<c:if test="${category.CATEGORY eq resource.CATEGORY}">
															<option value="${resource.CATEGORY}*${resource.RES_NO}*${resource.RESOURCE__NAME}">${resource.RESOURCE__NAME}</option>
														</c:if>
														
														<br />
													</c:forEach>
											</c:forEach>
											</optgroup>
										<%-- </c:if> --%>
								</select></td>
							</tr>
							<tr>
								<td>예약날짜</td>
								<td><input type="text" name="startdate" id="datepicker1"></td>
							</tr>
							<tr>
								<td>예약시간</td>
								<td>
								<select name="start" class="select-box" style="width: 125px;">
									<option value="00:00">오전 0:00</option>
									<option value="00:30">오전 0:30</option>
									<option value="01:00">오전 1:00</option>
									<option value="01:30">오전 1:30</option>
									<option value="02:00">오전 2:00</option>
									<option value="02:30">오전 2:30</option>
									<option value="03:00">오전 3:00</option>
									<option value="03:30">오전 3:30</option>
									<option value="04:00">오전 4:00</option>
									<option value="04:30">오전 4:30</option>
									<option value="05:00">오전 5:00</option>
									<option value="05:30">오전 5:30</option>
									<option value="06:00">오전 6:00</option>
									<option value="06:30">오전 6:30</option>
									<option value="07:00">오전 7:00</option>
									<option value="07:30">오전 7:30</option>
									<option value="08:00">오전 8:00</option>
									<option value="08:30">오전 8:30</option>
									<option value="09:00">오전 9:00</option>
									<option value="09:30">오전 9:30</option>
									<option value="10:00">오전 10:00</option>
									<option value="10:30">오전 10:30</option>
									<option value="11:00">오전 11:00</option>
									<option value="11:30">오전 11:30</option>
									<option value="12:00">오후 12:00</option>
									<option value="12:30">오후 12:30</option>
									<option value="13:00">오후 1:00</option>
									<option value="13:30">오후 1:30</option>
									<option value="14:00">오후 2:00</option>
									<option value="14:30">오후 2:30</option>
									<option value="15:00">오후 3:00</option>
									<option value="15:30">오후 3:30</option>
									<option value="16:00">오후 4:00</option>
									<option value="16:30">오후 4:30</option>
									<option value="17:00">오후 5:00</option>
									<option value="17:30">오후 5:30</option>
									<option value="18:00">오후 6:00</option>
									<option value="18:30">오후 6:30</option>
									<option value="19:00">오후 7:00</option>
									<option value="19:30">오후 7:30</option>
									<option value="20:00">오후 8:00</option>
									<option value="20:30">오후 8:30</option>
									<option value="21:00">오후 9:00</option>
									<option value="21:30">오후 9:30</option>
									<option value="22:00">오후 10:00</option>
									<option value="22:30">오후 10:30</option>
									<option value="23:00">오후 11:00</option>
									<option value="23:30">오후 11:30</option>
								</select>
								~
								<select name="end" class="select-box" style="width: 125px;">
									<option value="00:00">오전 0:00</option>
									<option value="00:30">오전 0:30</option>
									<option value="01:00">오전 1:00</option>
									<option value="01:30">오전 1:30</option>
									<option value="02:00">오전 2:00</option>
									<option value="02:30">오전 2:30</option>
									<option value="03:00">오전 3:00</option>
									<option value="03:30">오전 3:30</option>
									<option value="04:00">오전 4:00</option>
									<option value="04:30">오전 4:30</option>
									<option value="05:00">오전 5:00</option>
									<option value="05:30">오전 5:30</option>
									<option value="06:00">오전 6:00</option>
									<option value="06:30">오전 6:30</option>
									<option value="07:00">오전 7:00</option>
									<option value="07:30">오전 7:30</option>
									<option value="08:00">오전 8:00</option>
									<option value="08:30">오전 8:30</option>
									<option value="09:00">오전 9:00</option>
									<option value="09:30">오전 9:30</option>
									<option value="10:00">오전 10:00</option>
									<option value="10:30">오전 10:30</option>
									<option value="11:00">오전 11:00</option>
									<option value="11:30">오전 11:30</option>
									<option value="12:00">오후 12:00</option>
									<option value="12:30">오후 12:30</option>
									<option value="13:00">오후 1:00</option>
									<option value="13:30">오후 1:30</option>
									<option value="14:00">오후 2:00</option>
									<option value="14:30">오후 2:30</option>
									<option value="15:00">오후 3:00</option>
									<option value="15:30">오후 3:30</option>
									<option value="16:00">오후 4:00</option>
									<option value="16:30">오후 4:30</option>
									<option value="17:00">오후 5:00</option>
									<option value="17:30">오후 5:30</option>
									<option value="18:00">오후 6:00</option>
									<option value="18:30">오후 6:30</option>
									<option value="19:00">오후 7:00</option>
									<option value="19:30">오후 7:30</option>
									<option value="20:00">오후 8:00</option>
									<option value="20:30">오후 8:30</option>
									<option value="21:00">오후 9:00</option>
									<option value="21:30">오후 9:30</option>
									<option value="22:00">오후 10:00</option>
									<option value="22:30">오후 10:30</option>
									<option value="23:00">오후 11:00</option>
									<option value="23:30">오후 11:30</option>
								</select>
								</td>
								</tr>
								<tr>
								<td>사용용도</td>
								<td><textarea name="purpose"></textarea></td>
								</tr>

						</table>
					</div>
					<div class="modal-footer">
						<button type="submit" class="btn btn-outline-primary">예약</button>
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">취소</button>
					</div>
				</form>
			</div>
		</div>
	</div>

