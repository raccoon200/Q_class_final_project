<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.kh.ok.address.model.vo.*, java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!doctype html>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="주소록" name="pageTitle"/>
</jsp:include>

<jsp:include page="/WEB-INF/views/common/nav.jsp">
	<jsp:param value="주소록" name="pageTitle"/>
</jsp:include>

	<style>
	table.table tr th{
		background:rgb(230,230,230);
	
	}
	table.table tr td{
		cursor:pointer;
	}
	</style>
	<p style="font-size:2em; color:rgb(0,125,255);"> </p>
	
	<table class="table table-hover">
    <tr>
      <th scope="col">번호</th>
      <th scope="col">이름</th>
      <th scope="col">이메일</th>
      <th scope="col">전화번호</th>
      <th scope="col">회사명</th>
      <th scope="col">주소</th>
      <th scope="col">삭제</th>
     
    </tr>

	<c:forEach var="addr" items="${address}" varStatus="cou" >
	<tr>
      <td>${cou.count}</td>
      <td>${addr.name}</td>
      <td>${addr.email}</td>
      <td>${addr.phone}</td>
      <td>${addr.company}</td>
      <td>${addr.address}</td>
      <td> <button onclick="fn_deleteAdd('${addr.address_no}');">삭제</button></td>
     </tr>
    </c:forEach>

</table>
<script>
function fn_deleteAdd(addId){
	alert(name+"삭제완료 되었습니다.");
	location.href="addressTrash?addId="+addId;
	
}
</script>
	

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>


