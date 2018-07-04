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
jhvbkljkjh


<c:forEach var="a" items="${address}" >
	
	<table>
	<tr>
		<td>
		${a.name}
		</td>
	</tr>
	</table>
	
	
</c:forEach>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>




<jsp:include page="/WEB-INF/views/common/footer.jsp"/>


