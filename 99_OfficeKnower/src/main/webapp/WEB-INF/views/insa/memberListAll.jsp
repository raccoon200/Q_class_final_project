<%@page import="com.kh.ok.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name="pageTitle"/>
</jsp:include>
<style>
.groupBox {width: 100%;overflow: hidden; padding: 30px 0 0 0; min-height: 60px;}
.groupBox .team {float: left; width: 200px;  padding-right: 20px;}
.groupBox .people { margin: 0 0 0 220px;   width: 819px;}
.groupBox .people li .img {
    width: 75px;
    height: 75px;
    overflow: hidden;
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
    float: left;
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
    top: 3px;
    left: 83px;
    width: 24px;
    height: 24px;
    background: url(${pageContext.request.contextPath}/resources/images/profile/camera.png);
    margin-left:170px;
    margin-top: 40px;
    cursor: pointer;
    display: none;
}
</style>
<script>
function fn_profile(userId,userName,position,job, join, com, cell){
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
	}else{
		$("#savebuttonDiv").css('display','none');
		$(".btn_upload").css('display','none');
		$('.img2').attr('src', '${pageContext.request.contextPath }/resources/images/profile/${l.getPhoto()}');
		$('.img2').val('');
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
</script>

<div class="groupBox">
	<hr /><br /><br />
	<div class="groupBox team">
		${list.get(0).getCom_name()}[${list.size()}명]
	</div>
	<div class="people">
	<ul>
		<c:forEach var="l" items="${list}" >
			<li>
				<img class="img" src="${pageContext.request.contextPath }/resources/images/profile/${l.getPhoto()}" onerror="this.src='${pageContext.request.contextPath }/resources/images/profile/default.jpg'" onclick="fn_profile('${l.getUserId()}','${l.getUserName()}','${l.getPosition()}','${l.getJob()}','${l.getJoinDate()}','${l.getPhone_com()}','${l.getPhone_cell()}')"/>
				<p class="name">${l.getUserName()}</p>
			</li>
		</c:forEach>
	</ul>
	</div>
</div>

<!-- 프로필 상자 -->
<div class="layer_box mid_large hide" id="insa_info_layer" style="margin-left: 10%; margin-top: -20%; display: none; width: 500px;">
	
	<div class="title_layer text_variables" style="font-size: 20px; color: black; border-color; border-top: 1px solid; border-left:1px solid; border-right:1px solid;"><span style="color: blue;">직원 정보</span></div>
	<button style="float: right; margin-top: -45px; margin-right: 10px;" onclick="fn_close()">X</button>
	<div class="userView insa-layer" style="border-bottom:1px solid; border-left:1px solid;border-right:1px solid;">
		<span class="btn_upload" onclick="fn_addProfile()"></span>
		
		<div class="profile">
			<img class="img2" src="${pageContext.request.contextPath }/resources/images/profile/${l.getPhoto()}" onerror="this.src='${pageContext.request.contextPath }/resources/images/profile/default.jpg'" style="background-size: 200px;"/>
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
		
		<input type="file" name="" id="photoUpload"  style="opacity: 0; position: relative;" onchange="LoadImg(this);"/><br />
		<div id="savebuttonDiv" style="position: relative;left: 200px;width: 201px;bottom: 40px; display: none;">
			<input type="button" value="저장" class="btn btn-outline-primary" style="text-align: center;"/> &nbsp;
			<input type="button" value="취소" class="btn btn-outline-primary"/>
		</div>
	</div>
</div>


<%-- <div class="layer_box" style="margin-left: 10%; margin-top: -20%; background: pink; width: 70%;">
<div class="title_layer text_variables">직원 정보</div>
<div class="userView insa-layer">
		<div class="profile">
			<img src="${pageContext.request.contextPath }/resources/images/profile/${l.getPhoto()}" onerror="this.src='${pageContext.request.contextPath }/resources/images/profile/default.jpg'"/>
					</div>
		<div class="proflie_right">
			<dl>
				<dd class="insa-layer-name">김희운</dd>
				<dd>
					<br>
				</dd>
				<dd>
				</dd>
			</dl>
		</div>
				<dl class="gon">
			<dt><span class="text">입사일</span></dt>
			<dd><span class="text">2018-05-21</span></dd>
						<dt>사내 전화</dt>
			<dd></dd>
						<dt><span class="text">휴대전화</span></dt>
			<dd><span class="text"></span></dd>
																				</dl>
			</div>
</div> --%>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>