<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script> -->
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.3.1.js"></script>
<!-- 부트스트랩관련 라이브러리 -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
<title>게시판</title>
</head>
<body>
	<!-- nav 시작 -->
	
	
	<!-- nav 끝 -->

	<table class="table table-hover">

    <tr>
      <th scope="col">번호</th>
      <th scope="col">제목</th>
      <th scope="col">작성자</th>
      <th scope="col">첨부파일</th>
      <th scope="col">작성일</th>
      <th scope="col">조회수</th>
    </tr>
	<c:if test="${not empty list }">
	<c:forEach var="board" items="${list }" varStatus="vs">
    <tr id='${board["BOARD_NO"] }' onclick="fn_boardView(${board['BOARD_NO']})">
      <th scope="row">${board["BOARD_NO"]}</th>
      <td>${board["TITLE"]}</td>
      <td>${board["WRITER"]}</td>
      <td>${board["RENAMED_FILE_NAME"]}</td>
      <td>${board["WRITEDATE"]}</td>
      <td>${board["COUNT"] }</td>
    </tr>
    </c:forEach>
	</c:if>

</table>

<input type="button" value="글쓰기" onclick="location.href='${pageContext.request.contextPath}/board/boardForm'"/>
<script>
function fn_boardView(no) {
	location.href='${pageContext.request.contextPath }/board/boardView?boardNo='+no;
	
}
</script>

<!-- 페이지바 처리 -->
<% 
int pageNum = Integer.parseInt(String.valueOf(request.getAttribute("pageNum")));
int numPerPage = Integer.parseInt(String.valueOf(request.getAttribute("numPerPage")));	
int cPage=1;
try{
	cPage = Integer.parseInt(request.getParameter("cPage"));
}catch(NumberFormatException e) {
	
}
%>
<%=com.kh.ok.board.common.util.Utils.getPageBar(pageNum, cPage, numPerPage, "boardBasicList")%>

</body>
</html>