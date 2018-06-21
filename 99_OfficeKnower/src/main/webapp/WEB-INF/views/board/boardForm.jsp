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
function validate() {
	return true;
}
$(function() {
	$("[name=upFile]").on("change", function () {
		//var fileName = $(this).val();
		var fileName = $(this).prop("files")[0].name;
		
		$(this).next(".custom-file-label").html(fileName);
	});
});
</script>
<style>
/* 부트스트랩 라벨명 정렬 */
div#board-container label.custom-file-label{text-align:left;}
div#board-container{
	width:800px;
	text-align:center;

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
</style>
<div id="board-container">
	
	<form action="boardFormEnd.do" name="boardFrm" method="post" enctype="multipart/form-data" onsubmit="return validate();">
		<div class="input-group mb-3" style="padding:0px">
			<div class="input-group-prepend" style="padding:0px">
			    <span class="input-group-text">제목</span>
			</div>
			<div class="custom-file">
				<input type="text" name="title" id="boardTitle" class="form-control" required />
			</div>
		</div>
		
		<div class="input-group mb-3" style="padding:0px">
			<div class="input-group-prepend" style="padding:0px">
			    <span class="input-group-text">작성자</span>
			</div>
			<div class="custom-file">
				<input type="text" name="writer" id="boardWriter" class="form-control" value="${memberLoggedIn.userId}"required readonly />
			</div>
		</div>
		<div class="input-group mb-3">
		  <div class="input-group-prepend">
		    <span class="input-group-text">첨부파일</span>
		  </div>
		  <div class="custom-file">
		    <input type="file" class="custom-file-input" name="upFile" id="inputGroupFile01">
		    <label class="custom-file-label" for="inputGroupFile01"></label>
		  </div>
		</div>
		<span class="input-group-text" id="input-group-text-cum">내용</span>
		<textarea name="content" id="" cols="30" rows="10" class="form-control" required></textarea>
		<br />
		<input type="submit" value="등록" class="btn btn-outline-primary" />
		<input type="button" value="취소" class="btn btn-outline-secondary" onclick='location.href="{pageContext.request.contextPath}/board/boardBasicList"' />
	</form>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>