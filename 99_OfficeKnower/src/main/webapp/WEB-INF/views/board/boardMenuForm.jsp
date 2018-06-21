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
	<jsp:param value="게시판 만들기" name="selectMenu"/>
</jsp:include>	
<style>
#member-select{
	width:83%;
	float:right;

}
#user-add{
	padding:1px;
	background:white;
	color:rgb(180,180,255);
	border:1px solid white;
}
#btn-board-menu-form + input{
	float:center;
}
#member-select > div > img {
  	width : 25px;
  	border-radius:15px;
  }

#member-select {
	border: 1px solid rgb(210,210,210);
	border-radius: 4px;
	padding:5px;
	height:150px;
	overflow-y: scroll;
}
#btn-board-menu-form{
	display:block;
	padding-left: 45%;
}
#btn-board-menu-form button {
	display:inline;
}
</style>
<script>
$(function() {
	$("#user-add").hide();
})

$.ajax( {
	type : "POST",
	url : "${pageContext.request.contextPath}/member/memberCompanyListAll",
	dataType : "json",
	success : function(data) {
		
		console.log(data);
		var memberList = data.members;
		var str='';
		var str2='';
		for(index in memberList){	
			if(memberList[index].USERID!=undefined){
				str += '<input type="hidden" name="memberInfo" value="'+memberList[index].USERID+'">';
				str += '<div value="'+memberList[index].USERID+'" id="'+memberList[index].USERID;
				str += '"><img src="${pageContext.request.contextPath}/resources/images/profile/'+memberList[index].PHOTO+'" alt="" />&nbsp;&nbsp;&nbsp;<span>'+memberList[index].USERID+
				' </span> &nbsp;&nbsp; <span>'+memberList[index].USERNAME+'</span>&nbsp;&nbsp;<img src="${pageContext.request.contextPath}/resources/images/common/board_delete.PNG" class="board-delete" value="'+memberList[index].USERID+'" alt="">'; 
		  		str += '</div>';
					
			}else {
				str2 += memberList[index].count;
			}
				
			
		}	
		
	
		$("#member-select").append(str);
		$("#count").text(str2);
		
	},
	error : function(xhr, status, e) {
		
	}
})


$(function() {
	$("#member-select").children().hover(function() {
	
		$(this).css("background", "rgb(230,230,230)");
	}, function() {
		$(this).css("background","white");
	})
	
})

$(function() {
	$(".board-delete").click(function() {
		//$(this).attr("value")를 하면 아이디값이 출력됨.
		if($(':input[name=kind]:radio:checked').val()=="전사게시판") {
			alert("전사게시판은 사용자를 삭제할 수 없습니다.");
		}else if($(this).attr("value") == "${memberLoggedIn.userId}"){
			alert("관리자 본인은 제외할 수 없습니다");
		}else {
			$(this).attr("value","");
			$(this).parent().prev().remove();
			$(this).parent().remove();
			
			$("#count").text($("[name=memberInfo]").length);
		}
	})

})
function fn_memberListView(){
	$.ajax( {
		type : "POST",
		url : "${pageContext.request.contextPath}/member/memberCompanyListAll",
		dataType : "json",
		success : function(data) {
			
			console.log(data);
			var memberList = data.members;
			var str='';
			var str2='';
			for(index in memberList){	
				if(memberList[index].USERID!=undefined){
					str += '<input type="hidden" name="memberInfo" value="'+memberList[index].USERID+'">';
					str += '<div value="'+memberList[index].USERID+'" id="'+memberList[index].USERID;
					str += '"><img src="${pageContext.request.contextPath}/resources/images/profile/'+memberList[index].PHOTO+'" alt="" />&nbsp;&nbsp;&nbsp;<span>'+memberList[index].USERID+
					' </span> &nbsp;&nbsp; <span>'+memberList[index].USERNAME+'</span>&nbsp;&nbsp;<img src="${pageContext.request.contextPath}/resources/images/common/board_delete.PNG" class="board-delete" value="'+memberList[index].USERID+'" alt="">'; 
			  		str += '</div>';
						
				}else {
					str2 += memberList[index].count;
				}
					
				
			}	
			
			$("#member-select").text("");
			$("#member-select").append(str);
			$("#count").text(str2);
			
		},
		error : function(xhr, status, e) {
			
		}
	})
}
</script>

<form method="post" action="${pageContext.request.contextPath }/board/boardMenuFormEnd">
 	<fieldset class="form-group">
    <div class="row">
      <legend class="col-form-label col-sm-2 pt-0">게시판 종류</legend>
      <div class="col-sm-10">
        <div class="form-check">
          <input class="form-check-input" type="radio" name="kind" id="all-board-menu" value="전사게시판" checked onclick="fn_memberListView()">
          <label class="form-check-label" for="all-board-menu">
            	전사게시판
          </label>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <input class="form-check-input" type="radio" name="kind" id="group-board-menu" value="그룹게시판">
          <label class="form-check-label" for="group-board-menu">
            	그룹게시판
          </label>
        </div>
        
      </div>
    </div>
  </fieldset>
  <fieldset class="form-group">
    <div class="row">
      <legend class="col-form-label col-sm-2 pt-0">사용 여부</legend>
      <div class="col-sm-10">
        <div class="form-check">
          <input class="form-check-input" type="radio" name="status" id="board-menu-status-Y" value="Y" checked>
          <label class="form-check-label" for="board-menu-status-Y">
            	사용
          </label>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <input class="form-check-input" type="radio" name="status" id="board-menu-status-M" value="M">
          <label class="form-check-label" for="board-menu-status-M">
            	미사용
          </label>
          <br /> * 미사용 체크시 사용자 화면에 노출되지 않습니다.(관리자는 확인 가능)
        </div>
        
      </div>
    </div>
  </fieldset>
  <div class="form-group row">
    <label for="boardMenuName" class="col-sm-2 col-form-label">이름</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" name="title" id="boardMenuName" >
    </div>
  </div>
  <input type="hidden" name="com_no" value="${memberLoggedIn.com_no }" />
  <fieldset class="form-group">
    <div class="row">
      <legend class="col-form-label col-sm-2 pt-0">사용자</legend>
      <div class="col-sm-10">
      	게시판 사용자 : <span id="count"></span>명
       	
       	
        <span style="float:right">
        	<!-- Button trigger modal -->
			<button type="button" class="btn btn-primary" id="user-add" data-toggle="modal" data-target="#exampleModalCenter">
			  사용자 추가
			</button>
			
			<!-- Modal -->
			<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
			  <div class="modal-dialog modal-dialog-centered" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="exampleModalCenterTitle">사용자 추가</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>
			      <div class="modal-body">
			        ...
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			        <button type="button" class="btn btn-primary">Save changes</button>
			      </div>
			    </div>
			  </div>
			</div>
        </span>
      </div>
    </div>
  </fieldset>
  
  <div class="form-group">
  	<div id="member-select">
  	
  
  	</div>
  
    
  </div>
 <input type="hidden" name="userId" value="${memberLoggedIn.userId }" />
  <br /><br /><br /><br /><br /><br /><br /><br />
  <div id="btn-board-menu-form">
	  <input type="submit" class="btn btn-primary" value="등록"/>
	  <input type="button" value="취소" class="btn btn-outline-secondary" onclick="location.href='${pageContext.request.contextPath}/board/boardBasicList'"/>
  </div>
</form>
<script>
$(function() {
	$("[name=kind]").change(function() {
		if($(this).val()=='전사게시판'){
			$("#user-add").hide();
		}else {
			$("#user-add").show();
		}
	});

})
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>