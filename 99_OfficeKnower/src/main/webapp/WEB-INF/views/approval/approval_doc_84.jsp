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
	<jsp:param value="기안" name="selectMenu" />
</jsp:include>
<style>
.trtr:hover{
	background:rgb(240,240,240);
}
.trtr{
	cursor:pointer;
}
</style>
<h6 style="font-weight:bold">기안</h6>

<hr />
<p style="color:rgb(200,200,200)">※ 기안 목록</p>
<p style="color:rgb(200,200,200); font-size: 13px;">※ 전체 목록은 내가 기안한, 결재 중인 문서가 나옵니다.</p>

<ul class="nav nav-tabs" id="myTab" role="tablist">
  <li class="nav-item">
    <a class="nav-link active" id="approval-tab" data-toggle="tab" href="#approval" role="tab" aria-controls="approval" aria-selected="true">결재</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" id="breakRequest-tab" data-toggle="tab" href="#breakRequest" role="tab" aria-controls="breakRequest" aria-selected="false">휴가</a>
  </li>
</ul>
<div class="tab-content" id="myTabContent">
  <div class="tab-pane fade show active" id="approval" role="tabpanel" aria-labelledby="approval-tab">
	  	<table class="table table-bordered" id="approvalList" style="width : 100%">
	    <tr style="background:#F6F6F6;">
	      <th scope="col" style="min-width:190px;">문서번호</th>
	      <th scope="col" style="min-width:220px;">제목</th>
	      <th scope="col" style="min-width:80px;">기안자</th>
	      <th scope="col" style="min-width:110px;">기안일</th>
	      <th scope="col" style="min-width:100px;">결재 상태</th>
	    </tr>
	    <c:forEach var="v" items="${approval84List }">
	    <tr class="trtr" onclick='location.href="${pageContext.request.contextPath}/office/approvalView?approval_no=${v.approval_no }&navkind=기안"'>
	    	<td>${v.approval_no }</td>
	    	<td>${v.title }</td>
	    	<td>${v.writer }</td>
	    	<td>${v.writeDate }</td>
	    	<td>${v.status }</td>
	    </tr>
	    </c:forEach>
		</table>
  	
  </div>
 
  <div class="tab-pane fade" id="breakRequest" role="tabpanel" aria-labelledby="breakRequest-tab">
  		<table class="table table-bordered" id="approvalList" style="width : 100%">
	    <tr style="background:#F6F6F6;">
	      <th scope="col" style="min-width:60px;">번호</th>
	      <th scope="col" style="min-width:150px;">작성자</th>
	      <th scope="col" style="min-width:60px;">종류</th>
	      <th scope="col" style="min-width:90px;">첨부파일</th>
	      <th scope="col" style="min-width:110px;">시작일</th>
	      <th scope="col" style="min-width:110px;">종료일</th>
	      <th scope="col" style="min-width:110px;">결재 상태</th>
	    </tr>
	    <c:forEach var="v" items="${breakRequest84List }">
	     <tr class="trtr" onclick='location.href="${pageContext.request.contextPath}/office/approvalBreakRequestView?break_request_no=${v.break_request_no }&navkind=기안"'>
	    	<td>${v.break_request_no}</td>
	    	<td>${v.userid }</td>
	    	<td>${v.kind }</td>
	    	<td>
	    		<c:if test="${v.renamed_file_name != 'no'}"> 
	    			<img style="width:18px" src="${pageContext.request.contextPath }\resources\images\common\board_file_image.PNG" alt="첨부파일" />
	    		</c:if>		
	    	</td>
	    	<td>${v.startdate }</td>
	    	<td>${v.enddate }</td>
	    	<td>${v.status }</td>
	    </tr>
	    </c:forEach>
		</table>
  </div>
</div>



<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>