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
	<jsp:param value="자원관리" name="selectMenu" />
</jsp:include>
<strong>자원 관리</strong>
<hr />
<br />
<strong>자원 목록</strong>
<button type="button" class="btn btn-secondary" data-toggle="modal"
				data-target="#resources_add">추가하기</button>
<br /><br />
<table class="table">
	<thead class="thead-light">
	<tr>
	<th>자원명</th>
	<th>카테고리명</th>
	<th>관리</th>
	</tr>
	</thead>
	<c:forEach var="resList" items="${resList}">		
	<tr>
	<td>${resList.resource__name}</td>
	<td>${resList.category}</td>
	<td>
	<button type="button" data-toggle="modal"
				data-target="#resources_update" class="btn btn-light" onclick="fn_resUpdateClick(this.value);" value="${resList.res_no}" >수정</button>
	<button type="button" class="btn btn-light" onclick="fn_resDeleteClick(this.value);" value="${resList.res_no}">삭제</button>
	</td>
	</tr>
	</c:forEach>
</table>

<script>
function fn_resValidate() {
	if($("#resource__name").val()=='') {
		alert('자원명을 입력하세요');
		return false;
	}
	<c:forEach var= "resList" items="${resList}">
		if($("#cateSelect").val()=='${resList.category}') {
			if($("#resource__name").val()=='${resList.resource__name}') {
				alert('해당 카테고리에 같은 자원명이 있습니다.');
				return false;
			}
		}
	</c:forEach> 
	console.log($("[name=resource__name]").val());
	console.log($("select").val());
	return true;
}

</script>
<div class="modal fade" id="resources_add" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">자원 추가</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<form action="${pageContext.request.contextPath}/reservation/reservationResourcesAdd" onsubmit="return fn_resValidate();" method="post">
				<input type="hidden" name="com_no" value="${memberLoggedIn.com_no}" />
				<div class="modal-body"> 
					<table class="table">
					<tr>
					<td>
						<label for="resource__name">자원명</label></td>
					<td>
						<input type="text" name="resource__name" id="resource__name" />
					</td>
					</tr>	
					<tr>
					<td>
					<label for="category">카테고리명</label>
					</td>
					<td>
					<select class="select" id="cateSelect" name="category" >
						<optgroup label="카테고리">
						<c:forEach items="${cateList}" var="cateList">
							<option value="${cateList.CATEGORY}">${cateList.CATEGORY}</option>
						</c:forEach>
						</optgroup>
					</select>
					</td>
					</tr>			
					</table>
					</div>
				<div class="modal-footer">
						<button type="submit" class="btn btn-outline-success">추가</button>
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">취소</button>
				</div>
			</form>
		</div>
	</div>
</div>
<!-- 업데이트 모달 -->
<script>
function fn_resUpdateClick(res_no) {
	<c:forEach var="resList" items="${resList}">
		if(${resList.res_no} == res_no) {
			
		}
	</c:forEach>
}
</script>
<div class="modal fade" id="resources_update" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">자원 추가</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<form action="${pageContext.request.contextPath}/reservation/reservationResourcesUpdate" onsubmit="return fn_resValidate();" method="post">
				<input type="hidden" name="com_no" value="${memberLoggedIn.com_no}" />
				<div class="modal-body"> 
					<table class="table">
					<tr>
					<td>
						<label for="resource__name">자원명</label></td>
					<td>
						<input type="text" name="resource__name" id="resource__name" />
					</td>
					</tr>	
					<tr>
					<td>
					<label for="category">카테고리명</label>
					</td>
					<td>
					<select class="select" id="cateSelect" name="category" >
						<optgroup label="카테고리">
						<c:forEach items="${cateList}" var="cateList">
							<option value="${cateList.CATEGORY}">${cateList.CATEGORY}</option>
						</c:forEach>
						</optgroup>
					</select>
					</td>
					</tr>			
					</table>
					</div>
				<div class="modal-footer">
						<button type="submit" class="btn btn-outline-success">수정</button>
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">취소</button>
				</div>
			</form>
		</div>
	</div>
</div>