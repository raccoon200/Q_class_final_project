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
	<!-- <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>-->
	<script src="${pageContext.request.contextPath }/resources/js/jquery-3.3.1.js"></script>
	<!-- 부트스트랩관련 라이브러리 -->
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
	<!-- 사용자작성 css -->
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/style.css" />
</head>
<body>
	<div id="enroll-container">
	<form action="${pageContext.request.contextPath }/member/memberEnrollEnd.do" method="post" onsubmit="return validate();">
		<div id="userId-container">
		<input type="text" class="form-control" name="userId" id="userId_" placeholder="아이디" required/>
		<span class="guide ok">이 아이디는 사용가능합니다.</span>
		<span class="guide error">이 아이디는 사용할 수 없습니다.</span>
		<span class="guide length">아이디는 4글자 이상이여야 합니다.</span>
		<input type="hidden" id="idDuplicateCheck" value="0"/>
		</div>
		<br />
		<input type="password" class="form-control" name="password" id="password_" placeholder="비밀번호" required/>
		<br />
		<input type="password" class="form-control" id="password2" placeholder="비밀번호확인" required/>
		<br />
		<input type="text" class="form-control" name="userName" placeholder="이름" required/>
		<br />
		<input type="email" class="form-control" name="email" id="email" placeholder="이메일" />
		<br />
		<input type="text" class="form-control" name="phone" id="phone" maxlength="11" placeholder="전화번호" required/>
		<br />
		<input type="text" class="form-control" name="address" id="address" placeholder="주소" />
		<br />
		<select name="gender" id="gender" class="form-control" required>
			<option value="" disabled selected>성별</option>
			<option value="M">남</option>
			<option value="F">여</option>
		</select>
		<br />
		<div class="form-check-inline form-check">
			취미 : &nbsp;
			<input type="checkbox" name="hobby" id="hobby1" value="ps4" class="form-check-input"/>
			<label for="hobby1" class="form-check-label">ps4</label>&nbsp;
			<input type="checkbox" name="hobby" id="hobby2" value="switch" class="form-check-input"/>
			<label for="hobby2" class="form-check-label">switch</label>&nbsp;
			<input type="checkbox" name="hobby" id="hobby3" value="피아노" class="form-check-input"/>
			<label for="hobby3" class="form-check-label">피아노</label>&nbsp;
			<input type="checkbox" name="hobby" id="hobby4" value="영화" class="form-check-input"/>
			<label for="hobby4" class="form-check-label">영화</label>&nbsp;
			<input type="checkbox" name="hobby" id="hobby5" value="여행" class="form-check-input"/>
			<label for="hobby5" class="form-check-label">여행</label>&nbsp;
		</div>
		<br />
		<input type="submit" value="가입" class="btn btn-outline-success" />
	</form>
</div>
</body>
</html>

