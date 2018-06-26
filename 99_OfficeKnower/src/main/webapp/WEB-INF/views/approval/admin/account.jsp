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
	<jsp:param value="기본 정보" name="selectMenu"/>
</jsp:include>
<style>
div.tab-pane{
	padding-top: 20px;
}
span.guide{
	display: none;
	position: absolute;
	font-size: 13px;
	top: 37px;
    right: 35px;
}
span.ok{color:green;}
span.error{color:red;}

ul#autoComplete{
    position: absolute;
    min-width: 311px;
    border: 1px solid #ced4da;
    border-top: 0px;
    display: inline-block;
    padding: 0;
    margin: 0;
    top: 67px;
    left: 158px;
    background: white;
}
ul#autoComplete li{
	padding: 0 10px;
	list-style: none;
	cursor: pointer;
	position: relative;
}
ul#autoComplete li.sel{
	background: lightseagreen;
	color: white;
}
span.srchval{
	color: #0069d9;
}
span.spanUserId{
	float: right;
}
a#editName{
	position: absolute;
    top: 29px;
    left: 64px;
    display: none;
}
</style>
<script>
	$(function(){
		$("#accountName").on("keyup", function(e){
			var name = $(this).val().trim();
			var com_no = $(this).siblings("[name=com_no]").val();
			var sel = $(".sel");
			var li = $("#autoComplete li");
			if(e.key == 'ArrowDown'){
				if(sel.length == 0){
					$("#autoComplete li:first").addClass("sel");
				}else if(sel.is(li.last())){
					sel.removeClass("sel")
				}else{
					sel.removeClass("sel").next().addClass("sel");
				}
				
			}else if(e.key == 'ArrowUp'){
				if(sel.length == 0){
					$("#autoComplete li:last").addClass("sel");
				}else if(sel.is(li.first())){
					sel.removeClass("sel")
				}else{
					sel.removeClass("sel").prev().addClass("sel");
				}
				
			}else if(e.key == 'Enter'){
				$(this).val(sel.children(".username").text());
				//검색어목록은 감추고, 생성했던 li태그는 삭제
				$("#accountName").siblings("[name=userId]").val(sel.children(".spanUserId").text())
				$("#accountName").siblings(".guide.ok").text(sel.children(".spanUserId").text()).show();
				$("#accountName").attr("readonly","readonly");
				$("#editName").show();
				//검색어목록은 감추고, 생성했던 li태그는 삭제
				$("#autoComplete").hide().children().remove();
			}else{
				$.ajax({
					url : "${pageContext.request.contextPath}/approval/selectListByName.do",
					type : "post",
					data : {name : name, com_no:com_no},
					dataType : "json",
					success : function(data){
						var list = data.list;
						var html = "";
						if(list.length == 0){
							$("#autoComplete").hide();
						}else{
							for(index in list){
								html += "<li><span class='username'>"+list[index].userName.replace(name, "<span class='srchval'>"+name+"</span>")+"</span><span class='spanUserId badge badge-light'>"
								+list[index].userId+"</span></li>";
							}
							$("#autoComplete").html(html).show();
						}
					},
					error:function(jqxhr, textStatus, errorThrown) {
			            console.log("ajax실패!", jqxhr, textStatus, errorThrown);
			        }
				});	
			}
		});
		//부모요소에 이벤트핸들러를 설정하고, 자식요소를 이벤트 소스로 사용
		$("#autoComplete").on("mouseover","li",function () {
			$("#autoComplete li").removeClass("sel");
			$(this).addClass("sel");
		});
		$("#autoComplete").on("mouseout","li",function () {
			$(this).removeClass("sel");
		});
		$("#autoComplete").on("click","li",function () {
			$("#accountName").val($(this).children(".username").text());
			$("#accountName").siblings("[name=userId]").val($(this).children(".spanUserId").text())
			$("#accountName").siblings(".guide.ok").text($(this).children(".spanUserId").text()).show();
			$("#accountName").attr("readonly","readonly");
			$("#editName").show();
			//검색어목록은 감추고, 생성했던 li태그는 삭제
			$("#autoComplete").hide().children().remove();
		}); 
	});
	function fn_editName(){
		$("#accountName").val("");
		$("#accountName").removeAttr("readonly");
		$("#accountName").siblings("[name=userId]").val("");
		$("#accountName").siblings(".guide.ok").hide();		
		$("#editName").hide();
	}
	function fn_validate(){
		var regExp = /^[0-9]+$/;
		if($("#frm").find("[name=userId]").val() == ""){
			return false;			
		}
		if($("#frm").find("select").val()==""){
			alert("은행을 선택해주세요.");
			$("#frm").find("select").focus();
			return false;
		}
		if(!regExp.test($("[name=account_no]").val())){
			alert("계좌번호는 숫자만 입력해주세요.");
			return false;
		}
		return true;
	}
</script>
<h4>기본 정보</h4>
<hr />
<br />
<ul class="nav nav-tabs" id="myTab" role="tablist">
	<li class="nav-item">
  		<a class='nav-link active' id="account-tab" data-toggle="tab" href="#account" role="tab" aria-controls="account" aria-selected="true">직원 계좌</a>
	</li>
</ul>
<div class="tab-content" id="myTabContent">
	<div class="tab-pane fade active show" id="account" role="tabpanel" aria-labelledby="account-tab" >
		<form action="${pageContext.request.contextPath}/approval/deleteAccounts.do" method="post" name="accountsDelete">
			<p>		
				<input type="checkbox" name="" id="accountTotalCheck"/>&nbsp;<label for="totalCheck">전체선택</label>&nbsp;
				<a href="javascript:void(0)" data-toggle="modal" data-target="#accountInsertModal"> + 직원 계좌 추가</a>&nbsp;
				<a href="javascript:void(0)" id="accountsDelete" style="display: none;" onclick="fn_accountsDelete();">삭제 <span id="accountCnt"></span></a>
			</p>
			<table class="table table-hover">
				<thead>
					<tr>
						<th scope="col">이름</th>
						<th scope="col">아이디</th>
						<th scope="col">은행명</th>
						<th scope="col">계좌번호</th>
						<th scope="col">등록일</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${!empty accountList}">
						<input type="hidden" name="com_no" value="${memberLoggedIn.com_no}"/>
						
						<c:forEach items="${accountList}" var="account">
							<tr>
								<td>
									<input type="checkbox" class="deleteCheck accountCheck" name="userId" value="${account.userId}" />&nbsp;${account.name}
								</td>
								<td>${account.userId}</td>
								<td>${account.bankName}</td>
								<td>${account.account_no}</td>
								<td>
									${account.reg_date}
									<span style="float: right;">					
										<a href="javascript:void(0)" data-toggle="modal" data-target="#accountUpdateModal" onclick="fn_update('${account.userId}', '${account.bankName},'${account.account_no}')">
											수정
										</a>/<a href="javascript:void(0)" onclick="fn_delete('${account.userId}')">삭제</a>
									</span>
								</td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${empty accountList}">
						<tr>
							<td colspan="5" style="text-align: center">
								직원 계좌가 없습니다.
							</td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</form>
	</div>
</div>
<!-- 부서 insertModal -->
<div class="modal fade" id="accountInsertModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalCenterTitle">계좌 추가</h5>
		  		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<form action="${pageContext.request.contextPath}/approval/accountInsert.do" id="frm" method="post" onsubmit="return fn_validate();">
				<div class="modal-body">
					<a href="javascript:void(0)" id="editName" onclick="fn_editName()">변경</a>
					<table class="table" style="margin-bottom: 0px;">
						<tr>
							<th>이름</th>
							<td>
								<input type="text" class="form-control name" name="name" id="accountName" autocomplete="off" required />
								<input type="hidden" name="userId" value=""/>
								<input type="hidden" name="com_no" value="${memberLoggedIn.com_no }"/>
								<span class="guide ok"></span>
								<ul id="autoComplete"></ul>
							</td>
						</tr>
						<tr>
							<th>은행명</th>
							<td>
								<select class="form-control" name="bankName">
									<option value="">은행명</option>
  									<option value="국민은행">국민은행</option>
									<option value="신한은행">신한은행</option>
									<option value="우리은행">우리은행</option>
									<option value="KEB하나은행">KEB하나은행</option>
									<option value="KDB산업은행">KDB산업은행</option>
									<option value="IBK기업은행">IBK기업은행</option>
									<option value="한국수출입은행">한국수출입은행</option>
									<option value="NH농협은행">NH농협은행</option>
									<option value="수협은행">수협은행</option>
									<option value="대구은행">대구은행</option>
									<option value="부산은행">부산은행</option>
									<option value="경남은행">경남은행</option>
									<option value="광주은행">광주은행</option>
									<option value="전북은행">전북은행</option>
									<option value="제주은행">제주은행</option>
									<option value="SC제일은행">SC제일은행</option>
									<option value="한국씨티은행">한국씨티은행</option>
									<option value="우체국">우체국</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>계좌번호</th>
							<td>
								<input type="text" class="form-control" name="account_no" id="" required placeholder="-없이 숫자만"/>
							</td>
						</tr>
					</table>
				</div>
				<div class="modal-footer">
					<button type="reset" class="btn btn-secondary" data-dismiss="modal">닫기</button>
					<button type="submit" class="btn btn-primary">추가</button>
				</div>
			</form>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
