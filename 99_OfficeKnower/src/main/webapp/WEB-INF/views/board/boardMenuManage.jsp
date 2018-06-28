<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="게시판" name="pageTitle"/>
</jsp:include>
	<!-- nav 시작 -->
<jsp:include page="/WEB-INF/views/common/nav.jsp">
	<jsp:param value="게시판" name="pageTitle"/>
	<jsp:param value="게시판 관리" name="selectMenu"/>
</jsp:include>	
	<!-- nav 끝 -->
	<style>
	.modify {
		color: rgb(0,125,255);
		cursor: pointer;
	}
	</style>
	<table class="table table-hover">

    <tr>
      <th scope="col">종류</th>
      <th scope="col">게시판 이름</th>
      <th scope="col">관리자</th>
      <th scope="col">만든 날짜</th>
      <th scope="col">사용 여부</th>
      <th scope="col">수정</th>
      <th scope="col">삭제</th>
    </tr>
	<c:if test="${not empty list }">
	<c:forEach var="boardMenu" items="${list }" varStatus="vs">
    <tr>
      <th scope="row">${boardMenu["KIND"]}</th>
      <td>${boardMenu["TITLE"]}</td>
      <td>${boardMenu["USERID"]}</td>
      <td>${boardMenu["CREATEDATE"]}</td>
      <td>${boardMenu["STATUS"] }</td>
      <td class="modify" onclick="location.href='${pageContext.request.contextPath}/board/boardMenuFormUpdate?boardMenuNo=${boardMenu['BOARD_MENU_NO']}'" >수정</td>
      <td class="modify" >
      		<c:if test='${boardMenu["TITLE"] eq "사내공지" }'> <span style="color:red; cursor:pointer">삭제 불가</span> </c:if>
      		<c:if test='${boardMenu["TITLE"] ne "사내공지" }'> <span onclick="location.href='${pageContext.request.contextPath}/board/boardMenuDelete?boardMenuNo=${boardMenu['BOARD_MENU_NO']}'">삭제</span> </c:if>      		
      </td>
    </tr>
    </c:forEach>
	</c:if>

</table>



<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>