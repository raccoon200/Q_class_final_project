<%@page import="com.kh.ok.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="예약" name="pageTitle"/>
</jsp:include>
<jsp:include page="/WEB-INF/views/common/nav.jsp">
	<jsp:param value="예약" name="pageTitle"/>
	<jsp:param value="직원 목록" name="selectMenu"/>
</jsp:include>
<strong>나의 예약 목록</strong>
<hr />
<strong>예약 목록</strong>
<br /><br />
<table class="table">
  <thead class="thead-light">
    <tr>
      <th scope="col">예약번호</th>
      <th scope="col">카테고리</th>
      <th scope="col">자원 이름</th>
      <th scope="col">사용 목적</th>
      <th scope="col">예약 날짜</th>
    </tr>
  </thead>
  <tbody>
	  <c:forEach var="list" items="${list}">
	<c:if test='${"Y" eq list.approval_status}'>
	  <tr>
		<td>${list.reservation_no}</td>
		<td>${list.category }</td>
		<td>${list.res_name }</td>
		<td>${list.purpose==null?'미기입':list.purpose}</td>
		<td>${list.startdate}</td>
	  </tr>
	 </c:if> 
	 <c:if test='${"Y" ne list.approval_status }'>
	 <tr>
	 	<td colspan="5">데이터가 없습니다!</td>
	 </tr>
	 </c:if>
	  </c:forEach> 
  </tbody>
</table>
<hr />	  
<br />
<strong>대기 목록</strong>
<br /><br />
<table class="table">
  <thead class="thead-light">
    <tr>
      <th scope="col">예약번호</th>
      <th scope="col">카테고리</th>
      <th scope="col">자원 이름</th>
      <th scope="col">사용 목적</th>
      <th scope="col">예약 날짜</th>
    </tr>
  </thead>
  <tbody>
	  <c:forEach var="list" items="${list}">
	<c:if test='${"N" eq list.approval_status}'>
	  <tr>
		<td>${list.reservation_no}</td>
		<td>${list.category }</td>
		<td>${list.res_name }</td>
		<td>${list.purpose==null?'미기입':list.purpose}</td>
		<td>${list.startdate}</td>
	  </tr>
	 </c:if> 
	 <c:if test='${"N" ne list.approval_status }'>
	 <tr>
	 	<td colspan="5">데이터가 없습니다!</td>
	 </tr>
	 </c:if>
	  </c:forEach> 
  </tbody>
</table>
<hr />
<div class="modal fade" id="reservation" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">예약하기</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <form action="${pageContext.request.contextPath }/member/memberLogin.do" method="post">
	      <div class="modal-body">
	      <table>
	      <tr>
	      <td>
		     자원 이름
		     </td>
		     <td>
	      <select class="selectpicker">
		  <optgroup label="Picnic">
		    <option>Mustard</option>
		    <option>Ketchup</option>
		    <option>Relish</option>
		  </optgroup>
		  <optgroup label="Camping">
		    <option>Tent</option>
		    <option>Flashlight</option>
		    <option>Toilet Paper</option>
		  </optgroup>
		</select>
		</td>
		</tr>
	      </table>
	        <input type="text" class="form-control" name="userId" id="userId" placeholder="아이디" required/>
	        <br />
	        <input type="password" class="form-control" name="password" id="password" placeholder="비밀번호" required />
	      </div>
	      <div class="modal-footer">
	        <button type="submit" class="btn btn-outline-success">로그인</button>
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
	      </div>
	      </form>
	    </div>
	  </div>
	</div>