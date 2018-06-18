<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name="pageTitle"/>
</jsp:include>
<style>
.groupBox {width: 80%;overflow: hidden; padding: 30px 0 0 0; min-height: 60px;}
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
    height: auto;
    border-radius: 50%;
    float: left;
    margin-left: 30px;
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
</style>

<div class="groupBox">
	<hr /><br /><br />
	<div class="groupBox team">
		${list.get(0).getCom_name()}[${list.size()}명]
	</div>
	<div class="people">
	<ul>
		<c:forEach var="l" items="${list}" >
			<li>
				<img class="img" src="${pageContext.request.contextPath }/resources/images/profile/${l.getPhoto()}" onerror="this.src='${pageContext.request.contextPath }/resources/images/profile/default.jpg'" onclick="fn_profile('${l.getUserName()}','${l.getPosition()}','${l.getJob()}','${l.getJoinDate()}','${l.getPhone_com()}','${l.getPhone_cell()}')"/>
				<p class="name">${l.getUserName()}</p>
			</li>
		</c:forEach>
	</ul>
	</div>
</div>

<!-- 프로필 상자 -->
<div class="layer_box mid_large hide" id="insa_info_layer" style="margin-left: 10%; margin-top: -20%; background: pink; display: none; width: 500px;">
	<div class="title_layer text_variables" style="font-size: 20px; color: blue;">직원 정보</div>
	<button style="float: right; margin-top: -45px;" onclick="fn_close()">X</button>
	<div class="userView insa-layer">
		<div class="profile">
			<img class="img2" src="${pageContext.request.contextPath }/resources/images/profile/${l.getPhoto()}" onerror="this.src='${pageContext.request.contextPath }/resources/images/profile/default.jpg'"/>
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
	</div>
</div>

<script>
function fn_profile(userName,position,job, join, com, cell){
	$(".insa-layer-name").text(userName);
	$(".insa-layer-position").text(position +" / " + job);
	$(".insa-layer-date").text(join);
	$(".insa-layer-com").text(com);
	$(".insa-layer-cell").text(cell);
	$("#insa_info_layer").css('display','block');
	$(".groupBox").css('display','none');
}
function fn_close(){
	$("#insa_info_layer").css('display','none');	
	$(".groupBox").css('display','block');	
}
</script>
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