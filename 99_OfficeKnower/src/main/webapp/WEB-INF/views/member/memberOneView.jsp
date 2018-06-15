<%@page import="com.kh.ok.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script> -->
<jsp:include page="/WEB-INF/views/common/office_main.jsp">
	<jsp:param value="" name="pageTitle"/>
</jsp:include>
<h3>내 정보 관리</h3>
<hr />
<div class="table-responsive">
	<table class="table table-hover">
		<tr>
			<th>이름</th>
			<td>
				${member.userName}
			</td>
		</tr>
		<tr>
			<th>소속</th>
			<td>
				${member.dept}
			</td>
		</tr>
		<tr>
			<th>직위</th>
			<td>
				${member.position}
			</td>
		</tr>
		<tr>
			<th>직무</th>
			<td>
				${member.job}
			</td>
		</tr>
		<tr>
			<th>사내 전화</th>
			<td>
				${member.phoneCom }
			</td>
		</tr>
		<tr>
			<th>휴대전화</th>
			<td>
				${member.phoneCell }
			</td>
		</tr>
		<tr>
			<th>개인 이메일</th>
			<td>
				${member.email }
			</td>
		</tr>
		<tr>
			<th>사번</th>
			<td>
				${member.empNo }
			</td>
		</tr>
		<tr>
			<th>입사일</th>
			<td>
				${member.joinDate }
			</td>
		</tr>
		<tr>
			<th>생년월일</th>
			<td>
				${member.birthday }
			</td>
		</tr>
		<tr>
			<th>자택주소</th>
			<td>
				${member.address }
			</td>
		</tr>
		<tr>
			<th>기타정보</th>
			<td>
				${member.etcInf }
			</td>
		</tr>
	</table>
</div>



<%-- <jsp:include page="/WEB-INF/views/common/footer.jsp"/> --%> 