<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>${param.pageTitle}</title>
<!-- 	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
 --><script src="${pageContext.request.contextPath }/resources/js/jquery-3.3.1.js"></script>
<!-- 부트스트랩관련 라이브러리 -->
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
	<!-- 사용자작성 css -->
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/style.css" />
</head>
<body>
	indexpage !!!!!!!!!!!
	<button onclick="location.href='${pageContext.request.contextPath}/member/memberOneSelect.do?userId=aabb'">눌러</button>
	<c:if test="${memberLoggedIn==null }">
     <!-- 로그인, 회원가입 버튼 -->
     <button type="button" class="btn btn-outline-success" data-toggle="modal" data-target="#loginModal">로그인</button>
     &nbsp;
     <button type="button" class="btn btn-outline-success" onclick="location.href='${pageContext.request.contextPath}/member/memberEnroll.do'">회원가입</button>
 	</c:if>
 	<c:if test="${memberLoggedIn != null }">
 	<a href="${pageContext.request.contextPath }/member/memberView.do?userId=${memberLoggedIn.userId }">${memberLoggedIn.userName }</a>님, 안녕하세요 :)
 	<button class="btn btn-outline-success" type="button" onclick="location.href='${pageContext.request.contextPath}/member/memberLogout.do'">로그아웃</button>
 	</c:if>
	<div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">로그인</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <form action="${pageContext.request.contextPath }/member/memberLogin.do" method="post">
	      <div class="modal-body">
	        <input type="text" class="form-control" name="userId" id="userId" placeholder="아이디" required/>
	        <br />
	        <input type="password" class="form-control" name="password" id="password" placeholder="비밀번호" required />
	      </div>
	      <div class="modal-footer">
	        <button type="submit" class="btn btn-outline-success">로그인</button>
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
	      </div>
	      </form>
	    </div>
	  </div>
	</div>
</body>
</html>