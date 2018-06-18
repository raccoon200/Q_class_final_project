<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="전자결재" name="pageTitle"/>
</jsp:include>
<style>
div.main_btn{
    padding: 20px 25px 0;
    margin: 0 auto;
    overflow: hidden;
    zoom: 1;
}
div.main_btn button{
	width: 200px; 
	height: 44px; 
	font-size: 18px;
}
nav#leftMenu{
    width: 250px;
    height: 100%;
    border: 0;
    background: #e8ecee repeat;
}
div.menufield{
    top: 65px;
    height: auto;
    bottom: 0;
    left: 0;
    right: 0;
    margin: 26px 0 0 25px;
    padding-right: 12px;
    overflow-x: hidden;
    overflow-y: auto;
}
ul.menu_list li>a{
	float: left;
    max-width: 72%;
    white-space: nowrap;
    overflow: hidden;
    font-size: 15px;
    color: #676767;
    text-decoration: none;
}
ul.menu_list li{
	list-style: none;
	margin-top: 10px;
	padding-left: 16px;
}
ul.menu_list{
	padding: 0 0 20px 0;
}
ul.menu_list li>ul{
	margin: 16px 0 0 0;
	padding: 0;
}
</style>
<nav id="leftMenu">
	<div class="main_btn">
		<button type="button" class="btn btn-primary">작성하기</button>
	</div>
	<div class="menufield">
		<ul class="approval menu_list">
			<li>
				<a href="#">대기</a><br />
			</li>
			<li>
				<a href="#">예정</a><br />
			</li>
			<li>
				<a href="#">진행</a><br />
			</li>
			<li>
				<a href="#">완료</a><br />
			</li>
			<li>
				<a href="#">수신 대기</a><br />
			</li>
			<li>
				<a href="#">회람 대기</a><br />
			</li>
			<li>
				<a href="javascript:void(0)">문서함</a><br />
				<ul>
					<li>
						<a href="#">전체</a><br />
					</li>
					<li>
						<a href="#">기안</a><br />
					</li>
					<li>
						<a href="#">결제</a><br />
					</li>
					<li>
						<a href="#">수신</a><br />
					</li>
					<li>
						<a href="#">회람/참조</a><br />
					</li>
					<li>
						<a href="#">반려</a><br />
					</li>
					<li>
						<a href="#">임시 보관</a><br />
					</li>
				</ul>
			</li>
			<li>
				<a href="#">설정</a><br />
			</li>
			<c:if test='${memberLoggedIn.grade eq "슈퍼관리자" or memberLoggedIn.grade eq "게시판관리자"}'>
				<li>
					<a href="#">관리자 설정</a><br />
				</li>
				<li>
					<a href="#">회계 정보 관리</a><br />
				</li>
			</c:if>
		</ul>
	</div>
</nav>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
