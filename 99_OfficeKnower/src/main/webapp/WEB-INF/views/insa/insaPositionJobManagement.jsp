<%@page import="com.kh.ok.insa.model.vo.Position"%>
<%@page import="java.util.List"%>
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
	<jsp:param value="직위/직무 관리" name="selectMenu"/>
</jsp:include>

<style>
.plist_th_count{text-align: center; height: 50px;}
.cont_hidden{display: inline-block; padding-right: 20px;}
.plist_th_count.insa_th{border-right: 1px solid gray;}
span.span_blue2 {
   color: #3a60df;
   font-weight: bold;
   font-size: 16px;
}
div#card_info2 {
   z-index: 1;
   visibility: hidden;
   margin: auto;
   position: absolute;
}
.insa_position{width: 130px; display: inline;}
.insa_th{width: 100px;}
.insa_td{width: 200px; }
span.guide{display: none; font-size: 12px; position: absolute; right: 0px; margin-right: 20px;}
span.ok{color:green;}
span.error{color: red;}
.insa_job_input{width: 100px; text-align: center;}
</style>
<script>
$(function(){
	$("#selectjob").on("change",function(){
		console.log($(this).val());
		<c:forEach var='j' items='${jlist}'>
			console.log('${j.job}');
			console.log($("#selectjob").val() != '${j.job}');
		</c:forEach>
		<c:forEach items="${list}" var="m">
			if("${m.job}" == $(this).val()){
				console.log("$('#selectjob').val() =" + $('#selectjob').val());
				$(".deleteUpdateJob").hide();
				$(".insaJobDeleteUpdate").show();
				var html = "<select name='updatejob' id='deleteupdatejob' class='custom-select deleteUpdateJob' style='width: 150px;'>";
				html += "<option value='변경 직무' disabled selected>변경 직무</option>";
				html += "<c:forEach var='j' items='${jlist}'>";
				html += "if($('#selectjob').val() != '${j.job}'){";
				html += "<option class='positionOption'value='${j.job}'>${j.job}</option>}</c:forEach></select>";
				$("#insaJobDeleteUpdateSelect").append(html);
				return false;			
			}else{
				$(".insaJobDeleteUpdate").hide();
			}
		</c:forEach>
	});
	
	$("#insa_position_update").on("keyup",function(){
		var oldPosition = $("#insa_position_select").val();
		var newPosition = $(this).val().trim();
		var comNo = ${member.com_no};
		
 		if(newPosition.length==0){
			$(".guide.error").hide();
			$(".guide.ok").hide();
			$("#idDuplicateCheck").val(0);
			return;
		}
		$.ajax({
			url : "positioncheckIdDuplicate.do",
			data : {newPosition:newPosition,
					comNo:comNo},
			dataType : "json",
			success : function(data){
				console.log(data);		// true, false
				if(data.isUsable==true){
					$(".guide.error").hide();
					$(".guide.ok").show();
					$("#idDuplicateCheck").val(1);
				}else{
					$(".guide.error").show();
					$(".guide.ok").hide();
					$("#idDuplicateCheck").val(0);					
				}
			},
			error : function(jqxhr, textStatus, errorThrown){
				console.log("ajax실패",jqxhr,textStatus,errorThrown);
			}
		});
		
	}); 
});
</script>
<script>
function fn_popup(){
	var content = "<span class='span_blue2'>■ 직위추가</span><br />"
        + "직위 등급은 [+직위 추가] 버튼으로 생성할 수 있습니다.<br /> "
        + "<span class='span_blue2'>■ 직위삭제</span><br />"
        + "직위 등급은 [-직위 삭제] 버튼으로 삭제할 수 있습니다.<br /> "
		var postionText; 
		postionText = '<table id="popup2" cellpadding="5" bgcolor="#ffffff" style="font-size:9pt; filter:alpha(opacity=90); border-width:1; border-color:#3291BD; border-style:solid;">'; 
		postionText += '<tr><td>' + content + '</td></tr></table>'; 
		 document.getElementById('card_info2').innerHTML = postionText; 
		 document.getElementById('card_info2').style.visibility = 'visible';
}
function fn_hide(){
	document.getElementById('card_info2').innerHTML = ''; 
    document.getElementById('card_info2').style.visibility = 'hidden'; 	
}
/* job+직무추가*/
function fn_jobAdd(){
	$("#btn_jobsubmitbutton").show();
	
	console.log($("#insa_job_tr td").length);
	if($("#insa_job_tr td").length< ${jlist.size()}+1){
		var html = '<td><input type="text" class="form-control insa_job insaJob insa_job_input" name="job1" id="insa_jobAdd" value=""/></td>'
		$("#insa_job_tr").append(html);
	}
}
function fn_btnJobinsaDelte() {	
	var job = $("#selectjob").val();
	
	$("#insa_job_delete").val($("#deleteupdatejob").val());
	
	/* <c:forEach items="${list}" var="m">
		if("${m.job}" == job){
			alert('기존에 값이 있습니다.');
			return false;			
		}
	</c:forEach>
	 */
	$("#jobDeleteModal").submit();
}
function fn_btnJobinsaUpdate(){
	$("#updateJobModal").submit();
}
/* job +직무수정 */
function fn_jobUpdate(){
	$("#jobUpdate").modal();
}
/* job +직무삭제 */
function fn_jobDelete(){
	$("#selectjob").val("삭제 직무");
	$("#deleteupdatejob").val("변경 직무");
	$(".insaJobDeleteUpdate").hide();
	$("#jobDelete").modal();
}
/* job 저장 버튼 */
function fn_btnJobSubmit(){
	/* console.log($("#insa_jobAdd").val()); */
	$("#job").val($("#insa_jobAdd").val());
	
	/* console.log($("#insa_job").val($("#insa_jobAdd").val())); */
	
	var job = $("#insa_jobAdd").val();
	
	<c:forEach items="${jlist}" var="j">
		if("${j.job}" == job){
			alert('기존에 값이 있습니다.');
			return false;			
		}
	</c:forEach>
	$("#jobInsertAdd").submit();	
}
function fn_positionAdd(){
	if($("#insa_position_table tr").length< ${plist.size()}+2){
	var html = "<tr><th class='plist_th_count insa_th'>";
		html += ($("#insa_position_table tr").length); 
		html += "직위</th><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
		html += '<input type="text" class="form-control insa_position insaPosi" name="position" id="insa_positionAdd" value="${p.position }"/>';
		html += "</td></tr>";
	$("#insa_position_table").append(html);
	/* console.log($("#insa_position_table> tbody> tr> th:last").val()); */
	$(".insa_position_update").hide();
	$("#positionRemove").hide();
	$(".spanUpdateDelete").hide();
	$("#btnPositionAdd").show();
	}
	console.log($("#insa_position_table tr").length);
}
function fn_positionRemove(){
	if($("#insa_position_table tr").length >1 && $("#insa_position_table tr").length> ${plist.size()}){
		/* $(".insa_position_update").hide(); */
		$("#insa_position_table tr:last").remove();
	}
}
function fn_insaPositionUpdate(position,level){
	/* console.log(position); */
	$(".guide.error").hide();
	$(".guide.ok").hide();
	$("#idDuplicateCheck").val(0);
	$("#insa_position_update").val("");
	$("#insa_position_select").val(position);
	$("#positionLevel").val(level);
}
/* position 삭제 모달 */
function fn_insaPositionDelete(position){
	var comNo = ${member.com_no};
	$("#titlePositionTitile").text(position);
 	$.ajax({
		url : "positioncheckListDuplicate.do",
		data : {position:position,
				comNo:comNo},
		dataType : "json",
		success : function(data){
			/* console.log(data);		// true, false */
			if((data.listEmpty) == true){
				$("#selectPoistionMemberListTitle").text(position+"직위를 가지고 있는 사용자");
				var arrUserId = data.userId+"";
				arrUserId = arrUserId.replace(/,/g,", ");
				$("#selectPoistionMemberList").text(arrUserId);
				$("#selectPoistionMemberMenu").show();
				$("#selectposition").show();
				$("#selectposition").val("변경 직위");
				$("#insauserId").val(data.userId);
				$("#s_position").val(position);
				$("#insacom_no").val(comNo);
			}else{
				$("#selectposition").hide();
				$("#selectPoistionMemberList").text("");
				$("#selectPoistionMemberMenu").hide();
				$("#selectPoistionMemberListTitle").text(position+"을 삭제하시겠습니까");				
				$("#selectposition").val("변경 직위");
				$("#s_position").val(position);
			}
		},
		error : function(jqxhr, textStatus, errorThrown){
			console.log("ajax실패",jqxhr,textStatus,errorThrown);
		}
	});
 	$("#s_position").val(position);
	$("#positionDelete").modal();
}

function fn_btninsaUpdate(){
	if($("#idDuplicateCheck").val() == 1){
		$("#updateModal").submit();
	}
}
function fn_btnSubmit(){
	console.log("1");
	if($("#insa_positionAdd").val().trim().length != 0)
		$("#positionAlterAdd").submit();
}
function fn_btninsaDelte() {	
	$("#positionDeleteModal").submit();
}
</script>
<div class="insa_management" style="width: 95%;">
	<h5 style="display: inline;">직위/직무 관리</h5> 
	<hr />
	<br /><br />
	
<div class="cont_hidden">
	<h6 class="cont_hidden">직위관리</h6>
	<div class="cont_hidden">
        <i class="icon-question" onMouseOver="fn_popup();" onMouseOut="fn_hide(); return true;"></i>
        <div id="card_info2"></div>
    </div>
    <a href="javascript:void(0)" Id="positionAdd" onclick="fn_positionAdd()">+직위추가</a> &nbsp;&nbsp;
    <!-- <a href="javascript:void(0)" Id="positionRemove" onclick="fn_positionRemove()" data-toggle="modal" data-target="#positionDelete">-직위삭제</a> -->
</div>

<br /><br />   
<form action="${pageContext.request.contextPath}/insa/insaPositionAdd.do" name="insaMemberDelete" id="positionAlterAdd">
	<table id="insa_position_table"class="table" style="width: 400px;">
		<thead class="thead-light">
		<tr>
			<th class="plist_th_count insa_th">등급</th>
			<th class="plist_th_count insa_td">직위</th>
		</tr>
		<c:if test="${empty plist}">
			<tr>
				<td colspan="2" style="text-align: center;">등급이 없습니다.</td>
			</tr>
		</c:if>
		</thead>
		<tbody>
		<c:if test="${not empty plist }">
			<c:forEach var="p" items="${plist}" varStatus="sts">
				<tr>
					<th class="plist_th_count insa_th">
						${sts.count}등급
					</th>
					<td class="plist_th_count insa_td">
						<input type="text" class="form-control insa_position" name="position"id="insa_position" value="${p.position }" readonly/> &nbsp;&nbsp;
						<a href="javascript:void(0)" class="insa_position_update" data-toggle="modal" data-target="#positionUpdate" onclick='fn_insaPositionUpdate("${p.position}","${p.position_level }")'>수정</a>
						<span class="spanUpdateDelete">/</span><a href="javascript:void(0)" class="insa_position_update insaPositionDelete" onclick='fn_insaPositionDelete("${p.position}")'>삭제</a>
					</td>
				</tr>
			</c:forEach>
		</c:if>
		</tbody>
	</table>
	<div>
		<input type="button" class="btn btn-outline-secondary" value="저장" onclick="fn_btnSubmit()" id="btnPositionAdd" style="display: none; margin-left: 200px;"/>
	</div>
</form>
</div>
<br /><br /><br />

<!-- 직무테이블 -->
<div class="cont_hidden">
	<h6 class="cont_hidden">직무관리</h6>
	<div class="cont_hidden">
    </div>
    <a href="javascript:void(0)" Id="jobAdd" onclick="fn_jobAdd()">+직무추가</a> &nbsp;&nbsp;
    <a href="javascript:void(0)" Id="jobAdd" onclick="fn_jobUpdate()">+직무수정</a> &nbsp;&nbsp;
    <a href="javascript:void(0)" Id="jobAdd" onclick="fn_jobDelete()">+직무삭제</a> &nbsp;&nbsp;
</div>

<form action="${pageContext.request.contextPath }/insa/insaJobAdd.do" id="jobInsertAdd">
<table class="table" id="insa_job_table" style="width: 400px;">
	<c:if test="${empty jlist}">
		<tr>
			<td colspan="${jlist.size() }" style="text-align: center;">직무가 없습니다.
			</td>
		</tr>
	</c:if>
	<c:if test="${not empty jlist }">
		<tr id="insa_job_tr">
			<c:forEach var="j" items="${jlist}" varStatus="sts">
				<td class="jlist_th_count insa_td" id="jlist_td_count">
					<input type="text" class="form-control insa_job_input" name="job"id="insa_position" value="${j.job}" readonly/> &nbsp;&nbsp;
				</td>
			</c:forEach>
		</tr>
		<%-- <tr id="insa_job_tr">
			<c:forEach var="j" items="${jlist}" varStatus="sts">
				<td class="jlist_th_count insa_td" id="jlist_td_count">
					<a href="javascript:void(0)" class="insa_job_update" data-toggle="modal" data-target="#jobUpdate" onclick='fn_insaJobUpdate("${j.job}")'>수정</a>
					<span class="spanUpdateDelete">/</span><a href="javascript:void(0)" class="insa_job_update insaJobDelete" onclick='fn_insaJobDelete("${j.job}")'>삭제</a>
				</td>
			</c:forEach>
		</tr> --%>
	</c:if>
</table>
	<input type="hidden" id="job" name="job" value=""/>
<div>
	<input type="button" id="btn_jobsubmitbutton" class="btn btn-outline-secondary" value="저장" onclick="fn_btnJobSubmit()" style="display:none; margin-left: 200px;"/>
</div>
</form>


<!-- position삭제 모달 -->
<div class="modal fade" id="positionDelete" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalCenterTitle">직위 삭제</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<!-- connectionInsert -->
			<form action="${pageContext.request.contextPath}/insa/positionDeleteModal.do" method="post" id="positionDeleteModal">
				<div class="modal-body">
					<table class="table" style="margin-bottom: 0px;">
						<tr>
							<th colspan="2"><span id="titlePositionTitile"></span>&nbsp;직위</th>
						</tr>
						<tr>
							<td colspan="2">
								<span id="selectPoistionMemberListTitle"></span><br />
								<span id="selectPoistionMemberList" style="font-weight: bold;" ></span> <br />
								<span id="selectPoistionMemberMenu"  style="display: none;">
								이 직위를 삭제하면 등급 내 직위가 없어지므로,
								아래 등급이 한 등급씩 위로 이동합니다.
								삭제 후 저장 버튼을 클릭하면 변경 내용이 적용됩니다.
								</span>
							</td>
						</tr>
						<tr>
							<td>
								<select name="selectposition" id="selectposition" class="custom-select" style="width: 150px; display: none;">
									<option value="변경 직위" disabled>변경 직위</option>
									<c:forEach var="p" items="${plist}">
										<c:if test="true">
											<option class="positionOption"value="${p.position}">${p.position}</option>
										</c:if>
									</c:forEach>
								</select>
								<input type="hidden" name="userId" id="insauserId" value=""/>
								<input type="hidden" name="com_no" id="insacom_no" value="${member.com_no}"/>
								<input type="hidden" name="s_position" id="s_position" value=""/>
							</td>
						</tr>
					</table>
				</div>
			<div class="modal-footer">
				<button type="reset" class="btn btn-secondary" data-dismiss="modal">닫기</button>
				<button type="reset" class="btn btn-primary" onclick="fn_btninsaDelte()">삭제</button>
			</div>
			</form>
		</div>
	</div>
</div>

<!-- position 업데이트 모달 -->
<div class="modal fade" id="positionUpdate" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalCenterTitle">직위 수정</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<!-- connectionInsert -->
			<form action="${pageContext.request.contextPath}/insa/updatePositionModal.do" method="post"  id="updateModal">
				<div class="modal-body">
					<table class="table" style="margin-bottom: 0px;">
						<tr>
							<th>기존 값</th>
							<td>
								<input type="text" class="form-control insa_position" id="insa_position_select"  readonly/>
							</td>
						</tr>
						<tr>
							<th>수정 값</th>
							<td>
								<input type="text" class="form-control insa_position" name="position" id="insa_position_update"  />
								<input type="hidden" name="comNo" value="${member.com_no}" />
								<input type="hidden" name="level" id="positionLevel" value="" />
								<span class="guide ok"> 사용가능합니다.</span>
								<span class="guide error">사용할 수 없습니다.</span>
								<input type="hidden" id="idDuplicateCheck" value="0" />
							</td>
						</tr>
					</table>
				</div>
			<div class="modal-footer">
				<button type="reset" class="btn btn-secondary" data-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-primary" onclick="fn_btninsaUpdate()">수정</button>
			</div>
			</form>
		</div>
	</div>
</div>

<!-- job삭제 모달 -->
<div class="modal fade" id="jobDelete" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalCenterTitle">직무 삭제</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<!-- connectionInsert -->
			<form action="${pageContext.request.contextPath}/insa/jobDeleteModal.do" method="post" id="jobDeleteModal">
				<div class="modal-body">
					<table class="table" style="margin-bottom: 0px;">
						<tr>
							<th colspan="2"><span id="titleJobTitile"></span>&nbsp;직무</th>
						</tr>
						<tr>
							<td style=" text-align: center;">
								<select name="selectjob" id="selectjob" class="custom-select" style="width: 150px;">
									<option value="삭제 직무" disabled selected>삭제 직무</option>
									<c:forEach var="j" items="${jlist}">
										<c:if test="true">
											<option class="positionOption" value="${j.job}">${j.job}</option>
										</c:if>
									</c:forEach>
								</select>
								<input type="hidden" name="com_no" id="insacom_no" value="${member.com_no}"/>
								<input type="hidden" name="job" id="insa_job_delete" value=""/>
							</td>
						</tr>
						<tr class="insaJobDeleteUpdate" style="display: none;">
							<td>기존 멤버에 해당하는 직무를 변경해주세요.</td>
						</tr>	
						<tr class="insaJobDeleteUpdate" style="display: none;">
							<th colspan="2"><span id="titleJobTitile"></span>&nbsp;변경 직무</th>
						</tr>
						<tr>
							<td class="insaJobDeleteUpdate" style="display: none; text-align: center;">
								<div id="insaJobDeleteUpdateSelect">
								
								</div>
							</td>
<%-- 							<td class="insaJobDeleteUpdate" style="display: none; text-align: center;" id="insaJobDeleteUpdateSelect">
								<select name="updatejob" id="deleteupdatejob" class="custom-select" style="width: 150px;">
									<option value="변경 직무" disabled selected>변경 직무</option>
									<c:forEach var="j" items="${jlist}">
										<c:if test="true">
											<option class="positionOption"value="${j.job}">${j.job}</option>
										</c:if>
									</c:forEach>
								</select>
							</td> --%>
						</tr>
					</table>
				</div>
			<div class="modal-footer">
				<button type="reset" class="btn btn-secondary" data-dismiss="modal">닫기</button>
				<button type="reset" class="btn btn-primary" onclick="fn_btnJobinsaDelte()">삭제</button>
			</div>
			</form>
		</div>
	</div>
</div>

<!-- job 업데이트 모달 -->
<div class="modal fade" id="jobUpdate" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalCenterTitle">직무 수정</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<!-- connectionInsert -->
			<form action="${pageContext.request.contextPath}/insa/updateJobModal.do" method="post"  id="updateJobModal">
				<div class="modal-body">
					<table class="table" style="margin-bottom: 0px;">
						<tr>
							<th>수정 직무</th>
							<td>
								<select name="selectjob" id="selectjobUpdate" class="custom-select" style="width: 150px;">
									<option value="수정 직무" disabled>수정 직무</option>
									<c:forEach var="j" items="${jlist}">
										<c:if test="true">
											<option class="positionOption"value="${j.job}">${j.job}</option>
										</c:if>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<th>수정 값</th>
							<td>
								<input type="text" class="form-control insa_position" name="job" id="insa_job_update"  />
								<input type="hidden" name="comNo" value="${member.com_no}" />
							</td>
						</tr>
					</table>
				</div>
			<div class="modal-footer">
				<button type="reset" class="btn btn-secondary" data-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-primary" onclick="fn_btnJobinsaUpdate()">수정</button>
			</div>
			</form>
		</div>
	</div>
</div>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>