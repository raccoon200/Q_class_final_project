<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
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
	width:500px;
	margin:0 auto;
	text-align:center;
}
div#board-container input{
	margin-bottom:15px;
}
</style>
<div id="board-container">
	<form action="boardUpdateEnd.do" name="boardFrm" method="post" enctype="multipart/form-data" onsubmit="return validate();">
		<input type="hidden" name="board_no" value="${board.board_no }" />
		<input type="hidden" name="board_menu_no" value="${board.board_menu_no }" />
		<input type="text" name="title" id="boardTitle" placeholder="제목" class="form-control" value="${board.title }" required />
		<input type="text" name="writer" id="boardWriter" placeholder="작성자" class="form-control" value="${memberLoggedIn.userId }" readonly required />
		<div class="input-group mb-3" style="padding:0px">
		  <div class="input-group-prepend" style="padding:0px">
		    <span class="input-group-text">첨부파일</span>
		  </div>
		  <div class="custom-file">
		    <input type="file" class="custom-file-input" id="upFile1" name="upFile">
		    <label class="custom-file-label" for="upFile">"${board.original_file_name }"</label>
		  </div>
		</div>
		
		<textarea name="content" id="" cols="30" rows="10" class="form-control" required placeholder="내용">"${board.content }"</textarea>
		<br />
		<input type="submit" value="수정" class="btn btn-outline-primary" />
		<input type="button" value="취소" class="btn btn-outline-secondary" />
	</form>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>