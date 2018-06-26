<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="휴가현황" name="pageTitle"/>
</jsp:include>
<jsp:include page="/WEB-INF/views/common/nav.jsp">
	<jsp:param value="인사관리" name="pageTitle"/>
	<jsp:param value="휴가현황" name="selectMenu"/>
</jsp:include> 
<style>
#pFont{
	font-size: 20px;
	font-weight: bold;
	margin-top:20px;
}
th{
	text-align: center;
}
#tblBreak{
	width : 90%;
}
#spanFont{
	font-size: 18px;
	font-weight: bold;
}
</style>
<div>
	<p id="pFont">휴가 현황</p>
</div>

<hr />
<br /><br />

<div>
	<ul class="nav nav-tabs">
	  <li class="nav-item">
	    <a class="nav-link " href="${pageContext.request.contextPath}/break/myBreak.do" >내 휴가</a>
	  </li>
	  <li class="nav-item">
	    <%-- <a class="nav-link" href="${pageContext.request.contextPath}/break/breakCal.do" id="cal">휴가 캘린더</a> --%>
	    <a class="nav-link" id="cal">휴가 캘린더</a>
	  </li>
	  <li class="nav-item">
	    <a class="nav-link" href="#">휴가 신청 관리</a>
	  </li>
	  
	</ul>
</div>
<script>

$(function(){
	$("#breakCal").hide();
});


$("#cal").on('click', function() {
   $("#break").hide();
   $("#breakCal").show();

});
</script>

<br /><br />

<!-- 내 휴가 -->
<div id="break">
	
		<c:if test="${not empty myBreak}">
		  <c:forEach var="bre" items="${myBreak}">
			   
			 <span id="spanFont"> 휴가현황 </span>  &nbsp;
			    총 휴가 ${bre.regular_break + bre.reward_break}일 /
			    사용 ${bre.regular_used_break + bre.reward_used_break}일 /
			    잔여 ${(bre.regular_break + bre.reward_break)- (bre.regular_used_break +bre.reward_used_break)}일
			  (정기 ${bre.regular_break - bre.regular_used_break}일, 포상 ${bre.reward_break - bre.reward_used_break}일)
			</c:forEach>
		   </c:if>
	
	<br />
	
		<table class="table table-bordered">
		  <thead>
		    <tr style="background:#F6F6F6;">
		      <th scope="col" rowspan="2">이름</th>
		      <th scope="col" colspan="2">휴가</th>
		      <th scope="col" colspan="2">사용 휴가</th>
		      <th scope="col" colspan="2">잔여 휴가</th>
		    </tr>
		  
		    <tr style="background:#F6F6F6;"> 
		      <td>정기</td>
		      <td>포상</td>
		      <td>정기</td>
		      <td>포상</td>
		      <td>정기</td>  
		      <td>포상</td>  
		    </tr>
		    </thead>
		  <tbody>
		  
		  <c:if test="${not empty myBreak}">
		  <c:forEach var="bre" items="${myBreak}">
			    <tr>
			      <th scope="row" style="width:180px;" >${bre.username}</th>
			      <td>${bre.regular_break}일</td>
			      <td>${bre.reward_break}일</td>
			      <td>${bre.regular_used_break}일</td>
			      <td>${bre.reward_used_break}일</td>
			      <td> ${bre.reward_break - bre.regular_used_break}일</td>
			      <td>${bre.reward_break - bre.regular_used_break}일</td>
			    </tr>
			</c:forEach>
		   </c:if>
		  </tbody>
		</table>
	

</div> <!-- 내 휴가 탭 -->


<!-- 휴가캘린더 -->
<div id="breakCal">

	<jsp:include page="/WEB-INF/views/break/breakCal.jsp"/>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>




