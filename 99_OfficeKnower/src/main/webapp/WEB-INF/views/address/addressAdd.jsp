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
<head> </head>

<script type="text/javascript">


var addr_personal = $('input:radio[name=P]').is(':checked');
var addr_share = $('input:radio[name=S]').is(':checked');
console.log("addr_personal="+addr_personal);
console.log("addr_share="+addr_share);

 radio : function(){
	if(window.location.pathname.indexOf("personal") !== -1){
		window.location = Common.getRoot() + "address/personal";
	}else if(window.location.pathname.indexOf("shared") !== -1){
		window.location = Common.getRoot() + "address/shared";
	}else{
		window.location = Common.getRoot() + "address/trash";
	}
}

</script>

<body>
	<form action="InsertAddress.do" method="post">
		<div class="addrtype">
				<label><input type="radio" name="type" value='P'> 개인 주소록</label>
				<label><input type="radio" name="type" value='S'> 공유 주소록</label>
		</div>
		
		<table>
			<tr>
				<td>
					이름 : <input type="text" name="name" id="name" />
				</td>
			</tr>
			<tr>
				<td>
					이메일 : <input type="text" name="email" id="email" />
				</td>
			</tr>
			<tr>
				<td>
					전화번호 : <input type="text" name="phone" id="phone" />
				</td>
			</tr>
			<tr>
				<td>
					태그: <input type="text" name="tag" id="tag" />
				</td>
			</tr>
			<tr>
				<td>
					회사 : <input type="text" name="company" id="company" />
					
				</td>
			</tr>
			<tr>
				<td>
				 	 주소 : <input type="text" name="address" id="address" />
				 	 
				</td>
			</tr>
			<tr>
				<td>
				 	 기념일 : <input type="text" name="anniversary" id="anniversary" />
				</td>
			</tr>
			<tr>
				<td>
				 	 메모 : <input type="text" name="memo" id="memo" />
				</td>
			</tr>
			<tr>
				<td>
					<input type="button" onclick value="저장"  />
					<input type ="submit" value = "저장 후 계속 추가 "/><br>
				</td>
			</tr>
	
	
		</table>
	</form>



</body>