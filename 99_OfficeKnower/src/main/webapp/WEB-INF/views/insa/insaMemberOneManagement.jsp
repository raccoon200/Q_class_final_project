<%@page import="com.kh.ok.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script> -->
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="인사관리" name="pageTitle"/>
</jsp:include>
<jsp:include page="/WEB-INF/views/common/nav.jsp">
	<jsp:param value="인사관리" name="pageTitle"/>
	<jsp:param value="사용자 관리" name="selectMenu"/>
</jsp:include>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script charset="UTF-8" type="text/javascript"
   src="http://t1.daumcdn.net/cssjs/postcode/1522037570977/180326.js"></script>
<%
	
	String[] add = null; 
	Member mem = ((Member)request.getAttribute("member"));
	if(mem.getAddress() !=null)
		add = (((Member)request.getAttribute("member")).getAddress()).split(",");
%>
<style>
/* input[type=button].btn2, input[type=submit].btn2{
    margin: 5px;
    background: white;
    border-color: #899bdb;
    padding: 5px;
    width: 110px;
} */
.form-control{width: 250px;}
.img2{
    width: 130px;
    height: 130px;
    border-radius: 50%;
    float: left;
    border: 1px solid;
    cursor: default;
}
dl dd {
    padding-bottom: 16px;
    min-height: 20px;
}
dd {
    display: block;
    -webkit-margin-start: 40px;
}
/* 사번 관련 */
div#emp_no-container{position: relative; padding: 0px;}
div#emp_no-container span.guide{display: none; font-size: 12px; position: absolute; top: 12px; right: 0px;}
div#emp_no-container span.ok{color:green;}
div#emp_no-container span.error{color: red;}
</style>
<script>
$(function(){
	
	$("#emp_no").on("keyup",function(){
		var empNo = $(this).val().trim();
		var comNo = ${member.com_no};
		var oldEmpNo = ${member.emp_no != null ?member.emp_no:"0"};
		
		if(empNo.length==0){
			$(".guide.error").hide();
			$(".guide.ok").hide();
			$("#idDuplicateCheck").val(0);
			return;
		}
		if(empNo == oldEmpNo){
			$(".guide.error").hide();
			$(".guide.ok").hide();
			$("#idDuplicateCheck").val(2);
			return;
		}
		$.ajax({
			url : "checkIdDuplicate.do",
			data : {empNo:empNo,
					comNo:comNo},
			dataType : "json",
			success : function(data){
				console.log(data);		// true, false
	//          방법1
	//			if(data=="true"){
				if(data.isUsable==true){
					$(".guide.error").hide();
					$(".guide.ok").show();
					$("#idDuplicateCheck").val(1);
				}else{
					$(".guide.error").show();
					$(".guide.ok").hide();
					$("#idDuplicateCheck").val(0);					
				}
			},
			error : function(jqxhr, textStatus, errorThrown){
				console.log("ajax실패",jqxhr,textStatus,errorThrown);
			}
		});		
	});
});
</script>
<script>
   //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
   function sample4_execDaumPostcode() {
      new daum.Postcode(
            {
               oncomplete : function(data) {
                  // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                  // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
                  // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                  var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                  var extraRoadAddr = ''; // 도로명 조합형 주소 변수

                  // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                  // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                  if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                     extraRoadAddr += data.bname;
                  }
                  // 건물명이 있고, 공동주택일 경우 추가한다.
                  if (data.buildingName !== '' && data.apartment === 'Y') {
                     extraRoadAddr += (extraRoadAddr !== '' ? ', '
                           + data.buildingName : data.buildingName);
                  }
                  // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                  if (extraRoadAddr !== '') {
                     extraRoadAddr = ' (' + extraRoadAddr + ')';
                  }
                  // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
                  if (fullRoadAddr !== '') {
                     fullRoadAddr += extraRoadAddr;
                  }

                  // 우편번호와 주소 정보를 해당 필드에 넣는다.
                  document.getElementById('sample4_postcode').value = data.zonecode; //5자리 새우편번호 사용
                  document.getElementById('sample4_roadAddress').value = fullRoadAddr;
                  document.getElementById('sample4_jibunAddress').value = data.jibunAddress;

                  // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                  if (data.autoRoadAddress) {
                     //예상되는 도로명 주소에 조합형 주소를 추가한다.
                     var expRoadAddr = data.autoRoadAddress
                           + extraRoadAddr;
                     document.getElementById('guide').innerHTML = '(예상 도로명 주소 : '
                           + expRoadAddr + ')';

                  } else if (data.autoJibunAddress) {
                     var expJibunAddr = data.autoJibunAddress;
                     document.getElementById('guide').innerHTML = '(예상 지번 주소 : '
                           + expJibunAddr + ')';

                  } else {
                     document.getElementById('guide').innerHTML = '';
                  }
               }
            }).open();
   }
</script>

<h3>사용자 수정</h3>
<hr />
<div class="table-responsive">
	<form action="insaMemberOneUpdate.do" method="post">
		<table class="table table-hover" style="width: 600px;">
	<tr>
		<td>
			<div style="cursor:pointer">
				<img class="img2" src="${pageContext.request.contextPath }/resources/upload/member/${member.photo}" onerror="this.src='${pageContext.request.contextPath }/resources/upload/member/default.jpg'" style="background-size: 200px;"/>
			</div>
		</td>
		<td>
			<ul style="list-style: none;">
				<li>
					<span>이름&nbsp;&nbsp;</span>
					<label><input type="text" class="form-control" id="userName" name="userName" value="${member.userName}" readonly></label>
				</li>
				<br />
				<li>
					<span>Id&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
					<label><input type="text" class="form-control" id="userId" name="userId" value="${member.userId}" readonly></label>
				</li>
			</ul>
		</td>
	</tr>
			<tr>
				<th>사번</th>
				<td>
					<div id="emp_no-container">
						<input type="number" class="form-control" id="emp_no" name="emp_no" value="${member.emp_no }" >
						<span class="guide ok"> 사용가능합니다.</span>
						<span class="guide error">사용할 수 없습니다.</span>
						<input type="hidden" id="idDuplicateCheck" value="0" />
					</div>
				</td>
			</tr>
			<tr>
				<th>입사일</th>
				<td>
					<input type="date" class="form-control" id="joinDate" name="joinDate" value="${member.joinDate }" >
				</td>
			</tr>
			<tr>
				<th>소속</th>
				<td>
					<input type="text" class="form-control" id="com_name" name="com_name" value="${member.com_name}" >
					<input type="hidden" class="form-control" id="com_no" name="com_no" value="${member.com_no}" >
				</td>
			</tr>
			<tr>
				<th>직위</th>
				<td>
					<select name="position" id="position" class="custom-select" style="width: 250px;">
						<c:forEach var="p" items="${plist}">
							<option value="${p.position}" ${p.position eq member.position?"selected":""}>${p.position}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<th>직무</th>
				<td>
					<select name="job" id="job" class="custom-select" style="width: 250px;">
						<c:forEach var="j" items="${jlist}">
							<option value="${j.job}" ${j.job eq member.job?"selected":""}>${j.job}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>
					<input type="email" class="form-control" id="email" name="email" value="${member.email }" >
				</td>
			</tr>
			<tr>
				<th>사내 전화</th>
				<td>
					<input type="text" class="form-control" id="phone_com" name="phone_com" value="${member.phone_com }" >
				</td>
			</tr>
			<tr>
				<th>휴대전화</th>
				<td>
					<input type="text" class="form-control" id="phone_cell" name="phone_cell" value="${member.phone_cell }" >
				</td>
			</tr>
			<tr>
				<th>자택주소</th>
					<td>
	                     <input type="text" class="form-control" id="sample4_postcode" placeholder="우편번호" style="display: inline;" value="<%=add!=null?add[0]:"" %>"> &nbsp;&nbsp; 
	                     <input type="button" class="btn btn-outline-primary" onclick="sample4_execDaumPostcode()" value="우편번호 찾기" size="35px"><br>
	                     <input type="text" class="form-control" id="sample4_roadAddress" placeholder="도로명주소" size="50px" style="width: 400px;" value="<%=add!=null?add[1]:"" %>"> 
	                     <input type="text" class="form-control" id="sample4_jibunAddress" placeholder="지번주소" size="50px" style="width: 400px;" value="<%=add!=null?add[2]:"" %>">
	                     <input type="hidden" name="address" id="address" value="" />
	                     <span id="guide" style="color: #999"></span>
				</td>
			</tr>
			<tr>
				<th>생년월일</th>
				<td>
					<input type="date" class="form-control" id="birthday" name="birthday" value="${member.birthday }" >
				</td>
			</tr>
			<tr>
				<th>기타정보</th>
				<td>
					<textarea id="etc_inf" name="etc_inf" cols="50" rows="5">${member.etc_inf }</textarea>
					
				</td>
			</tr>
			<tr>
				<th>계정 상태 </th>
				<td>
					<input type="checkbox" name="status" id="statusY"  ${member.status.trim() eq "Y"?"checked":" "} value="Y" class="checkbox1"/>
					<label for="statusY">정상</label> &nbsp;&nbsp;
					<input type="checkbox" name="status" id="statusN" ${member.status.trim() eq "N"?"checked":" "} value="N" class="checkbox1"/>
					<label for="statusN">탈퇴</label>
				</td>
			</tr>
			<tr>
				<th colspan="2">
					<input type="submit" value="저장" onclick="fn_addressSum()" class="btn btn-outline-primary"/>
				</th>
			</tr>
		</table>
	</form>
</div>
<script>
	
$("#statusY").click(function() {
    $('#statusN').prop("checked", false);
  });
$("#statusN").click(function() {
    $('#statusY').prop("checked", false);
  });
function fn_addressSum(){
	if($("#sample4_postcode").val().trim().length != 0)
	var add1 = $("#sample4_postcode").val() 
			+","+ $("#sample4_roadAddress").val()
			+","+ $("#sample4_jibunAddress").val();
	$("#address").val(add1);
}
</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>