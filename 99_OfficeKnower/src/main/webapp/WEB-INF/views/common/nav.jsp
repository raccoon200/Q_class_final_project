<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/style_nav.css" />
<script>
	$(function(){
		$(".depth1").click(function(){
			$(this).siblings("ul.depth2").toggleClass("show");
			if($(".depth2").hasClass("show")){
				$(this).children(".fold").attr("src", "${pageContext.request.contextPath }/resources/images/common/folder_icon_open.png");
			}else{
				$(this).children(".fold").attr("src", "${pageContext.request.contextPath }/resources/images/common/folder_icon.png");
			}
		});
		$("img.icon_edit").hover(function(){
			$(this).attr("src","${pageContext.request.contextPath }/resources/images/common/edit (2).png");
		},function(){
			$(this).attr("src","${pageContext.request.contextPath }/resources/images/common/edit (1).png");
		});
		if('${memberLoggedIn.grade}' != '슈퍼관리자' || '${memberLoggedIn.grade}' != '게시판관리자'){
			$("img.icon_edit icon_edit_board").hide();
		}
		$(".menu_list li a").each(function(index,item){
			console.log(item.text.trim());
			console.log("${param.selectMenu}");
			console.log(item.text.trim() == "${param.selectMenu}");
			if(item.text.trim() == "${param.selectMenu}"){
				$(this).addClass("strong");
			}
		});
	});
</script>
<nav id="leftMenu">
	<c:if test="${param.pageTitle eq '전자결재'}">
		<div class="main_btn">
			<button type="button" class="btn btn-primary">작성하기</button>
		</div>
		<div class="menufield">
			<ul class="menu_list">
				<li>
					<a href="${pageContext.request }/office/approval.do">대기</a><br />
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
					<a href="javascript:void(0)" class="depth1">
						<img src="${pageContext.request.contextPath }/resources/images/common/folder_icon.png" style="left: -4px; top: 218px;" alt="폴더" class="fold"/>
						문서함
					</a>
					<br />
					<ul class="depth2 hide">
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
				<c:if test='${memberLoggedIn.grade eq "슈퍼관리자" or memberLoggedIn.grade eq "전자결재관리자"}'>
					<li>
						<a href="javascript:void(0)" class="depth1">
							<img src="${pageContext.request.contextPath }/resources/images/common/folder_icon.png" alt="폴더" class="fold"/>
							관리자 설정
						</a>
						<br />
						<ul class="depth2 hide">
							<li>
								<a href="#">관리자 추가</a><br />
							</li>
							<li>
								<a href="#">기본 설정</a><br />
							</li>
							<li>
								<a href="#">양식함 관리</a><br />
							</li>
							<li>
								<a href="#">전체 문서 목록</a><br />
							</li>
							<li>
								<a href="#">삭제 문서 목록</a><br />
							</li>
						</ul>
					</li>
					<li>
						<a href="javascript:void(0)" class="depth1">
							<img src="${pageContext.request.contextPath }/resources/images/common/folder_icon.png" alt="폴더" class="fold"/>
							회계 정보 관리
						</a>
						<br />
						<ul class="depth2 hide">
							<li>
								<a href="#">기본 정보</a><br />
							</li>
							<li>
								<a href="#">코드 관리</a><br />
							</li>
							<li>
								<a href="#">데이터 조회</a><br />
							</li>
						</ul>
					</li>
				</c:if>
			</ul>
		</div>
	</c:if>
	<!-- 게시판 nav -->
	<c:if test="${param.pageTitle eq '게시판'}">
		<div class="main_btn">
			<button type="button" class="btn btn-primary">글쓰기</button>
		</div>
		<div class="menufield">
			<ul class="menu_list">
				<li>
					<a href="">최근 게시물</a><br />
				</li>
				<li>
					<a href="#">중요 게시물</a><br />
				</li>
				<li>
					<a href="javascript:void(0)" class="depth1">
						<img src="${pageContext.request.contextPath }/resources/images/common/folder_icon.png" alt="폴더" class="fold"/>
						전사 게시판
					</a>
					<br />
					<ul class="depth2 hide">
						<li class="board_menu_name">
							<img src="${pageContext.request.contextPath }/resources/images/common/edit (1).png" class="icon_edit icon_edit_board" alt="수정" />
							<a href="#">사내공지</a><br />
						</li>
						<li class="board_menu_name">
							<img src="${pageContext.request.contextPath }/resources/images/common/edit (1).png" class="icon_edit icon_edit_board" alt="수정" />
							<a href="#">목록들 반복문 돌려야함.</a><br />
						</li>
					</ul>
				</li>
				<li>
					<a href="javascript:void(0)" class="depth1">
						<img src="${pageContext.request.contextPath }/resources/images/common/folder_icon.png" alt="폴더" class="fold"/>
						그룹 게시판
					</a>
					<br />
					<ul class="depth2 hide">
						<li class="board_menu_name">
							<img src="${pageContext.request.contextPath }/resources/images/common/edit (1).png" class="icon_edit icon_edit_board" alt="수정" />
							<a href="#">목록들 반복문 돌려야함.</a><br />
						</li>
					</ul>
				</li>
				<c:if test='${memberLoggedIn.grade eq "슈퍼관리자" or memberLoggedIn.grade eq "게시판관리자"}'>
					<br />
					<li>
						<a href="#">게시판 만들기</a><br />
					</li>
					<li>
						<a href="#">게시판 관리</a><br />
					</li>
				</c:if>
			</ul>
		</div>
	</c:if>
	<!-- 인사관리 nav -->
	<c:if test="${param.pageTitle eq '인사관리'}">
		<div class="main_btn">
			<!-- 남은 휴가 가지고 와야함. 안가지고 오면 오류 생김. 차라리 Member에 남은 휴가를 포함 시켜 memberLoggedIn에 남기는게 좋을 것 같음... 아님 뭐 세션에 남은 휴가만 남기든가?? -->
			<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<span class="title">남은 휴가</span>
				<span class="num" id="left_vation_num">10</span>일			
			</p>
		</div>
		<hr />
		<div class="menufield">
			<ul class="menu_list">
				<li>
					<a href="javascript:void(0)" class="depth1">
						<img src="${pageContext.request.contextPath }/resources/images/common/folder_icon.png" alt="폴더" class="fold"/>
						인사 정보
					</a>
					<br />
					<ul class="depth2 hide">
						<li>
							<a href="${pageContext.request.contextPath}/insa/memberListAll.do">직원 목록</a><br />
						</li>
						<li>
							<a href="${pageContext.request.contextPath }/member/memberOneSelect.do?userId=${memberLoggedIn.userId}">내 정보 관리</a><br />
						</li>
					</ul>
				</li>
				<li>
					<a href="javascript:void(0)" class="depth1">
						<img src="${pageContext.request.contextPath }/resources/images/common/folder_icon.png" alt="폴더" class="fold"/>
						휴가
					</a>
					<br />
					<ul class="depth2 hide">
						<li>
							<a href="#">휴가 신청</a><br />
						</li>
						<li>
							<a href="#">휴가 현황</a><br />
						</li>
					</ul>
				</li>
				<c:if test='${memberLoggedIn.grade eq "슈퍼관리자" or memberLoggedIn.grade eq "인사관리관리자"}'>
					<br />
					<li>
						<a href="javascript:void(0)" class="depth1">
							<img src="${pageContext.request.contextPath }/resources/images/common/folder_icon.png" alt="폴더" class="fold"/>
							인사관리
						</a>
						<br />
						<ul class="depth2 hide">
							<li>
								<a href="#">조직 관리</a><br />
							</li>
							<li>
								<a href="#">사용자 관리</a><br />
							</li>
							<li>
								<a href="#">직위/직무 관리</a><br />
							</li>
							<li>
								<a href="#">인사관리자</a><br />
							</li>
						</ul>
					</li>
					<li>
						<a href="javascript:void(0)" class="depth1">
							<img src="${pageContext.request.contextPath }/resources/images/common/folder_icon.png" alt="폴더" class="fold"/>
							휴가 관리
						</a>
						<br />
						<ul class="depth2 hide">
							<li>
								<a href="#">기본설정</a><br />
							</li>
							<li>
								<a href="#">휴가 생성</a><br />
							</li>
							<li>
								<a href="#">직원 휴가 관리</a><br />
							</li>
						</ul>
					</li>
				</c:if>
			</ul>
		</div>
	</c:if>
	<!-- 게시판 nav -->
	<c:if test="${param.pageTitle eq '주소록'}">
		<div class="main_btn">
			<button type="button" class="btn btn-primary">주소 추가</button>
		</div>
		<div class="menufield">
			<ul class="menu_list">
				<li>
					<a href="#">개인 주소록&nbsp;<span class="badge badge-secondary">2</span></a><br />
				</li>
				<li>
					<a href="#">공유 주소록&nbsp;<span class="badge badge-secondary">2</span></a><br />
				</li>
				<li>
					<a href="#">휴지통&nbsp;<span class="badge badge-secondary">2</span></a><br />
				</li>
				<li>
					<a href="javascript:void(0)" class="depth1">
						<img src="${pageContext.request.contextPath }/resources/images/common/folder_icon.png" alt="폴더" class="fold"/>
						환경설정
					</a>
					<br />
					<ul class="depth2 hide">
						<li>
							<a href="#">기본정보 설정</a><br />
						</li>
					</ul>
				</li>
			</ul>
		</div>
	</c:if>
	<!-- 예약 nav -->
	<c:if test="${param.pageTitle eq '예약'}">
		<div class="main_btn">
			<button type="button" class="btn btn-primary">예약하기</button>
		</div>
		<div class="menufield">
			<ul class="menu_list">
				<li>
					<a href="#">나의 예약 목록</a><br />
				</li>
				<!-- 여기 반복문 돌리시길........................... -->
				<li>
					<a href="#">회의실</a><br />
				</li>
				<li>
					<a href="#">여기 반복문</a><br />
				</li>
				<!---------------------------------------------->
				<c:if test='${memberLoggedIn.grade eq "슈퍼관리자" or memberLoggedIn.grade eq "예약관리자"}'>
					<br />
					<li>
						<a href="javascript:void(0)" class="depth1">
							<img src="${pageContext.request.contextPath }/resources/images/common/folder_icon.png" alt="폴더" class="fold"/>
							예약 관리
						</a>
						<br />
						<ul class="depth2 hide">
							<li>
								<a href="#">승인 관리</a><br />
							</li>
							<li>
								<a href="#">반납 관리</a><br />
							</li>
							<li>
								<a href="#">카테고리 관리</a><br />
							</li>
							<li>
								<a href="#">자원관리</a><br />
							</li>
							<li>
								<a href="#">예약 관리자</a><br />
							</li>
						</ul>
					</li>
				</c:if>
			</ul>
		</div>
	</c:if>
	<!-- 게시판 nav -->
	<c:if test="${param.pageTitle eq '일정관리'}">
		<div class="main_btn">
			<button type="button" class="btn btn-primary">일정추가</button>
		</div>
		<div class="menufield">
			<ul class="menu_list">
				<li>
					<a href="javascript:void(0)" class="depth1">
						<img src="${pageContext.request.contextPath }/resources/images/common/folder_icon.png" alt="폴더" class="fold"/>
						내 캘린더
					</a>
					<br />
					<ul class="depth2 hide">
						<li class="board_menu_name">
							<img src="${pageContext.request.contextPath }/resources/images/common/edit (1).png" class="icon_edit" alt="수정" />
							<a href="#">켈린더1</a><br />
						</li>
						<li class="board_menu_name">
							<img src="${pageContext.request.contextPath }/resources/images/common/edit (1).png" class="icon_edit" alt="수정" />
							<a href="#">켈린터2</a><br />
						</li>
						<li class="board_menu_name">
							<img src="${pageContext.request.contextPath }/resources/images/common/edit (1).png" class="icon_edit" alt="수정" />
							<a href="#">반복문 돌리기</a><br />
						</li>
					</ul>
				</li>
				<li>
					<a href="javascript:void(0)" class="depth1">
						<img src="${pageContext.request.contextPath }/resources/images/common/folder_icon.png" alt="폴더" class="fold"/>
						공유 캘린더
					</a>
					<br />
					<ul class="depth2 hide">
						<li class="board_menu_name">
							<img src="${pageContext.request.contextPath }/resources/images/common/edit (1).png" class="icon_edit" alt="수정" />
							<a href="#">공유 켈린더1</a><br />
						</li>
						<li class="board_menu_name">
							<img src="${pageContext.request.contextPath }/resources/images/common/edit (1).png" class="icon_edit" alt="수정" />						
							<a href="#">공유켈린터2</a><br />
						</li>
						<li class="board_menu_name">
							<img src="${pageContext.request.contextPath }/resources/images/common/edit (1).png" class="icon_edit" alt="수정" />
							<a href="#">반복문 돌리기</a><br />
						</li>
					</ul>
				</li>
			</ul>
		</div>
	</c:if>
</nav>
<div id="sabu_container">
