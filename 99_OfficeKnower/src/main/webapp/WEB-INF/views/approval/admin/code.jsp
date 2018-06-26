<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String tabSelected = request.getParameter("tabSelected");
%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="전자결재" name="pageTitle"/>
</jsp:include>
<jsp:include page="/WEB-INF/views/common/nav.jsp">
	<jsp:param value="전자결재" name="pageTitle"/>
	<jsp:param value="코드 관리" name="selectMenu"/>
</jsp:include>
<style>
div.tab-pane{
	padding-top: 20px;
}
span.guide{
	display: none;
	position: absolute;
	font-size: 12px;
	top: 37px;
    right: 35px;
}
span.ok{color:green;}
span.error{color:red;}
</style>
<script>
	$(function(){
		$(".code").on("keyup", function(){
			var code = $(this).val().trim();
			var com_no = $(this).siblings("[name=com_no]").val();
			var preCode = $(this).siblings("[name=preCode]").val();
			var flag = $(this).attr("id");
			var codeDuplicate = $(this).siblings(".codeDuplicate");
			var ok = $(this).siblings(".guide.ok");
			var error = $(this).siblings(".guide.error");
			console.log(code.length);
			if(code.length==0){
				error.hide();
				ok.hide();
		        codeDuplicate.val(0);
		        return false;
			}
			
			if(preCode != null && code == preCode){
				error.hide();
				ok.hide();
		        codeDuplicate.val(1);
		        return false;
			}
			
			$.ajax({
				url : "${pageContext.request.contextPath}/approval/checkCodeDuplicate.do",
				dataType : "json",
				data : {code : code, com_no : com_no, flag : flag},
				success : function(data){
					console.log(data);
					if(data.isUsable == true){
						ok.show();
						error.hide();
		             	codeDuplicate.val(1);
					}else{
						error.show();
						ok.hide();
			            codeDuplicate.val(0);
					}
				},
				error:function(jqxhr, textStatus, errorThrown) {
		            console.log("ajax실패!", jqxhr, textStatus, errorThrown);
		        }
			});
		});
		$("#connectTotalCheck").on("click",function(){
			$(".connectCheck").prop("checked",$(this).prop("checked"));
			if($(this).prop("checked")){
				$(".connectCheck").addClass("checked");
			}else{
				$(".connectCheck").removeClass("checked");				
			}
			if($(".connectCheck.checked").length==0){
				$("#connectsDelete").hide();
			}else{
				$("#connectCnt").text($(".connectCheck.checked").length);
				$("#connectsDelete").show();
			}
		});
		$("#gajongTotalCheck").on("click",function(){
			$(".gajongCheck").prop("checked",$(this).prop("checked"));
			if($(this).prop("checked")){
				$(".gajongCheck").addClass("checked");
			}else{
				$(".gajongCheck").removeClass("checked");				
			}
			if($(".gajongCheck.checked").length==0){
				$("#gajongsDelete").hide();
			}else{
				$("#gajongCnt").text($(".gajongCheck.checked").length);
				$("#gajongsDelete").show();
			}
		});
		$("#deptTotalCheck").on("click",function(){
			$(".deptCheck").prop("checked",$(this).prop("checked"));
			if($(this).prop("checked")){
				$(".deptCheck").addClass("checked");
			}else{
				$(".deptCheck").removeClass("checked");				
			}
			if($(".deptCheck.checked").length==0){
				$("#deptsDelete").hide();
			}else{
				$("#deptCnt").text($(".deptCheck.checked").length);
				$("#deptsDelete").show();
			}
		});
		gajongsDelete
		$(".deleteCheck").on("click", function(){
			$(this).toggleClass("checked");
		})
		$(".connectCheck").on("change", function(){
			if($(".connectCheck.checked").length==0){
				$("#connectsDelete").hide();
			}else{
				$("#connectCnt").text($(".connectCheck.checked").length);
				$("#connectsDelete").show();
			}
			if($(".connectCheck").not(".checked").length != 0){
				$("#connectTotalCheck").prop("checked",false);
			}
		});
		$(".gajongCheck").on("change", function(){
			if($(".gajongCheck.checked").length==0){
				$("#gajongsDelete").hide();
			}else{
				$("#gajongCnt").text($(".gajongCheck.checked").length);
				$("#gajongsDelete").show();
			}
			if($(".gajongCheck").not(".checked").length != 0){
				$("#gajongTotalCheck").prop("checked",false);
			}
		});
		$(".deptCheck").on("change", function(){
			if($(".deptCheck.checked").length==0){
				$("#deptsDelete").hide();
			}else{
				$("#deptCnt").text($(".deptCheck.checked").length);
				$("#deptsDelete").show();
			}
			if($(".deptCheck").not(".checked").length != 0){
				$("#deptTotalCheck").prop("checked",false);
			}
		});
	});
	function fn_validate(frm){
		frm.find("input.codeDuplicate").val()
		if(frm.find("input.codeDuplicate").val() != 1){
			return false
		}
		return true;
	}
	function fn_update(flag, code, name){
		if(flag == 'connect'){
			$("#connectionUpdateModal").find("#connectionCode").val(code);
			$("#connectionUpdateModal").find("input[name=connection_name]").val(name);			
			$("#connectionUpdateModal").find("input[name=preCode]").val(code);			
		}else if(flag == 'gajong'){
			$("#gajongUpdateModal").find("#gajongCode").val(code);
			$("#gajongUpdateModal").find("input[name=title_of_account]").val(name);			
			$("#gajongUpdateModal").find("input[name=preCode]").val(code);		
		}else if(flag == 'dept'){
			$("#deptUpdateModal").find("#deptCode").val(code);
			$("#deptUpdateModal").find("input[name=dept]").val(name);			
			$("#deptUpdateModal").find("input[name=preCode]").val(code);		
		}
	}
	function fn_delete(flag, code, com_no){
		if(confirm("삭제하겠습니까?")){
			location.href="${pageContext.request.contextPath}/approval/deleteCode.do?flag="+flag+"&code="+code+"&com_no="+com_no;
		}
	};
	function fn_connectionsDelete(){
		if(confirm("정말로 삭제하시겠습니까?")){		
			document.connectionsDelete.submit();
		}
	}
	function fn_gajongsDelete(){
		if(confirm("정말로 삭제하시겠습니까?")){		
			document.gajongsDelete.submit();
		}
	}
	function fn_deptsDelete(){
		if(confirm("정말로 삭제하시겠습니까?")){		
			document.deptsDelete.submit();
		}
	}
</script>
<h4>코드 관리</h4>
<hr />
<br />
<ul class="nav nav-tabs" id="myTab" role="tablist">
	<li class="nav-item">
  		<a class='nav-link <%=tabSelected == null || "connection".equals(tabSelected)?"active":""%>' id="connection-tab" data-toggle="tab" href="#connection" role="tab" aria-controls="connection" aria-selected="true">거래처</a>
	</li>
	<li class="nav-item">
		<a class='nav-link <%="gajong".equals(tabSelected)?"active":""%>' id="gajong-tab" data-toggle="tab" href="#gajong" role="tab" aria-controls="gajong" aria-selected="false">계정과목</a>
	</li>
	<li class="nav-item">
  		<a class='nav-link <%="dept".equals(tabSelected)?"active":""%>' id="dept-tab" data-toggle="tab" href="#dept" role="tab" aria-controls="dept" aria-selected="false">부서</a>
	</li>
</ul>
<div class="tab-content" id="myTabContent">
	<div class='tab-pane fade <%=tabSelected == null || "connection".equals(tabSelected)?"active show":""%>' id="connection" role="tabpanel" aria-labelledby="connection-tab">
		<form action="${pageContext.request.contextPath}/approval/deleteCodes.do" method="post" name="connectionsDelete">
			<p>		
				<input type="checkbox" name="" id="connectTotalCheck"/>&nbsp;<label for="totalCheck">전체선택</label>&nbsp;
				<a href="javascript:void(0)" data-toggle="modal" data-target="#connectionInsertModal"> + 거래처 추가</a>&nbsp;
				<a href="javascript:void(0)" id="connectsDelete" style="display: none;" onclick="fn_connectionsDelete();">삭제 <span id="connectCnt"></span></a>
			</p>
			<table class="table table-hover">
				<thead>
					<tr>
						<th scope="col">코드</th>
						<th scope="col">거래처명</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${!empty connectList}">
						<input type="hidden" name="com_no" value="${memberLoggedIn.com_no}"/>
						<input type="hidden" name="flag" value="connection"/>
						<c:forEach items="${connectList}" var="connect">
							<tr>
								<th scope="row">
									<input type="checkbox" class="deleteCheck connectCheck" name="code" value="${connect.code}" /> ${connect.code}
								</th>
								<td>
									${connect.connection_name}
									<span style="float: right;">					
										<a href="javascript:void(0)" data-toggle="modal" data-target="#connectionUpdateModal" onclick="fn_update('connect','${connect.code}', '${connect.connection_name}')">
											수정
										</a>/<a href="javascript:void(0)" onclick="fn_delete('connection', '${connect.code}', '${connect.com_no}')">삭제</a>
									</span>
								</td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${empty connectList}">
						<tr>
							<td colspan="2" style="text-align: center">
								거래처가 없습니다.
							</td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</form>
	</div>
	<div class='tab-pane fade <%="gajong".equals(tabSelected)?"active show":""%>' id="gajong" role="tabpanel" aria-labelledby="gajong-tab">
		<form action="${pageContext.request.contextPath}/approval/deleteCodes.do" method="post" name="gajongsDelete">
			<p>		
				<input type="checkbox" name="" id="gajongTotalCheck" />&nbsp;<label for="totalCheck">전체선택</label>&nbsp;
				<a href="javascript:void(0)" data-toggle="modal" data-target="#gajongInsertModal"> + 계정과목 추가</a>
				<a href="javascript:void(0)" id="gajongsDelete" style="display: none;" onclick="fn_gajongsDelete();">삭제 <span id="gajongCnt"></span></a>
			</p>
			<table class="table table-hover">
				<thead>
					<tr>
						<th scope="col">코드</th>
						<th scope="col">계정과목명</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${!empty toaList}">
						<input type="hidden" name="com_no" value="${memberLoggedIn.com_no}"/>
						<input type="hidden" name="flag" value="gajong"/>
						<c:forEach items="${toaList}" var="toa">
							<tr>
								<th scope="row">
									<input type="checkbox" class="deleteCheck gajongCheck" name="code" value="${toa.code}" /> ${toa.code}
								</th>
								<td>
									${toa.title_of_account}
									<span style="float: right;">					
										<a href="javascript:void(0)" data-toggle="modal" data-target="#gajongUpdateModal" onclick="fn_update('gajong','${toa.code}', '${toa.title_of_account}')">수정</a>
										/<a href="javascript:void(0)" onclick="fn_delete('gajong', '${toa.code}', '${toa.com_no}')">삭제</a>
									</span>
								</td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${empty toaList}">
						<tr>
							<td colspan="2" style="text-align: center">
								계정 과목이 없습니다.
							</td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</form>
	</div>
	<div class='tab-pane fade <%="dept".equals(tabSelected)?"active show":""%>' id="dept" role="tabpanel" aria-labelledby="dept-tab">
		<form action="${pageContext.request.contextPath}/approval/deleteCodes.do" method="post" name="deptsDelete">
			<p>		
				<input type="checkbox" name="" id="deptTotalCheck" />&nbsp;<label for="totalCheck">전체선택</label>&nbsp;
				<a href="javascript:void(0)" data-toggle="modal" data-target="#deptInsertModal"> + 부서 추가</a>
				<a href="javascript:void(0)" id="deptsDelete" style="display: none;" onclick="fn_deptsDelete();">삭제 <span id="deptCnt"></span></a>
			</p>
			<table class="table table-hover">
				<thead>
					<tr>
						<th scope="col">코드</th>
						<th scope="col">거래처명</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${!empty deptList}">
						<input type="hidden" name="com_no" value="${memberLoggedIn.com_no}"/>
						<input type="hidden" name="flag" value="dept"/>
						<c:forEach items="${deptList}" var="dept">
							<tr>
								<th scope="row">
									<input type="checkbox" name="code" class="deleteCheck deptCheck" value="${dept.code}" /> ${dept.code}
								</th>
								<td>
									${dept.dept}
									<span style="float: right;">					
										<a href="javascript:void(0)" data-toggle="modal" data-target="#deptUpdateModal" onclick="fn_update('dept','${dept.code}', '${dept.dept}')">수정</a>
										/<a href="javascript:void(0)" onclick="fn_delete('dept', '${dept.code}', '${dept.com_no}')">삭제</a>
									</span>
								</td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${empty deptList}">
						<tr>
							<td colspan="2" style="text-align: center">
								부서가 없습니다.
							</td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</form>
	</div>
</div>
 
<!-- 거래처 insertModal -->
<div class="modal fade" id="connectionInsertModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalCenterTitle">거래처 추가</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<!-- connectionInsert -->
			<form action="${pageContext.request.contextPath}/approval/connectionInsert.do" method="post" onsubmit="return fn_validate($(this));">
				<div class="modal-body">
					<table class="table" style="margin-bottom: 0px;">
						<tr>
							<th>코드</th>
							<td>
								<input type="text" class="form-control code" name="code" id="connectionCode" required/>
								<input type="hidden" name="com_no" value="${memberLoggedIn.com_no }"/>
								<span class="guide ok">이 코드는 사용가능합니다.</span>
								<span class="guide error">이 코드는 사용할 수 없습니다.</span>
								<input type="hidden" class="codeDuplicate" value="0"/>
							</td>
						</tr>
						<tr>
							<th>거래처명</th>
							<td>
								<input type="text" class="form-control" name="connection_name" required/>
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
<!-- 계정과목 insertModal -->
<div class="modal fade" id="gajongInsertModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalCenterTitle">계정과목 추가</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<form action="${pageContext.request.contextPath}/approval/gajongInsert.do" method="post" onsubmit="return fn_validate($(this)`);">
				<div class="modal-body">
					<table class="table" style="margin-bottom: 0px;">
						<tr>
							<th>코드</th>
							<td>
								<input type="text" class="form-control code" name="code" id="gajongCode" required/>
								<input type="hidden" name="com_no" value="${memberLoggedIn.com_no }"/>
								<span class="guide ok">이 코드는 사용가능합니다.</span>
								<span class="guide error">이 코드는 사용할 수 없습니다.</span>
								<input type="hidden" class="codeDuplicate" value="0"/>
							</td>
						</tr>
						<tr>
							<th>계정과목명</th>
							<td>
								<input type="text" class="form-control" name="title_of_account" id="" required/>
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
<!-- 부서 insertModal -->
<div class="modal fade" id="deptInsertModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalCenterTitle">부서 추가</h5>
		  		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<form action="${pageContext.request.contextPath}/approval/deptInsert.do" method="post" onsubmit="return fn_validate($(this));">
				<div class="modal-body">
					<table class="table" style="margin-bottom: 0px;">
						<tr>
							<th>코드</th>
							<td>
								<input type="text" class="form-control code" name="code" id="deptCode" required/>
								<input type="hidden" name="com_no" value="${memberLoggedIn.com_no }"/>
								<span class="guide ok">이 코드는 사용가능합니다.</span>
								<span class="guide error">이 코드는 사용할 수 없습니다.</span>
								<input type="hidden" class="codeDuplicate" value="0"/>
							</td>
						</tr>
						<tr>
							<th>부서명</th>
							<td>
								<input type="text" class="form-control" name="dept" id="" required/>
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

<!-- 거래처 updateModal -->
<div class="modal fade" id="connectionUpdateModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalCenterTitle">거래처 수정</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<!-- connectionInsert -->
			<form action="${pageContext.request.contextPath}/approval/connectionUpdate.do" method="post" onsubmit="return fn_validate($(this));">
				<div class="modal-body">
					<table class="table" style="margin-bottom: 0px;">
						<tr>
							<th>코드</th>
							<td>
								<input type="text" class="form-control code" name="code" id="connectionCode" required/>
								<input type="hidden" name="com_no" value="${memberLoggedIn.com_no }"/>
								<span class="guide ok">이 코드는 사용가능합니다.</span>
								<span class="guide error">이 코드는 사용할 수 없습니다.</span>
								<input type="hidden" class="codeDuplicate" value="1"/>
								<input type="hidden" name="preCode"/>
							</td>
						</tr>
						<tr>
							<th>거래처명</th>
							<td>
								<input type="text" class="form-control" name="connection_name" required/>
							</td>
						</tr>
					</table>
				</div>
			<div class="modal-footer">
				<button type="reset" class="btn btn-secondary" data-dismiss="modal">닫기</button>
				<button type="submit" class="btn btn-primary">수정</button>
			</div>
			</form>
		</div>
	</div>
</div>

<!-- 계정과목 updateModal -->
<div class="modal fade" id="gajongUpdateModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalCenterTitle">계정과목 수정</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<!-- connectionInsert -->
			<form action="${pageContext.request.contextPath}/approval/gajongUpdate.do" method="post" onsubmit="return fn_validate($(this));">
				<div class="modal-body">
					<table class="table" style="margin-bottom: 0px;">
						<tr>
							<th>코드</th>
							<td>
								<input type="text" class="form-control code" name="code" id="gajongCode" required/>
								<input type="hidden" name="com_no" value="${memberLoggedIn.com_no }"/>
								<span class="guide ok">이 코드는 사용가능합니다.</span>
								<span class="guide error">이 코드는 사용할 수 없습니다.</span>
								<input type="hidden" class="codeDuplicate" value="1"/>
								<input type="hidden" name="preCode"/>
							</td>
						</tr>
						<tr>
							<th>거래처명</th>
							<td>
								<input type="text" class="form-control" name="title_of_account" required/>
							</td>
						</tr>
					</table>
				</div>
			<div class="modal-footer">
				<button type="reset" class="btn btn-secondary" data-dismiss="modal">닫기</button>
				<button type="submit" class="btn btn-primary">수정</button>
			</div>
			</form>
		</div>
	</div>
</div>
<!-- 부서 updateModal -->
<div class="modal fade" id="deptUpdateModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalCenterTitle">부서 수정</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<!-- connectionInsert -->
			<form action="${pageContext.request.contextPath}/approval/deptUpdate.do" method="post" onsubmit="return fn_validate($(this));">
				<div class="modal-body">
					<table class="table" style="margin-bottom: 0px;">
						<tr>
							<th>코드</th>
							<td>
								<input type="text" class="form-control code" name="code" id="deptCode" required/>
								<input type="hidden" name="com_no" value="${memberLoggedIn.com_no }"/>
								<span class="guide ok">이 코드는 사용가능합니다.</span>
								<span class="guide error">이 코드는 사용할 수 없습니다.</span>
								<input type="hidden" class="codeDuplicate" value="1"/>
								<input type="hidden" name="preCode"/>
							</td>
						</tr>
						<tr>
							<th>거래처명</th>
							<td>
								<input type="text" class="form-control" name="dept" required/>
							</td>
						</tr>
					</table>
				</div>
			<div class="modal-footer">
				<button type="reset" class="btn btn-secondary" data-dismiss="modal">닫기</button>
				<button type="submit" class="btn btn-primary">수정</button>
			</div>
			</form>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>