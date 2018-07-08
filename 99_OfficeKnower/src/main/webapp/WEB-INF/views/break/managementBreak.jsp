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
	<jsp:param value="직원 휴가 관리" name="selectMenu"/>
</jsp:include>
<style>
#pFont2{
	font-size: 20px;
	font-weight: bold;
	margin-top:20px;
}
#Info tr, td{
	text-align: center;
}
.updateViewText{
	color: #6699FF;
	cursor: pointer;
}
#outDiv{
	position: relative;
}
#innerUpdate{
	position: absolute;
	border: 1px solid;
	border-radius: 5px;
	top : 30px;
	left: 300px;
	width : 60%;
	height : 500px;
	background: white;
	z-index: 1;
	padding: 30px;
}
#innerView{
	position: absolute;
	border: 1px solid;
	border-radius: 5px;
	top : 30px;
	left: 300px;
	width : 60%;
	height : 450px;
	background: white;
	z-index: 1;
	padding: 15px;
}
.close4{
	float: right;
	cursor: pointer;
}
.nameInFont{
	font-size: 18px;
	font-weight: bold;
}
.tab-content{
	padding: 15px;
}
</style>
<script>

$(function(){
	$("#innerUpdate").hide();
	$("#innerView").hide();
	
	
	$(".close4").click(function() {
	
		$("#innerUpdate").hide();
		$("#innerView").hide();
	
	});
});

function fn_updateBreakInfo(userid){
	$("#innerUpdate").show();
	
	
	<c:if test="${not empty allList}">
	  <c:forEach var="bre" items="${allList}">
		var breUserId = "${bre.USERID}";
		var year = "${bre.JOINDATE}".substring(0,4);
		var mm =  "${bre.JOINDATE}".substring(5,7);
		var dd= "${bre.JOINDATE}".substring(8,10);
		
	
		//alert("mm" + mm);
		
		if(breUserId == userid)		{
			$("#breakUserid").val("${bre.USERID}");
	  		$("#nameInfo").html("${bre.USERNAME} ( ${bre.USERID} )");
	  		$("#joindateInfo").html("입사일 : " + year + "년" + mm + "월" + dd + "일");
	  		$("#pRegular").html("${bre.REGULAR_BREAK}");
	  		$("#beforeRegular").val("${bre.REGULAR_BREAK}");
	  		$("#pReward").html("${bre.REWARD_BREAK}");
	  		$("#beforeReward").val("${bre.REWARD_BREAK}");
		}
	 </c:forEach>
  </c:if>
	
	
}

function fn_ViewBreak(userid,username){
	var userid = userid;
	//alert(userid);
	
	$.ajax({
		url:"searchKindList.do",
		data : {userid:userid},
		dataType : "json",
		success : function(data){
			console.log(data);
			 data = data["kindList"];
			
			 if(data==""){
				 //alert("null아니야...>??");
				 
				 $("#memberName").html(username);
				 $("#memberRegular").html("0");
				 $("#memberReward").html("0");
				 $("#training").html("0");
				 $("#education").html("0");
				 $("#memberEvent").html("0");
				 $("#memberSick").html("0");
				 $("#memberCreate").html("0");
			 }else{
			 
				 for(var index in data){
					 var u =data[index];
					// console.log("여기 들어오긴 하는거지...??그치..???");
					 console.log("연차"+ u.연차);
	
					 console.log("여기는 null이 아닌 것입니다.");
					 $("#memberName").html(u.USERNAME);
					 $("#memberRegular").html(u.연차);
					 $("#memberReward").html(u.포상);
					 $("#training").html(u.훈련);
					 $("#education").html(u.교육);
					 $("#memberEvent").html(u.경조사);
					 $("#memberSick").html(u.병가);
					 $("#memberCreate").html(u.출산);
					 
	 
				} //for문 끝
			 
			 }
				$("#innerView").show();

		},
		error : function(jqxhr, textStatus, errorThrown){
			console.log("ajax실패",jqxhr,textStatus,errorThrown);
		}
	});
	
	
	/* 사용내역 ajax */
	 $.ajax({
		url:"personBreakRequestList.do",
		data : {userid:userid},
		dataType : "json",
		success : function(data){
			 console.log(data);
			 data = data["personBreakRequestList"];
			
			 if(data==""){
				 
				var html ="";
			 	var html2= "";
			 	html += '<table id="Info" class="table table-bordered">';
			 	html +='<thead>';
			 	html += '<tr style="background:#F6F6F6;">';
			 	html += '<th scope="col" rowspan="2">번호</th>';
			 	html += '<th scope="col" rowspan="2">신청자</th>';
			 	html += ' <th scope="col" rowspan="2">휴가 종류</th>';
			 	html += '<th scope="col" >일수</th>';
			 	html += ' <th scope="col">기간</th>';
			 	html += '<th scope="col" rowspan="2">상태</th>';
			 	html += '</tr>';
			 	html += '<tr style="background:#F6F6F6;"> ';
			 	html += '</tr>';
				html += '</thead>';
				html += '<tbody>';
				html += '<tr>';
				html += '<td colspan="6"> 휴가 사용 내역이 없습니다.</td>';
				html += '</tr>';
				
				
			 	html2 += '<table id="Info" class="table table-bordered">';
			 	html2 +='<thead>';
			 	html2 += '<tr style="background:#F6F6F6;">';
			 	html2 += '<th scope="col" rowspan="2">번호</th>';
			 	html2 += '<th scope="col" rowspan="2">신청자</th>';
			 	html2 += ' <th scope="col" rowspan="2">휴가 종류</th>';
			 	html2 += '<th scope="col" >일수</th>';
			 	html2 += ' <th scope="col">기간</th>';
			 	html2 += '<th scope="col" rowspan="2">상태</th>';
			 	html2 += '</tr>';
			 	html2 += '<tr style="background:#F6F6F6;"> ';
			 	html2 += '</tr>';
				html2 += '</thead>';
				html2 += '<tbody>';
				html2 += '<tr>';
				html2 += '<td colspan="6"> 휴가 취소 내역이 없습니다.</td>';
				html2 += '</tr>';
			  
				html += '</tbody>';
			    html += '</table>';
			    
				html2 += '</tbody>';
			    html2 += '</table>';
				 
				 $("#breakRequestListDiv").html(html);
				 $("#breakRequestDeleteListDiv").html(html2);
				
			 }else{
			 	var html ="";
			 	var html2= "";
			 	html += '<table id="Info" class="table table-bordered">';
			 	html +='<thead>';
			 	html += '<tr style="background:#F6F6F6;">';
			 	html += '<th scope="col" rowspan="2">번호</th>';
			 	html += '<th scope="col" rowspan="2">신청자</th>';
			 	html += ' <th scope="col" rowspan="2">휴가 종류</th>';
			 	html += '<th scope="col" >일수</th>';
			 	html += ' <th scope="col">기간</th>';
			 	html += '<th scope="col" rowspan="2">상태</th>';
			 	html += '</tr>';
			 	html += '<tr style="background:#F6F6F6;"> ';
			 	html += '</tr>';
				html += '</thead>';
				html += '<tbody>';
				
				
			 	html2 += '<table id="Info" class="table table-bordered">';
			 	html2 +='<thead>';
			 	html2 += '<tr style="background:#F6F6F6;">';
			 	html2 += '<th scope="col" rowspan="2">번호</th>';
			 	html2 += '<th scope="col" rowspan="2">신청자</th>';
			 	html2 += ' <th scope="col" rowspan="2">휴가 종류</th>';
			 	html2 += '<th scope="col" >일수</th>';
			 	html2 += ' <th scope="col">기간</th>';
			 	html2 += '<th scope="col" rowspan="2">상태</th>';
			 	html2 += '</tr>';
			 	html2 += '<tr style="background:#F6F6F6;"> ';
			 	html2 += '</tr>';
				html2 += '</thead>';
				html2 += '<tbody>';
				
				for(var index in data){
					var c = data[index];
					console.log("c"+c[1]);
					index += 1;
						
					if(c.STATUS=='결재 완료'){
						
						html += '<tr>';
						html += '<th>' + index + '</th>';
						html += '<th>' + username + '</th>';
						html += '<th>' + c.KIND + '</th>';
						html += '<th>' + c.BREAKDAYS + '</th>';
						html += '<th>' + c.STARTDATE +"~" + c.ENDDATE + "</th>";
						html += '<th>' + c.STATUS + '</th>';
					}else if(c.STATUS=='반려'){
						html2 += '<tr>';
						html2 += '<th>' + index + '</th>';
						html2 += '<th>' + username + '</th>';
						html2 += '<th>' + c.KIND + '</th>';
						html2 += '<th>' + c.BREAKDAYS + '</th>';
						html2 += '<th>' + c.STARTDATE +"~" + c.ENDDATE + "</th>";
						html2 += '<th>' + c.STATUS + '</th>';
					}		

					html += '</tr>';
					html2 += '</tr>';
					
             	}
			  
				html += '</tbody>';
			    html += '</table>';
			    
				html2 += '</tbody>';
			    html2 += '</table>';
				 
				 $("#breakRequestListDiv").html(html);
				 $("#breakRequestDeleteListDiv").html(html2);
		 
			 }
	

		},
		error : function(jqxhr, textStatus, errorThrown){
			console.log("ajax실패",jqxhr,textStatus,errorThrown);
		}
	});
	 
	
	
	
}


</script>
<div>
	<p id="pFont2">직원 휴가 관리</p>
</div>
<hr />
<br />

<!-- 직원 휴가 관리 div -->
<div id="outDiv">
<p style="font-size:18px; font-weight:bold;">휴가 현황 조회</p>
<br />
<!-- 휴가 현황 조회 table div -->
<div >
	<table id="Info" class="table table-bordered">
		  <thead>
		    <tr style="background:#F6F6F6;">
		      <th scope="col" rowspan="2">이름</th>
		      <th scope="col" rowspan="2">입사일</th>
		      <th scope="col" rowspan="2">올해 생성</th>
		      <th scope="col" colspan="2">생성 내역</th>
		      <th scope="col" colspan="2">사용현황</th>
		      <th scope="col" rowspan="2">잔여</th>
		      <th scope="col" rowspan="2">수정 &nbsp; |&nbsp; 상세</th>
		    </tr>
		  
		    <tr style="background:#F6F6F6;"> 	  
			    <td>정기</td>
			    <td>포상</td>
			    <td>정기</td>
			    <td>포상</td>
			   <!--  <td>연차</td>
			    <td>포상</td>
			    <td>훈련</td>
			    <td>교육</td>
			    <td>경조사</td>
			    <td>병가</td>
			    <td>출산</td> -->
		    </tr>
		    </thead>
		  <tbody>
		  
		  <c:if test="${not empty allList}">
		  <c:forEach var="bre" items="${allList}">
			    <tr>
			      <th scope="row" style="width:180px;" >${bre.USERNAME}</th>
			      <td> <fmt:formatDate value="${bre.JOINDATE}" pattern="yyyy년 MM월 dd일"/></td>
			     <td>${bre.REGULAR_BREAK + bre.REWARD_BREAK}일</td>
			      <td>${bre.REGULAR_BREAK}일</td>
			      <td>${bre.REWARD_BREAK}일</td>
			      <td> ${bre.REGULAR_USED_BREAK}일</td>
			      <td>${bre.REWARD_USED_BREAK}일</td> 
			      <td>${(bre.REGULAR_BREAK + bre.REWARD_BREAK)-(bre.REGULAR_USED_BREAK+bre.REWARD_USED_BREAK)}일</td> 
			      <td> <span class="updateViewText" onclick="fn_updateBreakInfo('${bre.USERID}')">수정</span> &nbsp;|&nbsp;
			       <span class="updateViewText" onclick="fn_ViewBreak('${bre.USERID}','${bre.USERNAME}')">상세</span></td> 
			    </tr> 
			</c:forEach>
		   </c:if>
		  </tbody>
		</table>
</div><!-- 휴가 현황 조회 table div end-->

<% 
int pageNum = Integer.parseInt(String.valueOf(request.getAttribute("pageNum")));
int numPerPage = Integer.parseInt(String.valueOf(request.getAttribute("numPerPage")));	
System.out.println("view pageNum"+ pageNum);
System.out.println("view numPerPage"+ numPerPage);
int cPage=1;
try{
	cPage = Integer.parseInt(request.getParameter("cPage"));
}catch(NumberFormatException e) {
	
}
%>

<!-- 페이지바 -->
	<%=com.kh.ok.board.common.util.Util2s.getPageBar(pageNum, cPage, numPerPage, "breakManagement.do")%>


<!-- 휴가 수정 div -->
<div id="innerUpdate">
<div style="font-size:30px;" class="close4">X</div>
<p style="font-size:20px;">직원 휴가일 설정</p>
<br />
<span id="nameInfo" class="nameInFont"></span> &nbsp;&nbsp; <span id="joindateInfo" class="nameInFont"></span>
<p>※ 정기 연차와 포상 휴가 일수는 ‘정수’ 단위로 입력할 수 있습니다.</p>
<p>※ 최대 포상휴가는 99일입니다.</p>
<br />

<div>
	<form action="addressBreakUpdate.do" id="BreakUpdateFrm">
		<table class="table table-bordered">		
		  <thead>
		    <tr style="background:#F6F6F6; text-align:center;">
		      <th scope="col" >종류</th>
		      <th scope="col" >현재</th>
		      <th scope="col" >변경 후</th>   
		    </tr>
		  
		    <tr> 	  
			    <td style="background:#F6F6F6;">정기</td>
			    <td>
			    	<span id="pRegular"></span>일
			    	<input type="hidden" name="beforeRegular" id="beforeRegular"/>
			    	<input type="hidden" name="breakUserid" id="breakUserid" />
			    </td>
			    <td>
			    	<input type="number" name="regularVal" id="regularVal" />
			    </td>
		    </tr>
		    <tr> 	  
			    <td  style="background:#F6F6F6;">포상</td>
			    <td>
			    	<span id="pReward"></span>일
			    	<input type="hidden" name="beforeReward" id="beforeReward"/>	    	
			    </td>
			    <td>
			    	<input type="number" name="rewardVal" id="rewardVal" />
			    </td>
		    </tr>
		    <tr>
		    	<th colspan="3" style="text-align: center;">
		    		<input type="button" class="btn btn-outline-primary" value="확인" onclick="fn_submitUpdateInfo()"/>
		    		<input type="button" class="close4 btn btn-outline-danger" style="float: none;" value="취소" />
		    	</th>
		    </tr>
		    </thead>
		</table>
	</form>
</div>
</div>
<!-- 휴가 수정 div end -->

<!-- 휴가 상세 div -->
<div id="innerView">
<div style="font-size:30px;" class="close4">X</div>

<ul class="nav nav-tabs" id="myTab" role="tablist">
  <li class="nav-item">
    <a class="nav-link active" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true">휴가 상세</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile" role="tab" aria-controls="profile" aria-selected="false">사용 내역</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" id="contact-tab" data-toggle="tab" href="#contact" role="tab" aria-controls="contact" aria-selected="false">휴가 취소</a>
  </li>
</ul>

<!-- 휴가 상세 div -->
<div class="tab-content" id="myTabContent" >
  <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
  <br />
  <p>※ 휴가 상세에서는 결재 완료된 휴가와 결재 대기 중인 휴가가 같이 표시됩니다.</p>
  <br />
  
  <div style="overflow-y:auto; height:400px;">
	<table id="Info" class="table table-bordered">
		  <thead>
		    <tr style="background:#F6F6F6;">
		      <th scope="col" rowspan="2">이름</th>
		      <th scope="col" colspan="7">사용현황</th>
		    </tr>
		  
		    <tr style="background:#F6F6F6;"> 	  
			    <td>연차</td>
			    <td>포상</td>
			    <td>훈련</td>
			    <td>교육</td>
			    <td>경조사</td>
			    <td>병가</td>
			    <td>출산</td> 
		    </tr>
		    </thead>
		  <tbody>
		  
		    <tr>
		      <th scope="row"><span id="memberName"></span></th>
		      <td><span id="memberRegular"></span></td>
		      <td><span id="memberReward"></span></td>
		      <td><span id="training"></span></td>
		      <td><span id="education"></span></td>
		      <td><span id="memberEvent"></span></td>
		      <td><span id="memberSick"></span></td>
		      <td><span id="memberCreate"></span></td>
		    </tr> 

		  </tbody>
	</table>
  </div>
  </div><!-- 휴가 상세 div end-->
  
  <!-- 사용 내역 div  -->
  <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
	<br />
  	<p>※ 사용 내역에서는 결재 완료된 휴가를 확인할 수 있습니다.</p>
 	<br />
  	<div id="breakRequestListDiv" style="overflow-y:auto; height:300px;"></div>
	<br />
  </div> <!-- 사용 내역 div end -->
  
  <!-- 휴가 취소 div -->
  <div class="tab-pane fade" id="contact" role="tabpanel" aria-labelledby="contact-tab" >
  	<br />
  	<p>※ 최소된 휴가를 확인할 수 있습니다.</p>
  	<div id="breakRequestDeleteListDiv" style="overflow-y:auto; height:300px;"></div>
 	<br /><br /><br />
  
</div>


</div>


<!-- 휴가 상세 div end-->



</div> <!-- 직원 휴가 관리 div end-->
<script>
function fn_submitUpdateInfo(){
	var rewardDay = $("#rewardVal").val().trim().length;
	var reaultDay = $("#regularVal").val().trim().length;
	
	if(rewardDay==0 && reaultDay==0){
		alert("정기휴가 혹은 포상휴가를 입력하세요.");
		return;
	}
	
	
	if(rewardDay>2){
		alert("최대 포상휴가는 99일입니다.");	
		return;
	}else if(reaultDay>2){
		alert("최대 정규휴가는 99일입니다.");	
		return;
	}else{
		alert("휴가를 수정 완료했습니다.");
		BreakUpdateFrm.submit();
	}
	
	
}


</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/> 