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

$(function(){
	
	$("#rewardBreak").hide();
});

function fn_select(){
	/* var userid = $("input:checkbox[name='choice']").val();
	alert(userid); */
	
	
	var userid = "";
	$("input[name=choice]:checked").each(function() {

		userid += $(this).val() + ",";

		console.log(userid)

		/*location.href = "${pageContext.request.contextPath}/break/choiceMember.do?userid="+userid; */
		
	});
	
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
	    			    html += "<th scope='col' rowspan='2'>이름</th>";
	    			    html += "<th scope='col' rowspan='2'>ID</th>";
	    			    html += "<th scope='col' rowspan='2'>소속</th>";
	    			    html += "<th scope='col' rowspan='2'>연차</th>";
	    			    html += "<th scope='col' colspan='2'>포상</th>";
	    			    html += "</tr>";			    
	    			    html += "<tr style='background:#F6F6F6;text-align:center;'>"; 
	   			     
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
	 						
	 						html += "<td> <input type='text' name='reward' id='reward' value='0'/> 일</td>";
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
	

    $("body").css("overflow","auto");

	$("#backgroundSmsLayer").remove();

	$("#divInnerBox").hide();
	$(".close").hide();  
		   
}	
</script>


<div>
	<p id="pFont2">휴가 생성</p>
</div>

<hr />
<br /><br />

<div>
	<ul class="nav nav-tabs">
	  <li class="nav-item">
	    <a class="nav-link " href="#" >연차 휴가 생성</a>
	  </li>
	  <li class="nav-item">
	    <a class="nav-link" id="createBreakReward" >포상 휴가 생성</a>
	  </li>
	  
	</ul>
</div>
<br /><br />

<div id="yearBreak">연차</div>


<div id="rewardBreak">
	<p style="font-size: 20px;">
	근무 기간에 따른 연차 휴가 외 별도 포상 휴가를 부여할 때 사용하는 기능입니다. <br />
	※ '생성 후' 입력란에 최종 포상 휴가 일수를 입력합니다. <br />
	예) 현재 포상 휴가를 3일 받은 직원에게 2일을 추가하고 싶다면, '생성 후' 입력란에 5일을 입력합니다. <br />
	※ 포상 휴가 일수는 '정수' 또는 '0.5' 단위로 입력할 수 있습니다. <br />
	※ 포상 휴가 일수를 입력한 후 '지금 생성하기'를 클릭하세요. <br />
	</p>

	<br />
	
	<table class="table">
  <thead>
    <tr>
      <th scope="col" style="width:300px; background:#F6F6F6; text-align:center;">대상자 선택</th>
      <th scope="col" style="color:darkgray;">대상자를 추가하세요  &nbsp;&nbsp; | &nbsp; 
      <sapn class="open" style="color: lightblue; cursor: pointer;">선택하기</sapn></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th scope="row" style="width:300px; height:400px; background:#F6F6F6;text-align:center;">휴가 일수</th>
      <td>
      	<p>
      		포상 휴가 일수를 입력한 후 '지금 생성하기'를 클릭하세요.
      	</p>
      	
      	<p id="memberCnt"></p>
      	<br /><br />
      	
      	<div id="selectedMember">
	      	<table class="table table-bordered">
			  <thead>
			    <tr style="background:#F6F6F6; text-align:center;">
			      <th scope="col" rowspan="2">이름</th>
			      <th scope="col"  rowspan="2">ID</th>
			      <th scope="col"  rowspan="2">소속</th>
			      <th scope="col"  rowspan="2">연차</th>
			      <th scope="col" colspan="2">포상</th>
			    </tr>
			  
			    <tr style="background:#F6F6F6;text-align:center;"> 
			     
			      <td>현재</td>  
			      <td>생성 후</td>  
			    </tr>
			    </thead>
			  <tbody>

			  </tbody>
			</table>
		</div>

      </td>
  
    </tr>
  </tbody>
</table>
	
	
	
	

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

</div>

<script>

$(function(){
	
	$("#rewardBreak").hide();

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

		$("body").css("overflow","auto");

		$("#backgroundSmsLayer").remove();

		$("#divInnerBox").hide();
		$(".close").hide();

	});



});

function fn_close(){
	$("body").css("overflow","auto");

	$("#backgroundSmsLayer").remove();

	$("#divInnerBox").hide();
	$(".close").hide();
	
}



$("#createBreakReward").on('click', function() {
   $("#yearBreak").hide();
   $("#divInnerBox").hide();
   $("#rewardBreak").show();

});

function fn_ajaxMember(){
	
	var enrolldate1 = $("#enrolldate1").val();
	var enrolldate2 = $("#enrolldate2").val();
	var name_com = $("#name_com").val();
	
	$.ajax({
	      url : "<%=request.getContextPath()%>/break/searchMember.do",
	            type: "post",
	            data : {enrolldate1:enrolldate1, enrolldate2:enrolldate2, name_com:name_com},
	            dataType : "json",
	            success: function(data){
	               console.log(data);
	               data = data["list"];
	               
                 	if(data==null){
	           	  
	              	}else {
	              	
	            	  	var html = ""; 
	            	  	
	            	  	html += "<form action=''>";
	            	   	html += "<table class='table table-bordered' >";
	            	  	html += "<thead>";
	    			    html += "<tr style='background:#F6F6F6; text-align:center;'>";
	    			    html += "<th scope='col'>";
	    			    html += "<input type='checkbox' name='selectAll' id='selectAll' />";
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