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
	<jsp:param value="기본설정" name="selectMenu"/>
</jsp:include> 
<style>
#pFont2{
	font-size: 20px;
	font-weight: bold;
	margin-top:20px;
}
</style>
<script>
$(function(){
	$("option[value=${bs.createdate}]").attr("selected","selected");
});
</script>
<p id="pFont2">기본설정</p>
<hr />
<h6>휴가 생성 조건</h6>
<form action="${pageContext.request.contextPath }/break/breakSettingEnd.do" method="post">
	<input type="hidden" name="com_no" value="${memberLoggedIn.com_no }"/>
	<table class="table">
		<tr>
			<th rowspan="4">휴가일수<br />(입사년도)</th>
			<td scope="col">N</td>
			<td>N+1</td>
			<td>N+2</td>
			<td>N+3</td>
			<td>N+4</td>
			<td>N+5</td>
			<td>N+6</td>
		</tr>
		<tr>
			<td><input type="number" name="n" id="" max="99" style="width: 50px;" value="${bs.n }"/></td>
			<td><input type="number" name="n1" id="" max="99" style="width: 50px;" value="${bs.n1 }"/></td>
			<td><input type="number" name="n2" id="" max="99" style="width: 50px;" value="${bs.n2 }"/></td>
			<td><input type="number" name="n3" id="" max="99" style="width: 50px;" value="${bs.n3 }"/></td>
			<td><input type="number" name="n4" id="" max="99" style="width: 50px;" value="${bs.n4 }"/></td>
			<td><input type="number" name="n5" id="" max="99" style="width: 50px;" value="${bs.n5 }"/></td>
			<td><input type="number" name="n6" id="" max="99" style="width: 50px;" value="${bs.n6 }"/></td>
		</tr>
		<tr>
			<td>N+7</td>
			<td>N+8</td>
			<td>N+9</td>
			<td>N+10</td>
			<td>N+11</td>
			<td>N+12</td>
			<td>이상</td>
		</tr>
		<tr>
			<td><input type="number" name="n7" id="" max="99" style="width: 50px;" value="${bs.n7 }"/></td>
			<td><input type="number" name="n8" id="" max="99" style="width: 50px;" value="${bs.n8 }"/></td>
			<td><input type="number" name="n9" id="" max="99" style="width: 50px;" value="${bs.n9 }"/></td>
			<td><input type="number" name="n10" id="" max="99" style="width: 50px;" value="${bs.n10 }"/></td>
			<td><input type="number" name="n11" id="" max="99" style="width: 50px;" value="${bs.n11 }"/></td>
			<td><input type="number" name="n12" id="" max="99" style="width: 50px;" value="${bs.n12 }"/></td>
			<td></td>
		</tr>
		<tr style="border-bottom: 1px solid #dee2e6;">
			<th>생성일자</th>
			<td colspan="13">
				<select name="createdate" id="">
					<option value="1">1</option>
					<option value="2">2</option>
					<option value="3">3</option>
					<option value="4">4</option>
					<option value="5">5</option>
					<option value="6">6</option>
					<option value="7">7</option>
					<option value="8">8</option>
					<option value="9">9</option>
					<option value="10">10</option>
					<option value="11">11</option>
					<option value="12">12</option>
				</select>
				월 1일
			</td>
		</tr>
	</table>
<button type="submit" class="btn btn-outline-info">저장</button>
</form>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
