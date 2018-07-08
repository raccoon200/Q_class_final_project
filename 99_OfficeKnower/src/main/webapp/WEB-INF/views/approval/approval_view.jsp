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
	<jsp:param value="${navkind }" name="selectMenu" />
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
	width:100%;
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

<script>
	$(function() {
	var approvalDataList;
	var str ="";
		var content = ${approval.content};
		
		content = JSON.stringify(content);
	
		var contentParse = JSON.parse(content);
		var transaction = contentParse.transaction;
		console.log("contentParse : "+contentParse.kind);
		console.log("contentparse : "+contentParse.content);
		var kind = contentParse.kind;
		if(kind == '기타'){
			$("#extraDiv").show();
			$("#spendingDiv").hide();
			$("#editor").html(contentParse.content);
			$("#kind").html("기타");
		}else if(kind == '지결'){
			$("#extraDiv").hide();
			$("#spendingDiv").show();
			$("#year").html(contentParse.year);
			$("#kind").html("지출결의서");
			$("#month").html(contentParse.month);
			$("#spendingMemberP").html("${spenderName}("+contentParse.userId+")");
			$("#account_info").html(contentParse.bankName+"  "+contentParse.account_no);
			
			var transactionParse = JSON.parse(contentParse.transaction);
			var sumPrice = 0;
			var arr;
			var priceNum='';
			for(var i=0; i<transactionParse.length; i++){
				str += "<tr>";
				str += "<td>"+transactionParse[i].title_of_account+"</td>";
				str += "<td>"+transactionParse[i].transactionDate+"</td>";
				str += "<td>"+transactionParse[i].dept+"</td>";
				str += "<td>"+transactionParse[i].price+"원</td>";
				str += "<td>"+transactionParse[i].connection+"</td>";
				str += "<td>"+transactionParse[i].summary+"</td>";
				str += "</tr>";
				
				arr = transactionParse[i].price.split(",");
				for(var i=0; i<arr.length; i++){
					priceNum += arr[i];
				}
				sumPrice = parseInt(priceNum);
			}
		
			var val = String(sumPrice.toString().replace(/[^0-9]/g, ""));
	        if(val.length < 1)
	            return false;
	        val = number_format(val);
			$("#sumPrice").html(val);			
			
		}
		
		
	$("#transaction").append(str);	
	})
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
</script>
<h4>${navkind }</h4>
<hr />
<h6>기본설정</h6>
<table class="table table-bordered">
	<tbody>
		<tr>
			<th style="width: 110px;" class="table-info">문서종류</th>
			<td scope="col"><!-- <select name="" id="" class="custom-select"
				style="width: 49%;"> -->
				<span style="padding-left:20%;padding-right:20%">공용</span>
				<span style="padding-left:20%;" id="kind">
					
				</span>
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
				<td>${v.position }</td>
			</c:forEach>
			<c:if test="${approvals_count != 4 }">
				<c:forEach var="v" begin="0" end="${4-approvals_count-1}" step="1">
					<td>&nbsp;</td>
				</c:forEach>
			</c:if>
		</tr>
		
		<tr style="height: 80px;">
			<c:forEach var="v" begin="0" end="${approvals_count-1}" step="1">
			<td>
				<div style="width: 130px; height: 70px; display: inline-block;">
					
					<c:if test="${approval.approval_status < approvals_count-v}">
						<c:if test="${approval.status eq '반려' and approval.approval_status + approvals_count-1 == v }">
							<img class="sign-image" src="${pageContext.request.contextPath }/resources/upload/member/sign_reject.png" alt="싸인이미지" />
						</c:if>
						<c:if test="${approval.status ne '반려' or approval.approval_status +approvals_count-1 != v }">
							<img class="sign-image" src="${pageContext.request.contextPath }/resources/upload/member/${approvals_list.get(v).sign }" alt="싸인이미지" />
						</c:if> 
					</c:if>
					<c:if test="${approval.approval_status == approvals_count-v and approvals_list.get(v).userId eq memberLoggedIn.userId}">
						<input type="button" class="approvalBtn" value="결재" data-toggle="modal" data-target="#approvalAction"/>
					</c:if>
				</div>	
			</td> 
			</c:forEach>
			<c:if test="${approvals_count != 4 }">
				<c:forEach var="v" begin="0" end="${4-approvals_count-1}" step="1">
					<td><div style="width: 130px; height: 70px; display: inline-block;"></div></td>
				</c:forEach>
			</c:if>
		</tr>
		
		<tr style="height: 40px;">
			
		<c:forEach var="v" items="${approvals_list }">
			<td>${v.userName }</td>
		</c:forEach>
		<c:if test="${approvals_count != 4 }">
				<c:forEach var="v" begin="0" end="${4-approvals_count-1}" step="1">
					<td>&nbsp;</td> 
				</c:forEach>
			</c:if>
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
      </div>
     
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
        <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="fn_approvalUpdate()">확인</button>
      </div>
      <script>
      function fn_approvalUpdate() {
    	  var value = $("input[name=approvalType]:checked").val();
	 	  if(value=='승인') {
	 		  location.href='${pageContext.request.contextPath}/approval/approvalAccept?approval_no=${approval.approval_no}&approval_status=${approval.approval_status}&status=${approval.status}&navkind=${navkind}';
	 	  }else if(value=='반려'){
	 		 location.href='${pageContext.request.contextPath}/approval/approvalReject?approval_no=${approval.approval_no}&approval_status=${approval.approval_status}&navkind=${navkind}';
	 	  }
      }
      </script>
    </div>
  </div>
</div>
<br />

<div id="spendingDiv" class="insertDiv">
		<h6>상세 보기</h6>
		<hr />
		제목   <p type="text" name="title" id="" class="form-control"
			style="width: 85%; display: inline-block; float: right;" >${approval.title }</p> <br
			clear="right" /> <br />
		<input type="hidden" name="transaction" value="" />
		<input type="hidden" name="approvals" value="${memberLoggedIn.userId }"/>
		<input type="hidden" name="writer" value="${memberLoggedIn.userId }"/>
	<%-- 	<input type="hidden" name="com_no" value="${memberLoggedIn.com_no }" /> --%>
		<table class="table table-bordered">
			<tbody>
				<tr>
					<th class="table-info" style="width: 110px; text-align: center;">회계기준월</th>
					<td><span  id="year" 
						style="width: 20%;" >
			
					</span> 년 &nbsp; <span id="month" 
						style="width: 20%;"></span> 월</td>
				</tr>
				<tr>
					<th class="table-info" style="width: 110px; text-align: center;">지출자</th>
					<td style="position: relative;">
						<p id="spendingMemberP"></p>
					
					</td>
				</tr>
				<tr>
					<th class="table-info" style="width: 110px; text-align: center;"
						id="account_td">계좌정보 
					</th>
					<td id="account_info"></td>
				</tr>
			</tbody>
		</table>
		
		<h6>거래 내역 </h6>
		<table id="transaction" class="transaction">
			<tr>
				<th>계정 과목</th>
				<th>지출일자</th>
				<th>지출부서</th>
				<th>금액</th>
				<th>거래처</th>
				<th>적요</th>
			</tr>
			
		</table>
		<table id="sum" class="transaction">
			<tr>
				<td id="sumIn" >총 <span id="sumPrice" >0</span>원</td>
			</tr>
		</table>
		<hr />

	</div>
	<div id="extraDiv" class="insertDiv">
		<h6>상세 보기</h6>
		<hr />
		제목 <input type="text" name="title" id="" class="form-control"
			style="width: 85%; display: inline-block; float: right;" value="${approval.title }"/> <br
			clear="right" /> <br /> <span class="input-group-text"
			id="input-group-text-cum">내용</span>
		<!-- <textarea name="content" id="" cols="30" rows="10" class="form-control" required></textarea> -->
		<div id="editor" class="form-control" style="height: 300px;">

		</div>
		
		<br />
		<hr />
	<br />
	<br />
	<br />
	<br />
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
