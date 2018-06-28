function addrCtrlPage_setting(initData){	// addr/main/setting
	var app = angular.module("AddrSetting", []);
	init_addrFactory(app); 
	app.controller("AddrSettingCtrl", ['$scope', 'Server', function($scope , Server ) {
		$scope.tagList = [];
		$scope.removeTagArr = [];
		$scope.ngShowTagCreate = false;

		var tmp_tagList = initData.tmp_tagList;
		if(tmp_tagList.resultCode == 'SUCCESS'){$scope.tagList = tmp_tagList.result.result; }

		$scope.modify_tag			= function (tag){			tag.mode_flag = 'modify';	}
		$scope.rollback_name		= function (name){	this.tag.mode_flag = 'nomal';	this.tag.name =name;}
		$scope.rename_tag		= function (tag){	
			var event_target = typeof event.target !== "undefined" 	? event.target  : window.event.srcElement;
			
			var tmp_tag_name = $j(event_target).parent().find('input').val();
			if(tmp_tag_name.trim() != '' ){
				tag.name = tmp_tag_name;
				tag.isModify ='Y'; 
				tag.mode_flag = 'nomal';
			}else{
				alert(lang.getMessage("SCHEDULE_TEXT_CANCELMODIFY"));
			}
		}

		$scope.tagCreateFnc = function (){
			$j('input[name="insertTag"]').val('')
			$scope.ngShowTagCreate = true;
		}

		$scope.insertTagOnly = function (){
			var type = $j('input[name="type"]:checked').val();
			var tagName  = $j('input[name="insertTag"]').val().trim();
			var duplicate_flag = false;

			angular.forEach($scope.tagList , function(value, key){
				
				if(value.name ==tagName ){
					duplicate_flag = true;
				}
			});

			if(tagName == ''){
				alert('태그명을 입력하세요');
				return;
			}else if(duplicate_flag){
				alert('동일한 태그명은 사용할 수 없습니다.');
				$j('input[name="insertTag"]').val('');
				return;
			}else{
				Server.post( Common.getRoot() + 'addr/addr_ajax/insertTagOnly', { 'tagName' : tagName , 'type' :  type }).success(function(data){
					alert(lang.getMessage("APPLY_OK"));
					$scope.tagList.push($j.parseJSON(data.result))
					$scope.hideLayer('ngShowTagCreate')
				}).error(function(data, status, headers, config) {
					alert('error');
				});
			}
		}

		$scope.hideLayer = function (flag){
			$scope[flag] = false;
		}

		$scope.remove_tag = function (index){
			if(confirm(lang.getMessage("CONFIRM_TAG_DELETE"))){
				$scope.removeTagArr.push($scope.tagList[index].no);
				$scope.tagList.splice(index , 1)
			}
		}

		$scope.submitSetting = function(){
			uniqueNames_P = [];
			uniqueNames_S = [];

			var keepgoing = true;
			angular.forEach($scope.tagList , function(value, key){	

				if(keepgoing){

					if(value.kind == 'P'){
						if($j.inArray(value.name, uniqueNames_P) === -1){ 
							uniqueNames_P.push(value.name);
						}else{
							alert(lang.getMessage("JASameTagName"))
							keepgoing =  false;
						}
					}else if(value.kind == 'S'){
						if($j.inArray(value.name, uniqueNames_S) === -1){ 
							uniqueNames_S.push(value.name);
						}else{
							alert(lang.getMessage("JASameTagName"))
							keepgoing =  false;
						}
					}
				}
			});

			if(keepgoing == false){
				document.location.reload();
				return;
			}


			Server.post( Common.getRoot() + 'addr/addr_ajax/multiSettingAddr', { removeTagArr : JSON.stringify($scope.removeTagArr) , tag: JSON.stringify($scope.tagList) , overwriteFlag: $j('#record_overwrite input[name="record_overwrite"]:checked').val() , per_page : $j('#addr_per_page').val() }).success(function(data){
				alert(lang.getMessage("APPLY_OK"));
			}).error(function(data, status, headers, config) {
				alert('error');
			});
		}
	}]);
}

function addrCtrlPage_import(initData){	// addr/main/import
	var app = angular.module("AddrImportApp", [ 'ngFileUpload' ]);
	init_addrFactory(app); 
	app.controller("AddrImportCtrl", ['$scope', 'Server', 'Upload', function($scope , Server , $upload) {
		$scope.importFromFiles =  [];
		$scope.importFromOrgs =  [];
		$scope.importFromMails =  [];
		$scope.importFromSmses =  [];
		$scope.orgLists = initData.orgLists;
		$scope.mboxLists = initData.mboxLists;
		$scope.Order = 'name';
		$scope.isReverse = false;

		$j(".tabType1").click(function(){
			$j('#importOrderMenu').removeClass('show');
			$j('#importOrderMenu a').removeClass('active')
			$j('#importOrderMenu a').eq(0).addClass('active')
			$j('#importOrderMenu a').eq(0).find('span').addClass('up');
			$scope.Order = 'name';
			$scope.isReverse = false;
		});


		if(Common.getIEVersion() == '8' || Common.getIEVersion() == '9' ){
			$j('#useable_formData').hide()
			$j('#unUseable_formData').show()
		}else{
			$j('#useable_formData').show()
			$j('#unUseable_formData').hide()
		}



		$j('.tabType1 li').click(function(){
			$j('.AllCheck').attr("checked", false)
		});

		$scope.orderList = function(flag){
			var event_target = typeof event.target !== "undefined" 	? event.target  : window.event.srcElement;
			$j('#importOrderMenu a').removeClass('active')
			$j('.orderClass').removeClass('up down')

			if($scope.Order != flag){
				$scope.Order =flag;
				$scope.isReverse = true;
			}
			$j(event_target).find('span').parent().addClass('active')
			
			if($scope.isReverse == true){
				$scope.isReverse = false;
				$j(event_target).find('span').addClass('up')
			}else{
				$scope.isReverse = true;
				$j(event_target).find('span').addClass('down')
			}
			$j('#importOrderMenu').toggleClass('show');
		}

		$scope.impor_from_file_fnc = function(){
			setTimeout(function() {
					$j('#impor_from_file_real').click();
			}, 500);
		}
		$scope.importAddrChecboxClickFnc = function(addr){	if(addr.isChecked == 'Y'){	addr.isChecked ='N'	}else{	addr.isChecked ='Y'	}	}

		$scope.showOrderMenu = function(){
			var $_this = $j('#importOrderMenu');
			$_this.css('top',(event.clientY -53)+'px')
			$_this.toggleClass('show');
			$j('.orderClass').addClass('absolute_hide')

			if($scope.Order == 'name'){
				$j('.name_flag').removeClass('absolute_hide')
			}else if($scope.Order == 'department'){
				$j('.department_flag').removeClass('absolute_hide')
			}else{
				$j('.company_flag').removeClass('absolute_hide')
			}
		}


		$scope.uploadFile = function(){
			
			//var file = $scope.myFile; 
			var file =  $j('#impor_from_file_real')[0].files[0]

			var uploadUrl = Common.getRoot()+'addr/addr_ajax/uploadImportFile'  ;
			Server.uploadFileToUrl(file, uploadUrl).success(function(data){
				if(data.resultCode == "SUCCESS"){
					$scope.importFromFiles = $j.parseJSON(data.result);
					$j('#after_file_upload').show();
				}else{
					alert(lang.getMessage("IMPORT_ADDR_WARNING_01"))
				}
			});
		}

		$scope.uploadIE = function(files) {
			if (files != undefined && files && files.length >= 1 ) {
				$scope.upload = $upload.upload({
					url: Common.getRoot()+'addr/addr_ajax/uploadImportFile' ,   //경로
					method: 'POST',   //메소드
					file:files,        //파일
					fileFormDataName : 'file',  //필드이름
				}).success(function(data, status, headers, config) {
					if(data.resultCode == "SUCCESS"){
						$scope.importFromFiles = $j.parseJSON(data.result);
						$j('#after_file_upload').show();
					}else{
						alert(lang.getMessage("IMPORT_ADDR_WARNING_01"))
					}
				});
			}

		}

		$scope.importAddrAllCheckFnc = function(flag){
			var model = ''
			if(flag == 'org' ){		model =$scope.importFromOrgs;	}
			else if (flag == 'file'){		model =$scope.importFromFiles;	}
			else if (flag == 'mail'){		model =$scope.importFromMails;	}
			else if (flag == 'sms'){		model =$scope.importFromSmses;	}

			var event_target = typeof event.target !== "undefined" 	? event.target  : window.event.srcElement;

			if($j(event_target).is(':checked') == true){
				angular.forEach(model , function(value, key){	value.isChecked = 'Y';	});
			}else{
				angular.forEach(model , function(value, key){	value.isChecked = 'N';});
			}
		}
		
		$scope.importFromDb = function(flag){
			var temp_arr = [];
			if(flag == 'org' ){

				var param ={	'flag' : flag };
				Server.post(Common.getRoot()+'addr/addr_ajax/getAddressFromDB'  , param  ).success(function(data){
					$j('#after_org_upload').show()
					$scope.importFromOrgs = $j.parseJSON(data.result);
				}).error(function(data, status, headers, config) {
					alert('error')
				});

			}else if (flag == 'sms' ){
				var param ={ 'flag' : flag };
				Server.post(Common.getRoot()+'addr/addr_ajax/getAddressFromDB'  , param  ).success(function(data){
					
					if(data.resultCode == 'SUCCESS' ){
						$j('#after_sms_upload').show()
						$scope.importFromSmses = $j.parseJSON(data.result);
					}else{
						alert(lang.getMessage("ADDR_TEXT_NO_SMS_LIST"));
					}
				}).error(function(data, status, headers, config) {
					alert('error')
				});
			}else if (flag == 'mail' ){
				angular.forEach( $scope.mboxLists , function(value, key){	if(value.isChecked == 'Y'){	temp_arr.push(value.no)	}	});
				if(temp_arr.length == 0) {
					alert(lang.getMessage("NOT_SELECTED_MAILBOX"));
					return;
				}
				var param ={	'flag' : flag,	'mboxNos' : temp_arr	};
				Server.post(Common.getRoot()+'addr/addr_ajax/getAddressFromDB'  , param  ).success(function(data){
					$j('#after_mail_upload').show()
					$scope.importFromMails = $j.parseJSON(data.result);
				}).error(function(data, status, headers, config) {
					alert('error')
				});
			}
		}

		$scope.importFromAddrSave = function(FLAG){
			var oName = Array();
			var oEmail = Array();
			var oEmail1 = Array();
			var oEmail2 = Array();
			var oEmail3 = Array();
			var oEmail4 = Array();
			var oHomeAddress = Array();
			var oHomePhone = Array();
			var oCellPhone = Array();
			var oPersonalSite = Array();
			var oBirth = Array();
			var oCompanyAddress = Array();
			var oCompanySite = Array();
			var oCompanyPhone = Array();
			var oFax = Array();
			var oCompanyName = Array();
			var oPosition = Array();
			var oPart = Array();
			var oMemo = Array();		
			var saveFlag ='';
			var tag = '';
			var importModel = '';
			var break_flag = false;


			if (FLAG == 'File' ){
				importModel = $scope.importFromFiles;
				saveFlag = $j("input[name='importAdd1']:checked").val();
			}else if ( FLAG == 'ORG' ){
				importModel = $scope.importFromOrgs;
				saveFlag = $j("input[name='importAdd5']:checked").val();
			}else if (FLAG == 'SMS'){
				importModel = $scope.importFromSmses;
				saveFlag = $j("input[name='importAdd6']:checked").val();
			}else if (FLAG == 'MAIL'){
				importModel = $scope.importFromMails;
				saveFlag = $j("input[name='importAdd3']:checked").val();
			}

			if(saveFlag == 'P')
				tag = $j('select[name="'+FLAG.toLowerCase()+'_p_tag"] option:selected').text()
			else
				tag = $j('select[name="'+FLAG.toLowerCase()+'_s_tag"] option:selected').text()

			if(tag == '미지정' && $j('select[name="'+FLAG.toLowerCase()+'_s_tag"]').val() == 'none' )
				tag ='';
			
			angular.forEach( importModel , function(value, key){	
				if(value.isChecked == 'Y'){
					oName.push(value.name);
					oEmail.push(value.email);
					oEmail1.push(value.email1);
					oEmail2.push(value.email2);
					oEmail3.push(value.email3);
					oEmail4.push(value.email4);
					oHomeAddress.push(value.home_address);
					oHomePhone.push(value.home_phone);
					oCellPhone.push(value.phone);
					oPersonalSite.push(value.personal_homepage);
					oBirth.push(value.birth);
					oCompanyAddress.push(value.company_address);
					oCompanySite.push(value.company_homepage);
					oCompanyPhone.push(value.company_phone);
					oFax.push(value.fax);
					oCompanyName.push(value.company);
					oPosition.push(value.grade);
					oPart.push(value.department);
					oMemo.push(value.memo);
				}
			});

			if(oName.length == 0){	alert(lang.getMessage("JONonSelectAddress"));	return;	}
			if($j.inArray('', oName) !=  -1 ){ alert('이름은 필수 항목입니다.');	return;	}


			// 이메일 , 전화번호 1차 필터 추가 
			var checkEmailArr = [oEmail , oEmail1 , oEmail2 , oEmail3 , oEmail4 ];
			var checkPhoneArr = [oHomePhone , oCellPhone , oCompanyPhone ];

			angular.forEach( checkEmailArr , function( EmailArr ){
				if(EmailArr.length != 0 ){
					angular.forEach( EmailArr , function( EmailData){
						if(EmailData.trim() != '' && AddrNewCommon.isEmail(EmailData.trim()) == false     ){
							alert(lang.getMessage("JAEMailChk")+" : "+EmailData );
							break_flag = true;
						}
					});
				}
			});
			if(break_flag){alert("형식이 올바르지 않아 업로드 할 수 없습니다.");  return;	}

			angular.forEach( checkPhoneArr , function( PhoneArr ){
				if(PhoneArr.length != 0 ){
					angular.forEach( PhoneArr , function( PhoneData){
						PhoneData = PhoneData.toString();
						if(PhoneData.trim() != '' && AddrNewCommon.phone_foreign(PhoneData.trim()) == false     ){
							alert(lang.getMessage("INVALID_PHONE")+" : "+PhoneData);
							break_flag = true;
						}
					});
				}
			});
			if(break_flag){alert("형식이 올바르지 않아 업로드 할 수 없습니다.");  return;	}


			var param = {"save_position" : saveFlag, "tag" : tag,
				"oName" : oName.join("__@!@!@!__"),		"oEmail" : oEmail.join("__@!@!@!__"),		"oEmail1" : oEmail1.join("__@!@!@!__"),		"oEmail2" : oEmail2.join("__@!@!@!__"),
				"oEmail3" : oEmail3.join("__@!@!@!__"),		"oEmail4" : oEmail4.join("__@!@!@!__"),		"oHomeAddress" : oHomeAddress.join("__@!@!@!__"),		"oHomePhone" : oHomePhone.join("__@!@!@!__"),
				"oCellPhone" : oCellPhone.join("__@!@!@!__"),	"oBirth" : oBirth.join("__@!@!@!__"),		"oPersonalSite" : oPersonalSite.join("__@!@!@!__"),	"oCompanyAddress" : oCompanyAddress.join("__@!@!@!__"),
				"oCompanySite" : oCompanySite.join("__@!@!@!__"),	"oCompanyPhone" : oCompanyPhone.join("__@!@!@!__"),		"oFax" : oFax.join("__@!@!@!__"),		
				"oCompanyName" : oCompanyName.join("__@!@!@!__"),		"oPosition" : oPosition.join("__@!@!@!__"),			"oPart" : oPart.join("__@!@!@!__"),		"oMemo" : oMemo.join("__@!@!@!__")};


			Server.post(Common.getRoot()+'addr/addr_ajax/importAddress'  , param  ).success(function(data){
				alert(data.message)
				if(saveFlag == 'P'){
					window.location = Common.getRoot() + "addr/main/personal";
				}else{
					window.location = Common.getRoot() + "addr/main/shared";
				
				}
			}).error(function(data, status, headers, config) {
				alert(data.message)
				document.location.reload();
			});

		}

		$j(document).ready(function(){
			$j('#contents').css('overflow-x','hidden');
			$j('#contents').css('overflow-y','auto');
		})
	}]);
}

function addrCtrlPage_export(initData) {// addr/main/export
	var app = angular.module("AddrExport", []);
	init_addrFactory(app); 
	app.controller("AddrExportCtrl", ['$scope', 'Server' ,function($scope , Server) {
		$scope.PersonalAddresses = [];
		$scope.SharedAddresses = [];
		$scope.TagAddresses = [];
		$scope.ExportAddresses = [];
		$scope.TmpAddr = [];

		var available_tab_flag ='P';
		var tempPersonalAddresses = initData.tempPersonalAddresses;
		var tempTagAddresses = initData.tempTagAddresses;

		$scope.checkAllFnc = function(flag){
			var model = '';
			if(flag == 'PA'){	model = $scope.PersonalAddresses;}
			else if (flag == 'SA'){	model = $scope.SharedAddresses;	}
			else if (flag == 'TAG'){	model = $scope.TagAddresses;	}

			var event_target = typeof event.target !== "undefined" 	? event.target  : window.event.srcElement;
			if($j(event_target).is(':checked') == true){
				angular.forEach(model , function(value, key){	value.isChecked = 'Y';	});
			}else{
				angular.forEach(model , function(value, key){	value.isChecked = 'N';});
			}
		}

		if(tempPersonalAddresses.resultCode == 'SUCCESS'){	$scope.PersonalAddresses = tempPersonalAddresses.result;	}
		if(tempTagAddresses.resultCode == 'SUCCESS'){	$scope.TagAddresses = tempTagAddresses.result;	}
		$scope.checkExport = function (OB){	if(OB.isChecked == "N"){ OB.isChecked = 'Y' }else{ OB.isChecked = 'N' }	}
		$scope.available_tab = function(TAB){available_tab_flag =TAB;	}
		$scope.chosungClickFnc = function (kind , event ){
			if ($j.type(event) == 'object')
				var chosung = event.target.value;
			else
				var chosung = event	// string

			Server.post( Common.getRoot() + 'addr/addr_ajax/getAddressList', {kind: kind , chosung: chosung  }
			).success(function(data){
				if(kind == 'P'){
					$scope.PersonalAddresses = data.result
				}else{
					$scope.SharedAddresses = data.result
				}
			});
			$j('.AllCheck').attr("checked", false)
		}

		$scope.addExportAddr = function (){
			
			if(available_tab_flag != 'T'){
				var model ='';
				if(available_tab_flag == 'P'){
					model = $scope.PersonalAddresses ;
				}else if(available_tab_flag == 'S'){
					model = $scope.SharedAddresses ;
				}
				angular.forEach( model, function(value, key){
					if(value.isChecked == 'Y'){
						value.isChecked = 'N';
						$scope.ExportAddresses.push(value);
					}
				});
			}else{
				var tag_nos = [];
				angular.forEach( $scope.TagAddresses, function(value, key){
					if(value.isChecked == 'Y'){
						value.isChecked = 'N';
						tag_nos.push(value.no);
					}
				});

				if(tag_nos.length == 0 ){
					alert(lang.getMessage("ADDR_TEXT_NO_TAG"))
					return;
				}

				Server.post( Common.getRoot() + 'addr/addr_ajax/getAddressList', {kind: 'T' , tagNo: tag_nos  }
				).success(function(data){ //$scope.TagAddresses
					if(data.resultCode == "SUCCESS" ){
						angular.forEach( data.result, function(value, key){
							value.isChecked = 'N';
							$scope.ExportAddresses.push(value);
						});
					}
				});
			}
			$j('.AllCheck').attr("checked", false)
		}

		$scope.delExportAddr= function (){
			angular.forEach($scope.ExportAddresses , function(value, key){
				if(value.isChecked == 'N'){
					$scope.TmpAddr.push(value);
				}
			});
			$scope.ExportAddresses = $scope.TmpAddr;
			$scope.TmpAddr = [];
		}

		$scope.downExportAddr= function (){
			event.preventDefault ? event.preventDefault() : event.returnValue = false;
			var pType = $j('input[type="radio"]:checked').val();
			var tmpNoArr = [];
			if($scope.ExportAddresses.length <= 0 ){
				alert(lang.getMessage("MAIN_WARN_NO_ADDRESS_U_SELECT"));
				return;
			}else{
				angular.forEach( $scope.ExportAddresses , function(value, key){
					if($j.inArray(value.no , tmpNoArr) == -1 ){ 
						tmpNoArr.push(value.no) 
					}
				});
				alert(lang.getMessage("LA_DUPLICATEREMOVE"));
				$j('#addrNos').val(tmpNoArr.join(','))
				$j('#pType').val(pType)
				$j('#addr_export_form').submit();
			}
		}
	}]);

	$j(document).ready(function(){
		$j('.isReadyClass').removeClass('isReadyClass')
	})
}

function addrCtrlPage_trash(initData , listOPT ) {// addr/main/trash
	var app = angular.module("AddrTrashApp", ['PageFactory']);
	var list_data = initData.list_data;
	init_addrFactory(app); 
	app.controller("AddrTrashCtrl", ['$scope', 'Server', 'PageFactory', 'Useable' , function($scope , Server , PageFactory ,Useable ) {
		PageFactory.init( {	itemsPerPage :   initData.itemsPerPage ,	currentPage : 1,	rangeSize : 10 ,	totalCount : initData.totalCount	});
		$scope.PageFactory = PageFactory; 
		$scope.Useable = Useable;
		$scope.initData = initData;
		$scope.listOPT = listOPT; 

		$scope.chosung = 'all';
		$scope.order = 'asc';
		$scope.orderby = 'name'; 
 		$scope.star = 'N';
		$scope.viewAnSnT = initData.viewAnSnT_Txt
		$scope.TrashAddrList = [];
		$scope.TrashAddrCount = 0; 
		$scope.checkedCnt = 0;
		$scope.DetailData = [];	// 한 주소의 상세 정보 객체
		$scope.selectpage  = PageFactory.currentPage ;

		$j('.chosungNomal').click(function(){
			$scope.chosung = $j(this).attr('value');
			$j('.chosungNomal').removeClass('on');
			$j(this).toggleClass('on');
			$scope.initializeList('init')
		});

		$scope.getAnS = function (flag) {
			var event_target = typeof event.target !== "undefined" 	? event.target  : window.event.srcElement;
			$scope.viewAnSnT =  $j(event_target).text();
			if(flag == 'star_n'){ 
				$scope.star = 'N';
			}else if (flag == 'star_y'){
				$scope.star = 'Y';
			}
			$scope.initializeList('init')
		}

		$scope.showDetailView = function (AddrObject){ // 개인 상세 정보 페이지 보이기 
			Server.post(Common.getRoot()+'addr/addr_ajax/addressDetailView'  , { kind : AddrObject.kind  , no : AddrObject.no }  ).success(function(data){
				$scope.DetailData = data.result;
			}).error(function(data, status, headers, config) {		alert('error')	});
			AddrNewCommon.showPopup($j('#addressDetailView'));
		}

		$scope.deleteOne = function(OB){ // 단일 주소 완전 삭제 
			event.preventDefault ? event.preventDefault() : event.returnValue = false;
			if(confirm(lang.getMessage("ADDR_TEXT_NONRECOVERY"))) {
				var tmpPersonal = [];
				var tmpShared = [];

				if(OB.kind == 'P'){
					tmpPersonal.push(OB.no)
				}else{
					tmpShared.push(OB.no)
				}
				param = { 'trashPersonal' : tmpPersonal , 'trashShared' : tmpShared }
				url  = 'addr/addr_ajax/clearSelAddress';
				Server.post(Common.getRoot()+ url  , param  ).success(function(data){
					$scope.initializeList();
					$scope.hideDetailView();
				})
			}
		}

		$scope.hideDetailView = function (){ // 개인 상세 정보 페이지 닫기
			$scope.DetailData = [];
			AddrNewCommon.hidePopup($j('#addressDetailView'));
		}

		$scope.checkBoxCntFnc = function (){
			var oNo =[];
			angular.forEach($scope.TrashAddrList , function(value, key){
				if(value.isChecked == 'Y'  ){
					oNo.push(value.no)
				}
			});
			$scope.checkedCnt = oNo.length;

			if($scope.checkedCnt > 0 ){
				$j('#main_menu').addClass("hide")
				$j('.extra_menu').removeClass("hide")
			}else{
				$j('#main_menu').removeClass("hide")
				$j('.extra_menu').addClass("hide")
				$j('#allList').attr("checked", false);
			}
		}

		$scope.orderChange = function (flag){ // 리스트 정렬 
			var event_target = typeof event.target !== "undefined" 	? event.target  : window.event.srcElement;
			var $_taget = null;

			$j('.orderClass').addClass('absolute_hide')
			$j('.orderClass').parent().removeClass('active')
			$j('.orderClass').removeClass('up down')

			if($j(event_target).is('a') == true)
				$_taget = $j(event_target).find('span');
			else
				$_taget = $j(event_target).parent().find('span');


			$_taget.removeClass('absolute_hide')
			$_taget.parent().addClass('active')

			if($scope.orderby != flag){
				$scope.orderby = flag;
				$scope.order = 'asc';	
			}else{
				if($scope.order == 'desc')
					$scope.order = 'asc';
				else
					$scope.order = 'desc';
			}

			if($scope.order == 'desc')
				$_taget.addClass('down')
			else
				$_taget.addClass('up')

			$scope.initializeList('init');
		}


		$scope.initializeList  = function(flag){

			if(flag == 'init')
				$scope.selectpage = 1;

			Server.post(Common.getRoot()+'addr/addr_ajax/trashAddress'  , { countPerPage :  $scope.countPerPage  , page : $scope.selectpage , order : $scope.order , orderby :  $scope.orderby , chosung : $scope.chosung , star : $scope.star , search_word : $scope.search_word , search_type : $scope.search_type }  ).success(function(data){
				if(data.resultCode == "SUCCESS"){
					PageFactory.init( {	itemsPerPage :   $scope.itemsPerPage ,	currentPage : $scope.selectpage ,	rangeSize : 10 ,	totalCount : data.result.total	});
					$scope.PageFactory = PageFactory; 
					$scope.TrashAddrList =data.result.result;	
					$scope.TrashAddrCount = data.result.total;
					$scope.checkedCnt = 0;
					if($scope.checkedCnt > 0 ){
						$j('#main_menu').addClass("hide")
						$j('.extra_menu').removeClass("hide")
					}else{
						$j('#main_menu').removeClass("hide")
						$j('.extra_menu').addClass("hide")
					}
				}else{
					PageFactory.init( {	itemsPerPage :   $scope.itemsPerPage  ,	currentPage : 1,	rangeSize : 10 ,	totalCount : 0	});
					$scope.PageFactory = PageFactory; 
					$scope.TrashAddrList =[];	
					$scope.TrashAddrCount = 0;
				}
				$scope.paginationButtonStyle();
				$scope.selectpage  = PageFactory.currentPage ;
				$scope.generateHashUrl();
			}).error(function(data, status, headers, config) {
				alert('error_initializeList')
			});
			$j('#allList').attr("checked", false);
			$j('#main_menu').removeClass("hide")
			$j('.extra_menu').addClass("hide")
		}

		$scope.paginationButtonStyle = function (){
			var currentPage = $scope.PageFactory.currentPage;
			var rangeSize =  $scope.PageFactory.rangeSize;
			var totalPage =  $scope.PageFactory.totalPage;

			if(currentPage == 1){
				$j('#goFirstPage').hide(); 
				$j('#goPrev10Page').hide(); 
			}else if (currentPage <= rangeSize ){
				$j('#goFirstPage').show(); 
				$j('#goPrev10Page').hide(); 
			}else if (currentPage > rangeSize){
				$j('#goFirstPage').show(); 
				$j('#goPrev10Page').show(); 
			}

			if(currentPage == totalPage){
				$j('#goNext10Page').hide(); 
				$j('#goLastPage').hide(); 
			}else if (currentPage < totalPage && currentPage > Math.floor(totalPage/rangeSize)*rangeSize ){
				$j('#goNext10Page').hide(); 
				$j('#goLastPage').show(); 
			}else if (currentPage < totalPage &&  currentPage <= Math.floor(totalPage/rangeSize)*rangeSize ){
				$j('#goNext10Page').show(); 
				$j('#goLastPage').show(); 
			}
		}

		$scope.setPage = function(n){
			Server.post(Common.getRoot()+'addr/addr_ajax/trashAddress'  , { countPerPage :  $scope.countPerPage  , page : n , order : $scope.order , orderby :  $scope.orderby , chosung : $scope.chosung , star : $scope.star , search_word : $scope.search_word , search_type : $scope.search_type}  ).success(function(data){
				$scope.TrashAddrList = data.result.result; 
			}).error(function(data, status, headers, config) {
				alert('error_setPage')
			});
			PageFactory.setPage(n);
			$scope.selectpage  = PageFactory.currentPage ;
			$scope.paginationButtonStyle();

			$scope.checkedCnt = 0;
			$j('#allList').attr("checked", false);
			$j('#main_menu').removeClass("hide")
			$j('.extra_menu').addClass("hide")
			$scope.generateHashUrl();
		}

		$scope.generateHashUrl = function(){
			var tmp_str ='';
			$scope.listOPT.countPerPage = $scope.countPerPage;
			$scope.listOPT.itemsPerPage = $scope.itemsPerPage;
			$scope.listOPT.chosung		= $scope.chosung;
			$scope.listOPT.order			= $scope.order;
			$scope.listOPT.orderby		= $scope.orderby;
			$scope.listOPT.star				= $scope.star;
			$scope.listOPT.kind			= $scope.kind;
			$scope.listOPT.search_word	= $scope.search_word;
			$scope.listOPT.search_type	= $scope.search_type;
			$scope.listOPT.startPage	= $scope.selectpage;

			angular.forEach($scope.listOPT , function(value, key){
				tmp_str += key+'='+value+'&'
			});
			tmp_str =  AddrNewCommon.encode(tmp_str.slice(0,-1))
			document.location.hash = tmp_str
		}

		$j(document).click(function(){	  // 메뉴텝 허용 이외의 영역 클릭시 
			var event_target = typeof event.target !== "undefined" 	? event.target  : window.event.srcElement;
			if (!$j(event_target).hasClass("popup_class"))	{
				$j('#dropDownListAnS').addClass("hide")
				$j('#dropDownListOrder').addClass("hide")	
			}
		});
		
		$scope.hideMenuTab = function (tab){
			if(tab == 'AnS'){
				$j('#dropDownListAnS').toggleClass('hide')
			}else if ( tab == 'Order'){
				$j('#dropDownListOrder').toggleClass('hide')
			}
		}
		// tab 관련 소스 end

		$scope.multySelectboxAction =  function(flag){
			var tmpPersonal = [];
			var tmpShared = [];
			var url = ''
			var param =''; 
			var bill_check = false;

			angular.forEach($scope.TrashAddrList , function(value, key){
				if(value.isChecked == 'Y'){
					if(value.kind == 'P'){
						tmpPersonal.push(value.no)
					}else{
						tmpShared.push(value.no)
					}

					if(value.bill_flag == 'Y'){
						bill_check = true;
					}
				}
			});


			if( parseInt(tmpPersonal.length) + parseInt(tmpShared.length) <= 0  ){
				alert(lang.getMessage("JONonSelectAddress"));
				return;
			}

			if (flag == 'clear')
			{
				var message = lang.getMessage("ADDR_TEXT_NONRECOVERY");

				if(bill_check == true){
					message = lang.getMessage("ADDR_TEXT_NONRECOVERY_BILL")
				}

				if(confirm(message)) {
					param = { 'trashPersonal' : tmpPersonal , 'trashShared' : tmpShared }
					url  = 'addr/addr_ajax/clearSelAddress';
				}else{
					return;
				}
			}else if (flag == 'restore')
			{
				if(confirm(lang.getMessage("JAAddressRestore"))){
					param = { 'restorePersonal' : tmpPersonal , 'restoreShared' : tmpShared }
					url  = 'addr/addr_ajax/restoreSelAddress';
				}else{
					return;
				}
			}

			Server.post(Common.getRoot()+ url  , param  ).success(function(data){
				$scope.initializeList();
			}).error(function(data, status, headers, config) {
				
				if(flag == 'restore'){
					alert(lang.getMessage("JARestoreFail"));
				}else{
					alert('error_multySelectboxAction')
				}
			});
		}

		if(window.location.hash !='' ){  
			var HashArr = AddrNewCommon.getHashObject(window.location.hash);
			angular.extend($scope.listOPT, HashArr);
		}

		$scope.countPerPage = $scope.listOPT.countPerPage;
		$scope.itemsPerPage = $scope.listOPT.itemsPerPage;
		$scope.chosung		= $scope.listOPT.chosung;
		$scope.order			= $scope.listOPT.order;
		$scope.orderby		= $scope.listOPT.orderby;
		$scope.star				= $scope.listOPT.star;
		$scope.selectpage	= $scope.listOPT.startPage;
		$scope.kind			= $scope.listOPT.kind;
		$scope.search_word	= $scope.listOPT.search_word;
		$scope.search_type	= $scope.listOPT.search_type;

		$j('.chosungNomal[value="'+$scope.chosung+'"]').toggleClass('on')	// 초성

		if($scope.star == 'Y'){
			$scope.viewAnSnT ='별 표시'
		}

		if($scope.search_word != '' && $scope.search_type != '' ){
			$j('#txtSearch').val($scope.search_word)
			$j('#search_reset').show()
		}
		$scope.initializeList()
		$scope.paginationButtonStyle();
	}]);
}

function addrCtrlPage_combine(initData , listOPT) {// addr/main/ personal shared
	var app = angular.module("AddrCombineApp", ['PageFactory']);
	init_addrFactory(app); 
	app.controller("AddrCombineCtrl", ['$scope', 'Server', 'PageFactory' , 'Useable' , function($scope , Server , PageFactory ,Useable ) {
		$scope.PageFactory = PageFactory; 
		$scope.Useable = Useable;
		$scope.initData = initData
		$scope.tag_list = initData.tag_list.result; 
		$scope.listOPT = listOPT; 
		$scope.viewAnSnT = initData.viewAnSnT_Txt;
		$scope.AddrCount = 0; 
		$scope.AddrList = '';
		$scope.DetailData = [];	// 한 주소의 상세 정보 객체
		$scope.checkedCnt = 0;

		if($scope.tag_list.length == 0 )
			$j('.tag_class').hide()

		$j('.chosungNomal').click(function(){	// 초성 선택
			$scope.chosung = $j(this).attr('value');
			$j('.chosungNomal').removeClass('on');
			$j(this).toggleClass('on');
			$scope.initializeList('init')
		});

		$scope.StarCheck = function(PA){ 	// 별 표시 -단일 -
			if(PA.star == 'N' ){		PA.star = 'Y'		}else{		PA.star = 'N'		}
			Server.post(Common.getRoot()+'addr/addr_ajax/setAddressStar'  , { addr_no :  PA.no , star : PA.star , kind : initData.kind }  ).success(function(data){
			}).error(function(data, status, headers, config) {
				alert('error')
			});
		}

		$scope.StarCheckShared = function(PA){ 	// 별 표시 -단일 공유 주소록 -
			if(PA.star == 'N' ){		PA.star = 'Y'		}else{		PA.star = 'N'		}
			Server.post(Common.getRoot()+'addr/addr_ajax/setLabel'  , { no :  PA.no  }  ).success(function(data){
			}).error(function(data, status, headers, config) {
				alert('error')
			});
		}

		$scope.insertTagOnly = function (){
			var type = $scope.initData.kind;
			var tagName  = $j('#insertTagInput').val().trim();
			var duplicate_flag = false;
			
			angular.forEach($scope.tag_list , function(value, key){
				
				if(value.name ==tagName ){
					duplicate_flag = true;
				}
			});

			if(tagName == ''){
				alert('태그명을 입력하세요');
				return;
			}else if(duplicate_flag){
				alert('동일한 태그명은 사용할 수 없습니다.');
				$j('#insertTagInput').val('')
				return;
			}else{
				
				Server.post( Common.getRoot() + 'addr/addr_ajax/insertTagOnly', { 'tagName' : tagName , 'type' :  type }).success(function(data){
					$scope.tag_list.push($j.parseJSON(data.result))
					$j('#insertTagInput').val('')
				}).error(function(data, status, headers, config) {
					alert('error');
				})
			}
		}

		$scope.removeAddrTags = function (){
			var event_target = typeof event.target !== "undefined" 	? event.target  : window.event.srcElement;
			var tmp_arr =[];
			var kind = $scope.initData.kind;

			angular.forEach($scope.AddrList , function(value, key){
				if(value.isChecked == 'Y'  ){
					tmp_arr.push(value.no)
				}
			});

			Server.post(Common.getRoot()+'addr/addr_ajax/removeAddrTags'  , { addr_no_arr :  tmp_arr , flag : 'removeAddrTags' , kind : kind }  ).success(function(data){
				$scope.initializeList('init')
			}).error(function(data, status, headers, config) {
				alert('error')
			});
		}

		$scope.removeOneTag = function (TAG){
		
			if(confirm(TAG.name+' 태그를 삭제하시겠습니까?')){
				var kind = $scope.initData.kind;
				var tmp_arr =[];
				tmp_arr.push(TAG.no)

				Server.post(Common.getRoot()+'addr/addr_ajax/removeAddrTags'  , { addr_no_arr :  tmp_arr , flag : 'removeOneTag'  , kind : kind  }  ).success(function(data){
					$scope.initializeList()
					var tmp_tag = $j.parseJSON(data.result) ; 
					$scope.tag_list  = tmp_tag.result;
				}).error(function(data, status, headers, config) {
					alert('error')
				});
			}
		}

		$scope.MultiStarCheck = function(){// 별 표시 -복수 -
			var event_target = typeof event.target !== "undefined" 	? event.target  : window.event.srcElement;
			var star ;
			var tmp_arr =[];
			var tmpStr ;
			if($j(event_target).hasClass('all_star_y')){star = 'Y';}else{star = 'N';}
			angular.forEach($scope.AddrList , function(value, key){
				if(value.isChecked == 'Y'  ){
					value.star = star;
					tmp_arr.push(value.no)
				}
			});

			if (initData.kind == 'P')	{
				if(tmp_arr.length ==  0 ){
					alert(lang.getMessage("JONonSelectAddress"));
					return;
				}else{
					tmpStr =tmp_arr.join("/");
				}

				Server.post(Common.getRoot()+'addr/addr_ajax/setAddressStar'  , { addr_no :  tmpStr , star : star  , kind : initData.kind }  ).success(function(data){
					$scope.initializeList()
				}).error(function(data, status, headers, config) {
					alert('error')
				});
			}else{
				if(tmp_arr.length ==  0 ){
					alert(lang.getMessage("JONonSelectAddress"));
					return;
				}else{
					Server.post(Common.getRoot()+'addr/addr_ajax/setLabelMulti'  , { addr_arr :  tmp_arr , star : star  }  ).success(function(data){
						$scope.initializeList()
					}).error(function(data, status, headers, config) {
						alert('error')
					});
				}
			}
		}

		$scope.checkBoxCntFnc = function (){
			var oNo =[];
			angular.forEach($scope.AddrList , function(value, key){
				if(value.isChecked == 'Y'  ){
					oNo.push(value.no)
				}
			});
			$scope.checkedCnt = oNo.length;

			if($scope.checkedCnt > 0 ){
				$j('#main_menu').addClass("hide")
				$j('.extra_menu').removeClass("hide")
			}else{
				$j('#main_menu').removeClass("hide")
				$j('.extra_menu').addClass("hide")
				$j('#allList').attr("checked", false);
			}
		}

		$scope.copyToSharedAddress = function (){ // 공유  주소에 복사
			var oNo =[];
			var oLabel =[];
			var oTag = [];
			var pUpdate = '0';

			angular.forEach($scope.AddrList , function(value, key){
				if(value.isChecked == 'Y'  ){
					oNo.push(value.no)
				}
			});

			if(oNo.length ==  0 ){
				alert(lang.getMessage("JONonSelectAddress"));
				return;
			}else if(confirm(lang.getMessage("CONFIRM_COPYTOSHARED")) ) {
				for(var i = 0 ; i < oNo.length  ; i++ ){	oLabel.push('0');		}

				Server.post(Common.getRoot()+'addr/addr_ajax/copyToShare'  ,  { 'oNo' : oNo, 'oLabel' : oLabel, 'oTag' : oTag, 'pUpdate' : pUpdate }  ).success(function(data){
					alert(lang.getMessage("ADDR_TEXT_COPYTOSHARE_NEW"));
				}).error(function(data, status, headers, config) {		alert('error')	});
				$scope.initializeList()
			}
		}

		$scope.showDetailView = function (AddrObject){ // 개인 상세 정보 페이지 보이기 
			Server.post(Common.getRoot()+'addr/addr_ajax/addressDetailView'  , { kind : initData.kind  , no : AddrObject.no }  ).success(function(data){
				$scope.DetailData = data.result;
			}).error(function(data, status, headers, config) {		alert('error')	});
			AddrNewCommon.showPopup($j('#addressDetailView'));
		}

		$scope.hideDetailView = function (){ // 개인 상세 정보 페이지 닫기
			$scope.DetailData = [];
			AddrNewCommon.hidePopup($j('#addressDetailView'));
		}

		$scope.showTagManageView = function (){ 
			AddrNewCommon.showPopup($j('#addressTagManageView'));
		}

		$scope.hideTagManageView = function (){ 
			AddrNewCommon.hidePopup($j('#addressTagManageView'));
		}

		$scope.rename_tag			= function (tag, mode){	tag.mode_flag =mode }

		$scope.rename_tag_confirm = function(tag) {
			var event_target = typeof event.target !== "undefined" 	? event.target  : window.event.srcElement;
			var rename = $j(event_target).parent().parent().find('input').val().trim();

			if( rename == '' ){
				alert('공백은 허용되지 않습니다.');
				return;
			}else{
				Server.post(Common.getRoot()+'addr/addr_ajax/renameTag'  , { kind : initData.kind  , tagName : rename , tagNo : tag.no }  ).success(function(data){
					alert(data.message)
					tag.mode_flag = 'nomal';
					if(rename_tag_confirm == 'SUCCESS')
						tag.name = rename;
					
				}).error(function(data, status, headers, config) {		alert('error')	});
			}
		}

		$scope.initializeList  = function(flag){ // 페이지 네이션 초기화 작업
			if(flag == 'init')
				$scope.selectpage = 1;

			Server.post(Common.getRoot()+'addr/addr_ajax/getAddressList'  ,  { countPerPage :  $scope.countPerPage  , startPage : $scope.selectpage , order : $scope.order , orderby :  $scope.orderby , chosung : $scope.chosung  , star : $scope.star , kind : $scope.kind  ,  tagNo : $scope.tagNo , search_word : $scope.search_word , search_type : $scope.search_type }   ).success(function(data){
				if(data.resultCode == "SUCCESS"){
					PageFactory.init( {	itemsPerPage :     $scope.itemsPerPage ,	currentPage : $scope.selectpage,	rangeSize : 10 ,	totalCount : data.total	});
					$scope.PageFactory = PageFactory; 
					$scope.AddrList =data.result;	
					$scope.AddrCount = data.total;
					$scope.checkedCnt = 0;
				}else{
					PageFactory.init( {	itemsPerPage :    $scope.itemsPerPage  ,	currentPage : 1,	rangeSize : 10 ,	totalCount : 0	});
					$scope.PageFactory = PageFactory; 
					$scope.AddrList =[];	
					$scope.AddrCount = 0;
					$scope.checkedCnt = 0;
				}

				$scope.paginationButtonStyle();
				$scope.selectpage  = PageFactory.currentPage ;
				if($scope.checkedCnt > 0 ){
					$j('#main_menu').addClass("hide")
					$j('.extra_menu').removeClass("hide")
				}else{
					$j('#main_menu').removeClass("hide")
					$j('.extra_menu').addClass("hide")
				}
				$j('#allList').attr("checked", false);
				$scope.generateHashUrl();		
			}).error(function(data, status, headers, config) {	alert('error')	});
		}

		$scope.paginationButtonStyle = function (){
			var currentPage = $scope.PageFactory.currentPage;
			var rangeSize =  $scope.PageFactory.rangeSize;
			var totalPage =  $scope.PageFactory.totalPage;

			if(currentPage == 1){
				$j('#goFirstPage').hide(); 
				$j('#goPrev10Page').hide(); 
			}else if (currentPage <= rangeSize ){
				$j('#goFirstPage').show(); 
				$j('#goPrev10Page').hide(); 
			}else if (currentPage > rangeSize){
				$j('#goFirstPage').show(); 
				$j('#goPrev10Page').show(); 
			}

			if(currentPage == totalPage){
				$j('#goNext10Page').hide(); 
				$j('#goLastPage').hide(); 
			}else if (currentPage < totalPage && currentPage > Math.floor(totalPage/rangeSize)*rangeSize ){
				$j('#goNext10Page').hide(); 
				$j('#goLastPage').show(); 
			}else if (currentPage < totalPage &&  currentPage <= Math.floor(totalPage/rangeSize)*rangeSize ){
				$j('#goNext10Page').show(); 
				$j('#goLastPage').show(); 
			}
		}

		$scope.setPage = function(n){ //페이지 이동 
			Server.post(Common.getRoot()+'addr/addr_ajax/getAddressList'  , { countPerPage :  $scope.countPerPage  , startPage : n , order : $scope.order , orderby :  $scope.orderby , chosung : $scope.chosung  , star : $scope.star , kind : $scope.kind   , tagNo : $scope.tagNo , search_word : $scope.search_word , search_type : $scope.search_type  }  ).success(function(data){
					$scope.AddrList = data.result; 
				}).error(function(data, status, headers, config) {		alert('error')	});
			PageFactory.setPage(n);
			
			$scope.selectpage  = PageFactory.currentPage ;
			$scope.paginationButtonStyle();
			$scope.checkedCnt = 0;
			$j('#allList').attr("checked", false);
			$j('#main_menu').removeClass("hide")
			$j('.extra_menu').addClass("hide")
			$scope.generateHashUrl();
		}
		
		$scope.hideMenuTab = function (tab){  // 메뉴텝 닫기 
			if(tab == 'AnSnT' || tab == 'orderListPopUp' || tab == 'insertTagPopUp' || tab == 'anotherCommendPopUp' ){
				$j('#'+tab).toggleClass('hide')
			}
		}

		$scope.orderList = function (flag){ // 리스트 정렬 
			if($scope.orderby != flag){
				$scope.orderby = flag;
				$scope.order = 'asc';	
			}else{
				if($scope.order == 'desc')
					$scope.order = 'asc';
				else
					$scope.order = 'desc';
			}
			$scope.initializeList('init');
		}

		$scope.getAnSnT = function (flag) { // 전체 리스트 , 별,  태그 설정
			var event_target = typeof event.target !== "undefined" 	? event.target  : window.event.srcElement;

			if($j(event_target).is('span') == true){
				$scope.viewAnSnT =  $j(event_target).parent().text();
			}else{
				$scope.viewAnSnT =  $j(event_target).text();
			}

			if(flag == 'star_n'){ // 전체
				$scope.star = 'N';
				$scope.tagNo = '';
			}else if (flag == 'star_y'){ // 별만
				$scope.star = 'Y';
				$scope.tagNo = '';
			}else{ // 태그
				$scope.star = 'N';
				$scope.tagNo = flag;
			}
			$scope.initializeList('init')
		}

		$scope.sendMailSelected = function (){	// 메일보내기 
			var tmp_mail_add =[];
			var checkCnt = 0;
			var tmpStr ='';
			angular.forEach($scope.AddrList , function(value, key){
				if(value.isChecked == 'Y' && value.email != '' && AddrNewCommon.isEmail(value.email) ){
					tmp_mail_add.push(value.no)
				}
				if(value.isChecked == 'Y')
					checkCnt++;
			});

			if(checkCnt == 0){
				alert(lang.getMessage("JONonSelectAddress"));
				return;
			}else if(tmp_mail_add.length ==  0 ){
				alert(lang.getMessage("MAIL_SEND_ERROR"));
				return;
			}else{
				tmpStr +=tmp_mail_add.join("/");
			}
			window.location = Common.getRoot() + "mail/webmail/m_write/new/address/" + initData.kind + '/' + tmpStr;
		}

		$scope.sendSmsSelected = function (){	
			var tmp_name_addr =[];	
			var tmp_phone_addr =[];
			var checkCnt = 0;
			var tmp_name_str ='';
			var tmp_phone_str ='';
			var alert_flag = false; 

			angular.forEach($scope.AddrList , function(value, key){
				if(value.isChecked == 'Y' && value.phone != '' && value.name != '' && AddrNewCommon.cellphone(value.phone) ){
					tmp_name_addr.push(value.name);
					tmp_phone_addr.push(value.phone);
				}

				if(value.isChecked == 'Y' && (!AddrNewCommon.cellphone(value.phone) ||  value.phone == ''))
					alert_flag = true;

				if(value.isChecked == 'Y')
					checkCnt++;
			});

			if(checkCnt == 0){
				alert(lang.getMessage("JONonSelectAddress"));
				return;
			}else if(tmp_name_addr.length ==  0 ){
				alert(lang.getMessage("JONSelectedWithoutNoCell"));
				return;
			}else{
				if(alert_flag)
					alert(lang.getMessage("JONSelectedWithoutNoCell"));

				tmp_name_str	+= tmp_name_addr.join(",");
				tmp_phone_str	+= tmp_phone_addr.join(",");
			}
			$j('#form_sms input[name="phone_num"]').val(tmp_phone_str)
			$j('#form_sms input[name="phone_name"]').val(tmp_name_str)
			$j('#form_sms').submit()
		}

		$scope.deleteSelected = function(){  // 복수 주소 삭제 
			var tmp_delete_arr =[];
			var tmpStr ='/';
			var bill_check = false;
			var message = lang.getMessage("LangRealDeleteOK")

			if($j('.listbox input[type="checkbox"]:checked').length == 0 ){
				alert(lang.getMessage("JONonSelectAddress"));
				return;
			}

			angular.forEach($scope.AddrList , function(value, key){
				if(value.isChecked == 'Y'  ){
					tmp_delete_arr.push(value.no)

					if(value.bill_flag == 'Y'){
						bill_check = true;
					}
				}
			});
			tmpStr +=tmp_delete_arr.join("/");

			if(bill_check == true){
				message = lang.getMessage("ADDR_TEXT_NONRECOVERY_BILL")
			}

			if(confirm(message)) {
				Server.post(Common.getRoot() + 'addr/addr_ajax/deleteAddress'  , { 'kind' : initData.kind , 'deleteStr' : tmpStr }  ).success(function(data){
					$scope.initializeList()
				}).error(function(data, status, headers, config) {	alert(lang.getMessage("JADeleteFail2"));});
			}
		}

		$scope.deleteOne = function(OB){ // 단일 주소 삭제 
			event.preventDefault ? event.preventDefault() : event.returnValue = false;
			var tmpStr ='/';
			var message =lang.getMessage("LangRealDeleteOK");

			if(OB.bill_flag == 'Y')
				message =lang.getMessage("ADDR_TEXT_NONRECOVERY_BILL");

			if(confirm(message)) {
				tmpStr += OB.no ;
				Server.post(Common.getRoot() + 'addr/addr_ajax/deleteAddress'  , { 'kind' : initData.kind , 'deleteStr' : tmpStr }  ).success(function(data){
					$scope.initializeList();
					$scope.hideDetailView();
				}).error(function(data, status, headers, config) {		alert(lang.getMessage("JADeleteFail2"));});
			}
		}

		$scope.modifyOne =  function(OB){
			event.preventDefault ? event.preventDefault() : event.returnValue = false;
			$j('#modify_form [name="no"]').val(OB.no);
			$j('#modify_form').submit();
		}

		$scope.insertTagSubmit = function (TAG){ // 선택한 주소에 태그 추가
			var arrTag = TAG.name;
			var tmp_arr =[];

			angular.forEach($scope.AddrList , function(value, key){
				if(value.isChecked == 'Y'  ){
					tmp_arr.push(value.no)
				}
			});

			if(tmp_arr.length == 0){
				alert(lang.getMessage("JONonSelectAddress"));
				return;
			}else if(arrTag == '' ){
				alert(lang.getMessage("JAInputTag"));
				return;
			}else if(tmp_arr.length  > 0 ){
				Server.post(Common.getRoot() + 'addr/addr_ajax/insertTages'  , {	arrAddrNo: tmp_arr.join(',') , arrTag: arrTag , kind: initData.kind
					}).success(function(data){
					var tag_result = $j.parseJSON(data.result);
					$scope.tag_list = tag_result.result.result;
					$j('#insertTagInput').val('')
					$scope.initializeList()

					if($scope.tag_list.length != 0 )
						$j('.tag_class').show()

				}).error(function(data, status, headers, config) {				alert("error");});
			}
		}

		$scope.generateHashUrl = function(){
			var tmp_str ='';
			$scope.listOPT.countPerPage = $scope.countPerPage;
			$scope.listOPT.itemsPerPage = $scope.itemsPerPage;
			$scope.listOPT.chosung		= $scope.chosung;
			$scope.listOPT.order			= $scope.order;
			$scope.listOPT.orderby		= $scope.orderby;
			$scope.listOPT.star				= $scope.star;
			$scope.listOPT.tagNo			= $scope.tagNo;
			$scope.listOPT.kind			= $scope.kind;
			$scope.listOPT.search_word	= $scope.search_word;
			$scope.listOPT.search_type	= $scope.search_type;
			$scope.listOPT.startPage	= $scope.selectpage;

			angular.forEach($scope.listOPT , function(value, key){
				tmp_str += key+'='+value+'&'
			});
			tmp_str =  AddrNewCommon.encode(tmp_str.slice(0,-1))
			document.location.hash = tmp_str
		}

		$j(document).click(function(){	  // 메뉴텝 허용 이외의 영역 클릭시 
			var event_target = typeof event.target !== "undefined" 	? event.target  : window.event.srcElement;
			if (!$j(event_target).hasClass("popup_class"))	{
				$j('.dropdown').addClass("hide")	
			}
		});

		if(window.location.hash !='' ){  
			var HashArr = AddrNewCommon.getHashObject(window.location.hash);
			angular.extend($scope.listOPT, HashArr);
		}

		$scope.countPerPage = $scope.listOPT.countPerPage;
		$scope.itemsPerPage = $scope.listOPT.itemsPerPage;
		$scope.chosung		= $scope.listOPT.chosung;
		$scope.order			= $scope.listOPT.order;
		$scope.orderby		= $scope.listOPT.orderby;
		$scope.star				= $scope.listOPT.star;
		$scope.tagNo			= $scope.listOPT.tagNo;
		$scope.selectpage	= $scope.listOPT.startPage;
		$scope.kind			= $scope.listOPT.kind;
		$scope.search_word	= $scope.listOPT.search_word;
		$scope.search_type	= $scope.listOPT.search_type;

		$j('.chosungNomal[value="'+$scope.chosung+'"]').toggleClass('on')	// 초성
		
		if($scope.star == 'Y'){
			$scope.viewAnSnT ='별 표시'
		}

		if($scope.tagNo !=''){
			angular.forEach($scope.tag_list , function(value, key){
				if(value.no == $scope.tagNo){
					$scope.viewAnSnT = value.name+' ('+value.tagCnt+')'
				}
			})
		}

		if($scope.listOPT.search_word != '' && $scope.listOPT.search_type != '' ){
			$j('#txtSearch').val($scope.listOPT.search_word)
			$j('#search_reset').show()
		}
		$scope.initializeList()
		$scope.paginationButtonStyle();
	}]);
}

function addrCtrlPage_add(){// addr/main/addr_add
	var app = angular.module("AddrAddApp", []);
	init_addrFactory(app); 

	app.controller("AddrAddCtrl", ['$scope', 'Server', function($scope , Server ) {
		$scope.emails = [{'remove_flag' : 'N' }];
		$scope.phones = [{'remove_flag' : 'N' }];
		$scope.websites = [{ 'remove_flag' : 'N' }];
		$scope.anniversaries = [{ 'remove_flag' : 'N' }];
		$scope.addresses = [{ 'remove_flag' : 'N' }];
		$scope.sidos = [] ;  // 시도 정보
		$scope.si_gu_guns = [] ;  // 시도 정보
		$scope.dongs = [] ;  // 동 정보
		$scope.detailAddresInfo = [] ;  // 상세 정보
		$scope.selectedDI =[];
		$scope.tags = [];

		$scope.SearchZipAddrType = 'Jibun';
		var $_THIS_TMP = '';

		$scope.addInfomation = function ( flag ){
			var model ='';
			if(flag == 'email'){	$_scopModel = $scope.emails;	}
			else if (flag == 'phone'){	$_scopModel = $scope.phones;	}
			else if (flag == 'website'){		$_scopModel =$scope.websites;}
			else if (flag == 'anniversary'){		$_scopModel =$scope.anniversaries;}
			else if (flag == 'address'){		$_scopModel =$scope.addresses;}

			if($_scopModel.length < 5 ){

				$_scopModel.push( { 'remove_flag' : 'Y' } )
				model = $_scopModel;
			}else{
				alert(lang.getMessage("ELEMENT_LIMIT_ERROR"));
			}	

			$_scopModel[0].remove_flag ='N'
		}

		$scope.removeInfomation = function ( flag ){
			var model = '';
			if(flag == 'email'){	model = $scope.emails;}
			else if (flag == 'phone'){	model = $scope.phones;	}
			else if (flag == 'website'){	model = $scope.websites;	}
			else if (flag == 'anniversary'){	model = $scope.anniversaries;	}
			else if (flag == 'address'){	model = $scope.addresses;	}
			model.splice(this.$index ,1);
		}

		$scope.getTagList = function (){
			Server.post( Common.getRoot() + 'addr/addr_ajax/getTagList', {kind: $j('.addrtype input:checked').val() , orderby:'a.name'}).success(function(data){
				var tag_result =$j.parseJSON(data.result);
				if(tag_result.total > 0 ){
					$scope.tags =tag_result.result;
					AddrNewCommon.showPopup($j('.tagLayer'));
				}else{
					alert(lang.getMessage("JANonExistTag"));
					return;
				}
			});
		}

		$scope.addrTypeRadioFnc = function (){	// 지번주소 도로명 주소 선택
			$j('#Jibun_search_tab').toggleClass('hide')
			$j('#Doro_search_tab').toggleClass('hide')
			$j('.search_info_tab').toggleClass('hide')
			$j('.detail_addr_list_tab').addClass('hide')
		}

		$scope.SearchAddressLayer = function (){ // 우편번호 검색 레이어 
			$scope.sidos = [] ;  // 시도 정보
			$scope.si_gu_guns = [] ;  // 시도 정보
			$scope.dongs = [] ;  // 동 정보
			$scope.detailAddresInfo = [] ;  // 상세 정보
			$j('.detail_addr_list_tab').addClass('hide')
			$j('#layer_level_1').removeClass('hide'); 
			$j('#layer_level_2').addClass('hide'); 
			$j('.resetTab').val('')

			var event_target = typeof event.target !== "undefined" 	? event.target  : window.event.srcElement;
			$_THIS_TMP = $j(event_target).parent().find('input');

			if($scope.sidos.length == 0 ){
				Server.jsonp( "https://biz.gabia.com/common/addr_ajax/gabia_address_api?callback=JSON_CALLBACK&", "flag=sido" ).success(function(data){
					$scope.sidos = data.result;
					$scope.sido_no =  ''
					AddrNewCommon.showPopup($j('#address_search_layer'));
				});
			}else{
				AddrNewCommon.showPopup($j('#address_search_layer'));
			}
		}

		$scope.getSigungu = function (gugun_no) { // 시 구 군 검색 창
			if(gugun_no != 'default'){

				Server.jsonp( "https://biz.gabia.com/common/addr_ajax/gabia_address_api?callback=JSON_CALLBACK&", "flag=gugun&gugun_no="+gugun_no ).success(function(data){
					$scope.si_gu_guns = data.result;
					$scope.dong_no ='';
				});
			}else{
				$scope.si_gu_guns = [] ; 
			}
		}

		$scope.getDong = function (dong) {  //동(洞) 리스트 받아오기
			if(dong != ''){
				Server.jsonp( "https://biz.gabia.com/common/addr_ajax/gabia_address_api?callback=JSON_CALLBACK&", "flag=dong&dong_no="+dong ).success(function(data){
					angular.forEach(data.result , function(value, key){
						if(value.ri != null){
							value.dong_ri = value.dong+" "+value.ri
						}else{
							value.dong_ri= value.dong
						}
					});
					$scope.dongs =  data.result
				});
			}
		}

		$scope.getJibunList = function (){
			if( !$j.isNumeric($scope.sido_no) || !$j.isNumeric($scope.sgg_no)  || !$j.isNumeric($scope.dong_no) ){
				alert(lang.getMessage("ADDR_TEXT_JIBUN_ERROR"));
				return;
			}

			Server.jsonp( "https://biz.gabia.com/common/addr_ajax/gabia_address_api?callback=JSON_CALLBACK&", "type=ji_num&sido_code="+$scope.sido_no+"&gugun_code="+$scope.sgg_no+"&word="+$scope.dong_no +"&extra_no="+$j('#Jibun_search_tab input').val()+"&flag="+"getDetailAddList" ).success(function(data){
				if(data.result != null && jQuery.type( data.result ) !== "string"){
					$scope.detailAddresInfo = data.result;
					$j('.detail_addr_list_tab').removeClass('hide')
				}else{
					alert(lang.getMessage("ADDR_TEXT_NO_SEARCH_LIST"));
					return;
				}
			});
		}

		$scope.getDoroList = function (){
			if( !$j.isNumeric($scope.sido_no) || !$j.isNumeric($scope.sgg_no)  || $j('#Doro_search_tab input').eq(0).val() == '' ){
				alert(lang.getMessage("ADDR_TEXT_DORO_ERROR"));
				return;
			}

			Server.jsonp( "https://biz.gabia.com/common/addr_ajax/gabia_address_api?callback=JSON_CALLBACK&", "type=road_name&sido_code="+$scope.sido_no+"&gugun_code="+$scope.sgg_no+"&word="+$j('#Doro_search_tab input').eq(0).val() +"&extra_no="+$j('#Doro_search_tab input').eq(1).val()+"&flag="+"getDetailAddList" ).success(function(data){
				if(data.result != null){
					$scope.detailAddresInfo = data.result;
					$j('.detail_addr_list_tab').removeClass('hide')
				}else{
					alert(lang.getMessage("ADDR_TEXT_NO_SEARCH_LIST"));
					return;
				}
			});
		}

		$scope.getDetailAddressString = function (){
			var zip_code = $j('#layer_level_2 tr').eq(1).find('td').eq(0).text();
			var detail_add1 = $j('#layer_level_2 tr').eq(1).find('td').eq(1).text();
			var detail_add2 = $j('#layer_level_2 input').val();
			$_THIS_TMP.val(detail_add1+" "+detail_add2+" ("+zip_code+")")
			AddrNewCommon.hidePopup($j('#address_search_layer'));
		}

		$scope.checkDetailInfo = function (DI){
			$scope.selectedDI = DI ; 
			$j('#layer_level_1').addClass('hide'); 
			$j('#layer_level_2').removeClass('hide'); 
		}

		$scope.setting_tag = function (){
			var tmp_arr = [];
			var tmp_str = '';

			$j('#add_address_form input[name="tag"]').val('');
			angular.forEach($j('.tagLayer input:checked') , function(item, key){ 
				tmp_arr.push(item.value);
			})
			tmp_str = $j('#add_address_form input[name="tag"]').val();
			if(tmp_str == '' )
				$j('#add_address_form input[name="tag"]').val(tmp_arr.join(',')) 
			else
				$j('#add_address_form input[name="tag"]').val( tmp_str+','+tmp_arr.join(',')) 

			AddrNewCommon.hidePopup($j('.tagLayer'));
		}

		$scope.submit_address = function (flag){
			var isWhiteSpace = function(str){return  $j.trim(str) }
			var name = $j('#add_address_form input[name="name"]').val().trim();
			var email = [];
			var type = $j('input[name="type"]:checked').val();
			var phone = [];
			var tag = $j('#add_address_form input[name="tag"]').val();
			var website = [];
			var messenger = [];
			var address = [];
			var anniversary = [];
			var company = $j('#add_address_form input[name="addr_company"]').val();
			var department = $j('#add_address_form input[name="addr_department"]').val();
			var grade = $j('#add_address_form input[name="addr_grade"]').val();
			var memo = $j('#add_address_form textarea').val();
			var minimum_info = 3 ;  

			email			= AddrNewCommon.address_availabilityCheck($j('.addr_emails'), 'email');
			phone		= AddrNewCommon.address_availabilityCheck($j('.addr_phones'), 'phone');
			website		= AddrNewCommon.address_availabilityCheck($j('.addr_websites'), 'website');
			anniversary		= AddrNewCommon.address_availabilityCheck($j('.addr_anniversaries'), 'anniversary');
			address		= AddrNewCommon.address_availabilityCheck($j('.addr_address'), 'address');

			if(email === false || phone === false){		return;	}

			if( isWhiteSpace(name) ){ minimum_info--; }
			if( email.length == 0 ){ minimum_info--; }
			if( phone.length == 0 ){ minimum_info--; }
			if(minimum_info == 0 ){	alert(lang.getMessage("LAFieldsRequired"));	return;	}

			if(name == ''){		alert(lang.getMessage("ADDR_TEXT_NO_NAME"));	return;	}

			var addr_data = {name: name, email: email, phone: phone, tag: tag, website: website, messenger: messenger, address: address, anniversary: anniversary, company: company, department: department, grade: grade, memo: memo, kind: type, update: 0};

			Server.post(Common.getRoot()+'addr/addr_ajax/addAddress1'  , { "address" :  JSON.stringify(addr_data)  } 
			).success(function(data){
				
				if(data.resultCode == 'SUCCESS'){
					alert(lang.getMessage("PAGE_SAVE_OK"));

					if(flag != 'add_more'){
						if(type == 'P')
							window.location = Common.getRoot()+"addr/main/personal";
						else
							window.location = Common.getRoot()+"addr/main/shared";
					}else{
						document.location.reload();
					}
				}else{
					alert(data.message)
				}
				
			}).error(function(data, status, headers, config) {
				alert('error')
			});
		}
	}])
}

function addrCtrlPage_modify(initData){ // addr/main/addr_modify

	var app = angular.module("AddrModifyApp", []);
	init_addrFactory(app); 

	app.controller("AddrModifyCtrl", ['$scope', 'Server', function($scope , Server ) {
		$scope.emails =  initData.detail_info.result.email;
		$scope.phones = initData.detail_info.result.phone;
		$scope.websites = initData.detail_info.result.ext_website; 
		$scope.anniversaries = initData.detail_info.result.ext_anniversary; 
		$scope.addresses = initData.detail_info.result.ext_address; 
		$scope.sidos = [] ;  // 시도 정보
		$scope.si_gu_guns = [] ;  // 시도 정보
		$scope.dongs = [] ;  // 동 정보
		$scope.detailAddresInfo = [] ;  // 상세 정보
		$scope.selectedDI =[];
		$scope.tags = [];

		$scope.SearchZipAddrType = 'Jibun';
		var $_THIS_TMP = '';

		if($scope.websites.length == 0){$scope.websites.push( { 'websites' : '' , 'remove_flag' : 'N' } )	}
		if($scope.anniversaries.length == 0){	$scope.anniversaries.push( { 'year' : 'all_year' , 'month' : '1' , 'date' : '1' ,  'lunar' : 'S' ,  'remove_flag' : 'N' } )	}
		if($scope.addresses.length == 0){$scope.addresses.push( { 'type' : '집' ,'content' : '' , 'remove_flag' : 'N' } )	}

		$scope.tags = [];
		$scope.addInfomation = function ( flag ){
			var model ='';
			if(flag == 'email'){	$_scopModel = $scope.emails;	}
			else if (flag == 'phone'){	$_scopModel = $scope.phones;	}
			else if (flag == 'website'){		$_scopModel =$scope.websites;}
			else if (flag == 'anniversary'){	$_scopModel =$scope.anniversaries;}
			else if (flag == 'address'){		$_scopModel =$scope.addresses;}

			if($_scopModel.length < 5 ){
				if(flag == 'anniversary')
					$_scopModel.push( { 'remove_flag' : 'Y' , 'lunar' : 'S' } )
				else if (flag == 'address')
					$_scopModel.push( { 'remove_flag' : 'Y' , 'type' : '집' } )
				else
					$_scopModel.push( { 'remove_flag' : 'Y' } )

				model = $_scopModel;
			}else{
				alert(lang.getMessage("ELEMENT_LIMIT_ERROR"));
			}
			$_scopModel[0].remove_flag ='N'
		}

		$scope.removeInfomation = function ( flag ){
			var model = '';
			if(flag == 'email'){	model = $scope.emails;}
			else if (flag == 'phone'){	model = $scope.phones;	}
			else if (flag == 'website'){	model = $scope.websites;	}
			else if (flag == 'anniversary'){	model = $scope.anniversaries;	}
			else if (flag == 'address'){	model = $scope.addresses;	}
			model.splice(this.$index ,1);
		}

		$scope.getTagList = function (){
			Server.post( Common.getRoot() + 'addr/addr_ajax/getTagList', {kind: $j('.addrtype input:checked').val() , orderby:'a.name'}).success(function(data){
				var tag_result = $j.parseJSON(data.result);
				if(tag_result.total > 0 ){
					$scope.tags =tag_result.result;
					AddrNewCommon.showPopup($j('.tagLayer'));
				}else{
					alert(lang.getMessage("JANonExistTag"));
					return;
				}
			});
		}

		$scope.addrTypeRadioFnc = function (){	// 지번주소 도로명 주소 선택
			$j('#Jibun_search_tab').toggleClass('hide')
			$j('#Doro_search_tab').toggleClass('hide')
			$j('.detail_addr_list_tab').addClass('hide')
			$j('.detail_addr_list_tab').addClass('hide')
		}

		$scope.SearchAddressLayer = function (){ // 우편번호 검색 레이어 
			$scope.sidos = [] ;  // 시도 정보
			$scope.si_gu_guns = [] ;  // 시도 정보
			$scope.dongs = [] ;  // 동 정보
			$scope.detailAddresInfo = [] ;  // 상세 정보
			$j('.detail_addr_list_tab').addClass('hide')
			$j('#layer_level_1').removeClass('hide'); 
			$j('#layer_level_2').addClass('hide'); 
			$j('.resetTab').val('')

			var event_target = typeof event.target !== "undefined" 	? event.target  : window.event.srcElement;
			$_THIS_TMP = $j(event.target).parent().find('input');
			
			if($scope.sidos.length == 0 ){
				Server.jsonp( "https://biz.gabia.com/common/addr_ajax/gabia_address_api?callback=JSON_CALLBACK&", "flag=sido" ).success(function(data){
					$scope.sidos = data.result;
					$scope.sido_no =  ''
					AddrNewCommon.showPopup($j('#address_search_layer'));
				});
			}else{
				AddrNewCommon.showPopup($j('#address_search_layer'));
			}
		}

		$scope.getSigungu = function (gugun_no) { // 시 구 군 검색 창
			if(gugun_no != 'default'){
				Server.jsonp( "https://biz.gabia.com/common/addr_ajax/gabia_address_api?callback=JSON_CALLBACK&", "flag=gugun&gugun_no="+gugun_no ).success(function(data){
					$scope.si_gu_guns = data.result;
					$scope.dong_no ='';
				});
			}else{
				$scope.si_gu_guns = [] ; 
			}
		}

		$scope.getDong = function (dong) {  //동(洞) 리스트 받아오기
			if(dong != ''){
				Server.jsonp( "https://biz.gabia.com/common/addr_ajax/gabia_address_api?callback=JSON_CALLBACK&", "flag=dong&dong_no="+dong ).success(function(data){
					angular.forEach(data.result , function(value, key){
						if(value.ri != null){
							value.dong_ri = value.dong+" "+value.ri
						}else{
							value.dong_ri= value.dong
						}
					});
					$scope.dongs =  data.result
				});
			}
		}

		$scope.getJibunList = function (){
			if( !$j.isNumeric($scope.sido_no) || !$j.isNumeric($scope.sgg_no)  || !$j.isNumeric($scope.dong_no) ){
				alert(lang.getMessage("ADDR_TEXT_JIBUN_ERROR"));
				return;
			}

			Server.jsonp( "https://biz.gabia.com/common/addr_ajax/gabia_address_api?callback=JSON_CALLBACK&", "type=ji_num&sido_code="+$scope.sido_no+"&gugun_code="+$scope.sgg_no+"&word="+$scope.dong_no +"&extra_no="+$j('#Jibun_search_tab input').val()+"&flag="+"getDetailAddList" ).success(function(data){
				if(data.result != null && jQuery.type( data.result ) !== "string"){
					$scope.detailAddresInfo = data.result;
					$j('.detail_addr_list_tab').removeClass('hide')
				}else{
					alert(lang.getMessage("ADDR_TEXT_NO_SEARCH_LIST"));
					return;
				}
			});
		}

		$scope.getDoroList = function (){
			if( !$j.isNumeric($scope.sido_no) || !$j.isNumeric($scope.sgg_no)  || $j('#Doro_search_tab input').eq(0).val() == '' ){
				alert(lang.getMessage("ADDR_TEXT_DORO_ERROR"));
				return;
			}

			Server.jsonp( "https://biz.gabia.com/common/addr_ajax/gabia_address_api?callback=JSON_CALLBACK&", "type=road_name&sido_code="+$scope.sido_no+"&gugun_code="+$scope.sgg_no+"&word="+$j('#Doro_search_tab input').eq(0).val() +"&extra_no="+$j('#Doro_search_tab input').eq(1).val()+"&flag="+"getDetailAddList" ).success(function(data){
				if(data.result != null){
					$scope.detailAddresInfo = data.result;
					$j('.detail_addr_list_tab').removeClass('hide')
				}else{
					alert(lang.getMessage("ADDR_TEXT_NO_SEARCH_LIST"));
					return;
				}
			});
		}

		$scope.getDetailAddressString = function (){
			var zip_code = $j('#layer_level_2 tr').eq(1).find('td').eq(0).text();
			var detail_add1 = $j('#layer_level_2 tr').eq(1).find('td').eq(1).text();
			var detail_add2 = $j('#layer_level_2 input').val();
			$_THIS_TMP.val(detail_add1+" "+detail_add2+" ("+zip_code+")")
			AddrNewCommon.hidePopup($j('#address_search_layer'));
		}

		$scope.checkDetailInfo = function (DI){
			$scope.selectedDI = DI ; 
			$j('#layer_level_1').addClass('hide'); 
			$j('#layer_level_2').removeClass('hide'); 
		}

		$scope.setting_tag = function (){
			var tmp_arr = [];
			var tmp_str = '';
			$j('#add_address_form input[name="tag"]').val('');
			angular.forEach($j('.tagLayer input:checked') , function(item, key){ 
				tmp_arr.push(item.value);
			})	
			
			tmp_str = $j('#add_address_form input[name="tag"]').val();
			if(tmp_str == '' )
				$j('#add_address_form input[name="tag"]').val(tmp_arr.join(',')) 
			else
				$j('#add_address_form input[name="tag"]').val( tmp_str+','+tmp_arr.join(',')) 
		}

		$scope.submit_address = function (){
			var isWhiteSpace = function(str){return  $j.trim(str);}
			var name = $j('#add_address_form input[name="name"]').val().trim();
			var email = [];
			var type = $j('input[name="type"]:checked').val();
			var phone = [];
			var tag = $j('#add_address_form input[name="tag"]').val();
			var website = [];
			var messenger = [];
			var address = [];
			var anniversary = [];
			var company = $j('#add_address_form input[name="addr_company"]').val();
			var department = $j('#add_address_form input[name="addr_department"]').val();
			var grade = $j('#add_address_form input[name="addr_grade"]').val();
			var memo = $j('#add_address_form textarea').val();
			var minimum_info = 3 ;  
			var no = initData.addr_no;

			email			= AddrNewCommon.address_availabilityCheck($j('.addr_emails'), 'email');
			phone		= AddrNewCommon.address_availabilityCheck($j('.addr_phones'), 'phone');
			website		= AddrNewCommon.address_availabilityCheck($j('.addr_websites'), 'website');
			anniversary		= AddrNewCommon.address_availabilityCheck($j('.addr_anniversaries'), 'anniversary');
			address		= AddrNewCommon.address_availabilityCheck($j('.addr_address'), 'address');

			if(email === false || phone  === false ){
				return;
			}

			if( isWhiteSpace(name) ){ minimum_info--; }
			if( email.length == 0 ){ minimum_info--; }
			if( phone.length == 0 ){ minimum_info--; }
			if(minimum_info == 0 ){	alert(lang.getMessage("LAFieldsRequired"));	return;	}

			var addr_data = {no: no , name: name, email: email, phone: phone, tag: tag, website: website, messenger: messenger, address: address, anniversary: anniversary, company: company, department: department, grade: grade, memo: memo, kind: type, update: 0};

			Server.post(Common.getRoot()+'addr/addr_ajax/editAddressDetail'  , { "address" :  JSON.stringify(addr_data)  } 
			).success(function(data){
				alert(lang.getMessage("ADDR_TEXT_SUCCESSMODIFY"));
				history.back();
				
			}).error(function(data, status, headers, config) {
				alert('error')
			});
		}
	}]);
}

function addrCtrlPage_Print(initData){ // addr/main/print_address
	var app = angular.module("AddrPrint", []);
	init_addrFactory(app); 
	app.controller("AddrPrintCtrl", ['$scope', 'Server' ,function($scope , Server) {
		$scope.PersonalAddresses = [];
		$scope.SharedAddresses = [];
		$scope.TagAddresses = [];
		$scope.ExportAddresses = [];
		$scope.TmpAddr = [];
		$scope.PrintComponent = [];		// 인쇄할 항목 
		$scope.PrintData = [];		// 인쇄할 데이터 
		$scope.IsShowComponent = {	'name' : "N", 'email' : "N", 	'phone' : "N", 'tag' : "N", 	'company' : "N", 'grade' : "N", 	'memo' : "N", 'anniversary' : "N", 	'address' : "N", 'website' : "N"	}
		var available_tab_flag ='P';

		$scope.checkAllFnc = function(flag){
			var model = '';
			if(flag == 'PA'){	model = $scope.PersonalAddresses;}
			else if (flag == 'SA'){	model = $scope.SharedAddresses;	}
			else if (flag == 'TAG'){	model = $scope.TagAddresses;	}

			var event_target = typeof event.target !== "undefined" 	? event.target  : window.event.srcElement;
			if($j(event_target).is(':checked') == true){
				angular.forEach(model , function(value, key){	value.isChecked = 'Y';	});
			}else{
				angular.forEach(model , function(value, key){	value.isChecked = 'N';});
			}
		}

		if(initData.tempPersonalAddresses.resultCode == 'SUCCESS'){	$scope.PersonalAddresses = initData.tempPersonalAddresses.result; 	$j('#PA_tbody').toggleClass('hide');}
		if(initData.tempTagAddresses.resultCode == 'SUCCESS'){	$scope.TagAddresses = initData.tempTagAddresses.result;	$j('#EA_tbody').toggleClass('hide'); $j('#EA_COUNT').toggleClass('hide');}

		$scope.checkExport = function (OB){	if(OB.isChecked == "N"){ OB.isChecked = 'Y' }else{ OB.isChecked = 'N' }	}
		$scope.available_tab = function(TAB){available_tab_flag =TAB; }
		$scope.chosungClickFnc = function (kind , event ){
			if ($j.type(event) == 'object')
				var chosung = event.target.value;
			else
				var chosung = event	

			Server.post( Common.getRoot() + 'addr/addr_ajax/getAddressList', {kind: kind , chosung: chosung  }
			).success(function(data){
				if(kind == 'P'){
					$scope.PersonalAddresses = data.result
				}else{
					$scope.SharedAddresses = data.result
				}
			});
			$j('.AllCheck').attr("checked", false)
		}

		$scope.addExportAddr = function (){
			
			if(available_tab_flag != 'T'){
				var model ='';
				if(available_tab_flag == 'P'){
					model = $scope.PersonalAddresses ;
				}else if(available_tab_flag == 'S'){
					model = $scope.SharedAddresses ;
				}
				angular.forEach( model, function(value, key){
					if(value.isChecked == 'Y'){
						value.isChecked = 'N';
						$scope.ExportAddresses.push(value);
					}
				});
			}else{
				var tag_nos = [];
				angular.forEach( $scope.TagAddresses, function(value, key){
					if(value.isChecked == 'Y'){
						value.isChecked = 'N';
						tag_nos.push(value.no);
					}
				});

				if(tag_nos.length == 0 ){
					alert(lang.getMessage("ADDR_TEXT_NO_TAG"))
					return;
				}


				Server.post( Common.getRoot() + 'addr/addr_ajax/getAddressList', {kind: 'T' , tagNo: tag_nos  }
				).success(function(data){ //$scope.TagAddresses
					if(data.resultCode == "SUCCESS" ){
						angular.forEach( data.result, function(value, key){
							value.isChecked = 'N';
							$scope.ExportAddresses.push(value);
						});
					}
				});
			}
			$j('.AllCheck').attr("checked", false)
		}

		$scope.delExportAddr= function (){
			angular.forEach($scope.ExportAddresses , function(value, key){
				if(value.isChecked == 'N'){
					$scope.TmpAddr.push(value);
				}
			});
			$scope.ExportAddresses = $scope.TmpAddr;
			$scope.TmpAddr = [];
		}

		$scope.printCheckboxesFnc = function (){
			$scope.PrintComponent = [];
			$scope.IsShowComponent = {	'name' : "N", 'email' : "N", 	'phone' : "N", 'tag' : "N", 	'company' : "N", 'grade' : "N", 	'memo' : "N", 'anniversary' : "N", 	'address' : "N", 'website' : "N"	}
			$j("input:checkbox[name='setPrint1']:checked").each(function( index , value ){
				$scope.PrintComponent.push($j(value).val());
				if($j(value).val() == '이름' ){ $scope.IsShowComponent.name = 'Y' }
				if($j(value).val() == 'Name' ){ $scope.IsShowComponent.name = 'Y' }
				if($j(value).val() == '이메일' ){ $scope.IsShowComponent.email = 'Y' }
				if($j(value).val() == 'Email' ){ $scope.IsShowComponent.email = 'Y' }
				if($j(value).val() == '전화번호' ){ $scope.IsShowComponent.phone = 'Y' }
				if($j(value).val() == 'Telephone' ){ $scope.IsShowComponent.phone = 'Y' }
				if($j(value).val() == '태그' ){ $scope.IsShowComponent.tag = 'Y' }
				if($j(value).val() == 'Tag' ){ $scope.IsShowComponent.tag = 'Y' }
				if($j(value).val() == '회사' ){ $scope.IsShowComponent.company = 'Y' }
				if($j(value).val() == 'Company' ){ $scope.IsShowComponent.company = 'Y' }
				if($j(value).val() == '직책' ){ $scope.IsShowComponent.grade = 'Y' }
				if($j(value).val() == 'Position' ){ $scope.IsShowComponent.grade = 'Y' }
				if($j(value).val() == '메모' ){ $scope.IsShowComponent.memo = 'Y' }
				if($j(value).val() == 'Memo' ){ $scope.IsShowComponent.memo = 'Y' }
				if($j(value).val() == '기념일' ){ $scope.IsShowComponent.anniversary = 'Y' }
				if($j(value).val() == 'Anniversary' ){ $scope.IsShowComponent.anniversary = 'Y' }
				if($j(value).val() == '주소' ){ $scope.IsShowComponent.address = 'Y' }
				if($j(value).val() == 'Address' ){ $scope.IsShowComponent.address = 'Y' }
				if($j(value).val() == '웹사이트' ){ $scope.IsShowComponent.website = 'Y' }
				if($j(value).val() == 'Site' ){ $scope.IsShowComponent.website = 'Y' }
			});

			if($scope.PrintComponent.length > 6 ){
				alert(lang.getMessage("ERROR_NOMORE_TITLE_A4"));
				$j(event.target).attr("checked", false);
				return false;
			}else if ($scope.PrintComponent.length  == 0 ){
				alert('최소 한가지 이상을 선택해 주세요');
				return false;
			}
			return true;
		}

		$scope.print_address = function (){
			var print_contents = $j("#print_addresses").html();
			$j("#print_iframe").contents().find("body").html(print_contents);
			$j("#print_iframe").contents().find(".btn_box_hidden").hide();
			$j("#print_iframe").focus();
			frames["print_iframe"].focus();
			frames["print_iframe"].print();
		}

		$scope.viewPrintAddrView= function (){
			if(!$scope.printCheckboxesFnc())
				return ;

			var tmpNoArr = [];
			var tmpStr;

			if($scope.ExportAddresses.length <= 0 ){
				alert(lang.getMessage("MAIN_WARN_NO_ADDRESS_U_SELECT"));
			}else{
				angular.forEach( $scope.ExportAddresses , function(value, key){
					if($j.inArray(value.no , tmpNoArr) == -1 ){ 
						tmpNoArr.push(value.no) 
					}
				});
				alert(lang.getMessage("LA_DUPLICATEREMOVE"));
				tmpStr = tmpNoArr.join('/'); 

				Server.post( Common.getRoot() + 'addr/addr_ajax/printAddress', {'noStr' : tmpStr}
				).success(function(data){ 
					var tmp =  $j.parseJSON(data.result)
					$scope.PrintData = tmp.result
					AddrNewCommon.showPopup($j('#print_layer'));
				});
			}
		}
	}]);	
}