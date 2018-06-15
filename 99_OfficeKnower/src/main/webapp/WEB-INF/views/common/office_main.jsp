<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
	<title>${pageTitle}</title>
<!-- <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>-->
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.3.1.js"></script>
<!-- 부트스트랩관련 라이브러리 -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/Font-Face/style.css" />
<style>
	header#header {
		position: fixed;
		left : 0px;
		top: 0px;
		width: 100%;
		height: 60px;
		background: white;
		z-index: 200;
		padding: 0;
		border-bottom: 1px solid lightgray;
	}
	div.container{
		position: relative;
		margin-top: 200px;
	}
	h1.logo_container{
		padding-left: 50px;
		float: left;
	}
	div#gnb{
		display: inline-block;
		margin: 16px 0 0 50px;
		font-size: 18px;
		cursor: pointer;
		position: relative;
	}
	div.header_container{
		border: 1px solid gray;
		background: white;
		display: inline-block;
	}
	div#menu_container{
		position: absolute;
		width: 500px;
		height: 400px;
		left: 59px;
		top: 59px;
	}
	div#userBox{
		float: right;
	}
</style>
<script>
	$(function(){
		$("#gnb").click(function(){
			$("#menu_container").toggle();
		})
	});
</script>
</head>
<body>
    <div class="container">
		<header class="jumbotron" id="header">
		<h1 class="logo_container">	
			<a href="${pageContext.request.contextPath }/office/office_main.do">
				<img src="${pageContext.request.contextPath }/resources/images/common/logo.png" alt="로고" style="width: 60px;height: 30px;"/>
			</a>
		</h1>
		<div id="gnb">
			${pageTitle } &nbsp;
			<span aria-hidden="true" class="icon-arrow-down" style="font-size: 15px;"></span>
		</div>
		<div id="menu_container" class="header_container" style="display: none;">
			<!-- 
				내용
				채워야됨
			 -->
		</div>
		<div id="userBox">
			<span aria-hidden="true" class="icon-arrow-down" style="font-size: 15px;"></span>
			
		</div>
		</header>
        <div class="jumbotron">
            <h1>어서와, Bootstrap은 처음이지?</h1>
            <p>
                Bootstrap은 가장 멋진 HTML, CSS, JS 프레임워크야.
            </p>
        </div>
        <p>부트스트랩1</p>
        <p>부트스트랩2</p>
    </div>
    <br />
   	<br />
   	<br />
   	<br />
   	<br />
   	<br />
   	<br />
   	<br />
   	<br />
   	<br />
   	<br />
   	<br />
   	<br />
   	<br />
   	<br />
   	<br />
   	<br />
   	<br />
   	<br />
   	<br />
   	<br />
</body>
</html>
