<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="예약" name="pageTitle" />
</jsp:include>
<jsp:include page="/WEB-INF/views/common/nav.jsp">
	<jsp:param value="예약" name="pageTitle" />
	<jsp:param value="예약 관리자" name="selectMenu" />
</jsp:include>
<style>
span#delete-impossible {
	color: red;
}

span#delete-possible {
	color: rgb(119, 158, 192);
	cursor: pointer
}

p#sub-title {
	font-weight: bold;
	font-size: 1.2em;
}

p#admin-add {
	color: rgb(119, 158, 192);
	cursor: pointer
}
#tmpdiv div {
	width:180px;
	border:1px solid rgb(200,200,200);
	cursor:pointer;
}
#tmpdiv .memberList:hover {
	background:rgb(232, 236,239)
}

</style>
<script>
function fn_admin_add() {
	if(!document.getElementById('tmprow')) {
		var str = '<tr id="tmprow"><td colspan="5"><input id="autocomplete" type="text"/><div id="tmpdiv"></div></td></tr>';
		$("#admin-table").append(str);
	}
	$("#autocomplete").keydown(function(key){
		if(key.keyCode==13){
		var userName = $("#autocomplete").val().trim();
		if(userName != "") {
          $.ajax({
                 type: 'post',
                 url: "${pageContext.request.contextPath}/reservation/admin/searchAdmin",
                 dataType: "json",
                 data: { userName : userName },
                 success: function(memberList) {
                	console.log(memberList)
                    var str2 = "";
                    for(index in memberList){	
            				str2 += '<div class="memberList" id="'+memberList[index].userId+'" value="'+memberList[index].userName+'">'+memberList[index].userName+"&emsp;";
            				if(memberList[index].dept != undefined){
            					str2 += memberList[index].dept+"&emsp;";
            				}else if(memberList[index].dept == undefined){
            					str2 += "&emsp;&emsp;&emsp;&emsp;"
            				}
            				if(memberList[index].position != undefined) {
            					str2+=	memberList[index].position;
            				}
            				str2 += "</div>";
            				console.log(str2);
            			
            				
            			
            		}
                    $("#tmpdiv").html(str2);
                 }
           });
		}
		}
	})
	$(document).on('click', '.memberList', function(){
		var userId= $(this).attr("id");
		var userName = $(this).attr("value");
		var bool = confirm("["+userName+"] 회원을 예약 관리자로 추가시키겠습니까?");
		var bool2 = true;
		if(bool == true){
			<c:forEach var="v" items="${reservationAdminList }">
				if(userId == "${v.USERID}"){
					alert("이미 추가된 회원입니다.");
					bool2 = false;
				}			
			</c:forEach>
			if(bool2 == true){
				location.href="${pageContext.request.contextPath}/reservation/admin/adminInsertEnd.do?userId="+userId;
			}
		}
	})

}


</script>
<p id="sub-title">관리자 추가</p>

<hr />
<br />

<p id="admin-add" onclick="fn_admin_add()">+ 관리자 추가</p>
<table class="table" id="admin-table">
	<thead>
		<tr>
			<th scope="col">이름</th>
			<th scope="col">사번</th>
			<th scope="col">아이디</th>
			<th scope="col">소속</th>
			<th scope="col"></th>
		</tr>
	</thead>
	<tbody>
		<c:if test="${fn:length(reservationAdminList) != 0 }">
			<c:forEach var="v" items="${reservationAdminList }">
				<tr>
					<th scope="row">${v.USERNAME }</th>
					<td>${v.EMP_NO }</td>
					<td>${v.USERID }</td>
					<td>${v.DEPT }</td>
					<td id="delete"><c:if test="${v.GRADE eq '슈퍼관리자' }">
							<span id="delete-impossible">삭제불가</span>
						</c:if> <c:if test="${v.GRADE ne '슈퍼관리자' }">
							<span id="delete-possible"
								onclick="location.href='${pageContext.request.contextPath}/reservation/admin/reservationAdminDelete.do?userId=${v.USERID }&grade=${v.GRADE }'">삭제</span>
						</c:if></td>
				</tr>
			</c:forEach>
		</c:if>


	</tbody>
</table>
<script>
$(function() {
	
	

}) 
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>