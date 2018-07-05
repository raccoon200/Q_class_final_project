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
	<jsp:param value="휴가 현황" name="selectMenu"/>
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
	
<ul class="nav nav-tabs" id="myTab" role="tablist">
	  <li class="nav-item">
	    <a class="nav-link active" id="myBreak-tab" data-toggle="tab" href="#myBreak" role="tab" aria-controls="myBreak" aria-selected="true">내 휴가</a>
	  </li>
	  <li class="nav-item">
	    <a class="nav-link" id="cal-tab" data-toggle="tab" role="tab" href="#Bcalendar" aria-controls="Bcalendar" aria-selected="false">휴가 캘린더</a>
	  </li>
	  <li class="nav-item">
	    <a class="nav-link" id="request-tab" data-toggle="tab" href="#request" role="tab" aria-controls="request" aria-selected="false">Contact</a>
	  </li>
</ul>

</div> 


<br /><br />

<!-- div모음 -->
<div class="tab-content" id="myTabContent">
<!-- 내 휴가 -->
<div class="tab-pane fade show active" id="myBreak" role="tabpanel" aria-labelledby="myBreak-tab">
	
		<c:if test="${not empty myBreak}">
		  <c:forEach var="bre" items="${myBreak}">
			   
			 <span id="spanFont"> 휴가현황 </span>  &nbsp;
			    총 휴가 ${bre.regular_break + bre.reward_break}일 /
			    사용 ${bre.regular_used_break + bre.reward_used_break}일 /
			    잔여 ${(bre.regular_break + bre.reward_break)- (bre.regular_used_break +bre.reward_used_break)}일
			  (정기 ${bre.regular_break - bre.regular_used_break}일, 포상 ${bre.reward_break - bre.reward_used_break}일)
			</c:forEach>
		   </c:if>
	
	<br /><br />
	
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
			      <td> ${bre.regular_break - bre.regular_used_break}일</td>
			      <td>${bre.reward_break - bre.regular_used_break}일</td>
			    </tr>
			</c:forEach>
		   </c:if>
		  </tbody>
		</table>
	

</div> <!-- 내 휴가 탭 -->




<!-- 휴가캘린더 -->
 <div class="tab-pane fade" id="Bcalendar" role="tabpanel" aria-labelledby="cal-tab">
	<div id="breakCal">
	
		<jsp:include page="/WEB-INF/views/break/breakCal.jsp"/>
	</div>
</div> <!-- 휴가 캘린더 탭 끝 -->

<!-- 휴가 신청 관리 -->

 <div class="tab-pane fade" id="request" role="tabpanel" aria-labelledby="request-tab">
 
 	휴가 신청 관리 div
 	<table class="table table-bordered">
		  <thead>
		    <tr style="background:#F6F6F6;">
		      <th scope="col">신청자</th>
		      <th scope="col" >소속</th>
		      <th scope="col" >종류</th>
		      <th scope="col">일수</th>
		      <th scope="col">기간</th>
		      <th scope="col">상태</th>
		      <th scope="col">상세</th>
		      <th scope="col">휴가신청취소</th>
		    </tr>

		    </thead>
		  <tbody>
		  
		  <c:if test="${not empty myBreak}">
		  <c:forEach var="bre" items="${myBreak}">
			  
			</c:forEach>
		   </c:if>
		  </tbody>
		</table>

 </div>

</div> <!-- div 모음 끝 -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>




