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
#requestDiv{
	width: 80%;
	position:relative;
}
.rowTh{
	background:#F6F6F6;
	width: 200px;
	text-align: center;
}
#spanChoice{
	color: #6699FF
}
#divChoice{
	width : 500px;
	height : 500px;
	background: white;
	border-radius:5px;
	border:1px solid black;
	position:absolute; top:240px; left: 800px; z-index:1;
	
}
#inner{
	padding-left:50px;
	padding-right:50px;
	position:relative;
}
#close2{
	width: 30px;
	float: right;
	cursor: pointer;
}
#innerFont{
	color: #6699FF;
	font-size: 20px;
}
#nameSelected{
	border: 1px solid darkgray;
	width: 330px;
	height: 300px;
	display: inline-block;
	position: relative;
	
}
#break_approval{
	display:inline-block;
	position:absolute; top:80px; left: 380px; z-index:1;
	padding-left:20px;
	
}
#icon_break{
	height: 300px;
}
#searchBox{
	background: #F6F6F6;
	margin: 20px;
}
.inputStyle{
	border:none;
}
#afterAjaxBox{
	position: absolute;
	z-index: 1;
}
#breakAjax{
	position: absolute;
	z-index: 2;
	background: #F6F6F6;
}
#fileAdd{
	width : 100%;
	height : 100px;
	border: 3px solid lightgray;
	border-style: dotted;
}


</style>
<script>
$(function(){
	$("#divChoice").hide();
});
function fn_showdivChoice(){
	$("#divChoice").show();
	
} 
function fn_BreakRequestSubmit(){
	var approval = $("#username1").val();
	var startDate = $("#startDate").val();
	var endDate = $("#endDate").val();
	var selectedUserid1 =$("#selectedUserid1").val();
	var selectedUserid2 =$("#selectedUserid2").val();
	var selectedUserid3 =$("#selectedUserid3").val();
	var selectedDay = $("#selectedDay").html();
	var kind = $("#kind option:selected").val();
	var regular = $("#regular").html();
	var reward = $("#reward").html();
	var reason = $("#reason").val();

	selectedDay *= 1;
	regular *= 1;
	reward *= 1;
	
	
	console.log("stratdate" + startDate);
	console.log("endDate" + endDate);
	console.log("1" +selectedUserid1);
	console.log("2" +selectedUserid2);
	console.log("3" +selectedUserid3);
	console.log("regular " + regular);
	console.log("reward " + reward);
	console.log("selectedDay " + selectedDay);
	console.log("kind " + kind);
	console.log("reason " + reason);

	
	/* 입력하세요 */
	if(approval==undefined || approval==''){
		alert("결재자를 선택해주세요.");
		return;
	}
	if(selectedDay==undefined || selectedDay==''){
		alert("휴가일자를 선택해주세요.");
		return;
	}if(kind=='휴가 종류 선택'){
		alert("휴가 종류를 선택해주세요.");
		return;
	}if(reason==undefined || reason==''){
		alert("사유를 입력해주세요.");
		return;
	}
	
	
	
	/*휴가 날짜 */
	if(kind=='포상'){
		if(reward<selectedDay){
			console.log("포상에 들어오니??/");
			alert("1선택된 일수가 현재 포상 일수보다 많습니다.");
			return;
		}
	}else{
		if(regular<selectedDay){
			alert("2선택된 일수가 현재 정기 휴가 일수보다 많습니다."+ regular+"  "+selectedDay);
			return;
		} 
	}
	
	
	breakRequestFrm.submit();
	
}
function fn_deleteChoice(){
	
	cnt=0;
	$("#username1").val("");
	$("#username2").val("");
	$("#username3").val("");
}
</script>

<div>
	<p id="pFont">휴가 신청</p>
</div>

<hr />
<br /><br />

<!-- 기안하기 div -->
<div>
	<p onclick="fn_BreakRequestSubmit()">기안하기</p>
</div>

<!-- 제일 바깥 div -->
<div id="requestDiv">

	<form action="breakInsert.do" id="breakRequestFrm" method="post" enctype="multipart/form-data">
		<table class="table table-bordered">
		
		  <tbody>
		    <tr>
		      <th scope="col" class="rowTh">현황</th>
		      <th scope="col">
		      <c:if test="${not empty myBreak}">
			  <c:forEach var="bre" items="${myBreak}">
				    생성 :  ${bre.regular_break + bre.reward_break}일 /
				    사용 : ${bre.regular_used_break + bre.reward_used_break}일 /
				    잔여 ${(bre.regular_break + bre.reward_break)- (bre.regular_used_break +bre.reward_used_break)}일
				  ( 정기<span id="regular">${bre.regular_break - bre.regular_used_break}</span>일, 포상 <span id="reward">${bre.reward_break - bre.reward_used_break}</span>일)
				</c:forEach>
			   </c:if>
		      
		      </th> 
	
		    </tr>
		  
		    <tr>
		      <th scope="row" class="rowTh">작성자</th>
		      <td>
		      	
			 	회사 :  <c:out value="${userInfo.COM_NAME}"/> &nbsp;&nbsp;
			 	직급 :  <c:out value="${userInfo.POSITION}"/>&nbsp;&nbsp;
			 	이름 :  <c:out value="${userInfo.USERNAME}"/>
	
		      </td>
		    </tr>
		    <tr>
		      <th scope="row" class="rowTh">신청</th>
		      <td>
		      	<c:out value="${userInfo.USERNAME}"/>
		      	 &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		      	<span id="approvals"></span>
		      	<span id="spanChoice" onclick="fn_showdivChoice();">결재선 선택</span>
		      	
		      </td>
		    </tr>
		    <tr>
		      <th scope="row" class="rowTh">휴가기간</th>
		      <td>
		      	<jsp:include page="/WEB-INF/views/break/testCal.jsp"></jsp:include>
		      	
		      </td>
		    </tr>
		    <tr>
		      <th scope="row" class="rowTh">종류</th>
		      <td>
		      	<select name="kind" id="kind">
		      		<option >휴가 종류 선택</option>
		      		<option value="연차">연차</option>
		      		<option value="포상">포상</option>
		      		<option value="훈련">훈련</option>
		      		<option value="교육">교육</option>
		      		<option value="경로사">경로사</option>
		      		<option value="병가">병가</option>
		      		<option value="출산">출산</option>
		      	</select>
		      </td>
		    </tr>
		    <tr>
		      <th scope="row" class="rowTh">사유</th>
		      <td>
		      	<textarea name="reason" id="reason" cols="140" rows="1"></textarea>
		      </td>
		    </tr>
		    <tr>
		    	<th scope="row" colspan="2">
		    	<!-- 파일첨부 div -->
		    	<div id="fileAdd">
					<span>별첨</span>
					<div class="input-group">
					  <div class="custom-file">
					    <input type="file" class="custom-file-input" id="breakFile" name="upFile">
					    <label class="custom-file-label" for="breakFile">파일을 선택하세요 </label>
					  </div>
					  
					 </div>
				</div>
		    	
		    	</th>
		    </tr>
		  </tbody>
		</table>
	</form>

	<br /><br /><br />
	
</div>
<!-- 제일 바깥 div 끝-->

<!-- 결재선 div 시작-->
<div id="divChoice">
	<div id="inner">
	<div style="font-size:30px;" id="close2">X</div>
		<div style="padding-top:30px;">
			<p id="innerFont">신청 실정</p> <span style='color:darkgray;'>최대 3명까지 선택 가능합니다.</span>
		</div>
		<div id="nameSelected">
			<input type="text" name="searchBox" id="searchBox" placeholder="클릭 후 입력"/>
			<div id="breakAjax"></div>
			<div id="afterAjaxBox">
				<div id="afterAjaxMember1"></div>
				<div id="afterAjaxMember2"></div>
				<div id="afterAjaxMember3"></div>
			</div>
			
		</div>
		<div id="break_approval">
			<img id="icon_break" src="${pageContext.request.contextPath }/resources/images/common/break_approval.JPG" alt="" />
		</div>
		
		
		<br /><br />
		<div style="text-align:center;">
			<button class="btn btn-link" style="border:1px solid;" onclick="fn_deleteChoice()">다시선택</button> &nbsp;&nbsp;
			<button class="btn btn-link" style="border:1px solid;" onclick="fn_nameSubmit()">확인</button> &nbsp;&nbsp;
			<button class="btn btn-secondary close1">취소</button>
		</div>
	
	</div>

</div>
<script>

$("#close2").click(function() {

	$("#divChoice").hide();

});
$(".close1").click(function() {

	$("#divChoice").hide();

});
function fn_reChoice(count){
	
	console.log("ㄷ르어오지?/");
	$("#username"+count).val("");
	
	cnt=count-1;
	console.log("cnt 초기화" +cnt);
}

function fn_nameSubmit(){
	
	var input1 = $("#username1").val();
	var input2 = $("#username2").val(); 
	var input3 = $("#username3").val();
	
	if(input1==undefined || input1==""){
		input1='미정1';
	}else{
		input1=$("#username1").val();
	}
	if(input2==undefined || input2==""){
		input2='미정2';
	}else{
		input2=$("#username2").val();
	}
	if(input3==undefined || input3==""){
		input3='미정3';
	}else{
		input3=$("#username3").val();
	}
	
	console.log("input1" + input1);
	console.log("input2" + input2);
	console.log("input3" + input3);
	
	if(input1=='미정1'){
		alert("1위에 순번 결재자가 비어있습니다.");
		return;
	}
	if(input3!='미정3' && input2=='미정2'){
		alert("2위에 순번 결재자가 비어있습니다.");
		return;
	}
	
	if(input1==input2){
		alert(" 1결재자는 사용자로 중복으로 지정할 수 없습니다.");
		return;
	}else if(input2==input3){
		alert(" 2 결재자는 사용자로 중복으로 지정할 수 없습니다.");
		return;
	}else if (input1==input3){
		alert(" 3 결재자는 사용자로 중복으로 지정할 수 없습니다.");
		return;
	}else{

		var html = "";
		if(input2=='미정2'){
			html += input1;
		}else if(input3=='미정3'){
			html += input1+"&nbsp;>&nbsp;"+input2;
		}
	//	html += input1+"&nbsp;>&nbsp;"+input2+"&nbsp;>&nbsp;"+input3+"&nbsp;&nbsp;";
		$("#approvals").html(html);
		$("#divChoice").hide();
		
	}
	
	
}
</script>
<script>
var cnt="";
$("#searchBox").on("keyup",function(){
	var name_com = $(this).val().trim();
	
	if(name_com.length==0){
		return;
	}
	$.ajax({
		url:"searchMember.do",
		data : {name_com:name_com},
		dataType : "json",
		success : function(data){
			console.log(data);
			 data = data["list"];
			var html = "<table class='break_search_table table table-borderless  table-hover' id='break_search_table'>";
			for(var index in data){
				var u =data[index];
				
				
				if(u.USERID=="${memberLoggedIn.userId}"){
					
				}else{
					
					html += "<tr >";
					if(u.POSITION == null){
						html += "<td >"+u.USERNAME+"</td><td> "+u.COM_NAME+"/ 직급: 미기재</td><td style='display:none;'>"+u.USERID+"</td>";
					}else{
						html += "<td >"+u.USERNAME+"</td><td> "+u.COM_NAME+"/ 직급: "+u.POSITION+"</td><td style='display:none;'>"+u.USERID+"</td>"; // u가 객체니까 키값으로 접근해야됨
					}
					html += "</tr>";
				
				}
			} //for문 끝
			
			 $("#breakAjax").html(html);
			 
			/*  console.log(data[0].userId); */ 
			
			$("#break_search_table tr").click(function(){     
				 cnt *= 1;
				 cnt += 1;
		        var str = ""
		        var tdArr = new Array();    // 배열 선언
		        
		        // 현재 클릭된 Row(<tr>)
		        var tr = $(this);
		        var td = tr.children();
		        var html2="";
		        
		        html2+= "<div class='input-group mb-3'>";
		        html2+= " <input type='text' class='inputStyle form-control' aria-describedby='basic-addon2'  name='username' id='username"+cnt+"' value='"+td.eq(0).text()+"'readonly>";
		        html2+= " <input type='hidden' id='selectedUserid"+cnt+"' value='"+td.eq(2).text()+"'readonly>";
		        html2+= " <div class='input-group-append'>";
		        html2+= "<span class='input-group-text' id='basic-addon2' onclick='fn_reChoice("+cnt+")'>X</span>";
		        html2+= "</div></div>";
		        
		        
		        //html2 += "&nbsp; <input type='text' class='form-control' name='username' id='username"+cnt+"' class='inputStyle' value='"+td.eq(0).text()+"' readonly/>";
		        
		 
		        // tr.text()는 클릭된 Row 즉 tr에 있는 모든 값을 가져온다.
		        console.log(td.eq(0).text());
		        console.log(td.eq(1).text());
		        console.log("cnt" +cnt);
		        $("#afterAjaxMember"+cnt).html(html2);
		      //  $("#memberListSearch").val(td.eq(0).text());
		        $("#break_search_table").css('display','none'); 
			});
			
/* 				$("#insa_search_table_ tr").on("keyup",function(event){
				console.log('실행하니');
				var tr = $(this).children();
		        var td = tr.children();
		        tr.css('background','black');
			}); */
		},
		error : function(jqxhr, textStatus, errorThrown){
			console.log("ajax실패",jqxhr,textStatus,errorThrown);
		}
	});
}); 
</script>
<!-- 결재선 div 끝-->


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>




