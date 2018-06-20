<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="게시판" name="pageTitle"/>
</jsp:include>



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


	<div id="board-container">
		<div class="input-group mb-3" style="padding:0px">
			<div class="input-group-prepend" style="padding:0px">
			    <span class="input-group-text">제목</span>
			</div>
			<div class="custom-file">
				<input type="text" name="title" id="boardTitle" value="${board.title }" class="form-control" required />
			</div>
		</div>
		
		<div class="input-group mb-3" style="padding:0px">
			<div class="input-group-prepend" style="padding:0px">
			    <span class="input-group-text">작성자</span>
			</div>
			<div class="custom-file">
				<input type="text" name="writer" id="boardWriter" value="${board.writer }" class="form-control" required readonly />
			</div>
		</div>
		<div class="input-group mb-3" style="padding:0px">
		  <div class="input-group-prepend" >
		    <span class="input-group-text">첨부파일</span>
		  </div>
		  <div class="custom-file">
		    <button type="button" 
	      onclick="fileDownload('${board.original_file_name}', '${board.renamed_file_name}' )" class="btn btn-block btn-outline-primary">${board.original_file_name}&nbsp;</button>
		  </div>
		</div>
		<span class="input-group-text" id="input-group-text-cum">내용</span>
		<textarea name="content" id="" cols="30" rows="10" class="form-control" required>${board.content }</textarea>
		<br />
		<input type="button" value="수정" class="btn btn-outline-primary" onclick="location.href='${pageContext.request.contextPath}/board/boardUpdate?boardNo=${board.board_no}'"/>
		<input type="button" value="삭제" class="btn btn-outline-primary" onclick="location.href='${pageContext.request.contextPath }/board/boardDelete?boardNo=${board.board_no }'"/>
		<input type="button" value="목록으로 이동" class="btn btn-outline-primary" onclick="location.href='${pageContext.request.contextPath}/board/boardBasicList'"/>
		
	</div>
<script>
function fileDownload(oName, rName) {
	oName = encodeURIComponent(oName);
	location.href="${pageContext.request.contextPath}/board/boardDownload.do?oName="+oName+"&rName="+rName;
}
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>