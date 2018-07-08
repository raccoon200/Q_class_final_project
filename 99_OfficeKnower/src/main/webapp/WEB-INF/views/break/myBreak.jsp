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
#request{
	position: relative;
}
#BreakView{
	position: absolute;
	top: -150px;
	left : 350px;
	width: 60%;
	height: 500px;
	background: white;
	z-index: 1;
	border-radius: 5px;
	border: 1px solid;
	padding: 30px;
}
#close3{
	width: 30px;
	float: right;
	cursor: pointer;
}

.viewFont{
	color : #6699FF;
	cursor: pointer;
}
#innerTableDiv{
	overflow-y: scroll;
}
</style>
<script>
$(function(){
	$("#BreakView").hide();
});
</script>
<div>
	<p id="pFont">휴가 현황</p>
</div>

<hr />
<br /><br />

<div>
<%
	String paramCPage = request.getParameter("cPage");
%>
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
<ul class="nav nav-tabs" id="myTab" role="tablist">
	  <li class="nav-item">
	    <a class="nav-link <%=paramCPage == null?"active":"" %>" id="myBreak-tab" data-toggle="tab" href="#myBreak" role="tab" aria-controls="myBreak" aria-selected="true">내 휴가</a>
	  </li>
	  <li class="nav-item">
	    <a class="nav-link" id="cal-tab" data-toggle="tab" role="tab" href="#Bcalendar" aria-controls="Bcalendar" aria-selected="false">휴가 캘린더</a>
	  </li>
	  
	  <!-- 휴가 신청 관리  tabs-->
	  
	  
	  <c:if test="${memberLoggedIn.grade eq '슈퍼관리자'}">
		  <li class="nav-item">
		    <a class="nav-link <%=paramCPage != null?"active":"" %>" id="request-tab" data-toggle="tab" href="#request" role="tab" aria-controls="request" aria-selected="false">휴가 신청 관리</a>
		  </li>
	  </c:if>
	  
	  <!-- 휴가 신청 관리  tabs end-->
	  
	  
</ul>

</div> 


<br /><br />

<!-- div모음 -->
<div class="tab-content" id="myTabContent">
<!-- 내 휴가 -->
<div class="tab-pane fade <%=paramCPage == null?"show active":"" %>" id="myBreak" role="tabpanel" aria-labelledby="myBreak-tab">
	
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

 <div class="tab-pane fade <%=paramCPage != null?"show active":"" %>" id="request" role="tabpanel" aria-labelledby="request-tab">
 
 	<span style='font-size:18px;'>총 &nbsp;<%=pageNum %> &nbsp;명</span>
 	<br /><br />
 	<table class="table table-bordered">
		  <thead>
		    <tr style="background:#F6F6F6;text-align:center;">
		      <th scope="col">신청자</th>
		      <th scope="col">소속</th>
		      <th scope="col">종류</th>
		      <th scope="col">일수</th>
		      <th scope="col">기간</th>
		      <th scope="col">상태</th>
		      <th scope="col">상세</th>
		      <th scope="col">휴가신청취소</th>
		    </tr>

		    </thead>
		  <tbody>
		  
		  <c:if test="${not empty BreakRequest}">
		  <c:forEach var="bre" items="${BreakRequest}">
			  <tr style='text-align:center;'>
			     <td>${bre.USERNAME}</td>
			     <td>${bre.COM_NAME}</td>
			     <td>${bre.KIND}</td>
			     <td>${bre.BREAKDAYS}</td>
			     <td>${bre.STARTDATE} ~ ${bre.ENDDATE} </td>
   
			     <%-- <c:if test="${bre.APPROVAL_STATUS eq 0}">
			    	 <th>결재 완료</th>
			     </c:if>
			     <c:if test="${bre.APPROVAL_STATUS ne 0}">
			    	 <th>결재 중</th>
			     </c:if> --%>
			     <th>${bre.STATUS}</th>
			     <th><span class='viewFont' onclick="fn_BreakView('${bre.BREAK_REQUEST_NO}');">상세</span></th>
			     <th><span class='viewFont' onclick="fn_deleteBreak('${bre.BREAK_REQUEST_NO}');">휴가신청취소</span></th>
			  </tr>
			</c:forEach>
		   </c:if>
		  </tbody>
		</table>
		
		<!-- 페이지바 -->
		<%=com.kh.ok.board.common.util.Util2s.getPageBar(pageNum, cPage, numPerPage, "myBreak")%>
		
		<!-- 휴가 상세보기  div-->
		<div id="BreakView">
			<div style="font-size:30px;" id="close3">X</div>
			<br />
			<p style="font-size:20px; font-weight:bold; ">휴가 신청 상세</p>
			<br /><br />
			
		<div id="innerTableDiv">
			<table class="table">
			  <thead>
			    <tr>
			      <th scope="col" style="width:300px; background:#F6F6F6; text-align:center;">이름</th>
			      <td><span id="nameInfo"></span></td>
			      <td style="width:150px; background:#F6F6F6; text-align:center;" >상태</td>
			      <td><span id="status"></span></td>
			    </tr>
			  </thead>
			  <tbody>
			    <tr>
			      <th scope="row" style="background:#F6F6F6;text-align:center;">소속</th>
			      <td colspan="3"><span id="com_nameInfo"></span></td>
		   		 </tr>
		   		 <tr>
		   			 <th scope="row" style="background:#F6F6F6;text-align:center;">종류</th>
		   		 	 <td><span id="kindInfo"></span></td>
		   		 	 <th scope="row" style="background:#F6F6F6;text-align:center;">휴가 일수</th>
		   		 	 <td><span id="dayInfo"></span></td>
		   		 </tr>
		   		 <tr>
		   		 	<th scope="row" style="background:#F6F6F6;text-align:center;">기간</th>
		   		 	<td colspan="3"><span id="dateInfo"></span></td>
		   		 </tr>
		   		 <tr>
		   		 	<th scope="row" style="background:#F6F6F6;text-align:center;">사유</th>
		   		 	<td colspan="3"><span id="reasonInfo"></span></td>
		   		 </tr>
		     </tbody>
		</table>
	</div>
			
		</div><!-- 휴가 상세보기 div end-->
		
		
 </div> <!-- 휴가 신청 관리 div끝 -->


</div> <!-- div 모음 끝 -->

<script>

function fn_deleteBreak(breakid){
	
	var bdelete = confirm("휴가신청을 취소하시겠습니까? 신청 취소를 하면 '반려'로 넘어갑니다.");
	
	if(bdelete==true){
		location.href="deleteBreak?breakid="+breakid+"&cPage="+"<%=cPage%>";
		alert("휴가신청이 취소되었습니다.");
	}else if(bdelete==false){
		alert("휴가신청취소가 취소되었습니다.");
	}
	
	
}

function fn_BreakView(breakid){
//	alert("상세보기 " +breakid);
	
	<c:if test="${not empty BreakRequest}">
	
	
	  <c:forEach var="bre" items="${BreakRequest}">
		  if("${bre.BREAK_REQUEST_NO}"==breakid){
			 
		     $("#nameInfo").html("${bre.USERNAME}");
			  
		  
			/*  <c:if test="${bre.APPROVAL_STATUS eq 0}">
		 	 	$("#status").html("결재완료");
		 	 </c:if>
		  	 <c:if test="${bre.APPROVAL_STATUS ne 0}">
		  		$("#status").html("결재중");
		  	 </c:if> */
		  	 $("#status").html("${bre.STATUS}");
		  	 $("#com_nameInfo").html("${bre.COM_NAME}");
		  	 $("#kindInfo").html("${bre.KIND}");
		  	 $("#dayInfo").html("${bre.BREAKDAYS}");
		  	 $("#dateInfo").html("${bre.STARTDATE} ~ ${bre.ENDDATE}");
		  	 $("#reasonInfo").html("${bre.REASON}");
	  	 
		  }else{
			  
		  }
	  
	  </c:forEach>
   </c:if>
	
	$("#BreakView").show();
	
	
}
$("#close3").click(function() {

	$("#BreakView").hide();

});
</script>




<jsp:include page="/WEB-INF/views/common/footer.jsp"/>



