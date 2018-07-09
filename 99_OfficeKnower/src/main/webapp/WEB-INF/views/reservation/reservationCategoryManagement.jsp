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
<button type="button" class="btn btn-secondary" data-toggle="modal"
				data-target="#category_add">추가하기</button>
<br />
<br />
<table class="table">
	<thead class="thead-light">
	<tr>
	<th>카테고리 이름</th>
	<th>카테고리 설명</th>
	<th>자원수</th>
	<th>관리</th>
	</tr>
	</thead>
	<c:forEach var="list" items="${categoryListCnt}">		
	<tr>
	<td>${list.CATEGORY}</td>
	<td>${list.CATEGORY_PURPOSE}</td>
	<td>${list.RES_CNT}</td>
	<td>
	<button type="button" data-toggle="modal"
				data-target="#category_update" class="btn btn-light" onclick="fn_updateClick(this.value);" value="${list.CATEGORY}">수정</button>
	<button type="button" class="btn btn-light" onclick="fn_deleteClick(this.value);" value="${list.CATEGORY}">삭제</button>
	</td>
	</tr>
	</c:forEach>
</table>

<div class="modal fade" id="category_add" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">카테고리 추가</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<form action="${pageContext.request.contextPath}/reservation/reservationCategoryAdd" onsubmit="return fn_cateValidate();">
				<div class="modal-body"> 
					<table class="table">
					<tr>
					<td>
					<label for="category">카테고리 이름</label>
					</td>
					<td>
					<input type="text" name="category" id="category" required/>
					</td>
					</tr>
					<tr>
					<td>
					<label for="category_purpose">카테고리 설명</label></td>
					<td>
					<textarea name="category_purpose" id="category_purpose" cols="30" rows="2"></textarea></td>
					</tr>				
					</table>
					</div>
				<div class="modal-footer">
						<button type="submit" class="btn btn-outline-primary">추가</button>
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">취소</button>
				</div>
			</form>
		</div>
	</div>
</div>
<script>
function fn_cateValidate() {
	<c:forEach var="list" items="${categoryListCnt}">
		if("${list.CATEGORY}"==$("#category").val()) {
			alert("카테고리명이 이미 있습니다");
			return false;
		}	
	</c:forEach>
	return true;
}
</script>
<div class="modal fade" id="category_update" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">카테고리 수정</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<form action="${pageContext.request.contextPath}/reservation/reservationCategoryUpdate" onsubmit="return fn_updateValidate();">
				<div class="modal-body"> 
					<table class="table">
					<tr>
					<td>
					<label for="category_">카테고리 이름</label>
					</td>
					<td>
					<input type="text" name="category" id="category_" required/>
					<input type="hidden" name="category_origin" id="category_origin" required/>
					<input type="hidden" id="category_res_cnt"/>
					</td>
					</tr>
					<tr>
					<td>
					<label for="category_purpose">카테고리 설명</label></td>
					<td>
					<textarea name="category_purpose" id="category_purpose_" cols="30" rows="2"></textarea></td>
					</tr>				
					</table>
					</div> 
				<div class="modal-footer">
						<button type="submit" class="btn btn-outline-primary" >수정</button>
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">취소</button>
				</div>
			</form> 
		</div>
	</div>
</div>	
<script>
function fn_updateClick(category) {
	<c:forEach var="list" items="${categoryListCnt}">
		if(category=="${list.CATEGORY}") {
			
			$("#category_update").find("#category_").val('${list.CATEGORY}');
			$("#category_update").find("#category_origin").val('${list.CATEGORY}');
			if('${list.CATEGORY_PURPOSE}'!='미기입') { 
			$("#category_update").find("#category_purpose_").val('${list.CATEGORY_PURPOSE}');
			}
			$("#category_update").find("#category_res_cnt").val('${list.RES_CNT}');
		}
	</c:forEach>
}
function fn_updateValidate() {
	if($("#category_res_cnt").val()!="0") {
		alert("해당 카테고리는 자원을 가지고 있어서 수정할 수 없습니다. \n 자원을 삭제한 뒤 다시 시도하십시오.");
		return false;
	}
	<c:forEach var="list" items="${categoryListCnt}">
		if("${list.CATEGORY}"==$("#category_").val()&& "${list.CATEGORY}"!=$("#category_origin").val()) {
			alert("카테고리명이 이미 있습니다");
			return false;
		}
	</c:forEach>
	return true;
}
function fn_deleteClick(category) {
	if(confirm('카테고리 삭제 시, 자원에 대한 모든 예약 기록이 삭제되며 복구할 수 없습니다.')) {
		$.ajax({
			type: 'post',
			url: 'reservationCategoryDelete',
			dataType: 'json',
			data: {category: category},
			success:function(data) {
				alert(data.msg);
				location.href='reservationCategoryManagement';
			} 			
		});
	}
}
</script>
<jsp:include page="/WEB-INF/views/reservation/reservationModal.jsp"/>