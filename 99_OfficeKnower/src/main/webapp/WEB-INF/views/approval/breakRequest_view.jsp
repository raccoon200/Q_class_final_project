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


span.srchval {
	color: #0069d9;
}

span.spanUserId {
	float: right;
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

<h4>휴가 ${navkind }</h4>
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
					${breakRequest.kind }
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
					
					<c:if test="${breakRequest.approval_status < approvals_count-v}">
						<c:if test="${breakRequest.status eq '반려' and breakRequest.approval_status == approvals_count-1-v }">
							<img class="sign-image" src="${pageContext.request.contextPath }/resources/upload/member/sign_reject.png" alt="싸인이미지" />
						</c:if>
						<c:if test="${breakRequest.status ne '반려' or breakRequest.approval_status == approvals_count-1-v }">
							<img class="sign-image" src="${pageContext.request.contextPath }/resources/upload/member/${approvals_list.get(v).sign }" alt="싸인이미지" />
						</c:if> 
					</c:if>
					<c:if test="${breakRequest.approval_status == approvals_count-v and approvals_list.get(v).userId eq memberLoggedIn.userId}">
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
	 		  location.href='${pageContext.request.contextPath}/approval/breakRequestAccept?break_request_no=${breakRequest.break_request_no}&approval_status=${breakRequest.approval_status}&status=${breakRequest.status}&navkind=${navkind}';
	 	  }else if(value=='반려'){
	 		 location.href='${pageContext.request.contextPath}/approval/breakRequestReject?break_request_no=${breakRequest.break_request_no}&approval_status=${breakRequest.approval_status}&navkind=${navkind}';
	 	  }
      }
      </script>
    </div>
  </div>
</div>
<br />
	<table class="table table-bordered">
			<tbody>
				<tr>
					<th class="table-info" style="width: 110px; text-align: center;">휴가 기간</th>
					<td><span  id="" style="width: 20%;" >${breakRequest.startdate }&nbsp;~&nbsp;${breakRequest.enddate }</span> 
				</tr>
				<tr>
					<th class="table-info" style="width: 110px; text-align: center;">휴가 일수</th>
					<td><span  id="" style="width: 20%;" >${breakRequest.breakdays }일</span> 
				</tr>
				<tr>
					<th class="table-info" style="width: 110px; text-align: center;">사유</th>
					<td><span  id="" style="width: 20%;" >${breakRequest.reason }</span> 
				</tr>
				<c:if test="${breakRequest.renamed_file_name ne 'no' }">
				<tr>
					<th class="table-info" style="width: 110px; text-align: center;">첨부파일</th>
					<td><span  id="" style="width: 20%; color:blue; cursor:pointer;" onclick="fileDownload('${breakRequest.renamed_file_name}')">${breakRequest.renamed_file_name}</span> 
				</tr>
				</c:if>
			</tbody>
		</table>
<script>
function fileDownload(rName) {
	location.href="${pageContext.request.contextPath}/approval/approvalDownload.do?rName="+rName;
}
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
