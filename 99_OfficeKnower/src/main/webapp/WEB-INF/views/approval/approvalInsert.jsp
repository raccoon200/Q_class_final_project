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
</jsp:include>
<style>

span.icon-plus {
	position: absolute;
	top: 10px;
	right: 8px;
	font-weight: bold;
	cursor: pointer;
}
.transactionDelete{
	cursor:pointer;
	color:rgb(100,150,200);
}
#transaction{
	border:1px solid rgb(200,200,200);
	width:80%;
	padding :5px;
}
#transaction tr th{
	background:rgb(190,229,235);
	border:1px solid rgb(220,220,220);
}
#transaction tr td{
	border:1px solid rgb(220,220,220);
}
#transactionAdd {
	margin:0 auto;
	border-top:1px solid rgb(200,200,200);
	border-bottom:1px solid rgb(200,200,200);
}
#transactionAdd tr th{
	background:rgb(240,240,240);
	width:100px;
	padding:10px;
	font-weight:normal;
	border-top:1px solid rgb(220,220,220);
	border-bottom:1px solid rgb(220,220,220);
}
#transactionAdd tr td{
	width:200px;
	padding:10px;
	border-top:1px solid rgb(220,220,220);
	border-bottom:1px solid rgb(220,220,220);
}
ul#autoComplete {
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

ul#autoComplete li {
	padding: 0 10px;
	list-style: none;
	cursor: pointer;
	position: relative;
}

ul#autoComplete li.sel {
	background: lightseagreen;
	color: white;
}

span.srchval {
	color: #0069d9;
}

span.spanUserId {
	float: right;
}

a#editName {
	position: absolute;
	top: 31%;
	left: 27%;
	display: none;
}

span.guide {
	display: none;
	position: absolute;
	font-size: 13px;
	top: 21px;
	left: 33%;
}

span.ok {
	color: green;
}

div.insertDiv {
	display: none;
}

div.div-inline {
	display: inline-block;
	width: 40%;
	height: 200px;
	overflow-x: hidden;
	overflow-y: auto;
}

div#checked {
	float: right;
}

div#unchecked {
	
}

span.arrowIcon {
	font-size: 22px;
	position: absolute;
	cursor: pointer;
}

span.check {
	top: 75px;
	left: 237px;
}

span.uncheck {
	top: 138px;
	left: 237px;
}

select {
	width: 100%;
	height: 100%;
}
#input-group-text-cum{
	background:rgb(190,229,235);
	text-align:center;
	font-weight:bold;
}
</style>
<script>


function validate() {
		var str = $(".ql-editor").html();
		$("[name=content]").attr("value", str);
	return true;
}
	$(function() {
		$("select[name=approval_mode]").on("change", function() {
			$("div.insertDiv").hide();
			if ($(this).val() == "지결") {
				$("#spendingDiv").show();
			}
			if ($(this).val() == "기타") {
				$("#extraDiv").show();
			}
		});
	});
	function number_format(data)
	{
	    var tmp = '';
	    var number = '';
	    var cutlen = 3;
	    var comma = ',';
	    var i;
	    var sign = data.match(/^[\+\-]/);
	    if(sign) {
	        data = data.replace(/^[\+\-]/, "");
	    }
	    len = data.length;
	    mod = (len % cutlen);
	    k = cutlen - mod;
	    for (i=0; i<data.length; i++)
	    {
	        number = number + data.charAt(i);
	        if (i < data.length - 1)
	        {
	            k++;
	            if ((k % cutlen) == 0)
	            {
	                number = number + comma;
	                k = 0;
	            }
	        }
	    }
	    if(sign != null)
	        number = sign+number;
	    return number;
	}
	$(function() {
	    $("input#price").on("keyup", function() {
	        var val = String(this.value.replace(/[^0-9]/g, ""));
	        if(val.length < 1)
	            return false;
	        this.value = number_format(val);
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
			<td scope="col"><select name="" id="" class="custom-select"
				style="width: 49%;">
					<option value="" selected>공용</option>
			</select> <select name="approval_mode" id="" class="custom-select"
				style="width: 49%;">
					<option value="">선택</option>
					<option value="지결">지출결의서</option>
					<option value="기타">기타</option>
			</select></td>
			<th style="width: 110px;" class="table-info">작성자</th>
			<td>${memberLoggedIn.com_name}&nbsp;${memberLoggedIn.position}
				&nbsp; ${memberLoggedIn.userName}</td>
		</tr>
	</tbody>
</table>
<script>
	$(function() {
		var year = $("[name=year]").val();
		var month = "${month}";
		var list;
		$("#spendingFrm").find("[name=title]").val(
				year + "년 " + month + "월 지출 보고서");

		$("#spendingFrm").find("[name=month]").find("option[value=${month}]")
				.attr("selected", "selected");
		$("#spendingFrm").find("[name=year]").on(
				"change",
				function() {
					$("#spendingFrm").find("[name=title]").val(
							$(this).val() + "년 " + $("[name=month]").val()
									+ "월 지출 보고서");
				});
		$("#spendingFrm").find("[name=month]").on(
				"change",
				function() {
					$("#spendingFrm").find("[name=title]").val(
							$("[name=year]").val() + "년 " + $(this).val()
									+ "월 지출 보고서");
				});
		//autoComplete
		$("#spendingMember")
				.on(
						"keyup",
						function(e) {
							var name = $(this).val().trim();
							var com_no = $(this).siblings("[name=com_no]")
									.val();
							var sel = $(".sel");
							var li = $("#autoComplete li");
							if (e.key == 'ArrowDown') {
								if (sel.length == 0) {
									$("#autoComplete li:first").addClass("sel");
								} else if (sel.is(li.last())) {
									sel.removeClass("sel")
								} else {
									sel.removeClass("sel").next().addClass(
											"sel");
								}

							} else if (e.key == 'ArrowUp') {
								if (sel.length == 0) {
									$("#autoComplete li:last").addClass("sel");
								} else if (sel.is(li.first())) {
									sel.removeClass("sel")
								} else {
									sel.removeClass("sel").prev().addClass(
											"sel");
								}

							} else if (e.key == 'Enter') {
								$(this).val(sel.children(".username").text());
								//검색어목록은 감추고, 생성했던 li태그는 삭제
								$("#spendingMember")
										.siblings("[name=userId]")
										.val(sel.children(".spanUserId").text());
								$("#spendingMember").siblings(".guide.ok")
										.text(
												sel.children(".spanUserId")
														.text()).show();
								$("#spendingMember").attr("readonly",
										"readonly");
								$("#editName").show();
								for (i in list) {
									if (list[i].userId == sel.children(
											".spanUserId").text()) {
										$("#info_account").text(
												list[i].bankName + "/"
														+ list[i].account_no);
										$("#account_td")
												.find("[name=bankName]").val(
														list[i].bankName);
										$("#account_td").find(
												"[name=account_no]").val(
												list[i].account_no);
									}
								}
								//검색어목록은 감추고, 생성했던 li태그는 삭제
								$("#autoComplete").hide().children().remove();
							} else {
								$
										.ajax({
											url : "${pageContext.request.contextPath}/approval/selectaccountListByName.do",
											type : "post",
											data : {
												name : name,
												com_no : com_no
											},
											dataType : "json",
											success : function(data) {
												list = data.list;
												var html = "";
												if (list.length == 0) {
													$("#autoComplete").hide();
												} else {
													for (index in list) {
														html += "<li><span class='username'>"
																+ list[index].name
																		.replace(
																				name,
																				"<span class='srchval'>"
																						+ name
																						+ "</span>")
																+ "</span><span class='spanUserId badge badge-light'>"
																+ list[index].userId
																+ "</span></li>";
													}
													$("#autoComplete").html(
															html).show();
												}
											},
											error : function(jqxhr, textStatus,
													errorThrown) {
												console
														.log("ajax실패!", jqxhr,
																textStatus,
																errorThrown);
											}
										});
							}
						});
		//부모요소에 이벤트핸들러를 설정하고, 자식요소를 이벤트 소스로 사용
		$("#autoComplete").on("mouseover", "li", function() {
			$("#autoComplete li").removeClass("sel");
			$(this).addClass("sel");
		});
		$("#autoComplete").on("mouseout", "li", function() {
			$(this).removeClass("sel");
		});
		$("#autoComplete").on(
				"click",
				"li",
				function() {
					$("#spendingMember").val(
							$(this).children(".username").text());
					$("#spendingMember").siblings("[name=userId]").val(
							$(this).children(".spanUserId").text())
					$("#spendingMember").siblings(".guide.ok").text(
							$(this).children(".spanUserId").text()).show();
					$("#spendingMember").attr("readonly", "readonly");
					for (i in list) {
						if (list[i].userId == $(this).children(".spanUserId")
								.text()) {
							$("#info_account")
									.text(
											list[i].bankName + "/"
													+ list[i].account_no);
							$("#account_td").find("[name=bankName]").val(
									list[i].bankName);
							$("#account_td").find("[name=account_no]").val(
									list[i].account_no);
						}
					}
					$("#editName").show();
					//검색어목록은 감추고, 생성했던 li태그는 삭제
					$("#autoComplete").hide().children().remove();
				});
		$("span.check")
				.on(
						"click",
						function() {
							var selected = $("select#unchecked_select").val();
							if (selected.length
									+ $("select#checked_select").children(
											"option").length > 4) {
								alert("결재선 최대인원은 4명입니다.");
								return false;
							}
							for (i in selected) {
								if ($("select#checked_select").children(
										"option[value='" + selected[i] + "']").length > 0) {

								} else {
									var html = "<option value='"+selected[i]+"'>"
											+ selected[i].substring(selected[i]
													.indexOf("/") + 1)
											+ "</option>"
									$("select#checked_select").append(html);
								}
							}
						});
		$("span.uncheck")
				.on(
						"click",
						function() {
							var selected = $("select#checked_select").val();

							for (i in selected) {
								$("select#checked_select").children(
										"option[value='" + selected[i] + "']")
										.remove();
							}
						});
	});
	function fn_editName() {
		$("#info_account").text("");
		$("#account_td").find("[name=bankName]").val("");
		$("#account_td").find("[name=account_no]").val("");
		$("#spendingMember").val("");
		$("#spendingMember").removeAttr("readonly");
		$("#spendingMember").siblings("[name=userId]").val("");
		$("#spendingMember").siblings(".guide.ok").hide();
		$("#editName").hide();
	}
	function fn_addApprovals() {
		var approvals = $("select#checked_select").children("option");
		var approvals_people = "";
		var approval_status = 0;
		var html = "<tr style='width: 100%; height: 40px;'>";
		html += "<th rowspan='3' class='table-info' style='width: 110px; text-align: center; position: relative;'>";
		html += "신청";
		html += "<span class='icon-plus' data-toggle='modal' data-target='#addApprovals'></span></th>";
		for (var i = 0; i < 4; i++) {
			var value = null;
			var position = null;
			if (approvals[i] != null) {
				value = approvals[i].value;
				position = value.substring(value.indexOf(":") + 1, value
						.indexOf(")"));
				html += "<td>" + position + "</td>";
			} else {
				html += "<td></td>";
			}
		}
		html += "</tr><tr style='height: 80px;'>"
		for (var i = 0; i < 4; i++) {
			html += "<td><div style='width: 130px; height: 70px; display: inline-block;'></div></td>"
		}
		html += "</tr><tr style='height: 40px;'>"
		for (var i = 0; i < 4; i++) {
			var value = null;
			var userName = null;
			if (approvals[i] != null) {
				if(i!=0) {
					approvals_people += ","+approvals[i].value.substring(0,approvals[i].value.indexOf("/"));
				}else {
					approvals_people += approvals[i].value.substring(0,approvals[i].value.indexOf("/"));
					approval_status++;
				}
				value = approvals[i].value;
				userName = value.substring(value.indexOf("/") + 1, value
						.indexOf(" "));
				html += "<td>" + userName + "</td>";
			} else {
				html += "<td></td>";
			}
		}
		html += "</tr>";
		$("table#approval_people").children("tbody").html(html);
		$("#addApprovals").modal('hide');
		$("[name=approvals]").attr("value", approvals_people);
		$("[name=approval_status]").attr("value",approval_status);
	}
</script>
<h6>결재선</h6>
<table class="table-bordered" id="approval_people"
	style="width: 100%; text-align: center;">
	<tbody>
		<tr style="width: 100%; height: 40px;">
			<th rowspan="3" class="table-info"
				style="width: 110px; text-align: center; position: relative;">
				신청 <span class="icon-plus" data-toggle="modal"
				data-target="#addApprovals"></span>
			</th>
			<td>${memberLoggedIn.position}</td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr style="height: 80px;">
			<td><div
					style="width: 130px; height: 70px; display: inline-block;"></div></td>
			<td><div
					style="width: 130px; height: 70px; display: inline-block;"></div></td>
			<td><div
					style="width: 130px; height: 70px; display: inline-block;"></div></td>
			<td><div
					style="width: 130px; height: 70px; display: inline-block;"></div></td>
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
<script>
function validate2() {
	var str = '';
	var length = document.getElementById("transaction").rows.length;
	
	var title_of_account = document.getElementById("transaction").rows[1].cells.item(0).innerHTML;
	var transactionDate = document.getElementById("transaction").rows[1].cells.item(1).innerHTML;
	var dept = document.getElementById("transaction").rows[1].cells.item(2).innerHTML;
	var price = document.getElementById("transaction").rows[1].cells.item(3).innerHTML;
	var connection = document.getElementById("transaction").rows[1].cells.item(4).innerHTML;
	var summary = document.getElementById("transaction").rows[1].cells.item(5).innerHTML;
	console.log("length : "+x);
	var str2 = document.getElementById("transaction")[0].src("rows");
	alert(str2);
	console.log(str2);
	return false;
}
</script>
<input type="button" value="클릭" onclick="validate2()" />
<div id="spendingDiv" class="insertDiv">
	<form action="${pageContext.request.contextPath }/approvals/insertApprovalSpending" onsubmit="validate2()" id="spendingFrm">
		<h6>상세 입력</h6>
		<hr />
		제목 <input type="text" name="title" id="" class="form-control"
			style="width: 85%; display: inline-block; float: right;" /> <br
			clear="right" /> <br />
			
		<input type="hidden" name="approvals" value=""/>
		<input type="hidden" name="approval_status" value="" />
		<input type="hidden" name="writer" value="${memberLoggedIn.userId }" />
		<input type="hidden" name="com_no" value="${memberLoggedIn.com_no }" />
		<table class="table table-bordered">
			<tbody>
				<tr>
					<th class="table-info" style="width: 110px; text-align: center;">회계기준월</th>
					<td><select name="year" id="" class="custom-select"
						style="width: 20%;">
							<option selected value='${year}'>${year}</option>
							<option value="${year_1}">${year_1}</option>
							<option value="${year_2}">${year_2}</option>
					</select> 년 &nbsp; <select name="month" id="" class="custom-select"
						style="width: 20%;">
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
					</select> 월</td>
				</tr>
				<tr>
					<th class="table-info" style="width: 110px; text-align: center;">지출자</th>
					<td style="position: relative;"><input type="text"
						class="form-control" name="" id="spendingMember"
						autocomplete="off" style="width: 31%; position: relative;" /> <input
						type="hidden" name="com_no" value="${memberLoggedIn.com_no}" /> <input
						type="hidden" name="userId" /> <span class="guide ok"></span>
						<ul id="autoComplete" style="width: 30%;"></ul> <a
						href="javascript:void(0)" id="editName" onclick="fn_editName()">변경</a>
					</td>
				</tr>
				<tr>
					<th class="table-info" style="width: 110px; text-align: center;"
						id="account_td">계좌정보 <input type="hidden" name="bankName" />
						<input type="hidden" name="account_no" id="account_no"/>
					</th>
					<td id="info_account"></td>
				</tr>
			</tbody>
		</table>
		
		<h6>거래 내역 &nbsp; <span style="color:rgb(119, 158, 196); cursor:pointer;" id="transactionAdd" onclick="fn_addTransactionHistory()">추가</span></h6>
		<table id="transaction">
			<tr>
				<th>계정 과목</th>
				<th>지출일자</th>
				<th>지출부서</th>
				<th>금액</th>
				<th>거래처</th>
				<th>적요</th>
				<th>상태</th>
			</tr>
			
		</table>
		<script>
	
		function fn_addTransactionHistory(){
			if(document.getElementById("account_no").value==""){
				alert("지출자를 확인해주세요");
			}else {
				$(document).ready(function() {
					$("#transactionAdd").click(function() {
						$("#transactionHistory").modal();
					})
				})
			} 
		}
		</script>
		
		<input type="submit" value="등록" />
	</form>
</div>
<div id="extraDiv" class="insertDiv">
	<form action="${pageContext.request.contextPath }/approvals/insertApprovalExtra" onsubmit="validate()">
		<h6>상세 입력</h6>
		<hr />
 		<input type="hidden" name="approvals" value=""/> 
		<input type="hidden" name="approval_status" value="" />
		<input type="hidden" name="writer" value="${memberLoggedIn.userId }" />
		<input type="hidden" name="content" />
		<input type="hidden" name="com_no" value="${memberLoggedIn.com_no }" />
		제목 <input type="text" name="title" id="" class="form-control"
			style="width: 85%; display: inline-block; float: right;" /> <br
			clear="right" /> <br /> <span class="input-group-text"
			id="input-group-text-cum">내용</span>
		<!-- <textarea name="content" id="" cols="30" rows="10" class="form-control" required></textarea> -->
		<div id="editor" class="form-control" style="height: 300px;"></div>
		<!-- Include the Quill library -->
		<script src="https://cdn.quilljs.com/1.3.6/quill.js"></script>

		<!-- Initialize Quill editor -->
		<script>
			// var quill = new Quill('#editor', {
			//     theme: 'snow'
			// });
			var toolbarOptions = [ [ 'bold', 'italic', 'underline', 'strike' ], // toggled buttons

			[ {
				'header' : 1
			}, {
				'header' : 2
			} ], // custom button values
			[ {
				'list' : 'ordered'
			}, {
				'list' : 'bullet'
			} ], [ {
				'script' : 'sub'
			}, {
				'script' : 'super'
			} ], // superscript/subscript
			[ {
				'indent' : '-1'
			}, {
				'indent' : '+1'
			} ], // outdent/indent
			[ {
				'direction' : 'rtl'
			} ], // text direction

			//[{ 'size': ['small', false, 'large', 'huge'] }],  // custom dropdown
			[ {
				'header' : [ 1, 2, 3, 4, 5, 6, false ]
			} ], [ {
				'color' : []
			}, {
				'background' : []
			} ], // dropdown with defaults from theme
			[ {
				'font' : []
			} ], [ {
				'align' : []
			} ], [ 'image', 'link' ], [ 'clean' ] // remove formatting button
			];

			var quill = new Quill('#editor', {
				modules : {
					toolbar : toolbarOptions
				},
				theme : 'snow'
			});
		</script>
		<br />
		<input type="submit" value="등록" />
	</form>
</div>
<!-- Modal -->
<div class="modal fade" id="addApprovals" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalCenterTitle">결재선 추가</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div id="unchecked" class="div-inline">
					<select multiple="multiple" id="unchecked_select"
						class="form-control">
						<c:forEach var="m" items="${list}">
							<option
								value="${m.userId}/${m.userName} (${m.com_name}:${m.position})">${m.userName}
								(${m.com_name}:${m.position})</option>
						</c:forEach>
					</select>
				</div>
				<span class="icon-arrow-right-big check arrowIcon"></span> <span
					class="icon-arrow-left-big uncheck arrowIcon"></span>
				<div id="checked" class="div-inline">
					<select multiple="multiple" id="checked_select"
						class="form-control">
						<option disabled
							value="${memberLoggedIn.userId}/${memberLoggedIn.userName} (${memberLoggedIn.com_name}:${memberLoggedIn.position})">${memberLoggedIn.userName}
							(${memberLoggedIn.com_name}:${memberLoggedIn.position})</option>
					</select>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-primary"
					onclick="fn_addApprovals();">추가</button>
			</div>
		</div>
	</div>
</div>
<!-- Modal -->
		<div class="modal fade" id="transactionHistory" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog modal-lg" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel">거래 내역 추가(개인)</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>

		      <div class="modal-body">
		        <table id="transactionAdd">
		        	<tr>
		        		<th>계정과목</th>
		        		<td>
		        		<select name="title_of_account" required>
		        			<option value="" selected disabled hidden>계정과목</option>
		        			<c:forEach items="${title_of_accountList }" var="v">
		        			<option value="${v.TITLE_OF_ACCOUNT }">${v.TITLE_OF_ACCOUNT }</option>
		        			</c:forEach>
		        		</select>
		        		</td>
		        		<th>지출일자</th>
		        		<td>
		        		
		        		<script>
						$(function() {
						  $( "#datepicker1" ).datepicker({
						    dateFormat: 'yy-mm-dd',
						    prevText: '이전 달',
						    nextText: '다음 달',
						    monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
						    monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
						    dayNames: ['일','월','화','수','목','금','토'],
						    dayNamesShort: ['일','월','화','수','목','금','토'],
						    dayNamesMin: ['일','월','화','수','목','금','토'],
						    showMonthAfterYear: true,
						    changeMonth: true,
						    changeYear: true,
						    yearSuffix: '년'
						  });
						});
						</script>
    
						<input type="text" id="datepicker1" name="transactionDate" required></td>
			        	</tr>
		        	<tr>
		        		<th>지출부서</th>
		        		<td>
		        		<select name="dept" required>
		        			<option value="" selected disabled hidden>지출부서</option>
		        			<c:forEach items="${deptList }" var="v">
		        			<option value="${v.DEPT }">${v.DEPT }</option>
		        			</c:forEach>
		        		</select>
		        		</td>
		        		<th>공급가액</th>
		        		<td>
		        			<input type="text" name="price" id="price" placeholder="공급가액을 입력하세요" required/>
		        		</td>
		        	</tr>
		        	<tr>
		        		<th>거래처</th>
		        		<td>
		        			<input type="text" name="connection" placeholder="거래처명을 입력하세요" required/>
		        		</td>
		        		<th>적요</th>
						<td>
							<input type="text" name="summary" id="" placeholder="적요를 입력하세요" required/>
						</td>
		        	</tr>
		        </table>
		     
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary"  data-dismiss="modal">취소</button>
		        <input type="button" class="btn btn-primary" id="modalForm" onclick="fn_transactionSubmit()" value="저장"/>
		      </div>
		
		    </div>

		    <script>
			function fn_transactionSubmit() {
					var transactionDate = document.getElementsByName("transactionDate")[0].value;
					var title_of_account = document.getElementsByName("title_of_account")[0].value;
					var dept = document.getElementsByName("dept")[0].value;
					var price = document.getElementsByName("price")[0].value;
					var connection = document.getElementsByName("connection")[0].value;
					var summary = document.getElementsByName("summary")[0].value;
					var ids = title_of_account+dept+connection+summary;
					if(transactionDate == ""){
						alert("지출일자를 입력해주세요");
						return;
					}
					if(title_of_account == ""){
						alert("계정과목을 입력해주세요");
						return;
					}
					if(dept == ""){
						alert("지출부서를 입력해주세요");
						return;
					}
					if(price == ""){	
						alert("공급가액을 입력해주세요");
						return;
					}
					if(connection == ""){	
						alert("거래처를 입력해주세요");
						return;
					}
					if(summary == ""){	
						alert("적요를 입력해주세요");
						return;
					}
					var str = "";
					str += '<tr class="transactionRow" id="'+ids+'"><td>'+title_of_account+'</td>';
					str += '<td>'+transactionDate+'</td>';
					str += '<td>'+dept+'</td>';
					str += '<td>'+price+'</td>';
					str += '<td>'+connection+'</td>';
					str += '<td>'+summary+'</td>';
					str += '<td><span class="transactionDelete" value="'+ids+'">삭제</span></td>';
					$("#transaction").append(str);
					
					$("#modalForm").click(function() {
						$("#transactionHistory").modal('hide'); 
					})
					document.getElementsByName("transactionDate")[0].value="";
					document.getElementsByName("title_of_account")[0].value="";
					document.getElementsByName("dept")[0].value="";
					document.getElementsByName("connection")[0].value="";
					document.getElementsByName("summary")[0].value="";
					document.getElementsByName("price")[0].value="";
			}
			$(function() {
				$(document).on('click','.transactionDelete',function(){
				    var ids = "#"+$(this).attr("value");
				    alert("거래내역이 삭제되었습니다");
				    $(ids).remove();
				});
			})
			
		    </script>
		  </div>
		</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
