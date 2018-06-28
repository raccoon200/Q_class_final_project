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
	<jsp:param value="직위/직무 관리" name="selectMenu"/>
</jsp:include>
<style>
.plist_th_count{text-align: center;}
.cont_hidden{display: inline-block; padding-right: 20px;}
.plist_th_count.insa_th{border-right: 1px solid gray;}
span.span_blue2 {
   color: #3a60df;
   font-weight: bold;
   font-size: 16px;
}
div#card_info2 {
   z-index: 1;
   visibility: hidden;
   margin: auto;
   position: absolute;
}
</style>
<script>
function fn_popup(){
	var content = "<span class='span_blue2'>■ 직위 관리</span><br />"
        + "직위 등급은 [+등급 추가] 버튼으로 생성할 수 있습니다.<br /> 각 카드 발급사에 문의 부탁드립니다. "
        
		var postionText; 
		postionText = '<table id="popup2" cellpadding="5" bgcolor="#ffffff" style="font-size:9pt; filter:alpha(opacity=90); border-width:1; border-color:#3291BD; border-style:solid;">'; 
		postionText += '<tr><td>' + content + '</td></tr></table>'; 
		 document.getElementById('card_info2').innerHTML = postionText; 
		 document.getElementById('card_info2').style.visibility = 'visible';
}
function fn_hide(){
	document.getElementById('card_info2').innerHTML = ''; 
    document.getElementById('card_info2').style.visibility = 'hidden'; 	
}

function fn_positionAdd(){
	console.log("1");
}
</script>
<div class="insa_management" style="width: 95%;">
	<h5 style="display: inline;">직위/직무 관리</h5> 
	<hr />
	<br /><br />
	
<div class="cont_hidden">
	<h6 class="cont_hidden">직위관리</h6>
	<div class="cont_hidden">
        <i class="icon-question" onMouseOver="fn_popup();" onMouseOut="fn_hide(); return true;"></i>
        <div id="card_info2"></div>
    </div>
    <a href="javascript:void(0)" onclick="fn_positionAdd()">+등급추가</a>
</div>

<br /><br />   
<form action="${pageContext.request.contextPath}/insa/insaMemberDelete.do" name="insaMemberDelete">
	<table class="table" style="width: 300px;">
		<thead class="thead-light">
		<tr>
			<th class="plist_th_count">등급</th>
			<th class="plist_th_count">직위</th>
		</tr>
		<c:if test="${empty plist}">
			<tr>
				<td colspan="9" style="text-align: center;">해당 사원이 없습니다.</td>
			</tr>
		</c:if>
		</thead>
		<c:if test="${not empty plist }">
			<c:forEach var="p" items="${plist}" varStatus="sts">
				<tr>
					<th class="plist_th_count insa_th">${sts.count}등급</th>
					<td class="plist_th_count">${p.position }</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
</form>
	
</div>



<jsp:include page="/WEB-INF/views/common/footer.jsp"/>