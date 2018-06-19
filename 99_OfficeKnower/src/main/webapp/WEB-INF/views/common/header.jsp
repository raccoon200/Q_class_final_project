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
	<title>${param.pageTitle}</title>
<!-- <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>-->
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.3.1.js"></script>
<!-- 부트스트랩관련 라이브러리 -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
<!-- 아이콘 -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/Font-Face/style.css" />
<!-- 구글 폰트 -->
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic|Sunflower:300" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/style_header.css" />
<script>
	$(function(){
		$("#gnb").click(function(){
			$("#menu_container").toggle();
			$("#user-detail").hide();
			$("#notice-container").hide();
		});
		$("#userBox").click(function(){
			$("#user-detail").toggle();
			$("#menu_container").hide();
			$("#notice-container").hide();
		});
		$("#notice-icon-container").click(function(){
			$("#notice-container").toggle();
			$("#menu_container").hide();
			$("#user-detail").hide();
		});
		$("#user-detail").hover(function(){
			$(this).show();
		},function(){
			$(this).hide();
		});
		$("#menu_container").hover(function(){
			$(this).show();
		},function(){
			$(this).hide();
		});
		$("#notice-container").hover(function(){
			$(this).show();
		},function(){
			$(this).hide();
		});
		$(".menu_btn").hover(function(){
			var a = $(this).children("img").attr("src");
			$(this).children("img").attr("src",a.replace("small", "big"));
		}, function(){
			var a = $(this).children("img").attr("src");
			$(this).children("img").attr("src",a.replace("big", "small"));
		});
		
		/* 메뉴 컨테이너  URL연결 */
		/* 인사 */
		$("#insa_btn").on("click",function(){
			location.href = "${pageContext.request.contextPath}/insa/memberListAll.do";
		});
		/* 일정관리 */
		$("#sch_btn").on("click",function(){
			location.href = "${pageContext.request.contextPath}/cal/calTest.do";
		});
		/* 게시판 */
		$("#board_btn").on("click",function(){
			location.href = "${pageContext.request.contextPath}/";
		});
		/* 전자결재 */
		$("#check_btn").on("click",function(){
			location.href = "${pageContext.request.contextPath}/office/approval.do";
		});
		/* 주소록 */
		$("#address_btn").on("click",function(){
			location.href = "${pageContext.request.contextPath}/";
		});
		/* 예약 */
		$("#reservation_btn").on("click",function(){
			location.href = "${pageContext.request.contextPath}/";
		});
		/* 로그아웃 */
		$("#logout_btn").on("click",function(){
			location.href = "${pageContext.request.contextPath}/member/memberLogout.do";
		});
	});
</script>
</head>
<body>
    <div class="container_main">
		<header class="jumbotron" id="header">
		<h1 class="logo_container">	
			<a href="${pageContext.request.contextPath }/office/office_main.do">
				<img src="${pageContext.request.contextPath }/resources/images/common/logo.png" alt="로고" style="width: 60px;height: 30px;"/>
			</a>
		</h1>
		<div id="gnb">		
			${param.pageTitle } &nbsp;
			<span aria-hidden="true" class="icon-arrow-down" style="font-size: 15px; color: lightgray;"></span>
		</div>
		<!-- hover시 메뉴 컨테이너 -->
		<div id="menu_container" class="header_container" style="display: none;">
			<img src="${pageContext.request.contextPath }/resources/images/common/sp_icon.jpg" alt="" class="sp_icon" id="sp_icon_menu"/>
			
			<div class="menu_btn" id="insa_btn">
				<img src="${pageContext.request.contextPath }/resources/images/common/insa_small.png" alt="인사"/><br />
				<p>인사관리</p>
			</div>
			<div class="menu_btn" id="sch_btn">
				<img src="${pageContext.request.contextPath }/resources/images/common/sch_small.png" alt="일정"/><br />
				<p>일정관리</p>
			</div>
			<div class="menu_btn" id="board_btn">
				<img src="${pageContext.request.contextPath }/resources/images/common/board_small.png" alt="게시판"/><br />
				<p>게시판</p>
			</div>
			<div class="menu_btn" id="check_btn">
				<img src="${pageContext.request.contextPath }/resources/images/common/check_small.png" alt="결재"/><br />
				<p>전자결재</p>
			</div>
			<div class="menu_btn" id="address_btn">
				<img src="${pageContext.request.contextPath }/resources/images/common/address_small.png" alt="주소록"/><br />
				<p>주소록</p>
			</div>
			<div class="menu_btn" id="reservation_btn">
				<img src="${pageContext.request.contextPath }/resources/images/common/reservation_small.png" alt="예약"/><br />
				<p>예약</p>
			</div>
		</div>

		<div id="userBox">
			<img src="${pageContext.request.contextPath }/resources/upload/member/${memberLoggedIn.photo}" class="rounded-circle" style="width: 42px; height: 42px;" alt="프로필" />
			<div style="display: inline-block; margin: 12px 0 0 5px;">
				${memberLoggedIn.userId} &nbsp;
				<!-- ${memberLoggedIn.userId} -->
				<span aria-hidden="true" class="icon-arrow-down" style="font-size: 13px; color: lightgray;"></span>
			</div>
		</div>
		<!-- hover시 user 상세정보 -->
		<div id="user-detail" class="header_container">
		<img src="${pageContext.request.contextPath }/resources/images/common/sp_icon.jpg" alt="" class="sp_icon" id="sp_icon_detail"/>
			<div class="pic">
				<img src="${pageContext.request.contextPath }/resources/upload/member/${memberLoggedIn.photo}" alt="프로필" class="rounded-circle"/>
			</div>
			<div class="text">
				<p>${memberLoggedIn.com_name}</p>
				<p>${memberLoggedIn.userId}</p>
				<p>
					<!-- 설정 URL등록해야됨 -->
					<a href="${pageContext.request.contextPath }/member/memberOneSelect.do?userId=${memberLoggedIn.userId}">설정</a>
				</p>
				<!-- 로그아웃 -->
				<button type="button" id="logout_btn" class="btn btn-outline-primary">로그아웃</button>
			</div>
		</div>
		<div id="notice-icon-container">
			<span class="icon-sound-on" style="font-size: 30px; cursor: pointer;"></span>			
		</div>
		<div id="notice-container" class="header_container">
			<img src="${pageContext.request.contextPath }/resources/images/common/sp_icon.jpg" alt="" class="sp_icon" id="sp_icon_notice"/>
		
			asdf
		</div>
		</header>