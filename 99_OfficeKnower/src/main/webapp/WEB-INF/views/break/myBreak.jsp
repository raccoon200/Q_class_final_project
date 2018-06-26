<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="휴가현황" name="pageTitle"/>
</jsp:include>
<jsp:include page="/WEB-INF/views/common/nav.jsp">
	<jsp:param value="인사관리" name="pageTitle"/>
	<jsp:param value="휴가현황" name="selectMenu"/>
</jsp:include> 
<style>
#pFont{
	font-size: 20px;
	font-weight: bold;
	margin-top:20px;
}
th{
	text-align: center;
}

</style>
<div>
	<p id="pFont">휴가 현황</p>
</div>

<hr />
<br /><br />

<div>
	<ul class="nav nav-tabs">
	  <li class="nav-item">
	    <a class="nav-link active" >내 휴가</a>
	  </li>
	  <li class="nav-item">
	    <a class="nav-link" href="#">휴가 캘린더</a>
	  </li>
	  <li class="nav-item">
	    <a class="nav-link" href="#">휴가 신청 관리</a>
	  </li>
	  
	</ul>

</div>

<br /><br />
<table class="table table-bordered">
  <thead>
    <tr style="background:#F6F6F6;">
      <th scope="col" rowspan="2">이름</th>
      <th scope="col" colspan="2">휴가</th>
      <th scope="col" colspan="2">사용 휴가</th>
      <th scope="col" colspan="2">잔여 휴가</th>
    </tr>
  
    <tr style="background:#F6F6F6;"> 
      <td>정기</td>
      <td>포상</td>
      <td>정기</td>
      <td>포상</td>
      <td>정기</td>  
      <td>포상</td>  
    </tr>
    </thead>
  <tbody>
    <tr>
      <th scope="row" style="width:180px;">이름 들어가야함</th>
      <td>1</td>
      <td>2</td>
      <td>3</td>
      <td>4</td>
      <td>5</td>
      <td>6</td>
    </tr>
   
  </tbody>
</table>










<jsp:include page="/WEB-INF/views/common/footer.jsp"/>