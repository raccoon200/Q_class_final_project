<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>

<title> OK </title>
	

	<script src="/static/scripts/language.js" type="text/javascript"></script>
	<script src="/static/scripts/Sly.js" type="text/javascript"></script>
	<script src="/static/scripts/common_new.js" type="text/javascript"></script>
	<script src="/static/scripts/jquery-1.7.1.min.js" type="text/javascript"></script>
		
	<script src="/static/scripts/jcommon.js" type="text/javascript"></script>
	<script src="/static/scripts/jvalidateMessage.js" type="text/javascript"></script>
	<script src="/static/scripts/jorgtree.js" type="text/javascript"></script>
	<script src="/static/scripts/jaddressbook.js" type="text/javascript"></script>
	<script src="/static/scripts/jajaxBasic.js" type="text/javascript"></script>
	<script src="/static/scripts/jquery/jquery.toastmessage.js" type="text/javascript"></script>
	<!-- Frontend devteam -->

	<script src="/static/scripts/jquery-ui-1.11.4/jquery-ui.min.js" type="text/javascript"></script>
	<script src="/static/ui/js/main.js"></script>
		
	<script src="/static/scripts/addr/addrNewCommon.js" type="text/javascript"></script>
	<script src="/static/scripts/AngularJS/file-upload/ng-file-upload-shim.min.js" type="text/javascript"></script>
	<script src="/static/scripts/AngularJS/angular_1.2.28.js" type="text/javascript"></script>
	<script src="/static/scripts/AngularJS/file-upload/ng-file-upload.js" type="text/javascript"></script>
	<script src="/static/scripts/addr/angularjsFactory.js" type="text/javascript"></script>
	<script src="/static/scripts/addr/angularjsAddressCtrl.js" type="text/javascript"></script>
	<script src="/static/scripts/AngularJS/ngPage/pagination_factory.js" type="text/javascript"></script>
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
	<!--<form name="addressAdd" action="${pageContext.request.contextPath}/addr/addressAdd.do" method="post"> -->
</head>
<!-- start  -->
<div>
		<div class="mainbtn">
			<a href="/address/addressAdd.do" class="mail_btn">주소 추가</a>
		</div>
		<div class="menufield">
			<ul class="mail_list">
				<li>
					<a href="/address/main/personal">             
						<span class="listname " >개인 주소록</span>
					</a>
									</li>
				<li>
					<a href="/address/main/shared"><span class="listname ">공유 주소록</span>
					</a>
										<span class="count">2</span>
									</li>
				<li>
					<a href="/address/main/trash"><span class="listname ">휴지통</span>
					</a>

										<span class="count">2</span>
									</li>
				<li>
					<div class="  depth1">
						<a href="#" class="foldtop">
							<span class="icon fold "><em class="blind">내 환경설정 접고/펴기 토글</em></span>            
							<span class="listname fold ">환경설정</span>
							</a>
					</div>
					<ul class="depth2 hide  ">
						<li><a href="/address/main/setting">기본정보 설정</a></li>
						<li><a href="/address/main/import">주소록 가져오기 </a></li>
						<li><a href="/address/main/export">주소록 내보내기</a></li>
						<li><a href="/address/main/print_address" >인쇄하기</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</div>        	
			<!-- left End -->
		</div>

						<div id="contents" >
			<div ng-app="AddrAddApp" ng-controller="AddrAddCtrl">
	<!-- Contents -->
	<div class="setting_title addradd_head">
		<h3>주소 추가</h3>
			<div class="addrtype">
				<label><input type="radio" name="type" value='P' checked> 개인 주소록</label>
				<label><input type="radio" name="type" value='S'> 공유 주소록</label>
			</div>
	</div>

	<div class="content_inbox">
		<div class="cont_box">
			<form action='/views/address/doaddressAdd.do' method='post' onsubmit="return false;"  id ='add_address_form' >


				<div class="setting_field">
					<dl class="addList">
						<dt>이름</dt>
							<dd><input type="text" name='name'  title="이름" class="w200"></dd>

						<dt>이메일</dt>
							
							<dd ng-repeat="email in emails" >
								<input  type="text" title="이메일" class="w200 addr_emails" >

								<div ng-switch on='email.remove_flag' style='display:inline-block;' >
									<button class="weakblue"  ng-switch-when="Y" ng-click='removeInfomation("email")'>제거</button> 
									<button class="weakblue" ng-switch-when="N"  ng-click='addInfomation("email")'>추가</button>
								</div>
							</dd>

						<dt>전화</dt>
							
							<dd ng-repeat="phone in phones" >
								<span class="addInput addr_phones">
									<select title="전화 종류" class="w100">
										<option value="휴대폰" >휴대폰</option>
										<option value="집전화">집</option>
										<option value="회사전화">회사</option>
										<option value="fax">Fax</option>
									</select>
									<input type="text" title="전화" class="w200"> 
								</span>

								<div ng-switch on='phone.remove_flag' style='display:inline-block;' >
									<button class="weakblue"  ng-switch-when="Y" ng-click='removeInfomation("phone")'>제거</button> 
									<button class="weakblue" ng-switch-when="N"  ng-click='addInfomation("phone")'>추가</button>
								</div>
							</dd>


						<dt>태그</dt>
						<dd><input type="text" title="태그" name='tag' class="w200" > <button class="weakblue popupOpenBtn1"  ng-click='getTagList();'  >태그설정</button></dd>

						<dt>회사</dt>
							<dd>
								<input type="text" title="회사" placeholder="회사" name='addr_company' class="w200">
								<input type="text" title="부서" placeholder="부서" name='addr_department' class="w100">
								<input type="text" title="직급" placeholder="직급" name='addr_grade' class="w100">

							</dd>

						<dt>주소</dt>

							<dd  ng-repeat="address in addresses" >
								<span class="addInput addr_address">
									<select  title="주소 종류" class="w100 " >
										<option value="집">집</option>
										<option value="회사">회사</option>
										<option value="기타">기타</option>
									</select>
									<input type="text" title="주소" class="w200"> 
								</span>

								<button id='test' class="weakblue" ng-click="SearchAddressLayer()">우편번호</button> <span class="grey_bar">|</span>
								<div ng-switch on='address.remove_flag' style='display:inline-block;' >
									<button class="weakblue"  ng-switch-when="Y" ng-click='removeInfomation("address")'>제거</button> 
									<button class="weakblue" ng-switch-when="N"  ng-click='addInfomation("address")'>추가</button>
								</div>
							</dd>

							<dt>웹사이트</dt>
								<dd ng-repeat="website in websites" >
									<input type="text" title="웹사이트" class="w200 addr_websites"> 
									
									<div ng-switch on='website.remove_flag' style='display:inline-block;' >
										<button class="weakblue"  ng-switch-when="Y" ng-click='removeInfomation("website")'>제거</button> 
										<button class="weakblue" ng-switch-when="N"  ng-click='addInfomation("website")'>추가</button>
									</div>
								</dd>

							<dt>기념일</dt>
								
								<dd ng-repeat="anniversary in anniversaries" class ='addr_anniversaries'>
									<input type="text" title="기념일"  class="w200"> 
									<div ng-switch on='anniversary.remove_flag' style='display:inline-block;' >
										<button class="weakblue"  ng-switch-when="Y" ng-click='removeInfomation("anniversary")'>제거</button> 
										<button class="weakblue" ng-switch-when="N"  ng-click='addInfomation("anniversary")'>추가</button>
									</div>

									<br>
									<select name="year"><option value="all_year" selected>매년</option><option >2018</option><option >2017</option><option >2016</option><option >2015</option><option >2014</option><option >2013</option><option >2012</option><option >2011</option><option >2010</option><option >2009</option><option >2008</option><option >2007</option><option >2006</option><option >2005</option><option >2004</option><option >2003</option><option >2002</option><option >2001</option><option >2000</option><option >1999</option><option >1998</option><option >1997</option><option >1996</option><option >1995</option><option >1994</option><option >1993</option><option >1992</option><option >1991</option><option >1990</option><option >1989</option><option >1988</option><option >1987</option><option >1986</option><option >1985</option><option >1984</option><option >1983</option><option >1982</option><option >1981</option><option >1980</option><option >1979</option><option >1978</option><option >1977</option><option >1976</option><option >1975</option><option >1974</option><option >1973</option><option >1972</option><option >1971</option><option >1970</option><option >1969</option><option >1968</option><option >1967</option><option >1966</option><option >1965</option><option >1964</option><option >1963</option><option >1962</option><option >1961</option><option >1960</option><option >1959</option><option >1958</option><option >1957</option><option >1956</option><option >1955</option><option >1954</option><option >1953</option><option >1952</option><option >1951</option><option >1950</option><option >1949</option><option >1948</option></select>
																		<select name="month">
										<option value="1" >1월</option><option value="2" >2월</option><option value="3" >3월</option><option value="4" >4월</option><option value="5" >5월</option><option value="6" >6월</option><option value="7" >7월</option><option value="8" >8월</option><option value="9" >9월</option><option value="10" >10월</option><option value="11" >11월</option><option value="12" >12월</option></select>								</select>
									
									<select name="date" class="mgr_20">
										<option value="1" >1일</option><option value="2" >2일</option><option value="3" >3일</option><option value="4" >4일</option><option value="5" >5일</option><option value="6" >6일</option><option value="7" >7일</option><option value="8" >8일</option><option value="9" >9일</option><option value="10" >10일</option><option value="11" >11일</option><option value="12" >12일</option><option value="13" >13일</option><option value="14" >14일</option><option value="15" >15일</option><option value="16" >16일</option><option value="17" >17일</option><option value="18" >18일</option><option value="19" >19일</option><option value="20" >20일</option><option value="21" >21일</option><option value="22" >22일</option><option value="23" >23일</option><option value="24" >24일</option><option value="25" >25일</option><option value="26" >26일</option><option value="27" >27일</option><option value="28" >28일</option><option value="29" >29일</option><option value="30" >30일</option><option value="31" >31일</option></select>									</select>
									<label><input type="radio" name="anniversary_{{$index}}" value='S' title="양력" checked> 양력</label>
									<label><input type="radio" name="anniversary_{{$index}}" value='M' title="음력"> 음력</label>
							</dd>


						<dt>메모</dt>
							<dd><textarea title="메모" name='addr_memo' class="w300"></textarea></dd>
					</dl>
					<div class="bt_left">
						<button ng-click='submit_address()' >저장</button>
						<button ng-click='submit_address("add_more")' style="width:160px;">저장 후 계속 추가 + </button>
						</div>
					</div>
				</form>
			</div>
		</div>
	<div class="layer_box middle hide tagLayer" >
			<div class="title_layer text_variables">태그설정</div>
			<div class="print-item">
				<ul class="after" style ='overflow-y: auto;overflow-x: hidden;height: 150px;'>
					<li ng-repeat="tag in tags" ><input type="checkbox" id="tagset01" name="tagset1" value="{{tag.name}}"> <label for="tagset01">{{tag.name}}</label></li>
				</ul>
			</div>
			<div class="layer_button">
				<button class="btn_variables" type="button" ng-click='setting_tag()'>저장</button>
			</div>
			<a href="#" class="icon btn_closelayer" onclick="AddrNewCommon.hidePopup($j('.tagLayer'));" title="레이어 닫기"><span class="blind">레이어 닫기</span></a>
	</div>


	<div class="layer_box large hide popup3" id='address_search_layer' >
		<div id='layer_level_1'>
			<div class="title_layer text_variables" >우편번호 검색</div>
			<div class="print-item">
				<div>
					<label><input type="radio" name="addrTypeRadio" ng-model ='SearchZipAddrType' value="Jibun" title="지번주소" ng-change='addrTypeRadioFnc()'>지번 주소</label>
					<label><input type="radio" name="addrTypeRadio" ng-model ='SearchZipAddrType' value="Doro" title="도로명주소" ng-change='addrTypeRadioFnc()'> 도로명 주소</label>
				</div>
				<table class="cal_table1 bdt mgt_10">
					<caption>주소 검색 목록으로 시도, 시구군, 검색어로 구성되어 있습니다.</caption>
					<colgroup>
						<col width="25%">
						<col width="25%">
						<col width="25%">
						<col width="25%">
					</colgroup>
					<tbody><tr>
						<th>시도</th>
						<td>
							<select class="w200"  ng-model = "sido_no"  ng-options="sido.sido_code as sido.sido  for sido in sidos" ng-change ='getSigungu(sido_no)' >
								<option value="">선택</option>
							</select>

						</td>
						<th>시구군</th> 
						<td>

							<select class="w200"  ng-model = "sgg_no"  ng-options="si_gu_gun.gugun_code as si_gu_gun.gugun  for si_gu_gun in si_gu_guns"  ng-change ='getDong(sgg_no)' >
								<option value="">선택</option>
							</select>

						</td>
					</tr>
					<tr id= 'Jibun_search_tab'>
						<th>검색어</th>
						<td colspan="3">

							<select class="w200"  ng-model = "dong_no"  ng-options="dong.dong_code as dong.dong_ri  for dong in dongs"    >
								<option value="">선택</option>
							</select>
							+ 
							<input type="text"  class="w200 resetTab" placeholder="지번" > <button type="button" class="weakblue" ng-click="getJibunList()">검색</button>
						</td>
					</tr>

					<tr id= 'Doro_search_tab' class='hide'>
						<th>검색어</th>
						<td colspan="3">
							<input type="text" class="w200 resetTab" placeholder="도로명">
							 + 
							<input type="text" class="w200 resetTab" placeholder="건물번호"> <button type="button" class="weakblue" ng-click="getDoroList()">검색</button>
						</td>
					</tr>

				</tbody></table>

				<p class="pdt_10 search_info_tab ">
					검색 방법: 시/도 및 시/군/구 선택 후 동(읍/면) + 지번 입력(선택)<br>
					예) 역삼동 123 → ‘서울시’ ‘강남구’ 선택 후 역삼동 + 123				</p>

				<p class="pdt_10 search_info_tab hide">
					검색 방법: 시/도 및 시/군/구 선택 후 도로명 + 건물번호 입력(선택)<br>
					예) 테헤란로 123 → ‘서울시’ ‘강남구’ 선택 후 테헤란로 + 123				</p>

				<p class="pdt_10 gr_depth1">
					· 주소가 검색되지 않으면, 행정안전부의 도로명 주소 안내시스템&nbsp;<br>(<a href='http://www.juso.go.kr' target='_blank'>http://www.juso.go.kr</a>) 에서 확인하시기 바랍니다.				</p>

				<p class="pdt_30 detail_addr_list_tab hide">아래의 주소 중에서 해당하는 주소를 선택해 주세요.</p>
				<div class="post_scroll mgt_10 detail_addr_list_tab hide">
					<table class="tableType01">
						<caption>우편번호 검색 목록으로 우편번호, 주소로 구성되어 있습니다.</caption>
						<colgroup>
							<col width="15%">
							<col width="">
							<col width="15%">
						</colgroup>
						<thead>
							<tr>
								<th scope="col">우편번호</th>
								<th scope="col" colspan="2">주소</th>
							</tr>
						</thead>
						<tbody>

							<tr ng-if="SearchZipAddrType == 'Jibun' " ng-repeat ="DI in detailAddresInfo">
								<td class="center">{{DI.new_zipcode}}</td>
								<td>{{DI.old_addr_kor}}</td>
								<td class="ta_r"><button type="button" class="weakblue" ng-click="checkDetailInfo(DI)" >선택</button></td>
							</tr>

							<tr ng-if="SearchZipAddrType == 'Doro' " ng-repeat ="DI in detailAddresInfo">
								<td class="center">{{DI.new_zipcode}}</td>
								<td>{{DI.new_addr_kor}} {{DI.bracket}}</td>
								<td class="ta_r"><button type="button" class="weakblue" ng-click="checkDetailInfo(DI)">선택</button></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>

		<div id='layer_level_2' class='hide'>
			<table class="tableType01 mgt_10">
				<colgroup>
					<col width="15%">
					<col width="">
					<col width="15%">
				</colgroup>
				<thead>
					<tr>
						<th scope="col">우편번호</th>
						<th scope="col" colspan="2">주소</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="center ">{{selectedDI.new_zipcode}}</td>
						<td  ng-if="SearchZipAddrType == 'Jibun'">{{selectedDI.old_addr_kor}}</td>
						<td  ng-if="SearchZipAddrType == 'Doro'">{{selectedDI.new_addr_kor}} {{selectedDI.bracket}}</td>
						<td class="ta_r"></td>
					</tr>
				</tbody>
			</table>
			<p class="pdt_30 pdb_10">나머지 주소를 입력하신 후 주소입력 버튼을 눌러주세요.</p>
			<input type="text " class='resetTab' style="width:634px">

			<div class="layer_button">
				<button type="button" class="btn_variables" ng-click="getDetailAddressString()">주소입력</button>
			</div>
		</div>
		<a href="javascript:void(0)" class="icon btn_closelayer" onclick="AddrNewCommon.hidePopup($j('#address_search_layer'));"  title="레이어 닫기"><span class="blind">레이어 닫기</span></a>
	</div>
	<div id="dimmed" ></div>
</div>
<script>
	addrCtrlPage_add();
</script>
		</div>
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


<!-- end -->

</body>
</html>
