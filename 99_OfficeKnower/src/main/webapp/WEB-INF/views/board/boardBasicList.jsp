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
	<jsp:param value="${board_menu_title }" name="selectMenu"/>
</jsp:include>	 
	<!-- nav 끝 -->
	<style>
	table.table tr th{
		background:rgb(230,230,230);
	}
	table.table tr td{
		cursor:pointer;
	}
	</style>
	<p style="font-size:2em; color:rgb(0,125,255);">${board_menu_title }</p>
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
      <td>${board["BOARD_NO"]}</td>
      <td>${board["TITLE"]}</td>
      <td>${board["WRITER"]}</td>
      <td><c:if test='${fn:length(board["RENAMED_FILE_NAME"])>0}' > <img src="${pageContext.request.contextPath}/resources/images/common/board_file_image.PNG" width="20px" alt="" /> </c:if></td>
      <td><fmt:formatDate value='${board["WRITEDATE"]}' type="date"/></td>
      <td>${board["COUNT"] }</td>
    </tr>
    </c:forEach>
	</c:if>

</table>
<%-- 
<input type="button" value="글쓰기" class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/board/boardForm'"/> --%>
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
int board_menu_no = Integer.parseInt(String.valueOf(request.getAttribute("currentMenuNo")));
String board_menu_title= String.valueOf(request.getAttribute("board_menu_title"));
%>
<%=com.kh.ok.board.common.util.Utils.getPageBar(pageNum, cPage, numPerPage, "boardBasicList", board_menu_no, board_menu_title )%>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>