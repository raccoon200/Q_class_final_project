<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="전자결재" name="pageTitle" />
</jsp:include>
<jsp:include page="/WEB-INF/views/common/nav.jsp">
	<jsp:param value="전자결재" name="pageTitle" />
	<jsp:param value="데이터 조회" name="selectMenu" />
</jsp:include>

<script>
	$(function() {
	var approvalDataList;
	var str ="";
	<c:forEach items="${approvalDataList}" var="v">
		approvalDataList = ${v.CONTENT};
		
		approvalDataList = JSON.stringify(approvalDataList);
	
		var approvalDataListParse = JSON.parse(approvalDataList);
		var transaction = JSON.stringify(approvalDataListParse.transaction);
		transaction = approvalDataListParse.transaction;
		
		var transactionParse = JSON.parse(transaction);
		for(var i=0; i<transactionParse.length; i++){
			str += "<tr>";
			str += "<td>${v.APPROVAL_NO}</td>";
			str += "<td>"+transactionParse[i].year+'-'+transactionParse[i].month+"</td>";
			str += "<td>${v.USERNAME}</td>";
			str += "<td>"+transactionParse[i].title_of_account+"</td>";
			str += "<td>"+transactionParse[i].price+"원</td>";
			str += "<td>${v.STATUS}</td>";
			str += "</tr>";
						
		}
		
	</c:forEach>
	$("#approvalList").append(str);	
	})
</script>
<h6 style="font-weight:bold">데이터 조회</h6>

<hr />
<p style="font-weight:bold">지출 결의</p>
<br />

<table class="table table-bordered" id="approvalList" style="width : 80%">
    <tr style="background:#F6F6F6;">
      <th scope="col">문서번호</th>
      <th scope="col" >기준월</th>
      <th scope="col">지출자</th>
      <th scope="col">계정 과목</th>
      <th scope="col">금액</th>
      <th scope="col">결재 상태</th>
    </tr>
</table>
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
<%=com.kh.ok.board.common.util.Util2s.getPageBar(pageNum, cPage, numPerPage, "admin/approvalDataList")%>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>