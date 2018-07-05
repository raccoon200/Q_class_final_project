<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/style_nav.css" />
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>

<script>
	$(function(){
		$(".depth1").click(function(){
			$(this).siblings("ul.depth2").toggleClass("show");
			if($(this).siblings(".depth2").hasClass("show")){
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
		$(".menu_list li a").each(function(index, item) {
			console.log(item.text.trim());
			console.log("${param.selectMenu}");
			console.log(item.text.trim() == "${param.selectMenu}");
			if (item.text.trim() == "${param.selectMenu}") {
				$(this).addClass("strong");
			}
		});
		if("${param.selectMenu ne null}"=="true"){
			$(".depth2").addClass("show");
			$(".fold").attr("src", "${pageContext.request.contextPath }/resources/images/common/folder_icon_open.png");
		}
		var parentsWidth = $("div.container_main").css("width");
		var navWidth = $("nav#leftMenu").css("width");
		console.log(parentsWidth);
		console.log(navWidth);
		$("div#sabu_container").css("width",parseFloat(parentsWidth)-parseFloat(navWidth)+"px");
		$(window).resize(function(){
			location.reload();
		})
	
		
	});
</script>
<nav id="leftMenu" class="container" style="margin: 0; padding: 0;">
	<c:if test="${param.pageTitle eq '전자결재'}">
		<div class="main_btn">
			<button type="button" class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/approval/approvalInsert.do'">작성하기</button>
		</div>
		<div class="menufield">
			<ul class="menu_list">
				<li><a href="${pageContext.request }/office/approval.do">대기</a><br />
				</li>
				<li><a href="#">예정</a><br /></li>
				<li><a href="#">진행</a><br /></li>
				<li><a href="#">완료</a><br /></li>
				<li><a href="#">수신 대기</a><br /></li>
				<li><a href="#">회람 대기</a><br /></li>
				<li><a href="javascript:void(0)" class="depth1"> <img
						src="${pageContext.request.contextPath }/resources/images/common/folder_icon.png"
						alt="폴더" class="fold" /> 문서함
				</a> <br />
					<ul class="depth2 hide">
						<li><a href="#">전체</a><br /></li>
						<li><a href="#">기안</a><br /></li>
						<li><a href="#">결제</a><br /></li>
						<li><a href="#">수신</a><br /></li>
						<li><a href="#">회람/참조</a><br /></li>
						<li><a href="#">반려</a><br /></li>
						<li><a href="#">임시 보관</a><br /></li>
					</ul></li>
				<li><a href="${pageContext.request.contextPath }/approval/approvalSetting.do">설정</a><br /></li>
				<c:if
					test='${memberLoggedIn.grade eq "슈퍼관리자" or memberLoggedIn.grade eq "전자결재관리자"}'>
					<li><a href="javascript:void(0)" class="depth1"> <img
							src="${pageContext.request.contextPath }/resources/images/common/folder_icon.png"
							alt="폴더" class="fold" /> 관리자 설정
					</a> <br />
						<ul class="depth2 hide">
							<li><a href="${pageContext.request.contextPath }/approval/admin/approvalAdminInsert.do">관리자 추가</a><br /></li>
							<li><a href="#">기본 설정</a><br /></li>
							<li><a href="#">양식함 관리</a><br /></li>
							<li><a href="#">전체 문서 목록</a><br /></li>
							<li><a href="#">삭제 문서 목록</a><br /></li>
						</ul></li>
					<li>
						<a href="javascript:void(0)" class="depth1"> 
							<img src="${pageContext.request.contextPath }/resources/images/common/folder_icon.png" alt="폴더" class="fold" /> 
							회계 정보 관리
						</a>
						<br />
						<ul class="depth2 hide">
							<li>
								<a href="${pageContext.request.contextPath }/office/approval/account.do">기본 정보</a><br />
							</li>
							<li>
								<a href="${pageContext.request.contextPath }/office/approval/code.do">코드 관리</a><br />
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
	<script>
	function fn_boardWrite(no) {
		console.log(no);
		if(no==1 && '${memberLoggedIn.grade}'!='슈퍼관리자' && !'${memberLoggedIn.grade}'!='게시판관리자') {
			alert("사내공지는 관리자만 글을 쓸 수 있습니다");
			return false;
		}
		location.href='${pageContext.request.contextPath}/board/boardForm?boardMenuNo=${currentMenuNo}';
	}
	</script>
	<c:if test="${param.pageTitle eq '게시판'}">
		<div class="main_btn">
			<button type="button" class="btn btn-primary" onclick="fn_boardWrite(${currentMenuNo})" >글쓰기</button>
		</div>
		<div class="menufield">
			<ul class="menu_list">
				<li>
					<a href="${pageContext.request.contextPath }/board/boardRecentList">최근 게시물</a><br />
				</li>
				<li>
					<a href="${pageContext.request.contextPath }/board/boardImportantList">중요 게시물</a><br />
				</li>
				<li>
					<a href="javascript:void(0)" class="depth1">
						<img src="${pageContext.request.contextPath }/resources/images/common/folder_icon.png" alt="폴더" class="fold"/>
						전사 게시판
					</a>
					<br />
					<ul class="depth2 hide">
						<c:if test="${basicBoard != null}">
							<c:forEach var="v" varStatus="vs" items="${basicBoard }">
							<li class="board_menu_name">
								<c:if test="${v.USERID eq memberLoggedIn.userId or memberLoggedIn.grade eq '슈퍼관리자' }">
								<img src="${pageContext.request.contextPath }/resources/images/common/edit (1).png" class="icon_edit icon_edit_board" alt="수정" onclick="location.href='${pageContext.request.contextPath}/board/boardMenuFormUpdate?boardMenuNo=${v.BOARD_MENU_NO }'"/>
								</c:if>
								<a href="${pageContext.request.contextPath }/board/boardBasicList?boardMenuNo=${v.BOARD_MENU_NO}&title=${v.TITLE}">${v.TITLE}</a><br />
							</li>
							</c:forEach>
						</c:if>
					</ul>
				</li>
				<li>
					<a href="javascript:void(0)" class="depth1">
						<img src="${pageContext.request.contextPath }/resources/images/common/folder_icon.png" alt="폴더" class="fold"/>
						그룹 게시판
					</a>
					<br />
					<ul class="depth2 hide">
						<c:if test="${basicBoard != null}">
							<c:forEach var="v" varStatus="vs" items="${groupBoard }">
							<li class="board_menu_name">
								<c:if test="${v.USERID eq memberLoggedIn.userId or memberLoggedIn.grade eq '슈퍼관리자' }">
								<img src="${pageContext.request.contextPath }/resources/images/common/edit (1).png" class="icon_edit icon_edit_board" alt="수정" onclick="location.href='${pageContext.request.contextPath}/board/boardMenuFormUpdate?boardMenuNo=${v.BOARD_MENU_NO }'"/>
								</c:if>
								<a href="${pageContext.request.contextPath }/board/boardBasicList?boardMenuNo=${v.BOARD_MENU_NO}">${v.TITLE}</a><br />
							</li>
							</c:forEach>
						</c:if>
					</ul>
				</li>
				<c:if test='${memberLoggedIn.grade eq "슈퍼관리자" or memberLoggedIn.grade eq "게시판관리자"}'>
					<br />
					<li>
						<a href="${pageContext.request.contextPath }/board/boardMenuForm">게시판 만들기</a><br />
					</li>
					
				</c:if>
				<c:if test='${memberLoggedIn.grade eq "슈퍼관리자" }'>
					<li>
						<a href="${pageContext.request.contextPath }/board/boardMenuManage">게시판 관리</a><br />
					</li>
				</c:if>
				<c:if test='${memberLoggedIn.grade eq "슈퍼관리자" }'>
					<li>
						<a href="${pageContext.request.contextPath }/board/admin/boardAdminInsert.do">게시판 관리자 관리</a><br />
					</li>
				</c:if>
			</ul>
		</div>
	</c:if>
	<!-- 인사관리 nav -->
	<c:if test="${param.pageTitle eq '인사관리'}">
		<div class="main_btn">
			<!-- 남은 휴가 가지고 와야함. 안가지고 오면 오류 생김. 차라리 Member에 남은 휴가를 포함 시켜 memberLoggedIn에 남기는게 좋을 것 같음... 아님 뭐 세션에 남은 휴가만 남기든가?? -->
			<p>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span class="title">남은 휴가</span> <span
					class="num" id="left_vation_num"> <!-- 10 -->  
					
					<c:forEach var="item" items="${personBreak}">
						 ${item.REWARD_BREAK + item.REGULAR_BREAK}
					</c:forEach>
				</span>일
			</p>
		</div>
		<hr />
		<div class="menufield">
			<ul class="menu_list">
				<li><a href="javascript:void(0)" class="depth1"> <img
						src="${pageContext.request.contextPath }/resources/images/common/folder_icon.png"
						alt="폴더" class="fold" /> 인사 정보
				</a> <br />
					<ul class="depth2 hide">
						<li><a
							href="${pageContext.request.contextPath}/insa/memberListAll.do">직원 목록</a><br /></li>
						<li><a
							href="${pageContext.request.contextPath }/member/memberOneSelect.do?userId=${memberLoggedIn.userId}">내 정보 관리</a><br /></li>
					</ul></li>
				<li><a href="javascript:void(0)" class="depth1"> <img
						src="${pageContext.request.contextPath }/resources/images/common/folder_icon.png"
						alt="폴더" class="fold" /> 휴가
				</a> <br />
					<ul class="depth2 hide">
						<li>
							<a href="${pageContext.request.contextPath}/break/breakRequest.do">휴가 신청</a><br />
						</li>
						<li>
							<a href="${pageContext.request.contextPath}/break/myBreak">휴가 현황</a><br />
						</li>
					</ul>
				</li>
				<c:if test='${memberLoggedIn.grade eq "슈퍼관리자" or memberLoggedIn.grade eq "인사관리관리자"}'>
					<br />
					<li><a href="javascript:void(0)" class="depth1"> <img
							src="${pageContext.request.contextPath }/resources/images/common/folder_icon.png"
							alt="폴더" class="fold" /> 인사관리
					</a> <br />
						<ul class="depth2 hide">
							<li>
								<a href="#">조직 관리</a><br />
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/insa/memberManagement.do">사용자 관리</a><br />
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/insa/positionManagement.do">직위/직무 관리</a><br />
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
								<a href="${pageContext.request.contextPath}/break/breakCreate.do">휴가 생성</a><br />
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
		<div class="main_btn"><!-- <a href="../address/addressAdd.do"/>  formaction='/views/address/doaddressAdd.do' -->
		<a href="../address/addressAdd.do"> 	
			<button type="button" class="btn btn-primary">주소 추가</button> 
			</a>
		</div>
		<div class="menufield">
			<ul class="menu_list">
				<%-- <li><a href="${pageContext.request.contextPath}/address/addr_personal">개인 주소록&nbsp;<span
						class="badge badge-secondary">2</span></a><br /></li> --%>
				<li><a href="${pageContext.request.contextPath}/address/addressView.do">공유 주소록&nbsp;<span
						class="badge badge-secondary">2</span></a><br /></li>
				<li><a href="${pageContext.request.contextPath}/address/addressTrashList">휴지통&nbsp;<span
						class="badge badge-secondary">2</span></a><br /></li>
				<li><a href="javascript:void(0)" class="depth1"> <img
						src="${pageContext.request.contextPath }/resources/images/common/folder_icon.png"
						alt="폴더" class="fold" /> 환경설정
				</a> <br />
					<ul class="depth2 hide">
						<li><a href="#">기본정보 설정</a><br /></li>
					</ul></li>
			</ul>
		</div>
	</c:if>
	<!-- 예약 nav -->
	<c:if test="${param.pageTitle eq '예약'}">
		<div class="main_btn">
			<button type="button" class="btn btn-primary" data-toggle="modal"
				data-target="#reservation">예약하기</button>
		</div>
		<div class="menufield">
			<ul class="menu_list">
				<li><a href="${pageContext.request.contextPath}/reservation/reservationListPage">나의 예약 목록</a><br /></li>
				<!-- 여기 반복문 돌리시길........................... -->
				<li><a href="#">회의실</a><br /></li>
				<li><a href="#">여기 반복문</a><br /></li>
				<!---------------------------------------------->
				<c:if
					test='${memberLoggedIn.grade eq "슈퍼관리자" or memberLoggedIn.grade eq "예약관리자"}'>
					<br />
					<li><a href="javascript:void(0)" class="depth1"> <img
							src="${pageContext.request.contextPath }/resources/images/common/folder_icon.png"
							alt="폴더" class="fold" /> 예약 관리
					</a> <br />
						<ul class="depth2 hide">
							<li><a href="${pageContext.request.contextPath}/reservation/reservationApprovalManagement">승인 관리</a><br /></li>
							<li><a href="${pageContext.request.contextPath}/reservation/reservationReturnManagement">반납 관리</a><br /></li>
							<li><a href="${pageContext.request.contextPath}/reservation/reservationCategoryManagement">카테고리 관리</a><br /></li>
							<li><a href="#">자원관리</a><br /></li>
							<li><a href="${pageContext.request.contextPath }/reservation/admin/reservationAdminInsert.do">예약 관리자</a><br /></li>
						</ul></li>
				</c:if>
			</ul>
		</div>
	</c:if>
	<!-- 일정관리 nav -->
	<c:if test="${param.pageTitle eq '일정관리'}">
		<div class="main_btn">
			<button type="button" id="insertBtn" type="button" class="btn btn-primary" data-toggle="modal" 
		        data-target="#calendarInsert" onclick="buttonInsert();">일정추가</button>
		</div>
		
		<!-- 캘린더 보기 -->
		
		<div class="custom-control custom-checkbox" style="text-align:left; margin-left:25px; margin-top:25px;">
  			<input type="checkbox" class="custom-control-input" name="calChoice" id="customCheck1" onclick="fn_myCal('내 캘린더');"
  			${type eq '내 캘린더'?"checked":""}>
  			<label class="custom-control-label" for="customCheck1">내 캘린더 보기</label>
		</div>
		 <script>
		function fn_myCal(type,userId){
			location.href='${pageContext.request.contextPath}/cal/myCal.do?type='+type;
		}
		</script> 
		
		<div class="custom-control custom-checkbox" style="text-align:left; margin-left:25px;">
  			<input type="checkbox" class="custom-control-input" name="calChoice" id="customCheck2" value="공유 캘린더" onclick="fn_calchoice('공유 캘린더');"
  			  ${type eq '공유 캘린더'?"checked":""}>
  			<label class="custom-control-label" for="customCheck2">공유 캘린더 보기</label>
		</div>
		<script>
		function fn_calchoice(type){
			location.href='${pageContext.request.contextPath}/cal/shareCal.do?type='+type;
		}
		</script>
		
		<div class="custom-control custom-checkbox" style="text-align:left; margin-left:25px;">
  			<input type="checkbox" class="custom-control-input" name="calChoice" id="customCheck3" value="공유 캘린더" onclick="fn_sumCal('같이');"
  			  ${type eq '같이'?"checked":""}>
  			<label class="custom-control-label" for="customCheck3">캘린더 같이 보기</label>
		</div>
		<script>
		function fn_sumCal(type){
			location.href='<%=request.getContextPath()%>/cal/calTest.do?type='+type;
		}
		</script>
		
		<div class="menufield">
			<ul class="menu_list">
				<li>
					<a href="javascript:void(0)" class="depth1" style="font-size:20px;">
						<img src="${pageContext.request.contextPath }/resources/images/common/folder_icon.png" alt="폴더" class="fold"/>
						내 캘린더
					</a>
						&nbsp;&nbsp;&nbsp; <span class="calinsert"  onclick="calendarInsertFrm('내 캘린더');">만들기</span>
					
					<br />
					<ul class="depth2 hide">	
					<c:if test="${not empty clist}">
		   			 <c:forEach var="seche" items="${clist}" varStatus="vs">
		       			 <c:if test="${seche.TYPE eq '내 캘린더'}">
		   			 	   
							 <li class="board_menu_name">
								<%-- <img src="${pageContext.request.contextPath }/resources/images/common/edit (1).png" class="icon_edit" alt="수정" /> --%>
								<div class="divBox" style="background:${seche.COLOR}"></div>
								
							    <a href="<%=request.getContextPath()%>/cal/calcalendar.do?calendar_name=${seche.CALENDAR_NAME}&calendarid=${seche.CALENDARID}">${seche.CALENDAR_NAME}</a>
								<%-- ${seche.CALENDAR_NAME} --%>
								
								<!-- 캘린더 수정 -->
								&nbsp;&nbsp;&nbsp; <span class="calupdate"  onclick="calendarUpdateFrm('${seche.CALENDAR_NAME}','${seche.CALENDARID}', '${seche.COLOR}','${seche.TYPE}');">수정</span>
								
								<br />
							</li>
		   			 	</c:if>
		   			</c:forEach>
					</c:if>

					</ul>
				</li>
				<br />
				<li>
					<a href="javascript:void(0)" class="depth1" style="font-size:20px;">
						<img src="${pageContext.request.contextPath }/resources/images/common/folder_icon.png" alt="폴더" class="fold"/>
						공유 캘린더
					</a>
					&nbsp;&nbsp;&nbsp; <span class="calinsert"  onclick="calendarInsertFrm('공유 캘린더');">만들기</span>
					
					<br />
					<ul class="depth2 hide">
						<c:if test="${not empty clist}">
			   			 <c:forEach var="seche" items="${clist}" varStatus="vs">
			       			 <c:if test="${seche.TYPE eq '공유 캘린더'}">
			   			 	   
								 <li class="board_menu_name">
									<%-- <img src="${pageContext.request.contextPath }/resources/images/common/edit (1).png" class="icon_edit" alt="수정" /> --%>
									<div class="divBox" style="background:${seche.COLOR}"></div> &nbsp;&nbsp;
									
								
									<%-- <a href="<%=request.getContextPath()%>/cal/calcalendar.do?calendar_name=${seche.CALENDAR_NAME}">${seche.CALENDAR_NAME}</a> --%>
									 <a href="<%=request.getContextPath()%>/cal/calcalendar.do?calendar_name=${seche.CALENDAR_NAME}&calendarid=${seche.CALENDARID}">${seche.CALENDAR_NAME}</a>
									<%-- ${seche.CALENDAR_NAME} --%>
									
									<!-- 캘린더 수정 -->
									&nbsp;&nbsp;&nbsp; <span class="calupdate"  onclick="calendarUpdateFrm('${seche.CALENDAR_NAME}','${seche.CALENDARID}','${seche.COLOR}','${seche.TYPE}');">수정</span>
									
								</li>
			   			 	</c:if>
			   			</c:forEach>
						</c:if>
					</ul>
				</li>
			</ul>
		</div>
	</c:if>
</nav>

<div id="sabu_container" style="margin: 0px;">
	