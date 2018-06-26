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
				
/* 				$("#insa_search_table_ tr").on("keyup",function(event){
					console.log('실행하니');
					var tr = $(this).children();
			        var td = tr.children();
			        tr.css('background','black');
				}); */
			},
			error : function(jqxhr, textStatus, errorThrown){
				console.log("ajax실패",jqxhr,textStatus,errorThrown);
			}
		});
	}); 
	
	$("#insa_search_button").click(function(){
		
		/* var searchKey = $("#memberListSearch").val().trim();
	*/
		$(this).submit();		
	/* 	if(searchKey.length==0){
			return;
		} */
		
		/* $.ajax({
			url:"insaSelectMemberSearch.do",
			data : {searchKey:searchKey},
			dataType : "json",
			success : function(data){
				console.log(data.result);
			},
			error : function(jqxhr, textStatus, errorThrown){
				console.log("ajax실패",jqxhr,textStatus,errorThrown);
			}
		}); */

	}); 
	
});

</script>
<div class="insa_management" style="width: 95%;">
	<h5 style="display: inline;">사용자 관리</h5> 
	<div style="float: right!important">
		<span style="right: 0px; margin-right: 20px">사용자   ${boardCnt}</span>
	</div>
	<hr />
	<br /><br />
<form action="insaSelectMemberSearch.do" style="float: right;">
  <div class="input-group"  style="width: 200px; margin-right: 30px;">
    <input type="text" id="memberListSearch" name="searchKey" class="form-control" placeholder="Search..." value='${searchKey == null?"":searchKey }' >
    <div class="input-group-btn">
      <button id="insa_search_button"class="btn btn-default">
        <i class="icon-search"></i>
      </button>
    </div>
  </div>
      <div id="insa_ajaxValue"></div>
</form> 
<div style="float: right; margin-right: 30px;">
	<c:if test="${searchKey != null }">
	  <a href="${pageContext.request.contextPath}/insa/memberManagement.do" >검색취소</a>
	</c:if>
</div>
<br /><br />   

	<table class="table table-hover">
		<thead class="thead-light">
		<tr>
			<th>이름</th>
			<th>ID</th>
			<th>사내전화</th>
			<th>휴대전화</th>
			<th>소속조직</th>
			<th>직위</th>
			<th>입사일</th>
			<th>직무</th>
			<th>상태</th>
		</tr>
		</thead>
		<c:if test="${empty list}">
			<tr>
				<td colspan="9" style="text-align: center;">해당 사원이 없습니다.</td>
			</tr>
		</c:if>
		<c:if test="${not empty list }">
			<c:forEach var="l" items="${list}">
				<tr>
					<td>${l.getUserName()}</td>
					<td><a style="color:gray; font-weight:bold; text-decoration: underline;" href="${pageContext.request.contextPath}/insa/memberSelectManagement.do?userId=${l.getUserId()}">${l.getUserId()}</a></td>
					<td>${l.getPhone_com()}</td>
					<td>${l.getPhone_cell()}</td>
					<td>${l.getCom_name()}</td>
					<td>${l.getPosition()}</td>
					<td>${l.getJoinDate()}</td>
					<td>${l.getJob()}</td>
					<td>${l.getStatus()}</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
	
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
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>