<%@page import="com.kh.ok.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="인사관리" name="pageTitle"/>
</jsp:include>
<jsp:include page="/WEB-INF/views/common/nav.jsp">
	<jsp:param value="인사관리" name="pageTitle"/>
	<jsp:param value="직원 목록" name="selectMenu"/>
</jsp:include>
<style>

</style>
<div class="insa_management" style="width: 95%;">
	<h5 style="display: inline;">사용자 관리</h5> 
	<div style="float: right!important">
		<span style="right: 0px; margin-right: 20px">사용자   ${list.size()}</span>
	</div>
	<hr />
	<br /><br />
	
<!-- <input type="text" class="form-control"/>
<button class="btn btn-default" type="button"><span class="icon-search"></span></button>
<span aria-hidden="true" class="icon-search" style="font-size: 15px; color: lightgray;"></span>
-->
<form style="float: right;"> 
  <div class="input-group"  style="width: 200px; margin-right: 30px;">
    <input type="text" class="form-control" placeholder="Search...">
    <div class="input-group-btn">
      <button class="btn btn-default" type="submit">
        <i class="icon-search"></i>
      </button>
    </div>
  </div>
</form>
<br /><br />

	<table class="table table-hover">
		<thead class="thead-light">
		<tr>
			<th>이름</th>
			<th>ID</th>
			<th>사내전화</th>
			<th>휴대전화</th>
			<th>소속조직</th>
			<th>직위</th>
			<th>입사일</th>
			<th>직무</th>
			<th>상태</th>
		</tr>
		</thead>
		<tr>
			<td colspan="9">없음</td>
		</tr>
		<tr>
			<td colspan="9">없음</td>
		</tr>
		<tr>
			<td colspan="9">없음</td>
		</tr>
		<tr>
			<td colspan="9">없음</td>
		</tr>
	</table>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>