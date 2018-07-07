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
.submitBtn{
	margin-top:30px;
	background:rgb(190,229,235);
	font-weight:bold;
	font-size:15px;
	border:none;

}
#sumIn{
	color:rgb(150,150,150);
	padding-left:45%;
}
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
.transaction{
	border:1px solid rgb(200,200,200);
	width:80%;
	padding :5px;
}
.transaction tr th{
	background:rgb(190,229,235);
	border:1px solid rgb(220,220,220);
}
.transaction tr td{
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
.transactionAdd tr td{
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
.sign-image{
	padding-top:5px;
	width:60px;
	height:60px;
}
.approvalBtn{
	border:2px solid rgb(190,229,235);
	font-weight:bold;
	background:rgb(240,240,240);
	border-radius:2px;
	padding-top:5px;
	padding-bottom:5px;
	padding-left:10px;
	padding-right:10px;
	margin-top : 13px;
}
.approvalBtnModal{
	margin-left:30px; 
	margin-right:30px;
	border:2px solid rgb(190,229,235);
	font-weight:bold;
	background:rgb(240,240,240);
	border-radius:2px;
	padding-top:10px;
	padding-bottom:10px;
	padding-left:20px;
	padding-right:20px;
	font-size:1.2em;
}
</style>


<h4>대기</h4>
<hr />
<h6>기본설정</h6>
<table class="table table-bordered">
	<tbody>
		<tr>
			<th style="width: 110px;" class="table-info">문서종류</th>
			<td scope="col"><!-- <select name="" id="" class="custom-select"
				style="width: 49%;"> -->
				<span style="padding-left:20%;padding-right:20%">공용</span>
				<span style="padding-left:20%;">지출결의서</span>
				<!-- <span>기타</span> -->
			</td>
			<th style="width: 110px;" class="table-info">작성자</th>
			<td>${com_name}&nbsp;${writer.position}
				&nbsp; ${writer.userName}</td>
		</tr>
	</tbody>
</table>

<h6>결재선</h6>
<table class="table-bordered" id="approval_people"
	style="width: 100%; text-align: center;">
	<tbody>
		<tr style="width: 100%; height: 40px;">
			<th rowspan="3" class="table-info"
				style="width: 110px; text-align: center; position: relative;">
				신청 
			</th>
			<c:forEach var="v" items="${approvals_list }">
				<td>${v.userId }</td>
			</c:forEach>
			<c:forEach var="v" begin="0" end="${4-approvals_count}" step="1">
				<td></td>
			</c:forEach>
		</tr>
		<tr style="height: 80px;">
			<td>
				<div style="width: 130px; height: 70px; display: inline-block;">
					<c:if test="${approval.approval_status < 4}">
						<img class="sign-image" src="${pageContext.request.contextPath }/resources/upload/member/${approvals_list.get(0).sign }" alt="싸인이미지" />
					</c:if>
					<c:if test="${approval.approval_status == 4 and approvals_list.get(0).userId eq memberLoggedIn.userId}">
						<input type="button" class="approvalBtn" value="결재" data-toggle="modal" data-target="#approvalAction"/>
					</c:if>
				</div>	
			</td>
			<td>
				<div style="width: 130px; height: 70px; display: inline-block;">
					<c:if test="${approval.approval_status < 3}">
						<img class="sign-image" src="${pageContext.request.contextPath }/resources/upload/member/${approvals_list.get(1).sign }" alt="싸인이미지" />
					</c:if>
					<c:if test="${approval.approval_status == 3 and approvals_list.get(1).userId eq memberLoggedIn.userId}">
						<input type="button" class="approvalBtn" value="결재" data-toggle="modal" data-target="#approvalAction"/>
					</c:if>
				</div>	
			</td>
			<td>
				<div style="width: 130px; height: 70px; display: inline-block;">
					<c:if test="${approval.approval_status < 2}">
						<img class="sign-image" src="${pageContext.request.contextPath }/resources/upload/member/${approvals_list.get(2).sign }" alt="싸인이미지" />
					</c:if>
					<c:if test="${approval.approval_status == 2 and approvals_list.get(2).userId eq memberLoggedIn.userId}">
						<input type="button" class="approvalBtn" value="결재" data-toggle="modal" data-target="#approvalAction"/>
					</c:if>
				</div>	
			</td>
			<td>
				<div style="width: 130px; height: 70px; display: inline-block;">
					<c:if test="${approval.approval_status < 1}">
						<img class="sign-image" src="${pageContext.request.contextPath }/resources/upload/member/${approvals_list.get(3).sign }" alt="싸인이미지" />
					</c:if>
					<c:if test="${approval.approval_status == 1 and approvals_list.get(3).userId eq memberLoggedIn.userId}">
						<input type="button" class="approvalBtn" value="결재" data-toggle="modal" data-target="#approvalAction"/>
					</c:if>
				</div>	
			</td>
		</tr>
		
		<tr style="height: 40px;">
			
		<c:forEach var="v" items="${approvals_list }">
			<td>${v.userName }</td>
		</c:forEach>
		</tr>
	</tbody>
</table>

<!-- Modal -->
<div class="modal fade" id="approvalAction" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">결재하기</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      	<input type="radio" name="approvalType" id="accept" value="승인" checked/>
      	<label for="accept">승인</label>
      	<input type="radio" name="approvalType" id="reject" value="반려"/>
        <label for="reject">반려</label>
<!--         <p id="acceptLabel">승인하시겠습니까?</p>
        <p id="rejectLabel">반려하시겠습니까?</p> -->
      </div>
     
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
        <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="fn_approvalUpdate()">확인</button>
      </div>
      <script>
      function fn_approvalUpdate() {
    	  var value = $("input[name=approvalType]:checked").val();
	 	  if(value=='승인') {
	 		  location.href='${pageContext.request.contextPath}/approval/approvalAccept?approval_no=${approval.approval_no}&approval_status=${approval.approval_status}&status=${approval.status}';
	 	  }else if(value=='반려'){
	 		 location.href='${pageContext.request.contextPath}/approval/approvalReject?approval_no=${approval.approval_no}&approval_status=${approval.approval_status}';
	 	  }
      }
      </script>
    </div>
  </div>
</div>
<br />

<div id="spendingDiv" class="insertDiv">
	<form action="${pageContext.request.contextPath }/approvals/insertApprovalSpending" onsubmit="validate2()" id="spendingFrm" method="POST">
		<h6>상세 입력</h6>
		<hr />
		제목 <input type="text" name="title" id="" class="form-control"
			style="width: 85%; display: inline-block; float: right;" /> <br
			clear="right" /> <br />
		<input type="hidden" name="transaction" value="" />
		<input type="hidden" name="approvals" value="${memberLoggedIn.userId }"/>
		<input type="hidden" name="writer" value="${memberLoggedIn.userId }"/>
	<%-- 	<input type="hidden" name="com_no" value="${memberLoggedIn.com_no }" /> --%>
		<table class="table table-bordered">
			<tbody>
				<tr>
					<th class="table-info" style="width: 110px; text-align: center;">회계기준월</th>
					<td><select name="year" id="" class="custom-select"
						style="width: 20%;" >
			
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
		<table id="transaction" class="transaction">
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
		<table id="sum" class="transaction">
			<tr>
				<td id="sumIn" >총 <span id="sumValue" value="0">0</span>원</td>
			</tr>
		</table>
		<script>
		function fn_addTransactionHistory(){
			if(document.getElementById("account_no").value==""){
				alert("지출자를 확인해주세요");
			}else {
				$("#transactionHistory").modal();
			} 
		}
		</script>
		<hr />
		<input type="submit" value="등록" class="submitBtn"/>
		<br />
		<br />
		<br />
		<br />
	</form>
</div>
<div id="extraDiv" class="insertDiv">
	<form action="${pageContext.request.contextPath }/approvals/insertApprovalExtra" onsubmit="validate()">
		<h6>상세 입력</h6>
		<hr />
 		<input type="hidden" name="approvals" value="${memberLoggedIn.userId }"/> 
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
		<hr />
		<input type="submit" value="등록" class="submitBtn"/>
	</form>
	<br />
	<br />
	<br />
	<br />
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

		 
		  </div>
		</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
