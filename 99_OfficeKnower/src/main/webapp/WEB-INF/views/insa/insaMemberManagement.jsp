<%@page import="com.kh.ok.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="인사관리" name="pageTitle"/>
</jsp:include>
<jsp:include page="/WEB-INF/views/common/nav.jsp">
	<jsp:param value="인사관리" name="pageTitle"/>
	<jsp:param value="사용자 관리" name="selectMenu"/>
</jsp:include>
<style>
.insa_search_table{background: white;}
#insa_ajaxValue{position: absolute;}
#insa_newajaxValue{position: absolute;}
p#admin-add {
	width: 100px;
	color: rgb(119, 158, 192);
	cursor: pointer
}
</style>
<script>
$(function(){
	$("#memberListSearch").on("keyup",function(){
		var searchKey = $(this).val().trim();
		
		if(searchKey.length==0){
			return;
		}
		$.ajax({
			url:"insaMemberSearch.do",
			data : {searchKey:searchKey},
			dataType : "json",
			success : function(data){
				console.log(data);
				var html = "<table class='insa_search_table table table-borderless  table-hover' id='insa_search_table_'>";
				for(var index in data){
					var u =data[index];
					html += "<tr >";
					html += "<td >"+u.userName+"</td><td> (ID:"+u.userId+")</td>"; // u가 객체니까 키값으로 접근해야됨
					html += "</tr>";
				}
				
				 $("#insa_ajaxValue").html(html);
				 
				/*  console.log(data[0].userId); */ 
				
				$("#insa_search_table_ tr").click(function(){     
					 
			        var str = ""
			        var tdArr = new Array();    // 배열 선언
			        
			        // 현재 클릭된 Row(<tr>)
			        var tr = $(this);
			        var td = tr.children();
			        
			        // tr.text()는 클릭된 Row 즉 tr에 있는 모든 값을 가져온다.
			        console.log(td.eq(0).text());
			        $("#memberListSearch").val(td.eq(0).text());
			        $("#insa_search_table_").css('display','none');
				});
			},
			error : function(jqxhr, textStatus, errorThrown){
				console.log("ajax실패",jqxhr,textStatus,errorThrown);
			}
		});
	}); 
	$("#insa_ajaxValueDiv").focusout(function(){
		$("#insa_search_table_").css("opacity",0);
	});
	$("#insa_ajaxValueDiv").focusin(function(){
		$("#insa_search_table_").css("opacity",100);
	});
	
	/* 신규 사용자 검색 */
	$("#newmemberListSearch").on("keyup",function(){
		var searchKey = $(this).val().trim();
			$("#insa_newsearch_table_").css("opacity",100);		
		if(searchKey.length==0){
			$("#insa_newsearch_table_").css("opacity",0);
			return;
		}
		$.ajax({
			url:"insaNewMemberSearch.do",
			data : {searchKey:searchKey},
			dataType : "json",
			success : function(data){
				/* console.log(data); */
				console.log(data.searchchk);
				var html = "<table class='insa_search_table table table-borderless  table-hover' id='insa_newsearch_table_'>";
			    
				if(data.searchchk == true){
			    	$("#newmemberListSearchchk").val(1);
			    }
				for(var index in data.list){
					var u =data.list[index];
					html += "<tr >";
					html += "<td >"+u.userId+"</td><td> (Name:"+u.userName+")</td>"; // u가 객체니까 키값으로 접근해야됨
					html += "</tr>";
				}
				 $("#insa_newajaxValue").html(html);
				$("#insa_newsearch_table_ tr").click(function(){
					$("#newmemberListSearchchk").val(1);
			        var str = ""; 
			        var tdArr = new Array();    // 배열 선언
			        // 현재 클릭된 Row(<tr>)
			        var tr = $(this);
			        var td = tr.children();
			        // tr.text()는 클릭된 Row 즉 tr에 있는 모든 값을 가져온다.
			        console.log(td.eq(0).text());
			        $("#newmemberListSearch").val(td.eq(0).text());
			        $("#insa_newsearch_table_").css('display','none');
			        
				});
			},
			error : function(jqxhr, textStatus, errorThrown){
				console.log("ajax실패",jqxhr,textStatus,errorThrown);
			}
		});
	}); 

	$("#newmemberListSearch").focusout(function(){
		$("#insa_newsearch_table_").css("opacity",0);
	});
	$("#newmemberListSearch").focusin(function(){
		$("#insa_newsearch_table_").css("opacity",100);
	});
	/* $("#newmemberListSearchchk").on("change",function(){
		console.log($(this).val());
	}); */
	
	
	$("#insa_search_button").click(function(){
		$(this).submit();		
	}); 
	$("#insaTotalCheck").on("click",function(){
		$(".insaCheck").prop("checked",$(this).prop("checked"));
		if($(this).prop("checked")){
			$(".insaCheck").addClass("checked");
		}else{
			$(".insaCheck").removeClass("checked");				
		}
		if($(".insaCheck.checked").length==0){
			$("#connectsDelete").hide();
		}else{
			$("#insaCheck").text($(".insaCheck.checked").length);
			$("#connectsDelete").css("display","inline-block");
		}
	});
	
	$(".insaCheck").on("change", function(){
		if($(".insaCheck.checked").length==0){
			$("#gajongsDelete").hide();
		}else{
			$("#gajongCnt").text($(".gajongCheck.checked").length);
			$("#gajongsDelete").show();
		}
		if($(".insaCheck").not(".checked").length != 0){
			$("#gajongTotalCheck").prop("checked",false);
		}
	});
	
 	$(".deleteCheck.insaCheck").on("click", function(){
		if($(".deleteCheck:checked").length == parseInt("${list.size()}")){
			$("#insaTotalCheck").prop("checked",true);
		}else{
			$("#insaTotalCheck").prop("checked",false);
		}
		
		if($(".deleteCheck:checked").length > 0){
			$("#connectsDelete").css("display","inline-block");
		}else{
			$("#connectsDelete").hide();
		}
	   console.log( $("#getUserId").val() ); 
	});
});

function fn_btninsaUpdate(e){		
	$("#position").val($("#selectposition").val());
	$("#positionUpdateModal").modal('hide');
	
	$("#job").val($("#selectjob").val());
	$("#jobUpdateModal").modal('hide');
	
	$("#status").val($("#selectstatus").val());
	$("#statusUpdateModal").modal('hide');
	
	$("#updateType").val(e);
	document.insaMemberDelete.submit();
}

function fn_userDelete(){
	if(confirm("정말로 삭제하시겠습니까?")){		
		document.insaMemberDelete.submit();
	}

}
function fn_newMemberAdd(){
	/* location.href='${pageContext.request.contextPath}/insa/newMemberAdminAdd.do'; */
	$("#newmemberListSearchchk").val(0);
	$("#newmemberListSearch").val("");
	$("#newMemberAdminAddModal").modal();
}
function fn_newMemberUpdateAdd(){
	
	var search = $("#newmemberListSearch").val();
	var searchchk = $("#newmemberListSearchchk").val();

	if(searchchk == 1){
		$("#newMemberAdminAddModalForm").submit();
	}else{
		return
	}
}
</script>
<div class="insa_management" style="width: 100%;">
	<h5 style="display: inline;">사용자 관리</h5> 
	<div style="float: right!important">
		<span style="right: 0px; margin-right: 20px">사용자   ${boardCnt}</span>
	</div>
	<hr />
	<p id="admin-add" onclick="fn_newMemberAdd()">+ 사용자 초대</p>
	<br />
	
	<input type="checkbox" name="" id="insaTotalCheck"/>&nbsp;<label for="insaTotalCheck">전체선택</label>&nbsp;&nbsp;
	<!-- <a href="javascript:void(0)" data-toggle="modal" data-target="#connectionInsertModal"> + 거래처 추가</a>&nbsp; -->
	<div style="display: none;" id = "connectsDelete">
		<a href="javascript:void(0)" data-toggle="modal" data-target="#deptDeleteModal" onclick="fn_userDelete()"  >삭제 <span id="connectCnt"></span></a>&nbsp;&nbsp;
		<!-- <a href="javascript:void(0)" data-toggle="modal" data-target="#deptDeleteModal"  >소속조직 수정 <span id="connectCnt"></span></a>&nbsp;&nbsp; -->
		<a href="javascript:void(0)" data-toggle="modal" data-target="#positionUpdateModal"  >직위 수정<span id="connectCnt"></span></a>&nbsp;&nbsp;
		<a href="javascript:void(0)" data-toggle="modal" data-target="#jobUpdateModal"  >직무 수정<span id="connectCnt"></span></a>&nbsp;&nbsp;
		<a href="javascript:void(0)" data-toggle="modal" data-target="#statusUpdateModal"  >상태 수정<span id="connectCnt"></span></a>&nbsp;&nbsp;
	</div>
<form action="insaSelectMemberSearch.do" style="float: right;">
 <div id="insa_ajaxValueDiv">
  <div class="input-group"  style="width: 200px; margin-right: 30px;">
    <input type="text" id="memberListSearch" name="searchKey" class="form-control" placeholder="Search..." value='${searchKey == null?"":searchKey }' autocomplete="off" >
    <div class="input-group-btn">
      <button id="insa_search_button"class="btn btn-default">
        <i class="icon-search"></i>
      </button>
    </div>
  </div>
  <div id="insa_ajaxValue"></div>
 </div>
</form> 
<div style="float: right; margin-right: 30px;">
	<c:if test="${searchKey != null }">
	  <a href="${pageContext.request.contextPath}/insa/memberManagement.do" >검색취소</a>
	</c:if>
</div>
<br /><br />   
<form action="${pageContext.request.contextPath}/insa/insaMemberDelete.do" name="insaMemberDelete">
	<table class="table table-hover">
		<thead class="thead-light">
		<tr>
			<th></th>
			<th>이름</th>
			<th>ID</th>
			<th>사내전화</th>
			
			<th>부서</th>
			<th style="min-width: 56px;">직위</th>
			<th>입사일</th>
			<th style="min-width: 56px;">직무</th>
			<th style="min-width: 56px;">상태
			<input type="hidden" id="position" name="position" value=""/>
			<input type="hidden" id="job" name="job" value=""/>
			<input type="hidden" id="status" name="status" value=""/>
			<input type="hidden" id="updateType" name="updateType" value=""/>
			</th>
		</tr>
		</thead>
		<c:if test="${empty list}">
			<tr>
				<td colspan="9" style="text-align: center;">해당 사원이 없습니다.</td>
			</tr>
		</c:if>
		<c:if test="${not empty list }">
			<c:forEach var="l" items="${list}" varStatus="sts">
				<tr>
					<td>
						<input type="checkbox" class="deleteCheck insaCheck"id="getUserId" name="userId" value="${l.getUserId()}" />
					</td>
					<td style="white-space: nowrap">${l.getUserName()}</td>
					<td style="white-space: nowrap"><a style="color:gray; font-weight:bold; text-decoration: underline;" href="${pageContext.request.contextPath}/insa/memberSelectManagement.do?userId=${l.getUserId()}">${l.getUserId()}</a></td>
					<td>${l.getPhone_com()}</td>
					
					<td style="white-space: nowrap">${l.getDept()}</td>
					<td>${l.getPosition()}</td>
					<td>${l.getJoinDate()}</td>
					<td>${l.getJob()}</td>
					<td>${l.getStatus()}</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
</form>
	<c:if test="${not empty list }">
	 <%
    	int boardCnt = Integer.parseInt(String.valueOf(request.getAttribute("boardCnt")));
    	int numPerPage = Integer.parseInt(String.valueOf(request.getAttribute("numPerPage")));
    	int cPage = 1;
    	
    	try{
    		cPage = Integer.parseInt(request.getParameter("cPage"));
    	}catch(NumberFormatException e){
    		
    	}
    %>			
    <%=com.kh.ok.insa.util.Utils.getPageBar(boardCnt, cPage, numPerPage, "memberManagement.do")%>
	</c:if>
</div>
<!-- 직위 modal -->
<div class="modal fade" id="positionUpdateModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalCenterTitle">직위 수정</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<!-- connectionInsert -->
			<form action="${pageContext.request.contextPath}/insa/updateModal.do" method="post">
				<div class="modal-body">
					<table class="table" style="margin-bottom: 0px;">
						<tr>
							<th>직위</th>
							<td>
								<select name="selectposition" id="selectposition" class="custom-select" style="width: 250px;">
									<c:forEach var="p" items="${plist}">
										<option value="${p.position}" ${p.position eq member.position?"selected":""}>${p.position}</option>
									</c:forEach>
								</select>
							</td>
						</tr>
					</table>
				</div>
			<div class="modal-footer">
				<button type="reset" class="btn btn-secondary" data-dismiss="modal">닫기</button>
				<button type="reset" class="btn btn-primary" onclick="fn_btninsaUpdate('position')">수정</button>
			</div>
			</form>
		</div>
	</div>
</div>
<!-- 직무 modal -->
<div class="modal fade" id="jobUpdateModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalCenterTitle">직무 수정</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<!-- connectionInsert -->
			<form action="${pageContext.request.contextPath}/insa/updateModal.do" method="post">
				<div class="modal-body">
					<table class="table" style="margin-bottom: 0px;">
						<tr>
							<th>직무</th>
							<td>
								<select name="selectjob" id="selectjob" class="custom-select" style="width: 250px;">
									<c:forEach var="j" items="${jlist}">
										<option value="${j.job}" ${j.job eq member.job?"selected":""}>${j.job}</option>
									</c:forEach>
								</select>
							</td>
						</tr>
					</table>
				</div>
			<div class="modal-footer">
				<button type="reset" class="btn btn-secondary" data-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-primary" onclick="fn_btninsaUpdate('job')">수정</button>
			</div>
			</form>
		</div>
	</div>
</div>
<!-- 상태 modal -->
<div class="modal fade" id="statusUpdateModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalCenterTitle">상태 수정</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<!-- connectionInsert -->
			<form action="${pageContext.request.contextPath}/insa/updateModal.do" method="post">
				<div class="modal-body">
					<table class="table" style="margin-bottom: 0px;">
						<tr>
							<th>상태</th>
							<td>
								<select name="selectstatus" id="selectstatus" class="custom-select" style="width: 250px;">
										<option value="Y" >정상</option>
										<option value="N" >탈퇴</option>
								</select>
							</td>
						</tr>
					</table>
				</div>
			<div class="modal-footer">
				<button type="reset" class="btn btn-secondary" data-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-primary" onclick="fn_btninsaUpdate('status')">수정</button>
			</div>
			</form>
		</div>
	</div>
</div>

<!-- 사용자 초대 modal -->
<div class="modal fade" id="newMemberAdminAddModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalCenterTitle">사용자 초대</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<!-- connectionInsert -->
			<form action="${pageContext.request.contextPath}/insa/newMemberAdminAddModal.do" method="post" id="newMemberAdminAddModalForm">
				<div class="modal-body">
					<table class="table" style="margin-bottom: 0px;">
						<tr>
							<th>신규 사용자 검색</th>
							<td>
								  <div class="input-group"  style="width: 200px; margin-right: 30px;">
								    <input type="text" id="newmemberListSearch" name="searchKey" class="form-control" placeholder="Search..." value='${searchKey == null?"":searchKey }' autocomplete="off">
								    <input type="hidden" id="newmemberListSearchchk" class="form-control" value="0" >
								    <div class="input-group-btn">
								      <!-- <button id="insa_newsearch_button"class="btn btn-default" >
								        <i class="icon-search"></i>
								      </button> -->
								    </div>
								  </div>
							      <div id="insa_newajaxValue"></div>
							</td>
						</tr>
					</table>
				</div>
			<div class="modal-footer">
				<button type="reset" class="btn btn-secondary" data-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-primary" onclick="fn_newMemberUpdateAdd()">추가</button>
			</div>
			</form>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>