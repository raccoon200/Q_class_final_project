<%@page import="com.kh.ok.address.model.vo.Address"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="주소록" name="pageTitle"/>
</jsp:include>

<jsp:include page="/WEB-INF/views/common/nav.jsp">
	<jsp:param value="주소록" name="pageTitle"/>
</jsp:include>
<html>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script charset="UTF-8" type="text/javascript"
   src="http://t1.daumcdn.net/cssjs/postcode/1522037570977/180326.js"></script>
<%
	String[] add = null; 
	Address mem = ((Address)request.getAttribute("address"));
	if(mem.getAddress() !=null)
		add = (((Address)request.getAttribute("address")).getAddress()).split(",,");
%>
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
<script type="text/javascript">
  $('input:radio[name=addr_type]:input[value=addr_personal]').attr("checked", true);
  $('input:radio[name=addr_type]:input[value=addr_share]').attr("checked", true);
</script>

	<form action="updateAddress.do" method="post" id="updateAddressForm">
<!-- 		<div class="addrtype">
			<label><input type="radio" name="addr_type" value='addr_personal'> 개인 주소록</label>
			<label><input type="radio" name="addr_type" value='addr_share'> 공유 주소록</label>  		</div>-->
	<!-- 		<input type="button" value="Radio Value" onClick="();"> -->
		<table>
			<tr>
				<td>
					이름   
					<input type="text" name="name" id="name" value="${address.name}" />
					<input type="hidden" name="address_no" id="address_no" value="${address.address_no}" />
				</td>
			</tr>
			<tr>
				<td>
					이메일   <input type="text" name="email" id="email" value="${address.email}" />
				</td>
			</tr>
			<tr>
				<td>
					전화번호  <input type="text" name="phone" id="phone" value="${address.phone}" />
				</td>
			</tr>
			<tr>
				<td>
					태그   <input type="text" name="tag" id="tag" value="${address.tag}" />
				</td>
			</tr>
			<tr>
				<td>
					회사  <input type="text" name="company" id="company" value="${address.company}" />
				</td>
			</tr>
			<tr>
				<td>
			주소 
					<input type="text" class="form-control" id="sample4_postcode" placeholder="우편번호" style="display: inline;" value="<%=add!=null?add[0]:"" %>"> &nbsp;&nbsp; 
                     <input type="button" class="btn btn-outline-primary" onclick="sample4_execDaumPostcode()" value="우편번호 찾기" size="35px"><br>
                     <input type="text" class="form-control" id="sample4_roadAddress" placeholder="도로명주소" size="50px" style="width: 400px;" value="<%=add!=null?add[1]:"" %>"> 
                     <input type="text" class="form-control" id="sample4_jibunAddress" placeholder="지번주소" size="50px" style="width: 400px;" value="<%=add!=null?add[2]:"" %>">
                     <input type="hidden" name="address" id="address" value="" />
                     <span id="guide" style="color: #999"></span>				 	 
				</td>
			</tr>
			
			<tr>
				<td>
				 	 기념일  <input type="date" name="anniversary" id="anniversary" value="${address.anniversary}" required/>
				</td>
			</tr>
			<tr>
				<td>
				 	 메모 
				 	  <input type="text" name="memo" id="memo" value="${address.memo}" />
				 	  <input type="hidden" name="com_No" id="com_No" value="${address.com_No}" />
				</td>
			</tr>
			<tr>
				<td>
					<input type="button" value="수정"  onclick="fn_addressSum();"/>
				</td>
			</tr>
		</table>
	</form>
<script>
function fn_addressSum(){
	if($("#sample4_postcode").val().trim().length != 0)
	var add1 = $("#sample4_postcode").val() 
			+",, "+ $("#sample4_roadAddress").val()
			+",, "+ $("#sample4_jibunAddress").val();
	$("#address").val(add1);
	$("#updateAddressForm").submit();
}
</script>
	