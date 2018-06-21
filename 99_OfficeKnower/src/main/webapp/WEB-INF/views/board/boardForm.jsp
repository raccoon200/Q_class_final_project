<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script> -->
<script
	src="${pageContext.request.contextPath }/resources/js/jquery-3.3.1.js"></script>
<!-- 부트스트랩관련 라이브러리 -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"
	integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4"
	crossorigin="anonymous">
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"
	integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm"
	crossorigin="anonymous"></script>
<title>게시판 작성</title>
<script>
	function validate() {
		return true;
	}
	$(function() {
		$("[name=upFile]").on("change", function() {
			//var fileName = $(this).val();
			var fileName = $(this).prop("files")[0].name;

			$(this).next(".custom-file-label").html(fileName);
		});
	});
</script>

<style>
/* 부트스트랩 라벨명 정렬 */
div#board-container label.custom-file-label {
	text-align: left;
}

div#board-container {
	width: 600px;
	margin: 0 auto;
	text-align: center;
}

/* div#board-container input {
	margin-bottom: 15px;
} */
.input-group-text{
	width:100px;
	text-align:center;
	
}
#input-group-text-cum{
	width:600px;
	margin:0 auto;
	text-align:center;
	
}
</style>
</head>
<body>

	<div id="board-container">
		<form action="boardFormEnd" name="boardFrm" method="post" enctype="multipart/form-data" onsubmit="return validate();">
		<div class="input-group mb-3" style="padding:0px">
			<div class="input-group-prepend" style="padding:0px">
			    <span class="input-group-text">제목</span>
			</div>
			<div class="custom-file">
				<input type="text" name="title" id="boardTitle" placeholder="제목을 입력해주세요" class="form-control" required />
			</div>
		</div>
		
		<div class="input-group mb-3" style="padding:0px">
			<div class="input-group-prepend" style="padding:0px">
			    <span class="input-group-text">작성자</span>
			</div>
			<div class="custom-file">
				<input type="text" name="writer" id="boardWriter" value="${memberLoggedIn.userId }" class="form-control" required readonly />
			</div>
		</div>
		<div class="input-group mb-3" style="padding:0px">
		  <div class="input-group-prepend" >
		    <span class="input-group-text">첨부파일</span>
		  </div>
		  <div class="custom-file">
		    <input type="file" class="custom-file-input" id="upFile1" name="upFile">
		    <label class="custom-file-label" for="upFile">파일을 선택하세요</label>
		  </div>
		</div>
		<span class="input-group-text" id="input-group-text-cum">내용</span>
		<textarea name="content" id="" cols="30" rows="10" class="form-control" required placeholder="내용을 입력해주세요"></textarea>
		<br />
		<input type="submit" value="저장" class="btn btn-outline-success" />
	</form>
	</div>
</body>
</html>