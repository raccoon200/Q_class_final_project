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
	<link rel="shortcut icon" href="${pageContext.request.contextPath }/resources/images/common/favicon.ico">
	
</head>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script charset="UTF-8" type="text/javascript"
   src="http://t1.daumcdn.net/cssjs/postcode/1522037570977/180326.js"></script>
<style>
/* div#enroll-container{
	width:400px;
	margin:0 auto;
	text-align:center;
} */
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
<!-- 18/07/04 김영중 주소 추가 -->
<script>
   //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
   function sample4_execDaumPostcode() {
      new daum.Postcode(
            {
               oncomplete : function(data) {
                  // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                  // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
                  // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                  var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                  var extraRoadAddr = ''; // 도로명 조합형 주소 변수

                  // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                  // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                  if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                     extraRoadAddr += data.bname;
                  }
                  // 건물명이 있고, 공동주택일 경우 추가한다.
                  if (data.buildingName !== '' && data.apartment === 'Y') {
                     extraRoadAddr += (extraRoadAddr !== '' ? ', '
                           + data.buildingName : data.buildingName);
                  }
                  // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                  if (extraRoadAddr !== '') {
                     extraRoadAddr = ' (' + extraRoadAddr + ')';
                  }
                  // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
                  if (fullRoadAddr !== '') {
                     fullRoadAddr += extraRoadAddr;
                  }

                  // 우편번호와 주소 정보를 해당 필드에 넣는다.
                  document.getElementById('sample4_postcode').value = data.zonecode; //5자리 새우편번호 사용
                  document.getElementById('sample4_roadAddress').value = fullRoadAddr;
                  document.getElementById('sample4_jibunAddress').value = data.jibunAddress;

                  // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                  if (data.autoRoadAddress) {
                     //예상되는 도로명 주소에 조합형 주소를 추가한다.
                     var expRoadAddr = data.autoRoadAddress
                           + extraRoadAddr;
                     document.getElementById('guide').innerHTML = '(예상 도로명 주소 : '
                           + expRoadAddr + ')';

                  } else if (data.autoJibunAddress) {
                     var expJibunAddr = data.autoJibunAddress;
                     document.getElementById('guide').innerHTML = '(예상 지번 주소 : '
                           + expJibunAddr + ')';

                  } else {
                     document.getElementById('guide').innerHTML = '';
                  }
               }
            }).open();
   }
</script>
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
      var regx = /^[A-Za-z0-9]{3,13}$/;
      if (!regx.test(userId)) {
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
<script>
function fn_addressSum(){
	if($("#sample4_postcode").val().trim().length != 0)
	var add1 = $("#sample4_postcode").val()
			+", "+ $("#sample4_roadAddress").val()
			+", "+ $("#sample4_jibunAddress").val();
	$("#address").val(add1);
}
</script>

<body class="bg-light">
	<div class="container" style="max-width: 960px;">
	<div class="py-5 text-center">
		<img class="d-block mx-auto mb-4" src="${pageContext.request.contextPath }/resources/images/common/logo.png" alt="logo" height="72"/>
		<h2>회원가입</h2>
		<p class="lead">
			OK(Office Knower)에 오신것을 환영합니다. <br /> OK는 업무 효율을 높여주는 그룹웨어 서비스입니다.
		</p>
	</div>
	<form action="${pageContext.request.contextPath }/member/memberEnrollEnd.do" method="post" onsubmit="return validate();" enctype="multipart/form-data">
		<div class="row">
			<div class="col-md-4 order-md-2 mb-4">
				<h4 class="d-flex justify-content-between align-items-center mb-3">
					<span class="text-muted">회사 등록</span>
				</h4>
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
			<div class="col-md-8 order-md-1">
			<h4 class="mb-3">개인 정보</h4>
			<div id="userId-container">
				<input type="text" class="form-control" name="userId" id="userId_" placeholder="아이디" required maxlength="13"/>
				<span class="guide ok userId">사용가능합니다.</span>
				<span class="guide error userId">이미 사용중입니다.</span>
				<span class="guide length userId">3글자 이상이여야 합니다.</span>
				<span class="guide char userId">대소문자, 숫자만 입력가능합니다.</span>
				<input type="hidden" id="idDuplicateCheck" value="0"/>
				</div>
				<br />
				<div class="row">
					<div class="col-md-6 mb-3">
						<input type="password" class="form-control" name="password" id="password_" placeholder="비밀번호" required maxlength="13"/>			
					</div>
					<div class="col-md-6 mb-3">			
						<input type="password" class="form-control" id="password2" placeholder="비밀번호확인" required maxlength="13"/>
					</div>
				</div>
				<input type="text" class="form-control" name="userName" placeholder="이름" required maxlength="13"/>
				<br />
				<input type="email" class="form-control" name="email" id="email" placeholder="이메일" required maxlength="30"/>
				<br />
				<input type="tel" class="form-control" name="phone" id="phone" placeholder="전화번호" required maxlength="11" />
				<br />
		<!-- <<<<<<< HEAD
				<input type="text" class="form-control" name="address" id="address" placeholder="주소" required maxlength="50"/>
		======= -->
				<!-- <input type="text" class="form-control" name="address" id="address" placeholder="주소" required/> -->
				<input type="text" class="form-control" id="sample4_postcode" placeholder="우편번호" style="display: inline; width: 120px;" value=""> &nbsp;&nbsp; 
		        <input type="button" class="btn btn-outline-info" onclick="sample4_execDaumPostcode()" value="우편번호 찾기" size="35px"><br>
		        <input type="text" class="form-control" id="sample4_roadAddress" placeholder="도로명주소" size="50px"  value=""> 
		        <input type="text" class="form-control" id="sample4_jibunAddress" placeholder="지번주소" size="50px"  value="">
		        <input type="hidden" name="address" id="address" value="" />
		        <span id="guide" style="color: #999"></span>
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
				<hr />		
				<input type="submit" value="가입" class="btn btn-lg btn-block btn-info" onclick="fn_addressSum()"/>
				<br />
		</div>
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath }/resources/popper.min.js"></script>
<!-- Just to make our placeholder images work. Don't actually copy the next line! -->
<script src="${pageContext.request.contextPath }/resources/holder.min.js"></script>

</body>
</html>

