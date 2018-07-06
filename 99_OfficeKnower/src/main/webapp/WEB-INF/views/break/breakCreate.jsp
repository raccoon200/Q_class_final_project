<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="휴가 생성" name="pageTitle"/>
</jsp:include>
<jsp:include page="/WEB-INF/views/common/nav.jsp">
	<jsp:param value="인사관리" name="pageTitle"/>
	<jsp:param value="휴가 생성" name="selectMenu"/>
</jsp:include> 
<style>
#pFont2{
	font-size: 20px;
	font-weight: bold;
	margin-top:20px;
}
#rewardBreak{
	width : 90%;
	height : 600px;
	position:relative;
}
#divInnerBox{
	width : 800px;
	height : 800px;
	background: white;
	border-radius:5px;
	border:1px solid black;
	position:absolute; top:-150px; left: 300px; z-index:1;
	padding-left:50px;
	padding-right:50px;
}
#divTitle{
	margin-top: 50px;
	
	font-size:20px;
	color:#0055FF;
}
#memberTable{
	height : 400px;
	overflow-y: scroll;
	verflow-x:hidden
}

</style>
<script>

$( document ).ready(function() {
	$("#divInnerBox").hide();
}); 

function fn_createReward(userid,regular,reward, index){
	afterReward = $("#reward"+index+"").val();
	var test = $("input[name=reward]");
	console.log("이스케이프..?/" + userid);
	console.log("이스케이프..?/ index" + index);
	
	if(afterReward<0){
		alert("포상휴가를 잘못입력하셨습니다.");
		return;
	}
	
	if(afterReward==null || afterReward==0 ){
		alert("포상휴가 일수를 입력하세요.");
		return;
	}
	
	if(regular== 'undefined'){
		regular = 0;
	}
	if(reward== 'undefined'){
		reward =0;
	}
	
	console.log("이스케이프..?/reward" + reward);
	console.log("이스케이프..?/regular" + regular);
	console.log("input값" +afterReward);
	
	$.ajax({
	      url : "${pageContext.request.contextPath}/break/createReward.do",
	            type: "post",
	            data : {userid:userid,regular:regular, reward:reward,afterReward:afterReward},
	            dataType : "json",
	            success: function(data){
	               console.log(data);
	               data = data["afterList"];
	               
	               if(data==null){
	               		console.log("여기에 들어와...??/");
	              	}else { 
	              		console.log("에이작스 들어오는 거지..??/");
	            	   var html = "";
	            	   var cnt = "";
	            	   	
	            	    html += "<br><br><div style='font-size:20px;'> 휴가 생성 완료 </div><br>";
	            	    html += "<table class='table table-bordered' >";
	            	  	html += "<thead>";
	    			    html += "<tr style='background:#F6F6F6; text-align:center;'>";
	    			   // html += "<th scope='row' > <input type='checkbox' name='selectedMemberAll' id='selectedMemberAll' onclick='checkAllDelete()'/> </th>";
	    			    html += "<th scope='col' >이름</th>";
	    			    html += "<th scope='col' >ID</th>";
	    			    html += "<th scope='col' >소속</th>";
	    			    html += "<th scope='col' >연차</th>";
	    			    html += "<th scope='col' >포상</th>";
	    			   // html += "<th scope='col'>휴가 생성</th>";
	    			    html += "</tr>";			    
	    			    html += "<tr style='background:#F6F6F6;text-align:center;'>"; 
	   			     
	  			        
	  			    	html += "</tr>";
	    			    html += "</thead>";
	    			    
	    			    for(var index in data){
	 						var c = data[index];
							console.log("c"+c[1]);
	 						
						
	 						html += "<tr style='text-align:center;'>";
	 					//	html += "<th scope='row'> <input type='checkbox' name='selectedMember' value='"+c.USERID+"'/> </th>";
	 						html += "<td>" + c.USERNAME + "</td>";
	 						html += "<td>" + c.USERID + "</td>";
	 						html += "<td>" + c.COM_NAME + "</td>";
	 						
	 						if(c.REGULAR_BREAK==null){
	 							html += "<td> 0 일 </td>";
	 						}else{
	 							html += "<td>" + c.REGULAR_BREAK +"일 </td>";
	 						}
	 						
	 						if(c.REWARD_BREAK==null){
	 							html += "<td> 0 일 </td>";
	 						}else{
	 							html += "<td>" + c.REWARD_BREAK + "일</td>"; 
	 						}
	 						
	 						//html += "<td> <input type='text' name='reward' id='reward"+index+"' value='0'/> 일</td>";
	    			    	//html += "<td><button class='btn btn-link' style='border:1px solid;' Onclick='fn_createReward(\""+c.USERID+"\",\""+c.REGULAR_BREAK+"\",\""+c.REWARD_BREAK+"\","+index+");'> 생성 </button></td>";
	 						html += "</tr>";
	                 	}
	    			    	
	 						html += "</table>";
	    			    
	 				
	 						$("#afterRewardDiv").html(html);
	 						
	 						
	    			    
	               	} 
	               
	               
	               
	            	
	              },
	              error:function(jqxhr,textStatus,errorThrown){
	                 console.log("ajax 처리실패!");
	                 console.log(jqxhr);
	                 console.log(textStatus);
	                 console.log(errorThrown);
	              }
	                   
	  }); // ajax end
	
	
	
	
}

function checkAll(){
	if($("#selectAll").is(':checked')){
		$("input[name=choice]").prop("checked",true);
	}else{
		$("input[name=choice]").prop("checked",false);
	}
}


function checkAllDelete(){
	if($("#selectedMemberAll").is(':checked')){
		$("input[name=selectedMember]").prop("checked",true);
	}else{
		$("input[name=selectedMember]").prop("checked",false);
	}
}


function fn_select(){
	/* var userid = $("input:checkbox[name='choice']").val();
	alert(userid); */
	
	
	var userid = "";
	$("input[name=choice]:checked").each(function() {

		userid += $(this).val() + ",";

		console.log(userid)

		/*location.href = "${pageContext.request.contextPath}/break/choiceMember.do?userid="+userid; */
		
	});
	
	//선택된 회원 보여주는 에이작스 
	$.ajax({
	      url : "${pageContext.request.contextPath}/break/choiceMember.do",
	            type: "post",
	            data : {userid:userid},
	            dataType : "json",
	            success: function(data){
	               console.log(data);
	               data = data["memberList"];
	               
	               	 if(data==null){
	               		console.log("여기에 들어와...??/");
	              	}else { 
	              		console.log("에이작스 들어오는 거지..??/");
	            	   var html = "";
	            	   var cnt = "";
	            	   	html += "<table class='table table-bordered' >";
	            	  	html += "<thead>";
	    			    html += "<tr style='background:#F6F6F6; text-align:center;'>";
	    			    html += "<th scope='row' > 삭제</th>";
	    			    html += "<th scope='col' rowspan='2'>이름</th>";
	    			    html += "<th scope='col' rowspan='2'>ID</th>";
	    			    html += "<th scope='col' rowspan='2'>소속</th>";
	    			    html += "<th scope='col' rowspan='2'>연차</th>";
	    			    html += "<th scope='col' colspan='2'>포상</th>";
	    			    html += "<th scope='col' rowspan='2'>휴가 생성</th>";
	    			    html += "</tr>";			    
	    			    html += "<tr style='background:#F6F6F6;text-align:center;'>"; 
	   			     
	  			        html += "<td><input type='checkbox' name='selectedMemberAll' id='selectedMemberAll' onclick='checkAllDelete()'/> </td>";  
	  			        html += "<td>현재</td>";  
	  			     	html += "<td>생성 후</td>";  
	  			    	html += "</tr>";
	    			    html += "</thead>";
	    			    
	    			    for(var index in data){
	 						var c = data[index];
							console.log("c"+c[1]);
	 						
							cnt = index;
							cnt *= 1;
							cnt += 1;
	 						html += "<tr style='text-align:center;'>";
	 						html += "<th scope='row'> <input type='checkbox' name='selectedMember' value='"+c.USERID+"'/> </th>";
	 						html += "<td>" + c.USERNAME + "</td>";
	 						html += "<td>" + c.USERID + "</td>";
	 						html += "<td>" + c.COM_NAME + "</td>";
	 						
	 						if(c.REGULAR_BREAK==null){
	 							html += "<td> 0 일 </td>";
	 						}else{
	 							html += "<td>" + c.REGULAR_BREAK +"일 </td>";
	 						}
	 						
	 						if(c.REWARD_BREAK==null){
	 							html += "<td> 0 일 </td>";
	 						}else{
	 							html += "<td>" + c.REWARD_BREAK + "일</td>";
	 						}
	 						
	 						html += "<td> <input type='number' name='reward' id='reward"+index+"' placeholder='포상휴가 일수 입력'/> 일</td>";
	 						html += "<td><button class='btn btn-link' style='border:1px solid;' Onclick='fn_createReward(\""+c.USERID+"\",\""+c.REGULAR_BREAK+"\",\""+c.REWARD_BREAK+"\","+index+");'> 생성 </button></td>";
	 						html += "</tr>";
	                 	}
	 						html += "</table>";
	    			    
	 					//	$("#memberTable").html(html);
	 						$("#selectedMember").html(html);
	 						$("#memberCnt").html(cnt);
	 						
	    			    
	               	} 

	              },
	              error:function(jqxhr,textStatus,errorThrown){
	                 console.log("ajax 처리실패!");
	                 console.log(jqxhr);
	                 console.log(textStatus);
	                 console.log(errorThrown);
	              }
	                   
	  }); // ajax end

	$("#backgroundSmsLayer").remove();

	$("#divInnerBox").hide();
	$(".close").hide();  
		   
}	

//포상휴가 선택된 멤버 삭제하는 에이작스
function rewardMemberDelete(){
	
	var enrolldate1 = $("#enrolldate1").val();
	var enrolldate2 = $("#enrolldate2").val();
	var name_com = $("#name_com").val();
	console.log("delete에서도 찍히니??" +name_com);
	
	var userid = "";
	var selectedUser ="";
	
	if($("input:checkbox[name=selectedMember]").is(":checked")==false){
		alert("삭제할 사원을 선택하세요.");
	}else{
		

	$("input[name=selectedMember]").each(function() {
		selectedUser += $(this).val() + ",";
		console.log("selectedUser=" +selectedUser);

	});
	$("input[name=selectedMember]:checked").each(function() {
		userid += $(this).val() + ",";
		console.log(userid);

	});
	
	$.ajax({
	      url : "${pageContext.request.contextPath}/break/choiceMemberDelete.do",
	            type: "post",
	            data : {selectedUser:selectedUser,userid:userid, enrolldate1:enrolldate1, enrolldate2:enrolldate2, name_com:name_com},
	            dataType : "json",
	            success: function(data){
	               console.log(data);
	               data = data["deleteAfterMember"];
	               
	               	 if(data==null){
	               		console.log("여기에 들어와...??/");
	              	}else { 
	              		console.log("에이작스 들어오는 거지..??/");
	            	   var html = "";
	            	   var cnt = "";
	            	   	
	            	    
	            	    html += "<table class='table table-bordered' >";
	            	  	html += "<thead>";
	    			    html += "<tr style='background:#F6F6F6; text-align:center;'>";
	    			    html += "<th scope='row' > 삭제</th>";
	    			    html += "<th scope='col' rowspan='2'>이름</th>";
	    			    html += "<th scope='col' rowspan='2'>ID</th>";
	    			    html += "<th scope='col' rowspan='2'>소속</th>";
	    			    html += "<th scope='col' rowspan='2'>연차</th>";
	    			    html += "<th scope='col' colspan='2'>포상</th>";
	    			    html += "<th scope='col' rowspan='2'>휴가 생성</th>";
	    			    html += "</tr>";			    
	    			    html += "<tr style='background:#F6F6F6;text-align:center;'>"; 
	   			     
	  			        html += "<td><input type='checkbox' name='selectedMemberAll' id='selectedMemberAll' onclick='checkAllDelete()'/> </td>";  
	  			        html += "<td>현재</td>";  
	  			     	html += "<td>생성 후</td>";  
	  			    	html += "</tr>";
	    			    html += "</thead>";
	    			    
	    			    for(var index in data){
	 						var c = data[index];
							console.log("c"+c[1]);
	 						
							cnt = index;
							cnt *= 1;
							cnt += 1;
	 						html += "<tr style='text-align:center;'>";
	 						html += "<th scope='row'> <input type='checkbox' name='selectedMember' value='"+c.USERID+"'/> </th>";
	 						html += "<td>" + c.USERNAME + "</td>";
	 						html += "<td>" + c.USERID + "</td>";
	 						html += "<td>" + c.COM_NAME + "</td>";
	 						
	 						if(c.REGULAR_BREAK==null){
	 							html += "<td> 0 일 </td>";
	 						}else{
	 							html += "<td>" + c.REGULAR_BREAK +"일 </td>";
	 						}
	 						
	 						if(c.REWARD_BREAK==null){
	 							html += "<td> 0 일 </td>";
	 						}else{
	 							html += "<td>" + c.REWARD_BREAK + "일</td>"; 
	 						}
	 						
	 						html += "<td> <input type='number' name='reward' id='reward"+index+"' placeholder='포상휴가 일수 입력'/> 일</td>";
	    			    	html += "<td><button class='btn btn-link' style='border:1px solid;' Onclick='fn_createReward(\""+c.USERID+"\",\""+c.REGULAR_BREAK+"\",\""+c.REWARD_BREAK+"\","+index+");'> 생성 </button></td>";
	 						html += "</tr>";
	                 	}
	    			    	
	 						html += "</table>";
	    			    
	 					//	$("#memberTable").html(html);
	 						$("#selectedMember").html(html);
	 						$("#memberCnt").html(cnt);
	 						
	    			    
	               	} 

	              },
	              error:function(jqxhr,textStatus,errorThrown){
	                 console.log("ajax 처리실패!");
	                 console.log(jqxhr);
	                 console.log(textStatus);
	                 console.log(errorThrown);
	              }
	                   
	  }); // ajax end
	  
	}
	
}



</script>


<div>
	<p id="pFont2">휴가 생성</p>
</div>

<hr />
<br /><br />

<!-- tabs start -->
<div>
	
	<ul class="nav nav-tabs" id="myTab" role="tablist">
		  <li class="nav-item">
		    <a class="nav-link active" id="year-tab" data-toggle="tab" href="#year" role="tab" aria-controls="year" aria-selected="true">연차 휴가 생성</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" id="rewardBreak-tab" data-toggle="tab" role="tab" href="#rewardBreak" aria-controls="rewardBreak" aria-selected="false">포상 휴가 생성</a>
		  </li>
	</ul>

</div>
<!-- tabs end -->
<br /><br />

<!-- div 모음 시작 -->
<div class="tab-content" id="myTabContent"> 
	<div class="tab-pane fade show active" id="year" role="tabpanel" aria-labelledby="year-tab">
		<form action="${pageContext.request.contextPath }/break/breakSettingEnd.do" method="post">
	<input type="hidden" name="com_no" value="${memberLoggedIn.com_no }"/>
	<table class="table table-bordered">
		<tr>
			<th rowspan="4" style="background:#F6F6F6;" >휴가일수<br />(입사년도)</th>
			<td scope="col">N</td>
			<td>N+1</td>
			<td>N+2</td>
			<td>N+3</td>
			<td>N+4</td>
			<td>N+5</td>
			<td>N+6</td>
		</tr>
		<tr>
			<td><span id="bsn" >${bs.n }</span></td>
			<td><span id="bsn1" >${bs.n1 }</span></td>
			<td><span id="bsn2" >${bs.n2 }</span></td>
			<td><span id="bsn3" >${bs.n3 }</span></td>
			<td><span id="bsn4" >${bs.n4 }</span></td>
			<td><span id="bsn5" >${bs.n5 }</span></td>
			<td><span id="bsn6" >${bs.n6 }</span></td>		
		</tr>
		<tr>
			<td>N+7</td>
			<td>N+8</td>
			<td>N+9</td>
			<td>N+10</td>
			<td>N+11</td>
			<td>N+12</td>
			<td>이상</td>
		</tr>
		<tr>
			<td><span id="bsn7" >${bs.n7 }</span></td>
			<td><span id="bsn8" >${bs.n8 }</span></td>
			<td><span id="bsn9" >${bs.n9 }</span></td>
			<td><span id="bsn10" >${bs.n10 }</span></td>
			<td><span id="bsn11" >${bs.n11 }</span></td>
			<td><span id="bsn12" >${bs.n12 }</span></td>
			<td></td>
		</tr>
		<tr style="border-bottom: 1px solid #dee2e6;">
			<th style="background:#F6F6F6;">생성일자</th>
			<td colspan="13">
				<select name="createdate" id="">
					<option value="1">1</option>
					<option value="2">2</option>
					<option value="3">3</option>
					<option value="4">4</option>
					<option value="5">5</option>
					<option value="6">6</option>
					<option value="7">7</option>
					<option value="8">8</option>
					<option value="9">9</option>
					<option value="10">10</option>
					<option value="11">11</option>
					<option value="12">12</option>
				</select>
				월 1일
			</td>
		</tr>
	</table>
<button type="submit" class="btn btn-outline-info">저장</button>
</form>
		
		
		
		
	</div>


	<div class="tab-pane fade" id="rewardBreak" role="tabpanel" aria-labelledby="rewardBreak-tab">
		<p style="font-size: 20px;">
		근무 기간에 따른 연차 휴가 외 별도 포상 휴가를 부여할 때 사용하는 기능입니다. <br />
		※ '생성 후' 입력란에 최종 포상 휴가 일수를 입력합니다. <br />
		예) 현재 포상 휴가를 3일 받은 직원에게 2일을 추가하고 싶다면, '생성 후' 입력란에 5일을 입력합니다. <br />
		※ 포상 휴가 일수는 '정수' 단위로 입력할 수 있습니다. <br />
		※ 포상 휴가 일수를 입력한 후 '지금 생성하기'를 클릭하세요. <br />
		</p>
	
		<br />
		
		<table class="table">
		  <thead>
		    <tr>
		      <th scope="col" style="width:300px; background:#F6F6F6; text-align:center;">대상자 선택</th>
		      <th scope="col" style="color:darkgray;">대상자를 추가하세요  &nbsp;&nbsp; | &nbsp; 
		      <span class="open" style="color: lightblue; cursor: pointer;">선택하기</span></th>
		    </tr>
		  </thead>
		  <tbody>
		    <tr>
		      <th scope="row" style="width:300px; height:400px; background:#F6F6F6;text-align:center;">휴가 일수</th>
		      <td>
		      	<p>
		      		포상 휴가 일수를 입력한 후 '휴가 생성'버튼을 클릭하세요.
		      	</p>
		      	
		      	대상자 <span id="memberCnt"> 0 </span> 명
		      	<br /><br />
		      	
		      	<div id="selectedMember">
			      	<table class="table table-bordered" >
					  <thead>
					    <tr style="background:#F6F6F6; text-align:center;">
					 	  <th scope="col" rowspan="2" >
					      	<input type="checkbox" name="" id="" />
				          </th>
					      <th scope="col" rowspan="2">이름</th>
					      <th scope="col"  rowspan="2">ID</th>
					      <th scope="col"  rowspan="2">소속</th>
					      <th scope="col"  rowspan="2">연차</th>
					      <th scope="col" colspan="2">포상</th>
					      <th scope="col" rowspan="2">휴가 생성</th>
					    </tr>
					  
					    <tr style="background:#F6F6F6;text-align:center;"> 
					     
					      <td>현재</td>  
					      <td>생성 후</td>  
					        
					    </tr>
					    </thead>
					</table>
				</div>
			
	
			<div style="color: lightblue; font-size:20px;" onclick='rewardMemberDelete()'> 삭제</div>
	
	   		<div id="afterRewardDiv"></div>
	      </td>
	      
	  
	    </tr>
	  </tbody>
	</table>
		
	<br /><br /><br /><br />	
		
	
	<div id="divInnerBox">
			<div style="font-size:30px;" class="close">X</div>
			
			<div id="divTitle"> 포상 휴가 대기자 설정</div>
			<br />
			
			<%-- <form action="${pageContext.request.contextPath}/break/searchMember.do"> --%>
				<div class='form-group row'>
					<label for='startdate' class='col-sm-2 col-form-label'>입사일</label>
					<div class='row'>
						<div class='col'>
							<input type='date' name='enrolldate1' id='enrolldate1' class='form-control' /> 
						</div>
						<div class='col'>
							<input type='date' name='enrolldate2' id='enrolldate2' class='form-control'/>
						</div>
					</div>
				</div>
				
				<div class='form-group row'>
					<label for='startdate' class='col-sm-2 col-form-label'>이름</label>
					<div class='row'>
						<div class='col'>
							<input type='text' name='name_com' id='name_com' class='form-control' /> 
						</div>
					</div>
				</div>
		
				<input type="button" class="btn btn-light" style="margin-left:250px;" value="검색" onclick="fn_ajaxMember();" />
			<!-- 	<button type="button" class="btn btn-light" style="margin-left:250px;">검색</button> -->
			
			<!-- </form> -->
			<br /><br />
			
			<div id="memberTable">
			
				<table class="table table-bordered" >
				  <thead>
				    <tr style="background:#F6F6F6; text-align:center;">
				      <th scope="col" >
				      	<input type="checkbox" name="selectAll" id="selectAll" />
				      </th>
				      <th scope="col" >이름</th>
				      <th scope="col" >ID</th>
				      <th scope="col" >소속</th>
				      <th scope="col" >연차</th>
				      <th scope="col" >포상</th>
				    </tr>
				  
				    </thead>
				</table>
				<table class="table table-bordered" id="table">
				</table>
		
			</div>
				<input type="button" class="btn btn-link" style="margin-left:250px; border:1px solid;" value="선택" onclick="fn_select();" />
				<input type="button" class="btn btn-secondary"  value="닫기" onclick="fn_close();"/>
			
			
	</div> <!-- 팝업창 div 끝 -->
	
	</div> <!-- reward Create 끝 -->

</div> <!-- div 모음 끝 -->

<script>

$(function(){
	
	/* $("#rewardBreak").hide(); */

	$(".open").click(function() {

		$("body").css("overflow","hidden");
	
		$("body").append("<div id='backgroundSmsLayer'></div>");
	
		$("#backgroundSmsLayer").css({
	
			"position":"fixed",
		
			"top":"0px",
		
			"left":"0px",
		
			"width":"100%",
		
			"height":"100%",
		
			"background-color":"#000",
		
			"z-index":"0",
		
			"opacity":"0.3"
	
	});


	$("#divInnerBox").show();

	});

	// 레이어 닫기 이벤트

	$(".close").click(function() {

		
		$("#backgroundSmsLayer").remove();

		$("#divInnerBox").hide();
		$(".close").hide();

	});



});

function fn_close(){


	$("#backgroundSmsLayer").remove();

	$("#divInnerBox").hide();
	$(".close").hide();
	
}


function fn_ajaxMember(){
	
	var enrolldate1 = $("#enrolldate1").val();
	var enrolldate2 = $("#enrolldate2").val();
	var name_com = $("#name_com").val();
	
	var year = enrolldate1.substring(0,4);
	var month = enrolldate1.substring(5,7)*1;
	var day = enrolldate1.substring(8,11)*1;
	
	var date = new Date(year,month-1,day);
	var today = new Date();
	
	if(today<date){
		alert("입사일자가 현재일을 넘을 수 없습니다.");
	}
	
	$.ajax({
	      url : "<%=request.getContextPath()%>/break/searchMember.do",
	            type: "post",
	            data : {enrolldate1:enrolldate1, enrolldate2:enrolldate2, name_com:name_com},
	            dataType : "json",
	            success: function(data){
	               console.log(data);
	               data = data["list"];
	               
                 	if(data.length==0){
	           	  
                 	
						var html = ""; 
	            	  	
	            	  	html += "<form action=''>";
	            	   	html += "<table class='table table-bordered' >";
	            	  	html += "<thead>";
	    			    html += "<tr style='background:#F6F6F6; text-align:center;'>";
	    			    html += "<th scope='col'>";
	    			    html += "<input type='checkbox' name='selectAll' id='selectAll' onclick='checkAll()'/>";
	    			    html += "</th>";
	    			    html += "<th scope='col' >이름</th>";
	    			    html += "<th scope='col' >ID</th>";
	    			    html += "<th scope='col' >소속</th>";
	    			    html += "<th scope='col' >연차</th>";
	    			    html += "<th scope='col' >포상</th>";
	    			    html += "</tr>";
	    			    html += "</thead>"; 
                 		
	    			    html += "<tr>";
 						html += "<td colspan='6' style='text-align:center;'>조건에 맞는 검색결과가 없습니다.</td>";
 						html += "</tr>";
 						
 						$("#memberTable").html(html);
                 		
	              	}else {
	              	
	            	  	var html = ""; 
	            	  	
	            	  	html += "<form action=''>";
	            	   	html += "<table class='table table-bordered' >";
	            	  	html += "<thead>";
	    			    html += "<tr style='background:#F6F6F6; text-align:center;'>";
	    			    html += "<th scope='col'>";
	    			    html += "<input type='checkbox' name='selectAll' id='selectAll' onclick='checkAll()'/>";
	    			    html += "</th>";
	    			    html += "<th scope='col' >이름</th>";
	    			    html += "<th scope='col' >ID</th>";
	    			    html += "<th scope='col' >소속</th>";
	    			    html += "<th scope='col' >연차</th>";
	    			    html += "<th scope='col' >포상</th>";
	    			    html += "</tr>";
	    			    html += "</thead>"; 
	            	   
	                 	for(var index in data){
	 						var c = data[index];
	 						console.log("에이작스" +c);	
	
	 						html += "<tr>";
	 						html += "<th scope='row'> <input type='checkbox' name='choice' value='"+c.USERID+"'/> </th>";
	 						html += "<td>" + c.USERNAME + "</td>";
	 						html += "<td>" + c.USERID + "</td>";
	 						html += "<td>" + c.COM_NAME + "</td>";
	 						
	 						if(c.REGULAR_BREAK==null){
	 							html += "<td> 0 일 </td>";
	 						}else{
	 							html += "<td>" + c.REGULAR_BREAK +"일 </td>";
	 						}
	 						
	 						if(c.REWARD_BREAK==null){
	 							html += "<td> 0 일 </td>";
	 						}else{
	 							html += "<td>" + c.REWARD_BREAK + "일</td>";
	 						}
	 						
	 						html += "</tr>";
	                 	}
	 						html += "</table>";
	 						html += "</form>";
	 						
	 						$("#memberTable").html(html);
	                 	
	        				 

                 	} 

	              },
	              error:function(jqxhr,textStatus,errorThrown){
	                 console.log("ajax 처리실패!");
	                 console.log(jqxhr);
	                 console.log(textStatus);
	                 console.log(errorThrown);
	              }
	                   
	  }); // ajax end
	  
	  
  
	
}


</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>