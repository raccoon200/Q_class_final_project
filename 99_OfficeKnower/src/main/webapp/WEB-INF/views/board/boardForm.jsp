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
	var str = $(".ql-editor").html();
	$("[name=content]").attr("value", str);
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
	width:1000px;
	text-align:center;

}
.input-group-text{
	width:100px;
	text-align:center;
	
}
#input-group-text-cum{
	width:1000px;
	margin:0 auto;
	text-align:center;
	
}
#board-select-area{
	width:200px;
	height:40px;
	border:1px solid rgb(210,210,210);
	border-radius: 4px;
}

</style>
<script>
$(function() {

})
</script>
<div id="board-container">
	<br />

	<form action="boardFormEnd.do" name="boardFrm" method="post" enctype="multipart/form-data" onsubmit="return validate();">
		<input type="hidden" name="content" />
		 
		<div class="input-group mb-3" style="padding:0px">
			<div class="input-group-prepend" style="padding:0px">
			    <span class="input-group-text">게시판</span>
			</div>

			 <select class="selectpicker" name="board_menu_no" style="date-width:'500px'">
				<option value="" id="no-selected" selected disabled hidden>게시판을 선택</option>
			  <optgroup label="전사게시판">
			    <c:forEach var="v" varStatus="vs" items="${basicBoard }">
			    	<c:if test="${!fn:contains(memberLoggedIn.grade,'게시판관리자') or !fn:contains(memberLoggedIn.grade, '슈퍼관리자') }">
				    <c:if test="${ v.KIND eq '전사게시판' and v.TITLE ne '사내공지'}">
				    	<option value="${v.BOARD_MENU_NO }" <c:if test="${v.BOARD_MENU_NO eq currentMenuNo }">selected</c:if>>${v.TITLE }</option>
				    </c:if>
				    </c:if>
				    <c:if test="${fn:contains(memberLoggedIn.grade,'게시판관리자') or fn:contains(memberLoggedIn.grade, '슈퍼관리자') }">
				    <c:if test="${ v.KIND eq '전사게시판'}">
				    	<option value="${v.BOARD_MENU_NO }" <c:if test="${v.BOARD_MENU_NO eq currentMenuNo }">selected</c:if>>${v.TITLE }</option>
				    </c:if>
				    </c:if>
				</c:forEach>
			  </optgroup>
			  <optgroup label="그룹게시판">
			    <c:forEach var="v" varStatus="vs" items="${groupBoard }">
				    <c:if test="${v.KIND eq '그룹게시판'}">
				    	<option value="${v.BOARD_MENU_NO }"  <c:if test="${v.BOARD_MENU_NO eq currentMenuNo }">selected</c:if>>${v.TITLE }</option>
				    </c:if>
				</c:forEach>
			  </optgroup>
			</select>
			<%-- <select class="form-control" id="board-menu-select" name="board_menu_no">
				<c:forEach var="v" varStatus="vs" items="${board_menu_list }">
					
			      <option value="${v.BOARD_MENU_NO }">${v.TITLE }</option>  
			    </c:forEach>
			   
			    
			 </select> --%>
		</div> 
		
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
		<!-- <textarea name="content" id="" cols="30" rows="10" class="form-control" required></textarea> -->
		<div id="editor" class="form-control" style="height:300px;">
    
    	</div>
    	 <!-- Include the Quill library -->
	    <script src="https://cdn.quilljs.com/1.3.6/quill.js"></script>
	
	    <!-- Initialize Quill editor -->
	    <script>
	    // var quill = new Quill('#editor', {
	    //     theme: 'snow'
	    // });
	    var toolbarOptions = [
	  ['bold', 'italic', 'underline', 'strike'],        // toggled buttons
	
	  [{ 'header': 1 }, { 'header': 2 }],               // custom button values
	  [{ 'list': 'ordered'}, { 'list': 'bullet' }],
	  [{ 'script': 'sub'}, { 'script': 'super' }],      // superscript/subscript
	  [{ 'indent': '-1'}, { 'indent': '+1' }],          // outdent/indent
	  [{ 'direction': 'rtl' }],                         // text direction
	
	  //[{ 'size': ['small', false, 'large', 'huge'] }],  // custom dropdown
	  [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
	  [{ 'color': [] }, { 'background': [] }],          // dropdown with defaults from theme
	  [{ 'font': [] }],
	  [{ 'align': [] }],
	  ['image','link'],
	  ['clean']                                         // remove formatting button
	];
	
	var quill = new Quill('#editor', {
	  modules: {
	    toolbar: toolbarOptions
	  },
	  theme: 'snow'
	});
	    </script>
		<br />
		<input type="submit" value="등록" class="btn btn-outline-primary" />
		<input type="button" value="취소" class="btn btn-outline-secondary" onclick='location.href="{pageContext.request.contextPath}/board/boardBasicList"' />
	</form>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>