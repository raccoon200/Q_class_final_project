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
<script>
$(function(){
	$("#memberListSearch").on("keyup",function(){
		var searchKey = $(this).val().trim();
		var com_no = ${list.get(0).getCom_no()};

		if(searchKey.length==0){
			return;
		}
		$.ajax({
			url:"insaMemberSearch.do",
			data : {searchKey:searchKey,
					com_no:com_no},
			dataType : "json",
			success : function(data){
				console.log(data);
				$("#memberListSearch").text(data.userId);
			},
			error : function(jqxhr, textStatus, errorThrown){
				console.log("ajax실패",jqxhr,textStatus,errorThrown);
			}
		});
	});
	
	
});
</script>
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
    <input type="text" id="memberListSearch" name="userId" class="form-control" placeholder="Search..." value="">
    <div class="input-group-btn">
      <button id="insa_search_button"class="btn btn-default" type="submit">
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
		<c:if test="${empty list}">
			<tr>
				<td colspan="9"></td>
			</tr>
		</c:if>
		<c:if test="${not empty list }">
			<c:forEach var="l" items="${list}">
				<tr>
					<td>${l.getUserName()}</td>
					<td><a style="color:gray; font-weight:bold; text-decoration: underline;" href="#">${l.getUserId()}</a></td>
					<td>${l.getPhone_com()}</td>
					<td>${l.getPhone_cell()}</td>
					<td>${l.getCom_name()}</td>
					<td>${l.getPosition()}</td>
					<td>${l.getJoinDate()}</td>
					<td>${l.getJob()}</td>
					<td>${l.getStatus()}</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
	
	 <%
    	int boardCnt = Integer.parseInt(String.valueOf(request.getAttribute("boardCnt")));
    	int numPerPage = Integer.parseInt(String.valueOf(request.getAttribute("numPerPage")));
    	int cPage = 1;
    	
    	try{
    		cPage = Integer.parseInt(request.getParameter("cPage"));
    	}catch(NumberFormatException e){
    		
    	}
    %>
    <%=com.kh.ok.insa.util.Utils.getPageBar(boardCnt, cPage, numPerPage, "memberManagement.do")%>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>