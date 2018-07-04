<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>${param.pageTitle}</title>
	<!-- <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script> -->
	<script src="${pageContext.request.contextPath }/resources/js/jquery-3.3.1.js"></script>
	<!-- 부트스트랩관련 라이브러리 -->
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
	<!-- 사용자작성 css -->
	<%-- <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/style.css" /> --%>
</head>
<style>
div#enroll-container{
	width:400px;
	margin:0 auto;
	text-align:center;
}
/*중복아이디체크 관련*/
div#userId-container{position:relative; padding:0px;}
div#userId-container span.guide{
	display:none;
	font-size:12px;
	position:absolute;
	top:12px;
	right:10px;
}
div#userId-container span.ok{color:green;}
div#userId-container span.error{color:red;}

div#comName-container{position:relative; padding:0px;}
div#comName-container span.guide{
	display:none;
	font-size:12px;
	position:absolute;
	top:12px;
	right:10px;
}
div#comName-container span.ok.comName{color:green;}
div#comName-container span.error.comName{color:red;}
div#comName-container span.empty.comName{color:red;}
</style>
<script>
$(function() {
   $("#password2").blur(function() {
      var p1 = $("#password_").val();
      var p2 = $(this).val();
      if(p1!=p2){
         alert("패스워드가 일치하지 않습니다.");
         $("#password_").focus();
      }
   });
   
   $("#userId_").on("keyup", function() {
      var userId = $(this).val().trim();
      if(userId.length<3) {
         $(".guide.length.userId").show();
         $(".guide.error.userId").hide();
         $(".guide.ok.userId").hide();
         $(".guide.char.userId").hide();
         $("#idDuplicateCheck").val(0);
         return false;
      } 
      
      if (!(userId >= '0' && userId <= '9') && !(userId >= 'a' && userId <= 'z')&&!(userId >= 'A' && userId <= 'Z')) {
        $(".guide.char.userId").show();
  	 	$(".guide.length.userId").hide();
        $(".guide.error.userId").hide();
        $(".guide.ok.userId").hide();
        $("#idDuplicateCheck").val(0);
      	return false;
      }
      $.ajax({
         /* url : "${pageContext.request.contextPath}/member/checkIdDuplicate.do"; */ 
         url : "checkIdDuplicate.do", /*현재 디렉토리에서 상대주소*/
         dataType : "json",
         data : {userId:userId},  /*속성값(키):입력값*/
         success : function(data) {
            console.log(data); //true/ false
            //if(data=="true") {
            if(data.isUsable==true) {
               $(".guide.ok.userId").show();
               $(".guide.error.userId").hide();
               $(".guide.length.userId").hide();         
               $(".guide.char.userId").hide();
               $("#idDuplicateCheck").val(1);
            }
            else{
               $(".guide.error.userId").show();
               $(".guide.ok.userId").hide();
               $(".guide.length.userId").hide();
               $(".guide.char.userId").hide();
               $("#idDuplicateCheck").val(0);
               
            }
         },
         error:function(jqxhr, textStatus, errorThrown) {
            console.log("ajax실패!", jqxhr, textStatus, errorThrown);
         }
      });
   });
   
	$("[name=upFile]").on("change",function(){
		//var fileName = $(this).val();
		var fileName = $(this).prop("files")[0].name;
		
		$(this).next(".custom-file-label").html(fileName);
	});
	
	$("#comName").on("focusout", function(key) {
      var comName = $(this).val().trim();
      	if(comName==$("#comNamePre").val()&&$("#comNameDuplicateCheck").val()==1) {	
      		$(".guide.ok.comName").show();
   		    $(".guide.error.comName").hide();
   		    return;
      	} else {
      		$("#comNamePre").val(comName);
      	}
      	
      console.log(comName);
      //if(key.keyCode==13) {
      if(comName=='') {
    	 $(".guide.ok.comName").hide();
 		 $(".guide.error.comName").hide();
 		 $("#comNo").val('');
      } else {
      $.ajax({
          /* url : "${pageContext.request.contextPath}/member/checkIdDuplicate.do"; */ 
          url : "checkComNameDuplicate.do", /*현재 디렉토리에서 상대주소*/ 
          dataType : "json",
          data : {comName:comName},  /*속성값(키):입력값*/
          success : function(data) {
        	  
        	  console.log(data); //true/ false
              //if(data=="true") {
              if(data.isUsableCom==true) {
                 $.ajax({
                	 url : "selectComSEQ.do",
                	 dataType : "json",
                	 success : function(data) {
                         $(".guide.ok.comName").show();
                		 $(".guide.error.comName").hide();
                		 $(".guide.empty.comName").hide();
                		 $("#comNo").val(data.comSEQ);
                		 
                		 $("#comNameDuplicateCheck").val(1);
                	 }
                	 });
                	 }
              else{
                 $(".guide.error.comName").show();
                 $(".guide.ok.comName").hide(); 
                 $(".guide.empty.comName").hide();
                 $("#comNameDuplicateCheck").val(0);
              }
          },
          error:function(jqxhr, textStatus, errorThrown) {
             console.log("ajax실패!", jqxhr, textStatus, errorThrown);
          }
       });

      }
      });
	});
/**
 * 유효성 검사 함수
 */
function validate() {
   var userId = $("#userId_");
   if(userId.val().trim().length<3) {
      alert("아이디는 최소 3글자 이상이어야 합니다.");
      userId.focus();
      return false;
   }
   if($("#idDuplicateCheck").val()==0) {
	   alert("아이디 검사를 해주세요. 사용가능하다고 나와야 합니다.");
	   return false; 
   }
	//아이디 유효성 검사 (영문소문자, 숫자만 허용)
   for (i = 0; i < userId.val().length; i++) {
       ch = userId.val().charAt(i);
       if (!(ch >= '0' && ch <= '9') && !(ch >= 'a' && ch <= 'z')&&!(ch >= 'A' && ch <= 'Z')) {
           alert("아이디는 대소문자, 숫자만 입력가능합니다.");
           userId.focus();
           userId.select();
           return false;
       }
   }
	if($("#comNameDuplicateCheck").val()==0&&$("#comName").val()!='') {
		alert("동일한 회사이름은 안 됩니다.");
		return false;
	}
   return true;
}



</script>
<body>
	<div id="enroll-container">
	<form action="${pageContext.request.contextPath }/member/memberEnrollEnd.do" method="post" onsubmit="return validate();" enctype="multipart/form-data">
		<div id="userId-container">
		<input type="text" class="form-control" name="userId" id="userId_" placeholder="아이디" required maxlength="13"/>
		<span class="guide ok userId">이 아이디는 사용가능합니다.</span>
		<span class="guide error userId">이 아이디는 사용할 수 없습니다.</span>
		<span class="guide length userId">아이디는 3글자 이상이여야 합니다.</span>
		<span class="guide char userId">대소문자, 숫자만 입력가능합니다.</span>
		<input type="hidden" id="idDuplicateCheck" value="0"/>
		</div>
		<br />
		<input type="password" class="form-control" name="password" id="password_" placeholder="비밀번호" required maxlength="13"/>
		<br />
		<input type="password" class="form-control" id="password2" placeholder="비밀번호확인" required maxlength="13"/>
		<br />
		<input type="text" class="form-control" name="userName" placeholder="이름" required maxlength="13"/>
		<br />
		<input type="email" class="form-control" name="email" id="email" placeholder="이메일" required maxlength="30"/>
		<br />
		<input type="tel" class="form-control" name="phone" id="phone" placeholder="전화번호" required maxlength="11" />
		<br />
		<input type="text" class="form-control" name="address" id="address" placeholder="주소" required maxlength="50"/>
		<br />
		<!-- 파일 -->
		<div class="input-group mb-3" style="padding:0px">
		  <div class="input-group-prepend" style="padding:0px">
		    <span class="input-group-text">프로필 사진</span>
		  </div>
		  <div class="custom-file">
		    <input type="file" class="custom-file-input" name="upFile" id="upFile1">
		    <label class="custom-file-label" for="upFile1">파일을 선택하세요</label>
		  </div>
		</div>
		<div class="input-group mb-3" style="padding:0px">
		  <div class="input-group-prepend" style="padding:0px">
		    <span class="input-group-text">SIGN 사진</span>
		  </div>
		  <div class="custom-file">
		    <input type="file" class="custom-file-input" name="upFile" id="upFile2">
		    <label class="custom-file-label" for="upFile2">파일을 선택하세요</label>
		  </div>
		</div> 
		<div class="input-group mb-3" style="padding:0px">
		<span class="input-group-text">회사등록</span>
		<div id="comName-container">
		<input type="text" class="form-control" name="com_name" id="comName" placeholder="회사이름" autocomplete="off"/>
		<span class="guide ok comName">사용가능합니다.</span>
		<span class="guide error comName">이미 있습니다.</span>
		<input type="hidden" id="comNameDuplicateCheck" value="0"/>		
		<!-- <span class="guide empty comName">공백은 안 됩니다.</span> -->		
		<input type="text" class="form-control" name="com_no" id="comNo" readonly placeholder="회사번호"/>
		<input type="hidden" id="comNamePre"/>
		</div>
		</div>		
		<input type="submit" value="가입" class="btn btn-outline-success" />
	</form>
</div>

	
</body>
</html>

