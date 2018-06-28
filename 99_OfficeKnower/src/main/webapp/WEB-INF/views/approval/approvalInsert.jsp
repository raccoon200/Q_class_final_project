<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="전자결재" name="pageTitle"/>
</jsp:include>
<jsp:include page="/WEB-INF/views/common/nav.jsp">
	<jsp:param value="전자결재" name="pageTitle"/>
</jsp:include>
<style>
span.icon-plus{
	position: absolute;
	top: 10px;
	right: 8px;
	font-weight: bold;
	cursor: pointer;
}
</style>
<h4>작성하기</h4>
<hr />
<h6>기본설정</h6>
<table class="table table-bordered">
	<tbody>
		<tr>
			<th style="width: 110px;" class="table-info">문서종류</th>
			<td scope="col">
				<select name="" id="" class="custom-select" style="width: 49%;">
					<option value="" selected>공용</option>
				</select>
				<select name="" id="" class="custom-select" style="width: 49%;">
					<option value="">선택</option>
					<option value="지결">지출결의서</option>
					<option value="">ㄱㄱㄱㄱㄱㄱ</option>
					<option value="">ㄱㄱㄱㄱㄱㄱ</option>
				</select>
			</td>
			<th style="width: 110px;" class="table-info">작성자</th>
			<td>${memberLoggedIn.com_name} &nbsp;${memberLoggedIn.position} &nbsp; ${memberLoggedIn.userName}</td>
		</tr>
	</tbody>
</table>
<script>
$(function(){
	var year = $("[name=year]").val();
	var month = "${month}";
	$("#spendingFrm").find("[name=title]").val(year+"년 "+month+"월 지출 보고서");
	
	$("#spendingFrm").find("[name=month]").find("option[value=${month}]").attr("selected","selected");
	$("#spendingFrm").find("[name=year]").on("change", function(){
		$("#spendingFrm").find("[name=title]").val($(this).val()+"년 "+$("[name=month]").val()+"월 지출 보고서");
	});
	$("#spendingFrm").find("[name=month]").on("change",function(){
		$("#spendingFrm").find("[name=title]").val($("[name=year]").val()+"년 "+$(this).val()+"월 지출 보고서");
	});
});
</script>
<h6>결재선</h6>
<table class="table-bordered" id="approval_people" style="width: 100%; text-align: center;">
	<tbody>
		<tr style="width: 100%; height: 40px;">
			<th rowspan="3" class="table-info" style="width: 110px; text-align: center; position: relative;">
				신청
				<span class="icon-plus"></span>
			</th>
			<td>${memberLoggedIn.position}</td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr style="height: 80px;">
			<td><div style="width: 130px; height: 70px; display: inline-block;"></div></td>
			<td><div style="width: 130px; height: 70px; display: inline-block;"></div></td>
			<td><div style="width: 130px; height: 70px; display: inline-block;"></div></td>
			<td><div style="width: 130px; height: 70px; display: inline-block;"></div></td>		
		</tr>
		<tr style="height: 40px;">
			<td>${memberLoggedIn.userName}</td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
	</tbody>
</table>
<br />
<div>
	<form action="" id="spendingFrm">
		<h6>상세 입력</h6>
		<hr />
		제목 <input type="text" name="title" id="" class="form-control" style="width:85%; display: inline-block; float: right;"/>
		<br clear="right"/>
		<br />
		<table class="table table-bordered">
			<tbody>
				<tr>
					<th class="table-info" style="width: 110px; text-align: center;">회계기준월</th>
					<td>
						<select name="year" id="" class="custom-select" style="width: 20%;">
							<option selected value='${year}'>${year}</option>
							<option value="${year_1}">${year_1}</option>
							<option value="${year_2}">${year_2}</option>
						</select>
						년 &nbsp;
						<select name="month" id="" class="custom-select" style="width: 20%;">
							<option value='01'>01</option>
							<option value="02">02</option>
							<option value="03">03</option>
							<option value='04'>04</option>
							<option value="05">05</option>
							<option value="06">06</option>
							<option value='07'>07</option>
							<option value="08">08</option>
							<option value="09">09</option>
							<option value='10'>10</option>
							<option value="11">11</option>
							<option value="12">12</option>
						</select>
						월
					</td>
				</tr>
				<tr>
					<th class="table-info" style="width: 110px; text-align: center;">지출자</th>
					<td>
						<input type="text" class="form-control" name="" id="" style="width: 50%;"/>
					</td>
				</tr>
				<tr>
					<th class="table-info" style="width: 110px; text-align: center;">계좌정보</th>
					<td></td>
				</tr>
			</tbody>
		</table>
	</form>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
