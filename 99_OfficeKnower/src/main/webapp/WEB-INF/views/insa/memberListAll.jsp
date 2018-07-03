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
	<jsp:param value="직원 목록" name="selectMenu"/>
</jsp:include>
<style>
.groupBox {width: 100%;overflow: hidden; padding: 30px 0 0 0; min-height: 60px;}
.groupBox .team {float: left; width: 200px;  padding-right: 20px;}
.groupBox .people { padding: 0 0 0 220px;   width: 100%;}
.insaimg{
    width: 75px;
    height: 75px;
    overflow: hidden;
    cursor: pointer;
}
.groupBox .people li p {
    text-overflow: ellipsis;
    overflow: hidden;
    -webkit-line-clamp: 2;
    word-wrap: break-word;
    display: -webkit-box;
    -webkit-box-orient: vertical;
    height: 36px;
}
.groupBox .people li {
    position: relative;
    display: inline-block;
    padding-bottom: 20px;
    width: 75px;
    margin-right: 20px;
    text-align: center;
}
dl, li, menu, ol, ul {
    list-style: none;
}
div.profile{
display: block;}
p.name {
    display: block;
    -webkit-margin-before: 1em;
    -webkit-margin-after: 1em;
    -webkit-margin-start: 0px;
    -webkit-margin-end: 0px;
}

.layer_box .title_layer {
    padding-bottom: 21px;
    font-size: 16px;
    margin-top: 80%;
}
.layer_box .userView.insa-layer {
    overflow: auto;
    max-height: 480px;
}
.img2{
    width: 130px;
    height: 130px;
    border-radius: 50%;
    float: left;
    margin-left: 30px;
    border: 1px solid;
    cursor: default;
}
dl dd {
    margin: 0 0 0 100px;
    padding-bottom: 16px;
    min-height: 20px;
}
dd {
    display: block;
    -webkit-margin-start: 40px;
}
.insa-layer .btn_upload {
    display: inline-block;
    position: absolute;
    top: -42px;
    left: -26px;
    width: 24px;
    height: 24px;
    background: url(${pageContext.request.contextPath}/resources/images/profile/camera.png);
    margin-left:170px;
    margin-top: 40px;
    cursor: pointer;
    display: none;
}
div#insamenu_container{
	position: absolute;
	width: 140px; 
	padding: 20px 25px;
	left: 40px;
	top: 35px;
	border: 1px solid #ccc;
	background: white;
	display: inline-block;
}
div.insagroupBox{
	position: relative;
	margin-top: 60px;
	margin-left: 0px;
	margin-right: 0px;
	padding-left: 0px;
	padding-right: 0px;
	/* height: -webkit-fill-available; */
}
.insa_span_menu{width: 100%; height: 20px; cursor: pointer;}
.insa_span_menu:hover {
	background: #ccc;
}
.people_p_add{display: inline; opacity: 0}
.people_insatitle{float: left;}
</style>
<script>
function fn_profile(userId,userName,position,job, join, com, cell,photo){
	$(".insa-layer-name").text(userName);
	$(".insa-layer-position").text(position +" / " + job);
	$(".insa-layer-date").text(join);
	$(".insa-layer-com").text(com);
	$(".insa-layer-cell").text(cell);
	$("#insa_info_layer").css('display','block');
	$(".groupBox").css('display','none');
	
	if(userId =='<%= ((Member)request.getSession().getAttribute("memberLoggedIn")).getUserId()%>'){
		$(".btn_upload").css('display','block');
		$("#savebuttonDiv").css('display','block');
		$('.img2').attr('src', '${pageContext.request.contextPath }/resources/upload/member/'+photo);
	}else{
		$("#savebuttonDiv").css('display','none');
		$(".btn_upload").css('display','none');
		$('.img2').attr('src', "${pageContext.request.contextPath }/resources/upload/member/"+photo);
	}
}
function fn_close(){
	$("#insa_info_layer").css('display','none');	
	$(".groupBox").css('display','block');	
}
function fn_addProfile(){
	$("#photoUpload").trigger('click');
}
function LoadImg(value) {
    if(value.files && value.files[0]) {
         var reader = new FileReader();
         reader.onload = function (e) {
              $('.img2').attr('src', e.target.result);
         }
         reader.readAsDataURL(value.files[0]);
    }
}
function fn_profilePhoto(){
	var val =$('#photoUpload').val().length;
	if(val > 0){
		$('#file_form').submit();		
	}
}
$(function(){
	$("#insamenu_icon").click(function(){
		$("#insamenu_container").toggle();		
	});
	$(".insa_span_menu.insa_default").click(function(){
		$(".yearpeople").hide();
		$(".positionpeople").hide();
		$(".defaultpeople").show();
	});
	$(".insa_span_menu.insa_year").click(function(){
		$(".yearpeople").show();
		$(".defaultpeople").hide();
		$(".positionpeople").hide();
	});
	$(".insa_span_menu.insa_position").click(function(){
		$(".yearpeople").hide();
		$(".defaultpeople").hide();
		$(".positionpeople").show();
	});
	$(".insa_span_menu.insa-photo").click(function(){
		$(".insaimg").show();
	});
	$(".insa_span_menu.insa-onlyname").click(function(){
		$(".insaimg").hide();
	});
});
</script>

<div class="groupBox">
	<div class="insagroupBox">
		<div id="insamenu_icon">
			<span aria-hidden="true" class="icon-block-menu" style="font-size: 25px; color: lightgray; margin-left: 100px; cursor: pointer;"></span>
			<div id="insamenu_container" class="header_container" style="display: none;">
				<p style="font-weight: bold; font-size: 20px;">정렬</p>
				<p class="insa_span_menu insa_default">조직</p>
				<p class="insa_span_menu insa_year">입사년도</p> 
				<p class="insa_span_menu insa_position">직위</p>
				<hr />
				<p style="font-weight: bold; font-size: 20px;">옵션</p> 
				<p class="insa_span_menu insa-photo">사진표시</p> 
				<p class="insa_span_menu insa-onlyname">이름만표시</p>
			</div>
		</div>
	</div>
	<hr /><br /><br />
	
	<div class="groupBox team">
		${list.get(0).getCom_name()}[${list.size()}명] 
	</div>
	<div class="people defaultpeople" style="display: inline-block;">
	<ul>
		<c:forEach var="l" items="${list}" >
			<li>
				<img class="insaimg" src="${pageContext.request.contextPath }/resources/upload/member/${l.getPhoto()}" onerror="this.src='${pageContext.request.contextPath }/resources/upload/member/default.jpg'" onclick="fn_profile('${l.getUserId()}','${l.getUserName()}','${l.getPosition()}','${l.getJob()}','${l.getJoinDate()}','${l.getPhone_com()}','${l.getPhone_cell()}','${l.getPhoto()}')"/>
				<p class="name">${l.getUserName()}</p>
			</li>
		</c:forEach>
	</ul>
	</div>
	<!-- 입사년도 -->
	<div class="people yearpeople" style="display: none;">
					<ul>
			<c:forEach var="y" items="${yearList}" varStatus="sts">
				<c:forEach var="l" items="${list}" varStatus="sts2">
					<c:if test="${sts2.count == 1}">
						<p class="people_insatitle">${y}</p><br />
						<hr />
					</c:if>
					<c:set var="yea" value="${l.getJoinDate()!=null?l.getJoinDate():'미기재 '}"/>	
					<c:set var="year" value="${fn:substring(yea,0,4)}"/> 
						<c:if test='${y eq (year != null?year:"미기재 ")}'>
						<li>
							<img class="insaimg" src="${pageContext.request.contextPath }/resources/upload/member/${l.getPhoto()}" onerror="this.src='${pageContext.request.contextPath }/resources/upload/member/default.jpg'" onclick="fn_profile('${l.getUserId()}','${l.getUserName()}','${l.getPosition()}','${l.getJob()}','${l.getJoinDate()}','${l.getPhone_com()}','${l.getPhone_cell()}','${l.getPhoto()}')"/>
							<p class="name">${l.getUserName()}</p>
						</li>
						</c:if>
					<c:if test="${sts2.count == list.size()}">
						<p  class="people_p_add">asd</p><p style="opacity: 0; height: 0px;">asd</p>
						<br /><br /><br /><br /><br /><br />
					</c:if>
				</c:forEach>
			</c:forEach>
					</ul>
		<!-- </ul> -->
	</div>
	<!-- 직위 -->
	<div class="people positionpeople" style="display: none;">	
						<ul>
	<c:forEach var="p" items="${positionList}" varStatus="sts">
				<c:forEach var="l" items="${list}" varStatus="sts2">
					<c:set var="po" value="${l.getPosition()}"/>
					<c:if test="${sts2.count == 1}">
						<p class="people_insatitle">${p}</p><br />
						<hr />
					</c:if>
					<c:if test='${p eq (year != null?po:"미기재")}'>
						<li>
							<img class="insaimg" src="${pageContext.request.contextPath }/resources/upload/member/${l.getPhoto()}" onerror="this.src='${pageContext.request.contextPath }/resources/upload/member/default.jpg'" onclick="fn_profile('${l.getUserId()}','${l.getUserName()}','${l.getPosition()}','${l.getJob()}','${l.getJoinDate()}','${l.getPhone_com()}','${l.getPhone_cell()}','${l.getPhoto()}')"/>
							<p class="name">${l.getUserName()}</p>
						</li>
					</c:if>
					<c:if test="${sts2.count == list.size()}">
						<p class="people_p_add">asd</p><p style="opacity: 0; height: 0px;">asd</p>
						<br /><br /><br /><br /><br /><br />
					</c:if>
				</c:forEach>
			</c:forEach>
						</ul>
	</div>
	
</div>

<!-- 프로필 상자 -->
<div class="layer_box mid_large hide" id="insa_info_layer" style="margin-left: 10%; margin-top: -20%; display: none; width: 500px;">
	<div class="title_layer text_variables" style="font-size: 20px; color: black; border-color; border-top: 1px solid; border-left:1px solid; border-right:1px solid;"><span style="color: blue;">직원 정보</span></div>
	<button style="float: right; margin-top: -45px; margin-right: 10px;" onclick="fn_close()">X</button>
	<div class="userView insa-layer" style="border-bottom:1px solid; border-left:1px solid;border-right:1px solid; position: relative;">
		<span class="btn_upload" onclick="fn_addProfile()"></span>
		
		<div class="profile">
		<div style="cursor:pointer">
			<img class="img2" src="${pageContext.request.contextPath }/resources/upload/member/${l.getPhoto()}" onerror="this.src='${pageContext.request.contextPath }/resources/upload/member/default.jpg'" style="background-size: 200px;"/>
			</div>
		<div class="proflie_right">
			<dl style="margin-left: 150px;">
				<dd class="insa-layer-name"></dd>
				<dd>
					${list.get(0).getCom_name()}<br>
				</dd>
				<dd class="insa-layer-position">
				</dd>
			</dl>
		</div>
		</div>
			<dl class="gon" style="margin-left: 20px; margin-top: 20px;">
				<dt><span class="text">입사일</span></dt>
				<dd><span class="text insa-layer-date">2018-05-21</span></dd>
				<dt><span class="text">사내전화</span></dt>
				<dd><span class="text insa-layer-com"></span></dd>
				<dt><span class="text">휴대전화</span></dt>
				<dd><span class="text insa-layer-cell"></span></dd>
			</dl>
		<form action="profileUpdate.do" id="file_form" method="post" enctype="multipart/form-data">
			<input type="file" name="photoUpload" id="photoUpload"  style="opacity: 0; position: relative;" onchange="LoadImg(this);" value=""/><br />
			<div id="savebuttonDiv" style="position: relative;left: 200px;width: 201px;bottom: 40px; display: none; ">
				<input type="button" value="저장" class="btn btn-outline-primary" style="text-align: center;" onclick=" fn_profilePhoto()"/> &nbsp;
				<input type="button" value="취소"  onclick="fn_close()" class="btn btn-outline-primary"/>
			</div>
		</form>
	</div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>