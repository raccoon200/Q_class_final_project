<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="게시판" name="pageTitle"/>
</jsp:include>
<jsp:include page="/WEB-INF/views/common/nav.jsp">
	<jsp:param value="게시판" name="pageTitle"/>
</jsp:include>

<script>
$(function() {
	<c:if test="${board.bookmark eq 'N'}">
	$("#important-none").show();
	$("#important-apply").hide();
	</c:if>
	
	<c:if test="${board.bookmark eq 'Y'}">
	$("#important-none").hide();
	$("#important-apply").show();
	</c:if>
	var boardNo = ${board.board_no};
	$("#important-none").click(function() {
		$("#important-none").hide();
		$("#important-apply").show();
		
		$.ajax( {
			type : "GET",
			url : "${pageContext.request.contextPath}/board/importantApply",
			data : {"boardNo" : boardNo},
			dataType : "json",
			success : function(data) {
				
				console.log(data);
				
				
			},
			error : function(xhr, status, e) {
				
			}
		})
	})
	$("#important-apply").click(function() {
		$("#important-none").show();
		$("#important-apply").hide();
		
		$.ajax( {
			type : "GET",
			url : "${pageContext.request.contextPath}/board/importantDelete",
			data : {"boardNo" : boardNo},
			dataType : "json",
			success : function(data) {
				
				console.log(data);
				
				
			
				
			},
			error : function(xhr, status, e) {
				
			}
		})
	})
})
</script>
<style>
/* 부트스트랩 라벨명 정렬 */
div#board-container label.custom-file-label{text-align:left;}
div#board-container{
	width:800px;
	text-align:center;
	position:relative;
}
.input-group-text{
	width:100px;
	text-align:center;
	
}
#input-group-text-cum{
	width:800px;
	margin:0 auto;
	text-align:center;
	
}
#file_name{
	color:rgb(0,123,255);
	text-decoration:underline;
	cursor:pointer
}
.textarea{
	background:white;
}
.profile {
	width:45px;
	height:45px;
}
#important-area{
	position:absolute;
	top:15px;
	left:-10px;
}
.profile {
	position:absolute;
	top:24px;
	left:23px;
}
#title {
	position:absolute;
	top:12px;
	left:85px;
	font-size:1.5em;
}
.sub {
	position:absolute;
	color: rgb(150,150,150);
	font-size:0.9em;	
}
#comment-delete {
	top:0px;
	left: 97%;
	color:rgb(0,125,255);
	cursor:pointer;
}
#writer {
	top:47px;
	left:85px;
}
#kind {
	top:47px;
	left:170px;
}
#count {
	top:47px;
	left:290px;
}
#writedate {
	top:47px;
	left:410px;
}
div#content{
 	border:none; 
	width:100%;
	min-height:180px;
	
	
}
#comment-insert {
	height:60px;
	padding:10px;
	position:relative;
}
.comment{ 
	width:100%;
	background:rgb(246,247,248);
	border:none;

}
#comment{
	padding-bottom:0px;
	
}
.comment-profile{
	width:30px;
	height:30px;
}
#comment-count{
	float:left;
	color:rgb(100,100,100);
	padding:10px;
	font-size:0.9em;
}
.comment-user{
	display:inline-block;
	float:left;
	margin-left:30px;
	padding:0px;
	text-align:left;
	position:relative;
	width:90%;
	height:100px;
	
}
#comment-writer{
	top:-5px;
	left:50px;
	font-weight:bold;
}
#comment-writedate{
	top:-5px;
	left:120px;
}
#comment-content{
	top:18px;
	left:50px;
	background:color(246,247,248);
	border:none;
}
/* #comment-insert-button{
	position:absolute;
	top:10px;
	left:700px;
} */
#comment-insert-area{
	position:absolute;
	top:10px;
	left:-100px;

}
.top-btn{
	position:absolute;
	top:-10px;
	color:rgb(0,125,255);
	float:left;
	cursor:pointer;
}
#top-btn-list {
	left:0px;
}
#top-btn-update {
	left:150px;
}
#top-btn-delete{
	left:90px;
}
#file {
	font-size: 0.9em;
	color:rgb(50,50,50);
	cursor:pointer;
	float:left;
	padding-left:10px;
}
#board-content{
	float:left;
	padding-left:10px;
	height:200px;
	width:800px;
	
}
#board-content p {
	text-align:left;
}
</style>
<script>
$(function() {
	console.log($(".comment-user").length);
	var height = 100;
	height = height*$(".comment-user").length+70;
	$("#comment").height(height+"px");
	
	console.log($("div.ql-tooltip.ql-hidden"));
	$("div.ql-tooltip.ql-hidden").remove();
})


</script>
<div id="board-container" style="width: 100%">
	<span onclick="location.href='${pageContext.request.contextPath}/board/boardBasicList'" class="top-btn" id="top-btn-list">목록이동</span>
	<c:if test="${memberLoggedIn !=null }">
		<c:if test="${memberLoggedIn.userId eq board.writer || memberLoggedIn.grade eq '슈퍼관리자' || memberLoggedIn.grade eq '게시판관리자'  }">
			<span onclick="location.href='${pageContext.request.contextPath}/board/boardDelete?boardNo=${board.board_no}'" id="top-btn-delete" class="top-btn">삭제</span> &nbsp;&nbsp;&nbsp;
		</c:if>
		<c:if test="${memberLoggedIn.userId eq board.writer }">
			<span onclick="location.href='${pageContext.request.contextPath}/board/boardUpdate?boardNo=${board.board_no}'" id="top-btn-update" class="top-btn">수정</span> &nbsp;&nbsp;&nbsp;
		</c:if>
	</c:if> 
	

	<div id="important-area">
		
		<img src="${pageContext.request.contextPath }/resources/images/common/important_none.png" id="important-none" alt="" />
		<img src="${pageContext.request.contextPath }/resources/images/common/important_apply.png" id="important-apply" alt="" />
	</div>
	<%-- <img src="${pageContext.request.contextPath}/resources/images/profile/${board.profile}" class="board-delete" alt=""> --%>
	<img src="${pageContext.request.contextPath}/resources/upload/member/${board.profile}" class="profile" alt="프로필">
	<p id="title">${board.title }</p>
	<p id="writer" class="sub">${board.writer }</p>
	<p id="kind" class="sub"><%-- ${board.kind } --%>전사게시판</p>
	<p id="count" class="sub"><%-- ${board.count } --%>읽은 사람 ${board.count }</p>
	<p id="writedate" class="sub"><%-- ${board.writeDate } --%> ${board.writeDate }</p>
	<br /><br /><br />
	<hr>
	<c:if test="${fn:length(board.original_file_name) != 0  }">
		<p id="file" onclick="fileDownload('${board.original_file_name}', '${board.renamed_file_name }')">첨부파일  :  ${board.original_file_name }</p>
	</c:if>
	<br clear="both"/>
	<div id="board-content" style="width: 100%;">
		${board.content }
	</div>
	<br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
	<!-- <textarea id="content"cols="30" rows="10" readonly></textarea> -->
	<div class="comment" id="comment">
		<p id="comment-count"><span style="color:rgb(0,125,255); font-weight:bold">${fn:length(commentList) }</span>개의 댓글</p> <br /> <br />
		<c:forEach var="v" varStatus="vs" items="${commentList }">
		<div class="comment-user">
			<img src="${pageContext.request.contextPath}/resources/upload/member/${v.PHOTO}" class="comment-profile" alt="">
			<c:if test="${memberLoggedIn.userId eq v.WRITER }">
				<p id="comment-delete" class="sub" onclick="location.href='${pageContext.request.contextPath}/board/commentDelete?comment_no=${v.COMMENT_NO }&board_no=${v.BOARD_NO }'" style="white-space: nowrap;">삭제</p>
			</c:if>
			<p id="comment-writer" style="display: inline-block;">${v.WRITER }</p>
			<p id="comment-writedate" style="display: inline-block;">${v.WRITEDATE }</p>
			<p id="comment-content" style="margin-left:38px;">${v.CONTENT }</p>
		</div>
		</c:forEach>
		
	</div>
	<form action="${pageContext.request.contextPath }/board/commentInsert" method="post">
	<div class="comment" id="comment-insert">
		<input type="hidden" name="board_no" value="${board.board_no }" />
		<input type="hidden" name="writer" value="${memberLoggedIn.userId }" />
		<textarea name="content" id="" cols="80" rows="1" id="comment-insert-area" class="form-control" style="width: 88%; display: inline-block;"></textarea>
		<input  type="submit" value="등록" class="btn btn-outline-primary" id="comment-insert-button" style="margin-bottom: 29px;"/>
	</div>
	</form>
	
	
</div>
<script>
function fileDownload(oName, rName) {
	oName = encodeURIComponent(oName);
	location.href="${pageContext.request.contextPath}/board/boardDownload.do?oName="+oName+"&rName="+rName;
}
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>