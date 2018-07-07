<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="오피스 홈" name="pageTitle"/>
</jsp:include>
<link rel="icon" href="${pageContext.request.contextPath }/resources/favicon.ico">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/carousel.css">
<script>
	$(function(){
		$("body").css("overflow-y", "auto");
	});
</script>
<main role="main">
	<div id="myCarousel" class="carousel slide" data-ride="carousel">
        <ol class="carousel-indicators">
          <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
          <li data-target="#myCarousel" data-slide-to="1"></li>
          <li data-target="#myCarousel" data-slide-to="2"></li>
        </ol>
        <div class="carousel-inner">
          <div class="carousel-item active" style="background: url('${pageContext.request.contextPath }/resources/images/common/header-board.jpg') 69% 50%/cover no-repeat;">
            <div class="container">
              <div class="carousel-caption text-left">
                <h1 style="color: black;">${memberLoggedIn.com_name}에 오신걸 환영합니다.</h1>
                <p style="color: black;"></p>
              </div>
            </div>
          </div>
          <div class="carousel-item" style="background: url('${pageContext.request.contextPath }/resources/images/common/header-reservation.jpg') 69% 50%/cover no-repeat;">
            <div class="container">
              <div class="carousel-caption text-left">
                <h1 style="color: black;">${memberLoggedIn.com_name}에 오신걸 환영합니다.</h1>
                <p style="color: black;"></p>
              </div>
            </div>
          </div>
          <div class="carousel-item" style="background: url('${pageContext.request.contextPath }/resources/images/common/header-insa.jpg') 69% 50%/cover no-repeat;">
            <div class="container">
              <div class="carousel-caption text-left">
                <h1 style="color: black;">${memberLoggedIn.com_name}에 오신걸 환영합니다.</h1>
                <p style="color: black;"></p>
              </div>
            </div>
          </div>
        </div>
        <a class="carousel-control-prev" href="#myCarousel" role="button" data-slide="prev">
          <span class="carousel-control-prev-icon" aria-hidden="true"></span>
          <span class="sr-only">Previous</span>
        </a>
        <a class="carousel-control-next" href="#myCarousel" role="button" data-slide="next">
          <span class="carousel-control-next-icon" aria-hidden="true"></span>
          <span class="sr-only">Next</span>
        </a>
      </div>

	<div class="container marketing">

        <!-- Three columns of text below the carousel -->
        <div class="row">
          <div class="col-lg-4">
            <img src="${pageContext.request.contextPath }/resources/images/common/insa_small.png" alt="Generic placeholder image" width="100" height="100">
            <h2>인사 관리</h2>
            <p>끝에 구하지 이것을 장식하는 같으며, 어디 그리하였는가? 두기 싶이 봄날의 얼음 것이다. 청춘의 어디 바로 이는 것이다. 피고 있는 구하지 때문이다. 석가는 살 고동을 이상은 곧 뼈 그들에게 가장 칼이다.</p>
            <p><a class="btn btn-secondary" href="${pageContext.request.contextPath }/insa/memberListAll.do" role="button">인사관리 가기 &raquo;</a></p>
          </div><!-- /.col-lg-4 -->
          
          <div class="col-lg-4">
            <img src="${pageContext.request.contextPath }/resources/images/common/sch_small.png" alt="Generic placeholder image" width="100" height="100">
            <h2>일정 관리</h2>
            <p>끝에 구하지 이것을 장식하는 같으며, 어디 그리하였는가? 두기 싶이 봄날의 얼음 것이다. 청춘의 어디 바로 이는 것이다. 피고 있는 구하지 때문이다. 석가는 살 고동을 이상은 곧 뼈 그들에게 가장 칼이다.</p>
            <p><a class="btn btn-secondary" href="${pageContext.request.contextPath }/cal/calTest.do" role="button">일정관리 가기 &raquo;</a></p>
          </div><!-- /.col-lg-4 -->
          
          <div class="col-lg-4">
            <img src="${pageContext.request.contextPath }/resources/images/common/board_small.png" alt="Generic placeholder image" width="100" height="100">
            <h2>게시판</h2>
            <p>누구나 게시판을 만들어 커뮤니티 공간으로 활용할 수 있습니다. 모바일 앱이 지원되어 언제 어디서나 게시물을 등록하고 확인할 수 있습니다.</p>
            <p><a class="btn btn-secondary" href="${pageContext.request.contextPath }/board/boardRecentList" role="button">게시판 가기 &raquo;</a></p>
          </div><!-- /.col-lg-4 -->
          
          <div class="col-lg-4">
            <img src="${pageContext.request.contextPath }/resources/images/common/check_small.png" alt="Generic placeholder image" width="100" height="100">
            <h2>전자결재</h2>
            <p>신속한 의사 결정을 위한 무제한 사내 결재 시스템</p>
            <p><a class="btn btn-secondary" href="${pageContext.request.contextPath }/office/approval.do" role="button">전자결재 가기 &raquo;</a></p>
          </div><!-- /.col-lg-4 -->
          
          <div class="col-lg-4">
            <img src="${pageContext.request.contextPath }/resources/images/common/address_small.png" alt="Generic placeholder image" width="100" height="100">
            <h2>주소록</h2>
            <p>끝에 구하지 이것을 장식하는 같으며, 어디 그리하였는가? 두기 싶이 봄날의 얼음 것이다. 청춘의 어디 바로 이는 것이다. 피고 있는 구하지 때문이다. 석가는 살 고동을 이상은 곧 뼈 그들에게 가장 칼이다.</p>
            <p><a class="btn btn-secondary" href="${pageContext.request.contextPath }/address/addressView.do" role="button">주소록 가기 &raquo;</a></p>
          </div><!-- /.col-lg-4 -->
          
          <div class="col-lg-4">
            <img src="${pageContext.request.contextPath }/resources/images/common/reservation_small.png" alt="Generic placeholder image" width="100" height="100">
            <h2>예약</h2>
            <p>끝에 구하지 이것을 장식하는 같으며, 어디 그리하였는가? 두기 싶이 봄날의 얼음 것이다. 청춘의 어디 바로 이는 것이다. 피고 있는 구하지 때문이다. 석가는 살 고동을 이상은 곧 뼈 그들에게 가장 칼이다.</p>
            <p><a class="btn btn-secondary" href="${pageContext.request.contextPath }/reservation/reservationListPage" role="button">예약 가기 &raquo;</a></p>
          </div><!-- /.col-lg-4 -->
        </div><!-- /.row -->
        
        </div>
</main>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>