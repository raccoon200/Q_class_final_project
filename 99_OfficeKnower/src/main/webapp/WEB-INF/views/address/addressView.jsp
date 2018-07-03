<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.kh.ok.address.model.vo.*, java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!doctype html>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="주소록" name="pageTitle"/>
</jsp:include>

<jsp:include page="/WEB-INF/views/common/nav.jsp">
	<jsp:param value="주소록" name="pageTitle"/>
</jsp:include>

<html lang="ko">
<head>

	<meta charset="utf-8">
	<meta http-equiv="content-type" content="text/html; charset=utf-8">
	<meta http-equiv="Content-Script-Type" content="text/javascript" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
				<title>OK</title>
	<meta name="viewport" content="width=1024"/>
	<link rel="shortcut icon" type="image/x-icon" href="/static/images/favicon/favicon.ico">
	<link rel="stylesheet" type="text/css" href="/static/ui/css/style.css">
	<link rel="stylesheet" type="text/css" href="/static/css/jquery/jquery.toastmessage-min.css">
	
	 
	
	<style type="text/css">
		#alphaDiv {
			background-color: #4e515e;
			border: 0 none;
			display: none;
			float: left;
			height: 0;
			left: 0;
			position: absolute;
			top: 0;
			width: 0;
			z-index: 20;
		}
		#progressDiv {
			display: inline;
			left: 49%;
			position: absolute;
			top: 40%;
			z-index: 999;
		}
		#popupBaseA {
			background-color: #ffffff;
			border: 7px solid #0e84e4;
			overflow: visible;
			position: absolute;
			width: auto;
			z-index: 999999;
		}
	</style>

	<script src="../resources/static/scripts/language.js" type="text/javascript"></script>
	<script src="../resources/static/scripts/Sly.js" type="text/javascript"></script>
	<script src="../resources/static/scripts/common_new.js" type="text/javascript"></script>
		<script src="../resources/static/scripts/jquery-1.7.1.min.js" type="text/javascript"></script>
		<!-- <script src="/static/scripts/jquery-1.11.2.min.js?v=27283" type="text/javascript"></script> -->
	<script src="../resources/static/scripts/jcommon.js" type="text/javascript"></script>
	<script src="../resources/static/scripts/jvalidateMessage.js" type="text/javascript"></script>
	<script src="../resources/static/scripts/jorgtree.js" type="text/javascript"></script>
	<script src="../resources/static/scripts/jaddressbook.js" type="text/javascript"></script>
	<script src="../resources/static/scripts/jajaxBasic.js" type="text/javascript"></script>
		<script src="../resources/static/scripts/jquery/jquery.toastmessage.js" type="text/javascript"></script>
	<!-- Frontend devteam -->

	<!-- <script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js?v=27283"></script> -->
	<script src="../resources/static/scripts/jquery-ui-1.11.4/jquery-ui.min.js" type="text/javascript"></script>
	<script src="../resources/static/ui/js/main.js"></script>
		

		<script src="../../static/scripts/addr/addrNewCommon.js" type="text/javascript"></script>
	<script src="../../static/scripts/AngularJS/file-upload/ng-file-upload-shim.min.js" type="text/javascript"></script>
	<script src="../../static/scripts/AngularJS/angular_1.2.28.js" type="text/javascript"></script>
	<script src="../../static/scripts/AngularJS/file-upload/ng-file-upload.js" type="text/javascript"></script>
	<script src="../../static/scripts/addr/angularjsFactory.js" type="text/javascript"></script>
	<script src="../../static/scripts/addr/angularjsAddressCtrl.js" type="text/javascript"></script>
	<script src="../../static/scripts/AngularJS/hiworks/ngPage/pagination_factory.js" type="text/javascript"></script>
	
	<script type="text/javascript">
		jQuery(document).ready(function () {
		if( window != window.parent ){
			jQuery('#user_info_box').hide();
			jQuery('#topMenuBtnIcon').hide();
			jQuery('#topMenuBtn').unbind("click");
			jQuery('#topMenuBtn').css("cursor", "default");
			jQuery('#logo_anchor').attr("href", "javascript:void(0);");
			jQuery('#logo_anchor').css("cursor", "default");
			}
		});
		</script>
</head>

<body>


<script>
	if( navigator.userAgent.indexOf('Firefox') >= 0 ) {
		var eventNames = ["mousedown", "mouseover", "mouseout", 
									"mousemove", "mousedrag", "click", "dblclick",
									"keydown", "keypress", "keyup" ]; 
			
		for( var i = 0 ; i < eventNames.length; i++ ) {
			window.addEventListener( eventNames[i], function(e) {
				window.event = e;
			}, true );
		}	
	}
	$(function(){
		$('#addressAdd').on('!!!shown.bs.modal', function (e) {
			console.log("123");
		    if ($('#calendarView').hasClass('show')){
		        $(this).hide();
		        $("#calendarView").focus();
		        $(this).modal("hide");
		    }
		});
	});
	


	$j(document).ready(function(){
		var addr_search_menu_index = 0 ;

		$j( "#txtSearch" ).keydown(function() {
			if (event.keyCode == '13') {		// enter
				var search_type_flag = "all";
				if(addr_search_menu_index == 0){search_type_flag = "all";	}
				else if (addr_search_menu_index == 1){search_type_flag = "name";}
				else if (addr_search_menu_index == 2){search_type_flag = "email";}
				else if (addr_search_menu_index == 3){	search_type_flag = "phone";	}
				else if (addr_search_menu_index == 4){	search_type_flag = "company";	}
				AddrNewCommon.generateHashUrlSubmit($j(this).val() , search_type_flag)
			}

			if($j(this).val() != '' && (event.keyCode == '38' || event.keyCode == '40' )){	// 40 아래 , 38 위
				$j("#txtSearch")[0].value = $j("#txtSearch")[0].value + '' ;
				if(event.keyCode == '40'){	// 아래
					
					if(addr_search_menu_index != 4 )
						addr_search_menu_index++;

				}else if (event.keyCode == '38'){	// 위
					if(addr_search_menu_index != 0 )
						addr_search_menu_index--;
				}
				$j('#txtSearch_div li').css('background','#ffffff')
				$j('#txtSearch_div li').eq(addr_search_menu_index).css('background','#e8ecee')
			}

			if($j(this).val().length !=0 ){
				$j('#txtSearch_div').addClass('show')
				$j(".seach_text").text($j(this).val())
				$j('#txtSearch_div li').eq(addr_search_menu_index).css('background','#e8ecee')
			}else{	
				$j('#txtSearch_div').removeClass('show')
				addr_search_menu_index = 0;
				$j('#txtSearch_div li').css('background','#ffffff')
			}
		});

		$j( "#txtSearch" ).keyup(function() {
			if(event.keyCode != '13' &&  event.keyCode != '38' && event.keyCode != '40' ){
				if($j(this).val().length !=0 ){
					$j('#txtSearch_div').addClass('show')
					$j(".seach_text").text($j(this).val())
					$j('#txtSearch_div li').eq(addr_search_menu_index).css('background','#e8ecee')
				}else{	
					$j('#txtSearch_div').removeClass('show')
					addr_search_menu_index = 0;
					$j('#txtSearch_div li').css('background','#ffffff')
				}
			}
		})

		$j('.search_category').click(function(){
			AddrNewCommon.generateHashUrlSubmit( $j(this).find('span').text() , $j(this).attr('value') );
		});
	});

</script>

<a href="javascript:void(0)" class="search_bt hide" id="search_reset" onclick="AddrNewCommon.reset_search_word();" ><span class="sp_menu searchCancel"></span>검색 취소</a>

<div class="mail_search">
	<div class="search">
			<fieldset>
				<input type="text" id="txtSearch" autocomplete="off"  maxlength='30' name='txtSearch' value="" placeholder="주소 검색" onfocus="" onblur=""  >
				<a href="javascript:void(0)" class="btn_search" ><span class="icon src" onclick='AddrNewCommon.generateHashUrlSubmit( $j( "#txtSearch" ).val(), "all") ' ><em class="blind">검색</em></span></a>
			</fieldset>
	</div>
	<div  id="txtSearch_div"  class="dropdown hide" >
		<ul class="dropdown-menu" style="min-width:298px">
			<li><a href="javascript:void(0)" class="search_category" value='all'>전체 : <span class="seach_text emphasize bold"></span></a></li>
			<li><a href="javascript:void(0)" class="search_category" value='name'>이름 : <span class="seach_text emphasize bold"></span></a></li>
			<li><a href="javascript:void(0)" class="search_category" value='email'>이메일 : <span class="seach_text emphasize bold"></span></a></li>
			<li><a href="javascript:void(0)" class="search_category" value='phone'>전화번호 : <span class="seach_text emphasize bold"></span></a></li>
			<li><a href="javascript:void(0)" class="search_category" value='company'>회사 : <span class="seach_text emphasize bold"></span></a></li>
		</ul>
	</div>
</div>


						<div id="contents" >
			<div ng-app="AddrCombineApp" ng-controller="AddrCombineCtrl">
	<div class="content_title">
		<form>
			<fieldset>
				<span class="detail_select">
					<input type="checkbox" id="allList"  ng-click="Useable.checkBoxAllCkFnc(AddrList , 'allList'); checkBoxCntFnc();" />
					<span class='extra_menu hide' ng-bind="checkedCnt"></span>
					<span id='main_menu' >
						<span class='popup_class '  ng-click="hideMenuTab('AnSnT')" style="cursor: pointer;">보기: </span>
						<span  class='popup_class ' ng-bind="viewAnSnT" ng-click="hideMenuTab('AnSnT')" style="cursor: pointer;"></span>
						<img src="..\static\ui\images\btn_drop.gif" alt="모두보기" class="popup_class" ng-click="hideMenuTab('AnSnT')" style="cursor: pointer;">

						<div id='AnSnT' class="popup_class dropdown hide">
							<ul class="dropdown-menu">
								<li>
									<a href=""   ng-click="getAnSnT('star_n')">모두</a>
								</li>
								<li>
									<a href="" ng-click="getAnSnT('star_y')">별 표시</a>
								</li>

								<li class="divider tag_class"></li>
								<li class="dropdown-header tag_class">태그</li> 
								<li class="tag_class" style ="overflow-y: auto;overflow-x: hidden;max-height: 150px;">
									<a href='' ng-repeat="TAG in tag_list"  ng-click="getAnSnT(TAG.no)" value='{{TAG.no}}'>{{TAG.name}} (<span>{{TAG.tagCnt}}</span>)</a>
								</li>
							</ul>
						</div>
					</span>
				</span>

				<div  class='extra_menu hide'>
					<span class="detail_select">
						<a href="" ng-click='deleteSelected()'>삭제</a>
					</span>
					<span class="detail_select">
						<a href="" class='popup_class' ng-click="hideMenuTab('insertTagPopUp')">태그 붙이기<img src="../static/ui/images/btn_drop.gif" alt="태그 붙이기 드롭다운 메뉴 열기" class="open_drop" ></a>
																											<!--resources\static\ui\images\btn_drop.gif  -->
						
						<!--dropdown-->
						<div id='insertTagPopUp' class="dropscroll-menu dropdown popup_class hide">
							<ul class="popup_class" style="min-width:219px; max-height: 150px; overflow-y: auto; overflow-x: hidden;">
								<li ng-repeat="TAG in tag_list" ng-if="TAG.no != 'notag'"><a href="" class='popup_class ' ng-click='insertTagSubmit(TAG)' ng-bind="TAG.name"></a></li>
							</ul>
							<div class="popup_class cont_hidden">
								<input type="text" class="popup_class"  id='insertTagInput'  style="width:130px" class="fl"> <button class="point_color fr popup_class" ng-click="insertTagOnly()">추가</button>
							</div>
							<div class=" popup_classcont_hidden">
								<button  class="fl point_color" ng-click='removeAddrTags()' >태그 제거</button> <a href="" class="fr"><span class="point_color" ng-click="showTagManageView()">관리</span></a>
							</div>
						</div>
						<!--//dropdown-->
					</span>
										<span class="detail_select"><a href="" ng-click="sendSmsSelected()">문자 보내기</a>	</span>
					<span class="detail_select">
						<a href="" class='popup_class' ng-click="hideMenuTab('anotherCommendPopUp')">다른 작업<img src="../static/ui/images/btn_drop.gif" alt="다른작업 드롭다운 메뉴 열기" class="open_drop"></a>
							<!--dropdown-->
							<div id='anotherCommendPopUp' class="popup_class dropdown hide">
								<ul class="popup_class dropdown-menu " style="left:0;">
									<li><a href="" class='all_star_y' ng-click="MultiStarCheck()">별 표시</a></li>
									<li><a href=""  ng-click="MultiStarCheck()">별 제거</a></li> 
																		<li><a href="" class='popup_class' ng-click="copyToSharedAddress()">공유 주소록에 복사</a></li>
																	</ul>
							</div>
							<!--//dropdown-->
					</span>
				</div >
			</fieldset>
		</form>
		<div class="setting_box">
		<a class="icon order popup_class" href="" ng-click="hideMenuTab('orderListPopUp')"></a>
		
		<div  id='orderListPopUp' class="popup_class dropdown hide" style="right: 133px;position: absolute;top: 21px;">
			<ul class="dropdown-menu popup_class">
				<li class="dropdown-header popup_class">정렬</li>

				<li ng-if="orderby == 'name' && order =='asc' "><a href=""  ng-click='orderList("name")' class='active'>이름<span class="orderClass orderN icon up" ></span></a></li>
				<li ng-if="orderby == 'name' && order =='desc' "><a href=""  ng-click='orderList("name")' class='active'>이름<span class="orderClass orderN icon down" ></span></a></li>
				<li ng-if="orderby != 'name'"><a href=""  ng-click='orderList("name")'>이름<span class="orderClass orderN icon absolute_hide" ></span></a></li>

				<li ng-if="orderby == 'company' && order =='asc' "><a href=""  ng-click='orderList("company")' class='active'>회사<span class="orderClass orderN icon up" ></span></a></li>
				<li ng-if="orderby == 'company' && order =='desc' "><a href=""  ng-click='orderList("company")' class='active'>회사<span class="orderClass orderN icon down" ></span></a></li>
				<li ng-if="orderby != 'company'"><a href=""  ng-click='orderList("company")'>회사<span class="orderClass orderC icon absolute_hide" ></span></a></li>
			</ul>
		</div>
		</div>
	</div>

	<div class="cont_top_field">
		<div class="btList">
			<button type="button" class="chosungNomal" value='all'>전체</button>
			<button type="button" class="chosungNomal" value='ㄱ'>ㄱ</button>
			<button type="button" class="chosungNomal" value='ㄴ'>ㄴ</button>
			<button type="button" class="chosungNomal" value='ㄷ'>ㄷ</button>
			<button type="button" class="chosungNomal" value='ㄹ'>ㄹ</button>
			<button type="button" class="chosungNomal" value='ㅁ'>ㅁ</button>
			<button type="button" class="chosungNomal" value='ㅂ'>ㅂ</button>
			<button type="button" class="chosungNomal" value='ㅅ'>ㅅ</button>
			<button type="button" class="chosungNomal" value='ㅇ'>ㅇ</button>
			<button type="button" class="chosungNomal" value='ㅈ'>ㅈ</button>
			<button type="button" class="chosungNomal" value='ㅊ'>ㅊ</button>
			<button type="button" class="chosungNomal" value='ㅋ'>ㅋ</button>
			<button type="button" class="chosungNomal" value='ㅌ'>ㅌ</button>
			<button type="button" class="chosungNomal" value='ㅍ'>ㅍ</button>
			<button type="button" class="chosungNomal" value='ㅎ'>ㅎ</button>
			<button type="button" class="chosungNomal" value='A-Z'>A-Z</button>
			<button type="button" class="chosungNomal" value='0-9'>0-9</button>
		</div>
	</div>

<%-- 	<div class="content_inbox_ct">
		<!-- Contents -->
		<div class="cont_box">
			<form>
				<table class="listbox">
						<colgroup>
							<col width="45">
							<col width="20">
							<col width="20">
							<col width="">
							<col width="">
							<col width="">
							<col width="">
							<col width="">
						</colgroup>
					<tbody >

						<tr ng-repeat="PA in AddrList" >
							<td>								
								<input ng-if="PA.isChecked == 'Y'" id="id_{{$index}}" type="checkbox" checked ng-click ="Useable.checkBoxCkFnc(PA , 'id_'+$index); checkBoxCntFnc();" />
								<input ng-if="PA.isChecked == 'N'"  id="id_{{$index}}" type="checkbox" ng-click ="Useable.checkBoxCkFnc(PA , 'id_'+$index );checkBoxCntFnc();" />
								<label for="checkEmail" class="blind">주소 선택</label>
							</td>
							<td>
								<span ng-if="PA.star == 'Y' && PA.kind == 'P'"  class="sp_menu impt on" ng-click="StarCheck(PA)"></span>
								<span ng-if="PA.star == 'N' && PA.kind == 'P'"  class="sp_menu impt" ng-click="StarCheck(PA)"></span>
								<span ng-if="PA.star == 'Y'  && PA.kind == 'S'" class="sp_menu impt on" ng-click="StarCheckShared(PA)"></span>
								<span ng-if="PA.star == 'N'  && PA.kind == 'S'" class="sp_menu impt" ng-click="StarCheckShared(PA)"></span>
							</td>

							<td>
								<a href="" class="icon impt"><span class="blind">중요 주소 표시</span></a>
							</td>
							<td class="name"><div class="in"><span ng-click= 'showDetailView(PA)' ng-bind="PA.name" style="cursor: pointer;"></span></div></td>
							<td ng-bind="PA.email"></td>
							<td ng-bind="PA.phone"></td>
							<td class="title" ng-bind="PA.company"></td>
							<td class="byte gray" ng-bind="PA.tag"></td>
						</tr>
					</tbody>
				</table>
			</form>
		</div> <!-- cont_box end-->


		<div class="listbottom" style="margin-bottom: 40px;">
			<p class="number">주소 수 : <span ng-bind="AddrCount"></span></p>

			<div class="paginate">
			
				<a href="" id="goFirstPage" ><span class="icon pagenav1"  ng-click="PageFactory.prev_go_1_Page(this);" ></span></a>
				<a href="" class="space"  id="goPrev10Page" ><span class="icon pagenav2" ng-click="PageFactory.prev_interval_Page(this);"></span></a>

				<span ng-repeat="n in  PageFactory.range()" >
					<strong ng-if="n == PageFactory.currentPage"  style='margin-left:10px;cursor: pointer;' ng-click="setPage(n)"  ng-bind="n"></strong>
					<span ng-if="n != PageFactory.currentPage" ng-click="setPage(n)" style="cursor: pointer;margin-left:10px;"  ng-bind="n"></span>
				</span>

				<a href="" title="다음"  id="goNext10Page" ><span class="icon pagenav3" ng-click="PageFactory.next_interval_Page(this)"></span></a>
				<a href="" title="끝" class="space"  id="goLastPage" ><span class="icon pagenav4"  ng-click="PageFactory.next_end_Page(this)"></span></a>			
			</div>

			<div class="page_select ">
				<label for="pageCurrent" class="blind">현재 페이지 선택</label>
				<select id="pageCurrent"  ng-model="selectpage" ng-change='setPage(selectpage)' ng-options="n for n in PageFactory.pageArr"  >
				</select>
					/ 
				<span  ng-bind="PageFactory.totalPage"></span>
			</div>
		</div>
	</div> <!-- content_inbox_ct  end -->


<div id='addressTagManageView'  class="layer_box middle hide popup7">
		<div class="title_layer text_variables">태그 관리</div>
		<div class="approve_scroll" style="height: 215px;">
			<ul>

				<li class="after mgt_5"  ng-repeat="TAG in tag_list" ng-if="TAG.no != 'notag'">
					<div  ng-if="TAG.mode_flag == 'nomal'">
						<div class="fl"  ng-bind="TAG.name"></div>
						<div class="fr">
							<a class="weakblue" href=""  ng-click="rename_tag(TAG, 'modify')"  >수정</a> <span class="grey_bar">|</span>  
							<a class="weakblue" href="" ng-click="removeOneTag(TAG)">삭제</a>
						</div>
					</div>

					<div  ng-if="TAG.mode_flag == 'modify'">
						<div class="fl"><label><input type="text" value="{{TAG.name}}" class="w100"></label></div>
						<div class="fr">
							<a class="weakblue" href="" ng-click="rename_tag_confirm(TAG)">확인</a> <span class="grey_bar">|</span>  
							<a class="weakblue" href=""  ng-click="rename_tag(TAG, 'nomal')">취소</a>
						</div>
					</div>
                </li>

			</ul>
		</div> --%>
		
		<div class="layer_button">
			<button type="button" class="btn_variables" ng-click="hideTagManageView()">닫기</button>
		</div>
		<a href="javascript:void(0)" class="icon btn_closelayer"  ng-click="hideTagManageView()"  title="레이어 닫기"><span class="blind">레이어 닫기</span></a>
	</div>


	<div id='addressDetailView' class="layer_box large hide" >
		<div class="title_layer text_variables">{{DetailData.name}}</div>
		<div class="to-add" style='height: 350px; overflow: auto;'>
			<dl class="after" ng-if="DetailData.email != '' " >
				<dt>이메일</dt>
				<dd><a href="https://com.kh.ok/mail/webmail/m_write/new/address/{{initData.kind}}/{{DetailData.no}}">{{DetailData.email}}</a></dd>
			</dl>
			<dl class="after" ng-repeat="ext_email_one in DetailData.ext_email">
				<dt></dt>
				<dd>{{ext_email_one.email}}</dd>
			</dl>

			<dl class="after" ng-if="DetailData.phone != '' "><dt>전화</dt><dd>{{DetailData.phone}} ({{DetailData.phone_type}})</dd></dl>
			<dl class="after" ng-repeat="ex_phone_one in DetailData.ext_phone"><dt></dt><dd>{{ex_phone_one.phone}} ({{ex_phone_one.type}})</dd></dl>
			<dl class="after" ng-if="DetailData.company != '' "><dt>회사</dt><dd>{{DetailData.company}}</dd></dl>
			<dl class="after" ng-if="DetailData.department != '' "><dt>부서</dt><dd>{{DetailData.department}}</dd></dl>
			<dl class="after" ng-if="DetailData.grade != '' "><dt>직급</dt><dd>{{DetailData.grade}}</dd></dl>
			<dl class="after" ng-if="DetailData.tag != '' "><dt>태그</dt><dd>{{DetailData.tag}}</dd></dl>

			<dl class="after" ng-repeat="ext_address_one in DetailData.ext_address">
				<!--<dt>{{ext_address_one.type}} 주소</dt> -->
				<dt ng-if="$index == 0 ">주소</dt>
				<dt ng-if="$index != 0 "></dt>

				<dd>{{ext_address_one.content}} [{{ext_address_one.type}} 주소] </dd>
			</dl>

			<dl class="after" ng-repeat="ext_website_one in DetailData.ext_website">
				<dt ng-if="$index == 0 ">웹사이트</dt>
				<dt ng-if="$index != 0 "></dt>
				<dd><a href="http://{{ext_website_one.website}}" target="_blank" >{{ext_website_one.website}}</a></dd>
			</dl>
			<dl class="after" ng-repeat="ext_anniversary_one in DetailData.ext_anniversary">
				<dt ng-if="$index == 0 ">기념일</dt>
				<dt ng-if="$index != 0 "></dt>
				<dd>{{ext_anniversary_one.name}} , {{ext_anniversary_one.date_view}}</dd>
			</dl>
			<dl class="after" ng-if="DetailData.memo != '' "><dt>메모</dt><dd>{{DetailData.memo}}</dd></dl>
		</div>
		<div class="layer_button">
			<button type="button"  ng-click="modifyOne(DetailData);">수정</button> 
			<button type="button" ng-click="deleteOne(DetailData);">삭제</button>
		</div>
		<a href="" class="icon btn_closelayer"  ng-click="hideDetailView(DetailData);" ></a>

			<form id='modify_form' action="/addr/main/addr_modify" method="post">
				<input type="hidden" name="no" value=''>
				<input type="hidden" name="type" value='P'>
			</form>
	</div>
	<div id="dimmed" ></div>

	<form name="form_sms" id="form_sms" method="post" action="https://com.kh.ok/sms/sms_main/sms_write">
		<input type="hidden" name="phone_num" value="">
		<input type="hidden" name="phone_name" value="">
	</form>
</div>
<script>
	var initData = {
		"itemsPerPage" : 20,
		"countPerPage" : 20,
		"tag_list" : {"resultCode":"SUCCESS","result":[],"message":"","layerID":""},
		"kind" : 'P',
		"search_word" : '',
		"search_type" : '',
		"viewAnSnT_Txt" : '모두'
	};
	var listOPT = {"countPerPage":"20","itemsPerPage":"20","startPage":1,"order":"asc","orderby":"name","chosung":"all","star":"N","kind":"P","tagNo":"","search_word":"","search_type":""};
	addrCtrlPage_combine(initData , listOPT ); 
</script>		</div>
			</div>
			<div id="dimmed"></div>

	<!-- [D] 자동 로그아웃 안내 레이어 -->
	<div id="dimmed2"></div>
	<style>
	#dimmed2 {display: none;position: fixed;width: 100%;height: 100%;z-index: 2000;background-color: #000;opacity: .3;top: 0;left: 0;margin: 0;padding: 0;}
 	.layer_box.mid_large.auto-logout {width: 480px;z-index: 2010;}
	</style>
</div>
<div id='main_layer_div'>
	
</div>

<div class="layer_box small alarm hide popup1 " style="" id='HWA_MAIN'>
	<p class="text" id='HWA_MSG'  style="padding-top: 10px; padding-left: 30px; padding-right: 30px;"></p>
	<div class="layer_button">
		<button class="btn_variables" type="button" onclick="hidePopup();" id='HWA_MAIN_OK'>확인</button>
	</div>
	<a href="javascript:void(0)" class="icon btn_closelayer" onclick="hidePopup();" title="레이어 닫기"><span class="blind">레이어 닫기</span></a>
</div>


<script type="text/javascript">
jQuery( "#topMenuBtn" ).click(function() {
	if(jQuery("#gnb_layer").html().trim() == ""){
		jQuery.ajax({
			url : Common.getRoot() + "menu/manage_ajax/showMenu",
			data : {},
			type : 'post',
			dataType : 'json',
			async :	true,
			success : function(data){
				if(data.resultCode !== undefined && data.resultCode === RT_LOGOUT){
					console.log("logout");
					Common.showLogout(data);
					return;
				}

				jQuery("#gnb_layer").html(data.result);
				recentCount();
			},
			error : function(){
				return;
			}
		});	
	}else{
		recentCount();
	}
});

recentCount = function()
{
	jQuery.ajax({
		url : Common.getRoot() + "common/menu/recent_count",
		data : {},
		dataType : 'json',
		type : 'post',
		async :	true,
		success : function(data){
			if(data.resultCode !== undefined && data.resultCode === RT_LOGOUT){
				console.log("logout");
				Common.showLogout(data);
				return;
			}

			if(data.mail !== undefined && jQuery('#CNT_BADGE_MAIL_LINK').length > 0){
				jQuery('#CNT_BADGE_MAIL_LINK').css('display', 'block');
				jQuery("#CNT_BADGE_MAIL_LINK").html(data.mail);
				if(data.mail == 0) jQuery("#CNT_BADGE_MAIL_LINK").css("display", "none");
			}

			if(data.ea !== undefined && jQuery('#CNT_BADGE_EA_LINK').length > 0){
				jQuery('#CNT_BADGE_EA_LINK').css('display', 'block');
				jQuery("#CNT_BADGE_EA_LINK").html(data.ea);
				if(data.ea == 0) jQuery("#CNT_BADGE_EA_LINK").css("display", "none");
			}

			if(data.shared !== undefined && jQuery('#CNT_BADGE_SHARED_LINK').length > 0){
				jQuery('#CNT_BADGE_SHARED_LINK').css('display', 'block');
				jQuery("#CNT_BADGE_SHARED_LINK").html(data.shared);
				if(data.shared == 0) jQuery("#CNT_BADGE_SHARED_LINK").css("display", "none");
			}
		},
		error : function(){
			return;
		}
	});	
}


// web_alarm 추가 
jQuery( "#bell_btn" ).click(function() {
	if(jQuery("#_alarm_div").html().trim() == ""){
		jQuery.ajax({
			url : Common.getRoot() + "common/menu/web_alarm",
			data : {},
			type : 'post',
			dataType : 'json',
			async :	true,
			success : function(data){
				if(data.resultCode !== undefined && data.resultCode === RT_LOGOUT){
					console.log("logout");
					Common.showLogout(data);
					return;
				}

				jQuery("#_alarm_div").html(data.result);
			}
		});
	}else{
		jQuery("#notify_div").remove()
	}
});

recentAlarmCount = function()
{
	jQuery('.notification').show();
	jQuery.ajax({
		url : Common.getRoot() + "common/menu/web_alarm_cnt",
		data : {},
		type : 'post',
		dataType : 'json',
		async :	true,
		success : function(data){
			if(data.resultCode !== undefined && data.resultCode === RT_LOGOUT){
				console.log("logout");
				Common.showLogout(data);
				return;
			}

			if(data.result > 0 ){
				jQuery('#bell_btn').addClass('alram')
				jQuery('.wa_count_class').show()
				jQuery('.wa_count_class').text(data.result)
			}
		}
	});	
}

jQuery( document ).ready(function() {
	recentAlarmCount();
});

var CHECK_TIME_OUT = window.setInterval(Common.showTimeout, 6*60*60*1000);
</script>
</body>
</html>

