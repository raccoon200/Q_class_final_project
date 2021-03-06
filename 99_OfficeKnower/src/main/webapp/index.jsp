<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>OK(Office Knower)</title>
<!-- 	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
 --><script src="${pageContext.request.contextPath }/resources/js/jquery-3.3.1.js"></script>
<!-- 부트스트랩관련 라이브러리 -->
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
	<!-- 사용자작성 css -->
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/style.css" />
	<!-- 아이콘 -->
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/Font-Face/style.css" />
	<link rel="shortcut icon" href="${pageContext.request.contextPath }/resources/images/common/favicon.ico">
</head>
<style>
	img.logo{
		width: 64px;
   		height: 32px;
	}
	div.login-container{
		display: inline-block;
		padding: 0px;
		float: right;
	}
	div.header_container{
		border: 1px solid #ccc;
		background: white;
		display: inline-block;
	}
	img.sp_icon{
		position: absolute;
		width: 15px;
	}
	img#sp_icon_detail{
		top: -9px;
		left: 272px;
	}
	div#user-detail{
		position: absolute;
		right: 0px;
	    top: 59px;
	    width: 350px;
	    padding: 20px 25px;
	    background: white;
	    display: none;
	}
	div.pic{
		margin-right: 24px;
 		width: 80px;
 		display: inline-block;
	}
	div.text{
		display: inline-block;
	}
	div.pic img{
		width: 80px; 
		height: 80px;
		position: absolute;
		top: 20px;
	}
	ul.menuBtn li{
		display: inline-block;
		margin-left: 40px;
		width: 100px;
    	height: 100px;
    	cursor: pointer;
	}
	ul.menuBtn{
		padding-left: 0px;
	}
	ul.menuBtn li.selected{
		background: #2985DC;
		border-radius: 100%;
	}
	ul.menuBtn li.isSelected{
		background: #2985DC;
		border-radius: 100%;
	}
	img.menuIcon{
		display: inline-block;
	    padding-top: 16px;
		width: 41.33px;
	}
	div.hide{
		display: none;
	}
	div.show{
		display: block;
	}
	h1 span{
		display: block; 
		font-size: 64px;
	}
</style>
<script>
$(function(){
	$("#userBox").click(function(){
		$("#user-detail").toggle();
		$("#menu_container").hide();
		$("#notice-container").hide();
	});
	$("ul.menuBtn").children("li.isSelected").find("p").css("color", "white");
	$("ul.menuBtn").children("li.isSelected").find("img").attr("src", $("ul.menuBtn").children("li.isSelected").find("img").attr("src").replace("small","big"));
	$("ul.menuBtn").children("li").hover(function(){
		$(this).addClass("selected");
		$(this).find("p").css("color", "white");
		$(this).find("img").attr("src", $(this).find("img").attr("src").replace("small","big"));
	},function(){
		if(!$(this).hasClass("isSelected")){			
			$(this).find("p").css("color", "black");
			$(this).find("img").attr("src", $(this).find("img").attr("src").replace("big","small"));
		}
		$(this).removeClass("selected");
	});
	$("ul.menuBtn").children("li").on("click",function(){
		$(this).siblings("li.isSelected").find("p").css("color", "black");
		$(this).siblings("li.isSelected").find("img").attr("src", $(this).siblings("li.isSelected").find("img").attr("src").replace("big","small"));
		$(this).siblings("li.isSelected").removeClass("isSelected");

		$(".main-exc").addClass("hide");
		$(".main-exc").removeClass("show");
		
		if($(this).find("img").attr("alt") == "전자결재"){
			$("#approval_main").addClass("show");
			$("header").css("background","url('${pageContext.request.contextPath}/resources/images/common/header-approval.jpg') 69% 50%/cover no-repeat");
			$("header").find("h1").html("신속한 의사 결정을 위한 <span>사내 결재 시스템</span>");
		}else if($(this).find("img").attr("alt") == "인사관리"){
			$("#insa_main").addClass("show");
			$("header").css("background","url('${pageContext.request.contextPath}/resources/images/common/header-insa.jpg') 69% 50%/cover no-repeat");
			$("header").find("h1").html("조직과 사용자를 생성, 관리하는 <span>인사 관리 시스템</span>");
		}else if($(this).find("img").attr("alt") == "일정관리"){
			$("#schedule_main").addClass("show");
			$("header").css("background","url('${pageContext.request.contextPath}/resources/images/common/header-schedule.jpg') 69% 50%/cover no-repeat");
			$("header").find("h1").html("프로젝트 상황이 한눈에 들어오는 <span>일정관리 서비스</span>");
		}else if($(this).find("img").attr("alt") == "게시판"){
			$("#board_main").addClass("show");
			$("header").css("background","url('${pageContext.request.contextPath}/resources/images/common/header-board.jpg') 69% 50%/cover no-repeat");
			$("header").find("h1").html("엽업과 정보 공유를 위한<span>사내 게시판</span>");
		}else if($(this).find("img").attr("alt") == "주소록"){
			$("#address_main").addClass("show");
			$("header").css("background","url('${pageContext.request.contextPath}/resources/images/common/header-address.jpg') 69% 50%/cover no-repeat");
			$("header").find("h1").html("공유와 관리가 수월해지는 <span>주소록 서비스</span>");
		}else if($(this).find("img").attr("alt") == "예약"){
			$("#reservation_main").addClass("show");
			$("header").css("background","url('${pageContext.request.contextPath}/resources/images/common/header-reservation.jpg') 69% 50%/cover no-repeat");
			$("header").find("h1").html("공유와 관리가 수월해지는 <span>예약 서비스</span>");
		}
		
		$(this).addClass("isSelected");
		$(this).find("p").css("color", "white");
		$(this).find("img").attr("src", $(this).find("img").attr("src").replace("small","big"));
		
	});
});
</script>
<body>
	<div class="container" style="padding-top: 0px; padding: 0px;  max-width: 100%; margin: 0px;">
		<header style="background: url('${pageContext.request.contextPath}/resources/images/common/header-approval.jpg') 69% 50%/cover no-repeat; height: 560px;">
			<div class="container">
				<img src="${pageContext.request.contextPath}/resources/images/common/logo.png" alt="로고" class="logo"/>
				<div class="login-container">
					<c:if test="${memberLoggedIn==null }">
					     <!-- 로그인, 회원가입 버튼 -->
					     <button type="button" class="btn btn-outline-info" data-toggle="modal" data-target="#loginModal" style="width: 100px;">로그인</button>
					     &nbsp;
					     <button type="button" class="btn btn-outline-info" onclick="location.href='${pageContext.request.contextPath}/member/memberEnroll.do'" style="width: 100px;">회원가입</button>
				 	</c:if>
				 	<c:if test="${memberLoggedIn != null }">
						<div style="display: inline-block; margin: 0 0 0 5px; padding: 0 10px 0 10px; cursor: pointer;" id="userBox">
					 		<img src="${pageContext.request.contextPath }/resources/upload/member/${memberLoggedIn.photo}" class="rounded-circle" style="width: 42px; height: 42px;" alt="프로필" />
							${memberLoggedIn.userId} &nbsp;
							<!-- ${memberLoggedIn.userId} -->
							<span class="icon-arrow-down" style="font-size: 15px;"></span>
						</div>
						<!-- hover시 user 상세정보 -->
						<div id="user-detail" class="header_container">
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
								<button type="button" id="logout_btn" class="btn btn-outline-primary" onclick="location.href='${pageContext.request.contextPath}/member/memberLogout.do'">로그아웃</button>
							</div>
						</div>
				 	</c:if>
				</div>
			</div>	
			<div class="slogan-inner container" style="padding-top: 150px; font-size: 34px;">		
				<h1>
					신속한 의사 결정을 위한 
					<span>사내 결재 시스템</span>
				</h1>
				<c:if test="${memberLoggedIn ne null }">
					<p>
						<a class="btn btn-lg btn-primary" href="${pageContext.request.contextPath }/office/office_main.do" role="button">
							오피스로 가기 &raquo;
						</a>
					</p>
				</c:if>
			</div>	
		</header>
	</div>
	<div class="container" style="text-align: center; margin-top: 21px;">
		<ul class="menuBtn" style="list-style: none;">
			<li class="isSelected">
				<img src="${pageContext.request.contextPath}/resources/images/common/check_small.png" class="menuIcon" alt="전자결재" />
				<p style="margin: 0 auto;">전자결재</p>
			</li>
			<li>
				<img src="${pageContext.request.contextPath}/resources/images/common/insa_small.png" class="menuIcon" alt="인사관리" />
				<p style="margin: 0 auto;">인사관리</p>
			</li>
			<li>
				<img src="${pageContext.request.contextPath}/resources/images/common/sch_small.png" class="menuIcon" alt="일정관리" />
				<p style="margin: 0 auto;">일정관리</p>
			</li>
			<li>
				<img src="${pageContext.request.contextPath}/resources/images/common/board_small.png" class="menuIcon" alt="게시판" />
				<p style="margin: 0 auto;">게시판</p>
			</li>
			<li>
				<img src="${pageContext.request.contextPath}/resources/images/common/address_small.png" class="menuIcon" alt="주소록" />
				<p style="margin: 0 auto;">주소록</p>
			</li>
			<li>
				<img src="${pageContext.request.contextPath}/resources/images/common/reservation_small.png" class="menuIcon" alt="예약" />
				<p style="margin: 0 auto;">예약</p>
			</li>
		</ul>
	</div>
	
	<div id="approval_main" class="main-exc container">
		<div style="width: 100%; display: inline-block; margin-bottom: 100px;">
			<div style="display: inline-block; width: 416px;">
				<h1 style="font-size: 2.8rem; padding-top: 50px; padding-bottom: 25px;">편리하고 간편한 <br />전자결재 시스템</h1>
				<p>
					전자결재 시스템으로 웹 상에서 작업하고 결재 받자.
				</p>
			</div>
			<img src="${pageContext.request.contextPath }/resources/images/common/main_approval1.JPG" alt="main_board1.JPG" style="width: 436px; border: 1px solid lightgray; float: right;"/>
		</div>
		<div style="width: 100%; display: inline-block; margin-bottom: 20px;">
			<img src="${pageContext.request.contextPath }/resources/images/common/main_approval2.JPG" alt="main_board2.JPG" style="width: 436px; border: 1px solid lightgray;"/>
			<div style="display: inline-block; width: 416px; float: right;">
				<h1 style="font-size: 2.8rem; padding-top: 50px; padding-bottom: 25px;">지출 데이터가 한번에</h1>
				<p>
					거래처, 계정과목, 부서를 지정할 수 있고, 지출 데이터를 한 눈에 확인할 수 있다.
				</p>
			</div>
		</div>
	</div>
	<div id="insa_main" class="hide main-exc container">
		<div style="width: 100%; display: inline-block; margin-bottom: 100px;">
			<div style="display: inline-block; width: 416px;">
				<h1 style="font-size: 2.8rem; padding-top: 50px; padding-bottom: 25px;">한 눈에 볼 수있는 <br />직원 목록</h1>
				<p>
					전체 직원을 볼 수 있을 뿐 아니라<br />입사년도, 직위, 부서 별로도 볼 수 있습니다.
				</p>
			</div>
			<img src="${pageContext.request.contextPath }/resources/images/common/main_insa1.JPG" alt="main_insa1.JPG" style="width: 436px; border: 1px solid lightgray; float: right;"/>
		</div>
		<div style="width: 100%; display: inline-block; margin-bottom: 20px;">
			<img src="${pageContext.request.contextPath }/resources/images/common/main_insa2.JPG" alt="main_insa2.JPG" style="width: 436px; border: 1px solid lightgray;"/>
			<div style="display: inline-block; width: 416px; float: right;">
				<h1 style="font-size: 2.8rem; padding-top: 50px; padding-bottom: 25px;">이젠 전자결재로<br />휴가가자~~</h1>
				<p>
					휴가 신청을 전자결재로 기안할 수 있고, 관리자는 휴가를 생성, 수정, 삭제할 수 있습니다. <br />
					휴가 기본 설정을 통해 선택한 달의 1일에 연차 휴가가 자동으로 생성됩니다.
				</p>
			</div>
		</div>
	</div>
	<div id="schedule_main" class="hide main-exc container">
		<div style="width: 100%; display: inline-block; margin-bottom: 100px;">
			<div style="display: inline-block; width: 416px;">
				<h1 style="font-size: 2.8rem; padding-top: 50px; padding-bottom: 25px;">쉽고 빠르게 등록할 수 있는 프로젝트</h1>
				<p>
					간편하게 일정을 등록할 수 있습니다. <br />개인 프로젝트는 물론 팀원과 함께 관리하는 공유 프로젝트도 만들 수 있습니다.
				</p>
			</div>
			<img src="${pageContext.request.contextPath }/resources/images/common/main_schedule1.JPG" alt="main_schedule1.JPG" style="width: 436px; border: 1px solid lightgray; float: right;"/>
		</div>
		<div style="width: 100%; display: inline-block; margin-bottom: 20px;">
			<img src="${pageContext.request.contextPath }/resources/images/common/main_schedule2.JPG" alt="main_schedule2.JPG" style="width: 436px; border: 1px solid lightgray;"/>
			<div style="display: inline-block; width: 416px; float: right;">
				<h1 style="font-size: 2.8rem; padding-top: 50px; padding-bottom: 25px;">세부사항까지 챙길 수 있는 부가 기능</h1>
				<p>
					상세한 검색 기능으로 기간/프로젝트별 검색이 가능합니다.
				</p>
			</div>
		</div>
	</div>
	<div id="board_main" class="hide main-exc container">
		<div style="width: 100%; display: inline-block; margin-bottom: 100px;">
			<div style="display: inline-block; width: 416px;">
				<h1 style="font-size: 2.8rem; padding-top: 50px; padding-bottom: 25px;">누구나 만들 수 있는 사내 게시판</h1>
				<p>
					관리자가 게시판을 만들어 커뮤니티 공간으로 활용할 수 있습니다. <br />게시물을 등록하고 확인할 수 있습니다.
				</p>
			</div>
			<img src="${pageContext.request.contextPath }/resources/images/common/main_board1.JPG" alt="main_board1.JPG" style="width: 436px; border: 1px solid lightgray; float: right;"/>
		</div>
		<div style="width: 100%; display: inline-block; margin-bottom: 20px;">
			<img src="${pageContext.request.contextPath }/resources/images/common/main_board2.JPG" alt="main_board2.JPG" style="width: 436px; border: 1px solid lightgray;"/>
			<div style="display: inline-block; width: 416px; float: right;">
				<h1 style="font-size: 2.8rem; padding-top: 50px; padding-bottom: 25px;">보다 원활한 소통으로 이끌 게시판</h1>
				<p>
					공지, 파일 첨부 등 유용한 기능으로 팀원과의 원활한 소통을 돕습니다.
				</p>
			</div>
		</div>
	</div>
	<div id="address_main" class="hide main-exc container">
		<div style="width: 100%; display: inline-block; margin-bottom: 100px;">
			<div style="display: inline-block; width: 416px;">
				<h1 style="font-size: 2.8rem; padding-top: 50px; padding-bottom: 25px;">업무에 관련된<br />주소록은 공유하자~~</h1>
				<p>
					업무에 관련된 주소록을 등록, 수정, 삭제 할 수 있고, <br />주소록은 사내 공유 됩니다.
				</p>
			</div>
			<img src="${pageContext.request.contextPath }/resources/images/common/main_address1.JPG" alt="main_address1.JPG" style="width: 436px; border: 1px solid lightgray; float: right;"/>
		</div>
		<div style="width: 100%; display: inline-block; margin-bottom: 20px;">
			<img src="${pageContext.request.contextPath }/resources/images/common/main_address2.JPG" alt="main_address2.JPG" style="width: 436px; border: 1px solid lightgray;"/>
			<div style="display: inline-block; width: 416px; float: right;">
				<h1 style="font-size: 2.8rem; padding-top: 50px; padding-bottom: 25px;">버린 주소록도<br />다시보자</h1>
				<p>
					삭제된 주소록은 다시 복원 할 수 있습니다.
				</p>
			</div>
		</div>
	</div>
	<div id="reservation_main" class="hide main-exc container">
		<div style="width: 100%; display: inline-block; margin-bottom: 100px;">
			<div style="display: inline-block; width: 416px;">
				<h1 style="font-size: 2.8rem; padding-top: 50px; padding-bottom: 25px;">회사 비품을 예약해서 사용하자</h1>
				<p>
					회사 비품을 예약할 수 있고, 예약 현황을 확인할 수 있습니다.
				</p>
			</div>
			<img src="${pageContext.request.contextPath }/resources/images/common/main_reservation1.JPG" alt="main_board1.JPG" style="width: 436px; border: 1px solid lightgray; float: right;"/>
		</div>
		<div style="width: 100%; display: inline-block; margin-bottom: 20px;">
			<img src="${pageContext.request.contextPath }/resources/images/common/main_reservation2.JPG" alt="main_board2.JPG" style="width: 436px; border: 1px solid lightgray;"/>
			<div style="display: inline-block; width: 416px; float: right;">
				<h1 style="font-size: 2.8rem; padding-top: 50px; padding-bottom: 25px;">비품 카테고리와 자원을 한번에 관리하자</h1>
				<p>
					비품 카테고리와 자원을 한번에 관리할 수 있습니다.
				</p>
			</div>
		</div>
	</div>
	
	<!-- 로그인 modal -->
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
	        <button type="submit" class="btn btn-outline-info">로그인</button>
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
	      </div>
	      </form>
	    </div>
	  </div>
	</div>
</body>
</html>