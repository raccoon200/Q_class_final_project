<%@page import="com.kh.ok.insa.model.vo.Position"%>
<%@page import="java.util.List"%>
<%@page import="com.kh.ok.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="인사관리" name="pageTitle"/>
</jsp:include>
<jsp:include page="/WEB-INF/views/common/nav.jsp">
	<jsp:param value="인사관리" name="pageTitle"/>
	<jsp:param value="슈퍼관리자" name="selectMenu"/>
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
                 url: "${pageContext.request.contextPath}/insa/searchAdmin",
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
		var bool = confirm("["+userName+"] 회원을 슈퍼 관리자로 추가시키겠습니까?");
		var bool2 = true;
		if(bool == true){
			<c:forEach var="v" items="${boardAdminList }">
				if(userId == "${v.USERID}"){
					alert("이미 추가된 회원입니다.");
					bool2 = false;
				}			
			</c:forEach>
			if(bool2 == true){
				location.href="${pageContext.request.contextPath}/insa/adminSuperInsertEnd.do?userId="+userId;
			}
		}
	})

}


</script>
<p id="sub-title">슈퍼관리자 추가</p>

<hr />
<br />
<div class="insa_management" style="width: 95%;">
<p id="admin-add" onclick="fn_admin_add()">+ 관리자 추가</p>
<table class="table table table-hover" id="admin-table">
	<thead class="thead-light">
		<tr>
			<th scope="col">이름</th>
			<th scope="col">사번</th>
			<th scope="col">아이디</th>
			<th scope="col">소속</th>
			<th scope="col">관리자</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="v" items="${list }">
			<tr>
				<c:if test='${v.getGrade() != null  and  (v.getGrade() == "슈퍼관리자")}'>
					<th scope="row">${v.getUserName() }</th>
					<td>${v.getEmp_no() }</td>
					<td>${v.getUserId() }</td>
					<td>${v.getDept() }</td>
					<td id="delete">
						${v.getGrade() }
					 	<span id="delete-possible" onclick="location.href='${pageContext.request.contextPath}/insa/adminSuperDeleteEnd.do?userId=${v.getUserId() }'">삭제</span>
				</c:if>
			</tr>
		</c:forEach>


	</tbody>
</table>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>