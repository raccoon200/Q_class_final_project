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


<script type="text/javascript">

  $('input:radio[name=addr_type]:input[value=addr_personal]').attr("checked", true);
  $('input:radio[name=addr_type]:input[value=addr_share]').attr("checked", true);
  
/* var addr_personal = $('input:radio[name=P]').is(':checked');
var addr_share = $('input:radio[name=S]').is(':checked');
console.log("addr_personal="+addr_personal);
console.log("addr_share="+addr_share);

 function(){
	if(window.location.pathname.indexOf("personal") !== -1){
		window.location = Common.getRoot() + "address/personal";
	}else if(window.location.pathname.indexOf("shared") !== -1){
		window.location = Common.getRoot() + "address/shared";
	}else{
		window.location = Common.getRoot() + "address/trash";
	}
} */
</script>

	<form action="InsertAddress.do" method="post">
<!-- 		<div class="addrtype">
			<label><input type="radio" name="addr_type" value='addr_personal'> 개인 주소록</label>
			<label><input type="radio" name="addr_type" value='addr_share'> 공유 주소록</label>  		</div>-->
	<!-- 		<input type="button" value="Radio Value" onClick="();"> -->
		<table>
			<tr>
				<td>
					이름   <input type="text" name="name" id="name" />
				</td>
			</tr>
			<tr>
				<td>
					이메일   <input type="text" name="email" id="email" />
				</td>
			</tr>
			<tr>
				<td>
					전화번호  <input type="text" name="phone" id="phone" />
				</td>
			</tr>
			<tr>
				<td>
					태그   <input type="text" name="tag" id="tag" />
				</td>
			</tr>
			<tr>
				<td>
					회사  <input type="text" name="company" id="company" />
				</td>
			</tr>
			<tr>
				<td>
				 	 
				 	<!--  우편번호 검색 시작 -->
				 	<input type="text" id="sample3_postcode" placeholder="우편번호"> 
					<input type="button" onclick="sample3_execDaumPostcode()" value="우편번호 찾기"><br>

			<div id="wrap" style="display:none;border:1px solid;width:500px;height:300px;margin:5px 0;position:relative">
			<img src="//t1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
			</div>
			주소 <input type="text" id="address" name="address" class="d_form large" placeholder="주소">
			
			<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
			<script>
			    // 우편번호 찾기 찾기 화면을 넣을 element
			    var element_wrap = document.getElementById('wrap');
			
			    function foldDaumPostcode() {
			        // iframe을 넣은 element를 안보이게 한다.
			        element_wrap.style.display = 'none';
			    }
			
			    function sample3_execDaumPostcode() {
			        // 현재 scroll 위치를 저장해놓는다.
			        var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
			        new daum.Postcode({
			            oncomplete: function(data) {
			
			                var fullAddr = data.address; // 최종 주소 변수
			                var extraAddr = ''; // 조합형 주소 변수
			
			                // 기본 주소가 도로명 타입일때 조합한다.
			                if(data.addressType === 'R'){
			                    //법정동명이 있을 경우 추가한다.
			                    if(data.bname !== ''){
			                        extraAddr += data.bname;
			                    }
			                    // 건물명이 있을 경우 추가한다.
			                    if(data.buildingName !== ''){
			                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
			                    }
			                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
			                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
			                }
			
			                // 우편번호와 주소 정보를 해당 필드에 넣는다.
			                document.getElementById('sample3_postcode').value = data.zonecode; //5자리 새우편번호 사용
			                document.getElementById('address').value = fullAddr;
			
			                element_wrap.style.display = 'none';
			
			                // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
			                document.body.scrollTop = currentScroll;
			            },
			            // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
			            onresize : function(size) {
			                element_wrap.style.height = size.height+'px';
			            },
			            width : '100%',
			            height : '100%'
			        }).embed(element_wrap);
			
			        // iframe을 넣은 element를 보이게 한다.
			        element_wrap.style.display = 'block';
			    }
			</script>
				  <!-- 우편번호 검색 끝  -->
				</td>
			</tr>
			
			<tr>
				<td>
				 	 기념일  <input type="text" name="anniversary" id="anniversary" />
				</td>
			</tr>
			<tr>
				<td>
				 	 메모  <input type="text" name="memo" id="memo" />
				</td>
			</tr>
			<tr>
				<td>
					<input type="submit" value="저장"  />
				</td>
			</tr>
			
	
	
		</table>
	</form>

	