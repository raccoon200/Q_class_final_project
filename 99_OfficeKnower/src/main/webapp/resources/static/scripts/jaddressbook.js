var addressbookAlert = new validateMessage("userselect");

var FROM_DEFAULT = FROM_MAIL = 0;
var FROM_SMS = FROM_NOMAIL = 1;
var FROM_MEMO = FROM_BILL = FROM_EA = FROM_BOARD_ADMIN = FROM_BOOKING = 2;
var FROM_CALL = 4;
var FROM_BILL2 = 5;
var FROM_SHARED = 6;
var FROM_OFFICEMAIL = 7;
var FROM_APPROVAL = 9;

var PRIVATE_TAB = 0;
var SHARED_TAB = 1;
var CONSTRUCT_TAB = 2;
var GROUP_TAB = 3;


var addressbookClass = function(){
	this.currentTab = 0;
	this._callee = null;           // 피호출자
	this.leftValue = null;
	this.page = 1;
	this._clickTab = false;
	this._searchFlag = false;
	this._lastSearchKeyword = "";
	this._from = null;
	this._initFunc = null;
	this._applyFunc = null;
	this._closeFunc = null;
	this._viewFile = null;
	this._subFlag = true;
	this._nodeClickFunc = null;
	this._useMenu = "";
	this._orderKey = "name";
	this._orderValue = "ASC";
};

addressbookClass.prototype = {
	closeApply : function()
	{
		if (addressbook._applyFunc)
		{
			var func = (new Function('return ' + addressbook._applyFunc))();

			if (addressbook._viewFile != null && (addressbook._viewFile.indexOf("div_ea") >= 0 || addressbook._viewFile.indexOf("div_approval") >= 0))
			{
				if (!func.call())
				{
					return;
				}
			}
			else func.call();
		}

		addressbook.closeAddressbook();
	},

		btnApply : function()
		{
			if (addressbook._applyFunc)
			{
				var func = (new Function('return ' + addressbook._applyFunc))();
				func.call();
			}
		},

		getAddressbook : function(pFrom, pInitFunc, pApplyFunc, pView, pCloseFunc)
		{
			if(!jQuery("#dimmed").is(":visible")) {
				Common._createBackGround();
				Common._createProgress();
			}

			addressbook._from = pFrom;

			if (pView) addressbook._viewFile = pView;

			if (pInitFunc) addressbook._initFunc = pInitFunc;
			else addressbook._initFunc = "";

			if (pApplyFunc) addressbook._applyFunc = pApplyFunc;
			else addressbook._applyFunc = "";

			// add nkw
			if (pCloseFunc) addressbook._closeFunc = pCloseFunc;
			else addressbook._closeFunc = "";

			if(addressbook._from == FROM_BILL2) {
				this.currentTab = SHARED_TAB;
				var param = {"pTab" : SHARED_TAB, "pFrom" : pFrom, "pTarget" : "ALL", "pValue" : "", "pKeyword" : "", "pField" : "", "pView" : pView};
			}else if(addressbook._from == FROM_SHARED || addressbook._from == FROM_OFFICEMAIL) { 
				this.currentTab = CONSTRUCT_TAB;
				var param = {"pTab" : CONSTRUCT_TAB, "pFrom" : pFrom, "pTarget" : "ALL", "pValue" : "", "pKeyword" : "", "pField" : "", "pView" : pView};
			}else if(addressbook._from == FROM_APPROVAL) { 
				this.currentTab = CONSTRUCT_TAB;
				var param = {"pTab" : CONSTRUCT_TAB, "pFrom" : pFrom, "pTarget" : "ALL", "pValue" : "", "pKeyword" : "", "pField" : "", "pView" : pView};
			} else {
				var param = {"pTab" : PRIVATE_TAB, "pFrom" : pFrom, "pTarget" : "ALL", "pValue" : "", "pKeyword" : "", "pField" : "", "pView" : pView};
			}
			getAjaxData(Common.getRoot() + "common/userselector", param, function(pData) {
				if (typeof(pData) != "object" || pData.resultCode != RT_OK)
				{
					alert(addressbookAlert.getMessage("REQUEST_ERROR"));
					Common._closeBackGround();
					return;
				}

				if(pData.resultCode !== undefined && pData.resultCode === RT_LOGOUT){
					Common.showLogout(pData);
					return;
				}

				if (pData.resultCode == RT_OK)
				{
					jQuery("#wrap").append(pData.result);
					jQuery('#' + addressbook._viewFile).showPopup();

					Common._closeProgress();

					if (addressbook._from == FROM_MEMO || addressbook._from == FROM_APPROVAL) {
						addressbook.setTab(0);
					} else if(addressbook._from == FROM_SHARED || addressbook._from == FROM_OFFICEMAIL) {
						addressbook.currentTab = 2;
						addressbook.click_menuTab();
					} else if(addressbook._from == FROM_BILL2) {
						addressbook.currentTab = 1;
						document.getElementById("leftList").selectedIndex = 0;
					} else {
						addressbook.currentTab = 0;
						addressbook.click_menuTab();
					}

	try {
					if (addressbook._initFunc)
					{
						if (typeof addressbook._initFunc == 'function') {
							addressbook._initFunc.call();
						} else {
							var func = (new Function('return ' + addressbook._initFunc))();
							
							/*
							var func = (function() {
								return new Function('return ' + addressbook._initFunc)
							})(Function('return this')());
							*/
							
							func.call();
						}
					}
	} catch(E)
	{
		alert('error1:'+E);
	}
					if(addressbook._viewFile && addressbook._viewFile.indexOf("div_ea_eadoc_org_refer_view") < 0){
						jQuery("#searchP #keyword").eq(0).focus();
					}

				}
				else {
					Common._closeBackGround();	
				}
			});
		},

		closeAddressbook : function()
		{

			if( addressbook._viewFile == 'layer_shared_user_add' ){
				hidePopup();
			}else{
				jQuery('#' + addressbook._viewFile).hidePopup();
				Common._closeBackGround();
			}
			
			if (addressbook._closeFunc)
			{
				var func = (new Function('return ' + addressbook._closeFunc))();
				func.call();
			}
		},

		/**
		 * 피호출자 설정
		 */
		setCallee : function(obj)
		{
			this._callee = obj;
		},

		/**
		 * 피호출자 가져오기
		 */
		getCallee : function()
		{
			return this._callee;
		},

		Collapse : function()
		{
			this._toggle(document.getElementById('treeDiv'), 'collapse');
		},

		_toggle : function(parent, force)
		{
			if (parent.lastChild.nodeName == 'UL')
			{
				var max = parent.lastChild.childNodes.length;

				for (var i = 0; i < max; i++)
				{
					var obj = parent.lastChild.childNodes[i];
					this.getCallee().ToggleTree(obj, force);
					this._toggle(obj, force);
				}
			}
		},

		tabOver : function(pIndex)
		{
			if (this.currentTab == pIndex) return;

			document.getElementById("selectorTab").children[pIndex].className = "TabOver";
		},

		tabOut : function(pIndex)
		{
			if (this.currentTab != pIndex)
				document.getElementById("selectorTab").children[pIndex].className = "";
		},

		setTab : function(pIndex)
		{
			document.getElementById("searchMessage").style.display = "none";
			document.getElementById("searchCount").innerHTML = "";
			jQuery("#selectorTab").find("li").find("a").removeClass("on");
			jQuery("#selectorTab").find("li").eq(pIndex).find("a").addClass("on");

			this.currentTab = pIndex;

			jQuery("#searchP input[name=searchField]:first").attr("checked",true);	
			jQuery("#searchP #keyword").eq(0).val("");
			jQuery('#addrCancelSearch').hide();

			this.click_menuTab();
		},

		_createProgress : function(pFlag)
		{
			switch(pFlag)
			{
				case "ALL" :
					this._leftProgressDiv();
					this._rightProgressDiv();

					break;
				case "RIGHT" : this._rightProgressDiv();
					break;
				case "LEFT" : this._leftProgressDiv();
					break;
			}
		},

		_closeProgress : function()
		{
			var Tab = parseInt(this.currentTab, 10) + ((parseInt(addressbook._from, 10) == FROM_MEMO)?2 : 0) + ((parseInt(addressbook._from, 10) == FROM_APPROVAL)?2 : 0);
			switch (Tab)
			{
				case PRIVATE_TAB :
				case SHARED_TAB : document.getElementById("leftList").style.display = "";
					break;

				case CONSTRUCT_TAB :
				case GROUP_TAB :
					if (!addressbook._searchFlag) $j("treeDiv").css("display","");
			}

			document.getElementById("rightList").style.display = "";
			document.getElementById("leftProgressDiv").style.display = "none";
			document.getElementById("rightProgressDiv").style.display = "none";
		},

		_leftProgressDiv : function()
		{
			document.getElementById("leftList").style.display = "none";
			document.getElementById("treeDiv").style.display = "none";
			document.getElementById("leftProgressDiv").style.display = "";
		},

		_rightProgressDiv : function()
		{
			document.getElementById("rightList").style.display = "none";
			document.getElementById("rightProgressDiv").style.display = "";
		},

		click_menuTab : function()
		{
			this._createProgress("ALL");

			addressbook._clickTab = true;
			addressbook._searchFlag = false;
			addressbook.leftValue = "";

			var Tab = parseInt(this.currentTab, 10) + ((parseInt(addressbook._from, 10) == FROM_MEMO)?2 : 0) + ((parseInt(addressbook._from, 10) == FROM_APPROVAL)?2 : 0);

			switch(Tab)
			{
				case PRIVATE_TAB :
					var param = {"pTab" : Tab, "pFrom" : addressbook._from, "pTarget" : "ALL", "pValue" : "", "pKeyword" : "", "pField" : ""};
					if(addressbook._from == FROM_CALL) {
						param = {"pTab" : Tab, "pFrom" : addressbook._from, "pTarget" : "RIGHT", "pValue" : "", "pKeyword" : "", "pField" : ""};
						document.getElementById("leftDiv").style.display = "none";
						document.getElementById("rightListDiv").style.width = "300px";
						document.getElementById("rightList").style.width = "298px";
					}
					this._getAddressData(param);
					break;

				case SHARED_TAB :
					var param = {"pTab" : Tab, "pFrom" : addressbook._from, "pTarget" : "ALL", "pValue" : "", "pKeyword" : "", "pField" : ""};
					if(addressbook._from == FROM_CALL) {
						param = {"pTab" : Tab, "pFrom" : addressbook._from, "pTarget" : "RIGHT", "pValue" : "", "pKeyword" : "", "pField" : ""};
						document.getElementById("leftDiv").style.display = "none";
						document.getElementById("rightListDiv").style.width = "300px";
						document.getElementById("rightList").style.width = "298px";
					}
					this._getAddressData(param);
					break;

				case CONSTRUCT_TAB :
					var param = {"pTab" : Tab, "pFrom" : addressbook._from, "pTarget" : "ALL", "pValue" : "", "pKeyword" : "", "pField" : "", "pView" : addressbook._viewFile};
					if(addressbook._from == FROM_CALL){
						document.getElementById("leftDiv").style.display = "inline-block";
						document.getElementById("rightListDiv").style.width = "220px";
						document.getElementById("rightList").style.width = "218px";
					}
					this._getTreeAddressData(param);
					break;

				case GROUP_TAB :
					var param = {"pTab" : Tab, "pFrom" : addressbook._from, "pTarget" : "ALL", "pValue" : "", "pKeyword" : "", "pField" : ""};
					if(addressbook._from == FROM_CALL){
						document.getElementById("leftDiv").style.display = "inline";
						document.getElementById("rightListDiv").style.width = "220px";
						document.getElementById("rightList").style.width = "218px";
					}
					this._getTreeAddressData(param);
					break;
			}
			if(addressbook._viewFile == null || (addressbook._viewFile != "div_ea_eadoc_org_refer_view" && addressbook._viewFile != "div_ea_eadoc_stat_org")) jQuery("#searchP #keyword").eq(0).focus();
		},

		paging : function(pPage)
		{
			addressbook.page = pPage;
			var Tab = parseInt(this.currentTab, 10) + ((parseInt(addressbook._from, 10) == FROM_MEMO)?2 : 0) + ((parseInt(addressbook._from, 10) == FROM_APPROVAL)?2 : 0);

			var obj =document.getElementById("leftList");
			if(Tab == CONSTRUCT_TAB)
			{	
				jQuery.each(jQuery("#treeDiv strong"), function(index, value) {
					if(value.className == "selectedNode") {
						obj = value;
					}
				});
			}

			switch(Tab)
			{
				case PRIVATE_TAB : this.click_privateTag(obj, false, pPage);
					break;
				case SHARED_TAB : this.click_sharedTag(obj, false, pPage);
					break;
				case GROUP_TAB :
				case CONSTRUCT_TAB : this.click_const(obj, false, pPage);
					break;
			}
		},

		click_leftList : function(pObj)
		{
			this.page = 1;
			var Tab = parseInt(this.currentTab, 10) + ((parseInt(addressbook._from, 10) == FROM_MEMO)?2 : 0) + ((parseInt(addressbook._from, 10) == FROM_APPROVAL)?2 : 0);
			switch(Tab)
			{
				case PRIVATE_TAB : this.click_privateTag(pObj);
					break;
				case SHARED_TAB : this.click_sharedTag(pObj);
					break;
				case GROUP_TAB :
				case CONSTRUCT_TAB : this.click_const(pObj);
					break;
			}
		},

		click_sharedTag : function(pObj, pSearchFlag)
		{
			if (pSearchFlag) this.leftValue = "";
			else
				this.leftValue = (pObj.selectedIndex > -1)?pObj.value : "";

			var param = {"pTab" : this.currentTab, "pFrom" : addressbook._from, "pTarget" : ((pSearchFlag)?"ALL" : "RIGHT"), "pValue" : this.leftValue, "pKeyword" : Common.trim(jQuery("#searchP #keyword").eq(0).val()), "pField" : jQuery("#searchP input[name=searchField]:checked").val(), "pPage" : this.page};

			this._createProgress("RIGHT");
			this._getAddressData(param);
		},

		click_privateTag : function(pObj, pSearchFlag)
		{
			if (pSearchFlag) this.leftValue = "";
			else
				this.leftValue = (pObj.selectedIndex > -1)?pObj.value : "";

			var keyword = "";
			if (Common.trim(jQuery("#searchP #keyword").eq(0).val()) != "") keyword = Common.trim(jQuery("#searchP #keyword").eq(0).val());
			else
			{
				if (document.getElementById("searchMessage").style.display != "none")
					keyword = addressbook._lastSearchKeyword;
			}

			var param = {"pTab" : this.currentTab, "pFrom" : addressbook._from, "pTarget" : ((pSearchFlag)?"ALL" : "RIGHT"), "pValue" : this.leftValue, "pKeyword" : keyword, "pField" : jQuery("#searchP input[name=searchField]:checked").val(), "pPage" : this.page};

			this._createProgress("RIGHT");
			this._getAddressData(param);
		},

		click_const : function(pObj, pSearchFlag, pPage)
		{
			var Tab = parseInt(this.currentTab, 10) + ((parseInt(addressbook._from, 10) == FROM_MEMO)?2 : 0) + ((parseInt(addressbook._from, 10) == FROM_APPROVAL)?2 : 0);

			if (pPage == undefined) this.page = 1;
			else this.page = pPage;

			addressbook._subFlag = true;

			if (document.getElementById("searchMessage").style.display != "none")
				this.leftValue = pObj.value;
			else
			{
				this.leftValue = pObj.parentNode.parentNode.id.replace(/addressTreeNode_/ig, "");

				if (!addressbook._searchFlag)
				{
					if (document.getElementById("noentry"))
					{
						jQuery("#noentry li")[0].className = "";
					}

					jQuery("#treeDiv strong").removeClass("selectedNode");

					if (document.getElementById("noentryNode")) document.getElementById("noentryNode").className = "";
					pObj.className = "selectedNode";
				}
				//alert(pObj.parentNode.parentNode.childNodes.length);
			}

			var param = null;
			var keyword = "";
			if (Common.trim(jQuery("#searchP #keyword").eq(0).val()) != "") keyword = Common.trim(jQuery("#searchP #keyword").eq(0).val());
			else
			{
				if (document.getElementById("searchMessage").style.display != "none")
					keyword = addressbook._lastSearchKeyword;
			}
			
			if (pSearchFlag)
			{
				document.getElementById("treeDiv").innerHTML = "";
				param = {"pTab" : Tab, "pFrom" : addressbook._from, "pTarget" : "ALL", "pValue" : "", "pKeyword" : keyword, "pField" : jQuery("#searchP input[name=searchField]:checked").val(), "pPage" : this.page, "pSubFlag" : false, "pView" : addressbook._viewFile, "pOrderKey" : this._orderKey, "pOrderValue" : this._orderValue};
			}
			else
			{
				if (addressbook._subFlag)
					addressbook._subFlag = (document.getElementById("searchMessage").style.display == "none")?true:false;
				if (Tab == GROUP_TAB) addressbook._subFlag = false;

				param = {"pTab" : Tab, "pFrom" : addressbook._from, "pTarget" : "RIGHT", "pValue" : this.leftValue, "pKeyword" : keyword, "pField" : jQuery("#searchP input[name=searchField]:checked").val(), "pPage" : this.page, "pSubFlag" : addressbook._subFlag, "pView" : addressbook._viewFile,  "pOrderKey" : this._orderKey, "pOrderValue" : this._orderValue};
			}

			this._createProgress("RIGHT");
			this._getAddressData(param);
		},

		/**
		 * obj 노드의 펼치기 / 닫기 상태를 전환
		 */
		ToggleTree : function(obj, force)
		{
			if (obj.nodeName == 'IMG')
			{
				img = obj;
				obj = img.parentNode.parentNode;
			}
			else
			{
				if (obj.childNodes.length < 1) return;
				else if (obj.firstChild.nodeName != 'DIV') return;
				else if (obj.firstChild.firstChild.nodeName != 'IMG') return;

				var img = obj.firstChild.firstChild;
			}

			if (force == 'collapse')    mode = 'collapse';
			else if (force == 'expand') mode = 'expand';
			else mode = (img.src.indexOf('tree_m') > 0) ? 'collapse' : 'expand';

			// 닫기
			if (mode == 'collapse')
			{
				img.src = img.src.replace('tree_m', 'tree_p');
				obj.lastChild.style.display = 'none';
			}
			// 펼치기
			else
			{
				img.src = img.src.replace('tree_p', 'tree_m');
				obj.lastChild.style.display = '';
			}
		},

		selectNode : function(pNode)
		{
			this.click_leftList(pNode);
		},

		_getTreeAddressData : function(pParam)
		{
			getAjaxData(Common.getRoot() + "common/userselector/getright", pParam, function(pData) {
				if (typeof(pData) != "object" || pData.resultCode != RT_OK)
				{
					alert(addressbookAlert.getMessage("REQUEST_ERROR"));
					return;
				}

				if(pData.resultCode !== undefined && pData.resultCode === RT_LOGOUT){
					Common.showLogout(pData);
					return;
				}

				if (pData.resultCode == RT_OK)
				{
					jQuery("#treeDiv").html("");
	try {
					var tree = new OrgTree();
					tree.setCallee('addressbook');
					tree.setMaxDepth(pData.MAX_DEPTH);
					tree.setRootNode(document.getElementById('treeDiv'));
					tree.setRootFunc(document.getElementById('addressbook'));
					tree.setPrefixNode('addressTreeNode');
					tree.setPrefixFunc('addressTreeFunc');
					tree.setTreeData(pData.LEFT);
					tree.draw();

					tree.setManagerCallback(addressbook);
					addressbook.Collapse();

					tree.ToggleTree(document.getElementById('treeDiv').lastChild.firstChild.firstChild.firstChild, 'expand'); // 첫 탭 열기

					document.getElementById("leftList").style.display = "none";
					document.getElementById("treeDiv").style.display = "";

					addressbook._setRightList(pData.RIGHT);

					if (pData.RIGHT["CONDITION"]){
						jQuery("#searchP #spnSearchCtl").empty();
		
						if (pData.RIGHT["CONDITION"])
						{
							var new_radio = "";
							for(var i=0 ; i<pData.RIGHT["CONDITION"].length ; ++i)
							{
								new_radio += "<input type=\"radio\" value=\""+pData.RIGHT["CONDITION"][i].VALUE+"\" name=\"searchField\" id=\"rdo_sch_"+pData.RIGHT["CONDITION"][i].VALUE+"\" onclick=\"document.getElementById('keyword').focus();\"><label for=\"rdo_sch_"+pData.RIGHT["CONDITION"][i].VALUE+"\">"+pData.RIGHT["CONDITION"][i].TEXT+"</label>&nbsp;&nbsp;";
							}
								jQuery("#searchP #spnSearchCtl").append(new_radio);
								jQuery("#searchP input[name=searchField]:first").attr("checked",true);											
							document.getElementById("searchP").style.display = "block";
						}
					}
					else
						document.getElementById("searchP").style.display = "none";

					if (addressbook._nodeClickFunc)
					{
						var func = (new Function('return ' + addressbook._nodeClickFunc))();
						func.call();
					}

					// 최초 로딩시 최상위 조직 선택 표시.
					if (document.getElementById("treeDiv").firstChild.firstChild.id){
						document.getElementById("treeDiv").firstChild.firstChild.firstChild.lastChild.className = "selectedNode";
					}
	} catch(E)
	{
		alert(E + " - 2");
	}
				}
			});

			addressbook._clickTab = false;
			addressbook._closeProgress();
		},

		_getAddressData : function(pParam)
		{
			getAjaxData(Common.getRoot() + "common/userselector/getright", pParam, function(pData) {
				if (typeof(pData) != "object" || pData.resultCode != RT_OK)
				{
					alert(addressbookAlert.getMessage("REQUEST_ERROR"));
					return;
				}

				if(pData.resultCode !== undefined && pData.resultCode === RT_LOGOUT){
					Common.showLogout(pData);
					return;
				}

	try {
				if (pData.resultCode == RT_OK)
				{
					var Tab = parseInt(addressbook.currentTab, 10) + ((parseInt(addressbook._from, 10) == FROM_MEMO)?2 : 0) + ((parseInt(addressbook._from, 10) == FROM_APPROVAL)?2 : 0);

					if (parseInt(pData.RIGHT["TOTAL_PAGE"], 10) == 0 && addressbook._searchFlag && pData.LEFT.length == undefined)
					{
						if (jQuery("#searchCount").html() == "" || Common.trim(jQuery("#searchP #keyword").eq(0).val()) != addressbook._lastSearchKeyword)
						{
							alert(Common.trim(jQuery("#searchP #keyword").eq(0).val()) + addressbookAlert.getMessage("NO_DATA"));
							jQuery("#searchP #keyword").eq(0).val("");
							addressbook.setTab(addressbook.currentTab);

							if (document.getElementById("searchMessage").style.display == "none") addressbook._searchFlag = false;
							return;
						}
					}

					if (addressbook._searchFlag && pData.LEFT.length <= 0)
					{
						if (Tab < CONSTRUCT_TAB)
						{
							var nLength = document.getElementById("leftList").length;
							for(var i=nLength ; i>=0 ; --i)
								document.getElementById("leftList").remove(i);
						}

						var nRLength = document.getElementById("rightList").length;
						for(var i=nRLength ; i>=0 ; --i)
							document.getElementById("rightList").remove(i);
					}

					if ((pData.LEFT.length == 0 || addressbook._from == FROM_CALL) && pData.RIGHT.RESULT == null && addressbook.leftValue == "")
					{
						var nLength = document.getElementById("leftList").length;
						for(var i=nLength ; i>=0 ; --i)
							document.getElementById("leftList").remove(i);

						var nRLength = document.getElementById("rightList").length;
						for(var i=nRLength ; i>=0 ; --i)
							document.getElementById("rightList").remove(i);

						var oOption1 = new Option("등록된 Data가 없습니다.", "-1");
						var oOption2 = new Option("등록된 Data가 없습니다.", "-1");
						document.getElementById("leftList").options.add(oOption1);
						document.getElementById("rightList").options.add(oOption2);

						return;
					}

					if ((pData.LEFT.length > 0 || addressbook._from == FROM_CALL) && Tab < CONSTRUCT_TAB)
					{
						var nLength = document.getElementById("leftList").length;
						for(var i=nLength ; i>=0 ; --i)
							document.getElementById("leftList").remove(i);

						// 왼쪽 내용은 조직/그룹/태그 검색일 경우만.
						if (jQuery("#searchP input[name=searchField]:checked").attr("value") != "name" || addressbook._clickTab)
						{
							nLength = pData.LEFT.length;
							for(var i=0 ; i<nLength ; ++i)
							{
								var t = (pData.LEFT[i].extend_string && pData.LEFT[i].extend_string != "")?pData.LEFT[i].text_string + " (" + pData.LEFT[i].extend_string + ")" : pData.LEFT[i].text_string;
								var oOption = new Option(t, pData.LEFT[i].value_string);

								if (pData.LEFT[i].title_string && pData.LEFT[i].title_string != "")
									oOption.title = pData.LEFT[i].title_string;

								document.getElementById("leftList").options.add(oOption);
							}

							if (addressbook._from != FROM_CALL && document.getElementById("leftList").options[0].value != "" && document.getElementById("leftList").selectedIndex < 0)
								document.getElementById("leftList").selectedIndex = 0;

							if (document.getElementById("leftList").style.display == "none")
							{
								document.getElementById("leftList").style.display = "";
								document.getElementById("treeDiv").style.display = "none";
							}
						}
					}
					// 조직, 그룹에서 조직이름으로 검색을 했을 경우.
					else if (pData.LEFT.length > 0 && Tab >= CONSTRUCT_TAB)
					{
						var nLength = document.getElementById("leftList").length;
						for(var i=nLength ; i>=0 ; --i)
							document.getElementById("leftList").remove(i);

						if (jQuery("#searchP input[name=searchField]:checked").val() != "name" || addressbook._clickTab)
						{
							if (jQuery("#searchP input[name=searchField]:checked").val() != "name")
							{
								nLength = pData.LEFT.length;

								for(var i=0 ; i<nLength ; ++i)
								{
									var t = (pData.LEFT[i].extend_string && pData.LEFT[i].extend_string != "")?pData.LEFT[i].text_string + " (" + pData.LEFT[i].extend_string + ")" : pData.LEFT[i].text_string;
									var oOption = new Option(pData.LEFT[i].name + " (" + pData.LEFT[i].ct + ")", pData.LEFT[i].node_id);

									document.getElementById("leftList").options.add(oOption);
								}
							}
							if (document.getElementById("leftList").style.display == "none")
								document.getElementById("leftList").style.display = "";

							document.getElementById("treeDiv").style.display = "none";
						}

					}

					if (addressbook._searchFlag) addressbook._displaySearchResult_const(pData.RIGHT["TOTAL"]);

					if (document.getElementById("leftList").length > 0 && document.getElementById("leftList").options[0].value > 0 && document.getElementById("leftList").options[0].value != "" && document.getElementById("leftList").selectedIndex < 0) document.getElementById("leftList").selectedIndex = 0;

					addressbook._setRightList(pData.RIGHT);

				//	addressbook._clickTab = false;
				}

				if (addressbook._clickTab)
				{
					jQuery("#searchP #spnSearchCtl").empty();
	
					if (pData.RIGHT["CONDITION"])
					{
						var new_radio = "";
						for(var i=0 ; i<pData.RIGHT["CONDITION"].length ; ++i)
						{
							new_radio += "<input type=\"radio\" value=\""+pData.RIGHT["CONDITION"][i].VALUE+"\" name=\"searchField\" id=\"rdo_sch_"+pData.RIGHT["CONDITION"][i].VALUE+"\" onclick=\"document.getElementById('keyword').focus();\"><label for=\"rdo_sch_"+pData.RIGHT["CONDITION"][i].VALUE+"\">"+pData.RIGHT["CONDITION"][i].TEXT+"</label>&nbsp;&nbsp;";
						}
							jQuery("#searchP #spnSearchCtl").append(new_radio);
							jQuery("#searchP input[name=searchField]:first").attr("checked",true);											
						document.getElementById("searchP").style.display = "block";
					}

					else
						document.getElementById("searchP").style.display = "none";
				}


	/*
				if (addressbook._searchFlag && $("rightList").options.length == 1)
				{
					$("rightList").selectedIndex = 0;
					addressbook.copyOption('selTO');
				}
	*/
	} catch(E)
	{
		alert(E + " -- 1");
		console.log(E);
	}
			});

			addressbook._closeProgress();
		},

		_setRightList : function(pData, pSearchFlag, pConstAdmin)
		{
			var nLength = document.getElementById("rightList").length;
			for(var i=nLength ; i>=0 ; --i)
				document.getElementById("rightList").remove(i);

			if (addressbook._searchFlag == true && addressbook.currentTab < CONSTRUCT_TAB)
			{
				if (document.getElementById("leftList").length == 0 && document.getElementsByName("searchField").value == "tag") return;
			}
			if (!pData["RESULT"]) return;
			if (pData["RESULT"].length <= 0) return;

			if (pData["RESULT"].length > 0)
			{
				nLength = pData["RESULT"].length;

				if(addressbook._from == FROM_APPROVAL){
					for(var i=0 ; i<nLength ; ++i)
					{
						var oOption = new Option(pData["RESULT"][i].text_string, pData["RESULT"][i].value_string);
						if (pData["RESULT"][i].title_string && pData["RESULT"][i].title_string != "")
							oOption.title = pData["RESULT"][i].title_string;
						if (pData["RESULT"][i]["member_flag"] != undefined && pData["RESULT"][i]["member_flag"] == "N")
							oOption.style.color = "silver";
						if (pData["RESULT"][i].title_string && pData["RESULT"][i].title_string != "")
							oOption.setAttribute("node_id", pData["RESULT"][i].node_id);

						if (addressbook._searchFlag) oOption.selected = true;
						$j("#rightList").append(oOption);
					}
				}else{
					for(var i=0 ; i<nLength ; ++i)
					{
						var oOption = new Option(pData["RESULT"][i].text_string, pData["RESULT"][i].value_string);
						if (pData["RESULT"][i].title_string && pData["RESULT"][i].title_string != "")
							oOption.title = pData["RESULT"][i].title_string;
						if (pData["RESULT"][i]["member_flag"] != undefined && pData["RESULT"][i]["member_flag"] == "N")
							oOption.style.color = "silver";

						if (addressbook._searchFlag) oOption.selected = true;
						//document.getElementById("rightList").options.add(oOption);
						$j("#rightList").append(oOption);
					}
				}
			}

			var totalPage = parseInt(pData["TOTAL_PAGE"], 10);

			if (totalPage == 1) jQuery("#pagingP").html("");

			if (totalPage > 1 && parseInt(addressbook.page, 10) == 1)
			{
				jQuery("#pagingP").html("");
				if (pConstAdmin == undefined)
				{
					var szBuffer = "<select id=\"pageCurrent\" class=\"pageSelect\" onchange=\"addressbook.paging(this.value);\">";
					for(var i=1 ; i<=totalPage ; ++i)
					{
						if (i == parseInt(pData["PAGE"], 10))
							szBuffer += "<option value=\"" + i + "\" selected>" + i + "</option>";
						else
							szBuffer += "<option value=\"" + i + "\">" + i + "</option>";
					}
					szBuffer += "</select>";
					szBuffer += " / <span>" + totalPage + "</span>";
				}
				else
				{
					var szBuffer = "<select id=\"pageCurrent\" class=\"pageSelect\" onchange=\"constManage.getOutofEntry(this.value);\">";
					for(var i=1 ; i<=totalPage ; ++i)
					{
						if (i == parseInt(pData["PAGE"], 10))
							szBuffer += "<option value=\"" + i + "\" selected>" + i + "</option>";
						else
							szBuffer += "<option value=\"" + i + "\">" + i + "</option>";
					}
					szBuffer += "</select>";
					szBuffer += " / <span>" + totalPage + "</span>";
				}

				if(addressbook._from !== FROM_APPROVAL){
					szBuffer = "<div class=\"page_select\">" + szBuffer + "</div>";
				}
				//document.getElementById("pagingP").innerHTML = szBuffer;
				jQuery("#pagingP").html(szBuffer);
			}
			//else $("pagingP").innerHTML = "";
		},

		click_rightSelect : function(pType)
		{
			var bValue = (pType == "select")?true : false;

			for(var i=0 ; i<document.getElementById("rightList").length ; ++i)
				document.getElementById("rightList").options[i].selected = bValue;
		},

		click_searchBtn : function()
		{
			if (Common.trim(jQuery("#searchP #keyword").eq(0).val()) == "")
			{
				alert(addressbookAlert.getMessage("INVALID_KEYWORD"));
				jQuery("#searchP #keyword").eq(0).focus();
				return;
			}

			addressbook._searchFlag = true;

			if (jQuery("#searchP input[name=searchField]:checked").val() == "name") addressbook._subFlag = true;

			var Tab = parseInt(this.currentTab, 10) + ((parseInt(addressbook._from, 10) == FROM_MEMO)?2 : 0) + ((parseInt(addressbook._from, 10) == FROM_APPROVAL)?2 : 0);
			switch(Tab)
			{
				case PRIVATE_TAB : this.click_privateTag(document.getElementById("leftList"), true);
					break;
				case SHARED_TAB : this.click_sharedTag(document.getElementById("leftList"), true);
					break;
				case GROUP_TAB :
				case CONSTRUCT_TAB : this.click_const(document.getElementById("leftList"), true);
					break;
			}
			jQuery("#addrCancelSearch").show();
			jQuery("#searchP #keyword").eq(0).focus();
		},

		click_orderBtn : function(pOrderKey, pOrderValue)
		{
			this._orderKey = pOrderKey;
			this._orderValue = pOrderValue;
			
			if($j("#treeDiv .selectedNode").length > 0){
				this.click_leftList($j("#treeDiv .selectedNode").eq(0)[0]);
			}
		},

		_displaySearchResult_const : function(pResultCount)
		{
			document.getElementById("searchMessage").style.display = "block";

			if (Common.trim(jQuery("#searchP #keyword").eq(0).val()) != "")
				addressbook._lastSearchKeyword = Common.trim(jQuery("#searchP #keyword").eq(0).val());

			if(document.getElementById("searchKeyword")) document.getElementById("searchKeyword").innerHTML = "\"" + addressbook._lastSearchKeyword + "\"";

			var nTotal = 0;

			if (jQuery("#searchP input[name=searchField]:checked").val() == "name")
			{
				if (pResultCount) nTotal = pResultCount;
				else
				{
					for(var j=0 ; j<document.getElementById("leftList").length ; ++j)
					{
						var oTemp = $j("#leftList").find("option").eq(j).text().match(/\((\d+)\)$/i);
						nTotal += parseInt(oTemp[1], 10);
					}
				}
			}
			else nTotal = document.getElementById("leftList").length;

			document.getElementById("searchCount").innerHTML = nTotal;

			jQuery("#searchP #keyword").eq(0).val("");
		},

		copyOption : function(pID)
		{
			if (document.getElementById("rightList").selectedIndex > -1)
			{
				for(var i=0 ; i<document.getElementById("rightList").length ; ++i)
				{
					if (document.getElementById("rightList").options[i].selected)
					{
						var nCheck = 0;

						if (document.getElementById(pID).length > 0)
						{
							for(var j=0 ; j<document.getElementById(pID).length ; ++j)
							{
								if (document.getElementById(pID).options[j].value == document.getElementById("rightList").options[i].value)
								{
									++nCheck;
									break;
								}
							}
						}
							
						if (nCheck == 0)
						{
							var oOption = new Option(document.getElementById("rightList").options[i].text, document.getElementById("rightList").options[i].value);
							oOption.title = document.getElementById("rightList").options[i].title;

							document.getElementById(pID).options.add(oOption);

							switch (pID)
							{
								case "selTO" : addressbook._increaseCount("spselTO");
									break;
								case "selCC" : addressbook._increaseCount("spselCC");
									break;
								case "selBCC" : addressbook._increaseCount("spselBCC");
									break;
							}
						}
					}
				}
			}
			else alert(addressbookAlert.getMessage("NOT_SELECTED_ADDRESS"));
		},

		_increaseCount : function(pID)
		{
			var c = parseInt(document.getElementById(pID).innerHTML, 10);

			document.getElementById(pID).innerHTML = ++c;
		},

		_decreaseCount : function(pID)
		{
			var c = parseInt(document.getElementById(pID).innerHTML, 10);

			if (c > 0) document.getElementById(pID).innerHTML = --c;
		},

		removeOption : function(pID)
		{
			if (document.getElementById(pID).selectedIndex > -1)
			{
				for(var i=(document.getElementById(pID).length-1) ; i>=0 ; --i)
				{
					if (document.getElementById(pID).options[i].selected)
					{
						document.getElementById(pID).remove(i);

						switch (pID)
						{
							case "selTO" : addressbook._decreaseCount("spselTO");
								break;
							case "selCC" : addressbook._decreaseCount("spselCC");
								break;
							case "selBCC" : addressbook._decreaseCount("spselBCC");
								break;
						}
					}
				}
			}
		}

	
};

var addressbook = new addressbookClass();
