<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="전자결재" name="pageTitle"/>
</jsp:include>
<jsp:include page="/WEB-INF/views/common/nav.jsp">
	<jsp:param value="전자결재" name="pageTitle"/>
</jsp:include>
<style>
span.icon-plus{
	position: absolute;
	top: 10px;
	right: 8px;
	font-weight: bold;
	cursor: pointer;
}
ul#autoComplete{
    position: absolute;
    border: 1px solid #ced4da;
    border-top: 0px;
    display: inline-block;
    padding: 0;
    margin: 0;
   	top: 50px;
    left: 13px;
    background: white;
}
ul#autoComplete li{
	padding: 0 10px;
	list-style: none;
	cursor: pointer;
	position: relative;
}
ul#autoComplete li.sel{
	background: lightseagreen;
	color: white;
}
span.srchval{
	color: #0069d9;
}
span.spanUserId{
	float: right;
}
a#editName{
	position: absolute;
   	top: 31%;
    left: 27%;
    display: none;
}
span.guide{
	display: none;
	position: absolute;
	font-size: 13px;
	top: 21px;
    left: 33%;
}
span.ok{color:green;}
div.insertDiv{
	display: none;
}
div.div-inline{
	display: inline-block;
	width: 40%;
	height: 200px;
	overflow-x: hidden;
	overflow-y: auto;
}
div#checked{
	
	float: right;
}
div#unchecked{
	
}
span.arrowIcon{
	font-size: 22px;
	position: absolute;
	cursor: pointer;
}
span.check{
	top: 75px;
    left: 237px;
}
span.uncheck{
	top: 138px;
    left: 237px;
}
select{
	width: 100%;
	height: 100%;
}
</style>
<script>
$(function(){
	$("select[name=approval_mode]").on("change", function(){
		$("div.insertDiv").hide();
		if($(this).val()=="지결"){		
			$("#spendingDiv").show();
		}
	});
});
</script>
<h4>작성하기</h4>
<hr />
<h6>기본설정</h6>
<table class="table table-bordered">
	<tbody>
		<tr>
			<th style="width: 110px;" class="table-info">문서종류</th>
			<td scope="col">
				<select name="" id="" class="custom-select" style="width: 49%;">
					<option value="" selected>공용</option>
				</select>
				<select name="approval_mode" id="" class="custom-select" style="width: 49%;">
					<option value="">선택</option>
					<option value="지결">지출결의서</option>
					<option value="기타">기타</option>
					<option value="">ㄱㄱㄱㄱㄱㄱ</option>
				</select>
			</td>
			<th style="width: 110px;" class="table-info">작성자</th>
			<td>${memberLoggedIn.com_name} &nbsp;${memberLoggedIn.position} &nbsp; ${memberLoggedIn.userName}</td>
		</tr>
	</tbody>
</table>
<script>
$(function(){
	var year = $("[name=year]").val();
	var month = "${month}";
	var list;
	$("#spendingFrm").find("[name=title]").val(year+"년 "+month+"월 지출 보고서");
	
	$("#spendingFrm").find("[name=month]").find("option[value=${month}]").attr("selected","selected");
	$("#spendingFrm").find("[name=year]").on("change", function(){
		$("#spendingFrm").find("[name=title]").val($(this).val()+"년 "+$("[name=month]").val()+"월 지출 보고서");
	});
	$("#spendingFrm").find("[name=month]").on("change",function(){
		$("#spendingFrm").find("[name=title]").val($("[name=year]").val()+"년 "+$(this).val()+"월 지출 보고서");
	});
	//autoComplete
	$("#spendingMember").on("keyup", function(e){
		var name = $(this).val().trim();
		var com_no = $(this).siblings("[name=com_no]").val();
		var sel = $(".sel");
		var li = $("#autoComplete li");
		if(e.key == 'ArrowDown'){
			if(sel.length == 0){
				$("#autoComplete li:first").addClass("sel");
			}else if(sel.is(li.last())){
				sel.removeClass("sel")
			}else{
				sel.removeClass("sel").next().addClass("sel");
			}
			
		}else if(e.key == 'ArrowUp'){
			if(sel.length == 0){
				$("#autoComplete li:last").addClass("sel");
			}else if(sel.is(li.first())){
				sel.removeClass("sel")
			}else{
				sel.removeClass("sel").prev().addClass("sel");
			}
			
		}else if(e.key == 'Enter'){
			$(this).val(sel.children(".username").text());
			//검색어목록은 감추고, 생성했던 li태그는 삭제
			$("#spendingMember").siblings("[name=userId]").val(sel.children(".spanUserId").text());
			$("#spendingMember").siblings(".guide.ok").text(sel.children(".spanUserId").text()).show();
			$("#spendingMember").attr("readonly","readonly");
			$("#editName").show();
			for(i in list){
				if(list[i].userId == sel.children(".spanUserId").text()){
					$("#info_account").text(list[i].bankName+"/"+list[i].account_no);
					$("#account_td").find("[name=bankName]").val(list[i].bankName);
					$("#account_td").find("[name=account_no]").val(list[i].account_no);
				}
			}
			//검색어목록은 감추고, 생성했던 li태그는 삭제
			$("#autoComplete").hide().children().remove();
		}else{
			$.ajax({
				url : "${pageContext.request.contextPath}/approval/selectaccountListByName.do",
				type : "post",
				data : {name : name, com_no:com_no},
				dataType : "json",
				success : function(data){
					list = data.list;
					var html = "";
					if(list.length == 0){
						$("#autoComplete").hide();
					}else{
						for(index in list){
							html += "<li><span class='username'>"+list[index].name.replace(name, "<span class='srchval'>"+name+"</span>")+"</span><span class='spanUserId badge badge-light'>"
							+list[index].userId+"</span></li>";
						}
						$("#autoComplete").html(html).show();
					}
				},
				error:function(jqxhr, textStatus, errorThrown) {
		            console.log("ajax실패!", jqxhr, textStatus, errorThrown);
		        }
			});	
		}
	});
	//부모요소에 이벤트핸들러를 설정하고, 자식요소를 이벤트 소스로 사용
	$("#autoComplete").on("mouseover","li",function () {
		$("#autoComplete li").removeClass("sel");
		$(this).addClass("sel");
	});
	$("#autoComplete").on("mouseout","li",function () {
		$(this).removeClass("sel");
	});
	$("#autoComplete").on("click","li",function () {
		$("#spendingMember").val($(this).children(".username").text());
		$("#spendingMember").siblings("[name=userId]").val($(this).children(".spanUserId").text())
		$("#spendingMember").siblings(".guide.ok").text($(this).children(".spanUserId").text()).show();
		$("#spendingMember").attr("readonly","readonly");
		for(i in list){
			if(list[i].userId == $(this).children(".spanUserId").text()){
				$("#info_account").text(list[i].bankName+"/"+list[i].account_no);
				$("#account_td").find("[name=bankName]").val(list[i].bankName);
				$("#account_td").find("[name=account_no]").val(list[i].account_no);
			}
		}
		$("#editName").show();
		//검색어목록은 감추고, 생성했던 li태그는 삭제
		$("#autoComplete").hide().children().remove();
	}); 
	$("span.check").on("click", function(){
		var selected = $("select#unchecked_select").val();
		if(selected.length + $("select#checked_select").children("option").length > 4){
			alert("결재선 최대인원은 4명입니다.");
			return false;
		}
		for(i in selected){
			if($("select#checked_select").children("option[value='"+selected[i]+"']").length > 0){
				
			}else{
				var html = "<option value='"+selected[i]+"'>"+selected[i].substring(selected[i].indexOf("/")+1)+"</option>"
				$("select#checked_select").append(html);
			}
		}
	});
	$("span.uncheck").on("click",function(){
		var selected = $("select#checked_select").val();
		
		for(i in selected){
			$("select#checked_select").children("option[value='"+selected[i]+"']").remove();
		}
	});
});
function fn_editName(){
	$("#info_account").text("");
	$("#account_td").find("[name=bankName]").val("");
	$("#account_td").find("[name=account_no]").val("");
	$("#spendingMember").val("");
	$("#spendingMember").removeAttr("readonly");
	$("#spendingMember").siblings("[name=userId]").val("");
	$("#spendingMember").siblings(".guide.ok").hide();		
	$("#editName").hide();
}
function fn_addApprovals(){
	var approvals = $("select#checked_select").children("option");
	var html = "<tr style='width: 100%; height: 40px;'>";
	html += "<th rowspan='3' class='table-info' style='width: 110px; text-align: center; position: relative;'>";
	html += "신청";
	html += "<span class='icon-plus' data-toggle='modal' data-target='#addApprovals'></span></th>";
	for(var i = 0; i < 4;i++){
		var value = null;
		var position = null;
		if(approvals[i]!=null){
			value = approvals[i].value;
			position = value.substring(value.indexOf(":")+1,value.indexOf(")"));
			html += "<td>"+position+"</td>";
		}else{
			html += "<td></td>";
		}
	}
	html += "</tr><tr style='height: 80px;'>"
	for(var i = 0; i < 4;i++){
		html += "<td><div style='width: 130px; height: 70px; display: inline-block;'></div></td>"
	}
	html += "</tr><tr style='height: 40px;'>"
	for(var i = 0; i < 4;i++){
		var value = null;
		var userName = null;
		if(approvals[i]!=null){
			value = approvals[i].value;
			userName = value.substring(value.indexOf("/")+1,value.indexOf(" "));
			html += "<td>"+userName+"</td>";
		}else{
			html += "<td></td>";
		}
	}
	html += "</tr>"
	$("table#approval_people").children("tbody").html(html);
	$("#addApprovals").modal('hide');
}
</script>
<h6>결재선</h6>
<table class="table-bordered" id="approval_people" style="width: 100%; text-align: center;">
	<tbody>
		<tr style="width: 100%; height: 40px;">
			<th rowspan="3" class="table-info" style="width: 110px; text-align: center; position: relative;">
				신청
				<span class="icon-plus" data-toggle="modal" data-target="#addApprovals"></span>
			</th>
			<td>${memberLoggedIn.position}</td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr style="height: 80px;">
			<td><div style="width: 130px; height: 70px; display: inline-block;"></div></td>
			<td><div style="width: 130px; height: 70px; display: inline-block;"></div></td>
			<td><div style="width: 130px; height: 70px; display: inline-block;"></div></td>
			<td><div style="width: 130px; height: 70px; display: inline-block;"></div></td>		
		</tr>
		<tr style="height: 40px;">
			<td>${memberLoggedIn.userName}</td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
	</tbody>
</table>
<br />
<div id="spendingDiv" class="insertDiv">
	<form action="" id="spendingFrm">
		<h6>상세 입력</h6>
		<hr />
		제목 <input type="text" name="title" id="" class="form-control" style="width:85%; display: inline-block; float: right;"/>
		<br clear="right"/>
		<br />
		<table class="table table-bordered">
			<tbody>
				<tr>
					<th class="table-info" style="width: 110px; text-align: center;">회계기준월</th>
					<td>
						<select name="year" id="" class="custom-select" style="width: 20%;">
							<option selected value='${year}'>${year}</option>
							<option value="${year_1}">${year_1}</option>
							<option value="${year_2}">${year_2}</option>
						</select>
						년 &nbsp;
						<select name="month" id="" class="custom-select" style="width: 20%;">
							<option value='01'>01</option>
							<option value="02">02</option>
							<option value="03">03</option>
							<option value='04'>04</option>
							<option value="05">05</option>
							<option value="06">06</option>
							<option value='07'>07</option>
							<option value="08">08</option>
							<option value="09">09</option>
							<option value='10'>10</option>
							<option value="11">11</option>
							<option value="12">12</option>
						</select>
						월
					</td>
				</tr>
				<tr>
					<th class="table-info" style="width: 110px; text-align: center;">지출자</th>
					<td style="position: relative;">
						<input type="text" class="form-control" name="" id="spendingMember" autocomplete="off" style="width: 31%; position: relative;"/>
						<input type="hidden" name="com_no" value="${memberLoggedIn.com_no}"/>
						<input type="hidden" name="userId"/>
						<span class="guide ok"></span>
						<ul id="autoComplete" style="width: 30%;"></ul>
						<a href="javascript:void(0)" id="editName" onclick="fn_editName()">변경</a>
					</td>
				</tr>
				<tr>
					<th class="table-info" style="width: 110px; text-align: center;" id="account_td">
						계좌정보
						<input type="hidden" name="bankName" />
						<input type="hidden" name="account_no" />
					</th>
					<td id="info_account"></td>
				</tr>
			</tbody>
		</table>
	</form>
</div>

<!-- Modal -->
<div class="modal fade" id="addApprovals" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalCenterTitle">결재선 추가</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
			  <div id="unchecked" class="div-inline">
			  	<select multiple="multiple" id="unchecked_select" class="form-control">
			  		<c:forEach var="m" items="${list}">
						<option value="${m.userId}/${m.userName} (${m.com_name}:${m.position})">${m.userName} (${m.com_name}:${m.position})</option>
			  		</c:forEach>
			  	</select>
			  </div>
			  <span class="icon-arrow-right-big check arrowIcon"></span>
			  <span class="icon-arrow-left-big uncheck arrowIcon"></span>
			  <div id="checked" class="div-inline">
			  	<select multiple="multiple" id="checked_select" class="form-control">
			  		<option disabled value="${memberLoggedIn.userId}/${memberLoggedIn.userName} (${memberLoggedIn.com_name}:${memberLoggedIn.position})">${memberLoggedIn.userName} (${memberLoggedIn.com_name}:${memberLoggedIn.position})</option>
			  	</select>
			  </div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-primary" onclick="fn_addApprovals();">추가</button>
			</div>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
