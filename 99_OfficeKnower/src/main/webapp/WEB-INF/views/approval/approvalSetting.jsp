<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="전자결재" name="pageTitle"/>
</jsp:include>
<jsp:include page="/WEB-INF/views/common/nav.jsp">
	<jsp:param value="전자결재" name="pageTitle"/>
	<jsp:param value="설정" name="selectMenu"/>
</jsp:include>
<style>
.sub-title{
	font-weight:bold;
 
	margin-right:10px;
}

#sign-setting-area{
	width:515px;
	height:140px;
	background:rgb(249,249,249);

	padding-top:20px; 
	padding-left:30px;
	margin-top:10px;
	
}
#sign-area {
	width:90px;
	height:90px;
	border:1px solid rgb(200,200,200);
	background:white;
	position:relative;
}
#sign-area img {
	padding-left:20px;
	padding-top:20px;
	width:70px;
	height:70px;

}
.blue-text{
	color:rgb(0,125,255);
	cursor:pointer;
	
}
.custom-file{
	width:300px;
	top:-90px;
	left:120px;
}
#text-file-select{
font-size:0.9em;
color:rgb(120,120,120);
}
</style>
<script>
$(function() {
	$("[name=upFile]").on("change", function () {
		//var fileName = $(this).val();
		var fileName = $(this).prop("files")[0].name;
		
		$(this).next(".custom-file-label").html(fileName);

	});
});

$(function() {
    $("#imgInp").on('change', function(){
        readURL(this);
    });
});

function readURL(input) {
    if (input.files && input.files[0]) {
    var reader = new FileReader();

    reader.onload = function (e) {
            $('#sign-image').attr('src', e.target.result);
        }

      reader.readAsDataURL(input.files[0]);
    }
}


function fn_sign_default_setting() {
	$("#sign-image").attr("src","${pageContext.request.contextPath }/resources/upload/member/sign_default.png" );
	$(".custom-file-label").html("sign_default.png");

}

</script>
<span class="sub-title">서명 설정</span> 
<span id="sub-defualt-setting" class="blue-text" onclick="fn_sign_default_setting()">기본으로재설정</span>
<div id="sign-setting-area">


	<form action="${pageContext.request.contextPath }/approval/approvalSignUpdate" enctype="multipart/form-data" method="POST" onsubmit="test()">

	<div id="sign-area">
		<img id="sign-image" src="${pageContext.request.contextPath }/resources/upload/member/${memberLoggedIn.sign }" alt="" />
	</div>
	<div id="sign-input-area">
		<div class="custom-file">
		
		    <input type="file" class="custom-file-input" name="upFile" id="imgInp" accept="image/gif,image/jpeg,image/jpg,image/png">
		    <label class="custom-file-label" for="imgInp">${memberLoggedIn.sign }</label>
			<span id="text-file-select">파일 선택 : 46*46 / gif,jpg,jpeg,png 가능</span> <br />
			<span class="blue-text" onclick="fn_sign_default_setting()">삭제</span>
		 </div>
	</div>
	
	<input type="submit" value="저장" onsubmit="fn_check()"/>
	</form>
</div>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>