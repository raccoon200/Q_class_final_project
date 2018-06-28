var RT_ERROR = "ERROR";
var RT_FAIL = "FAIL";
var RT_OK = "SUCCESS";
var RT_WARNING = "WARNING";
var RT_LOGOUT = "LOGOUT";

var UPDATE_USER_INFO = "40";
var REQUEST_SMS_COUNT = "10";
var REQUEST_SHARED_MAIL = "20";
var REQUEST_SHARED_PERMISSION = "21";
var REQEUST_BILL_PERMISSION = "30";
var REQUEST_ETC = "999";
var REQUEST_ORG_BOARD_CREATE = "60";
var REQUEST_GROUP_BOARD_CREATE = "61";
var REQUEST_BOARD_PERMISSION = "62";

var CHANGE_MAIL_SIZE = "70";
var CHANGE_HARD_SIZE = "80";
var CANCEL_HID_LINK = "99";


var WEBHARD_READ = 2;
var WEBHARD_WRITE = 4;
var WEBHARD_DELETE = 1;

var BASIC_WEBHARD_SIZE = 100;
var BASIC_WEBMAIL_SIZE = 1000;

var DOMAIN_MINLEN = 2;
var GROUP_MINLEN = 6;

var WEBHARD_READ = 2;
var WEBHARD_WRITE = 4;
var WEBHARD_DELETE = 1;

function saveCaret(elem)
{
	if(document.selection)
		elem.caretPos = document.selection.createRange();
	else
	{
		var oldSelectionStart = elem.selectionStart;
		var oldSelectionEnd = elem.selectionEnd;
		var selectedText = elem.value.substring(oldSelectionStart, oldSelectionEnd);

		var str1 = elem.value.substring(0, oldSelectionStart);
		var sym = str1.substring(str1.length - 1);
	}
}

function insertAtCaret(textElement, newText)
{
	if ( textElement.isTextEdit )
	{
		if ( !textElement.caretPos )
		{
			saveCaret(textElement);
		}

		var caretPos = textElement.caretPos;
		caretPos.text = newText;
		caretPos.select();
	}
}


function fromSpecial(textElement, cInput )
{
	if( document.selection )
	{
		insertAtCaret( textElement, cInput );
	}
	else
	{
		var oldSelectionStart = textElement.selectionStart;
		var oldSelectionEnd = textElement.selectionEnd;
		var selectedText = textElement.value.substring(oldSelectionStart, oldSelectionEnd);

		var scrollTop, scrollLeft;

		if (textElement.type == 'textarea' && typeof textElement.scrollTop != 'undefined')
		{
				scrollTop  = textElement.scrollTop;
				scrollLeft = textElement.scrollLeft;
		}

		textElement.value = textElement.value.substring(0, oldSelectionStart) + cInput + textElement.value.substring(oldSelectionEnd);

		if (typeof scrollTop != 'undefined')
		{
			textElement.scrollTop  = scrollTop;
			textElement.scrollLeft = scrollLeft;
		}

		textElement.setSelectionRange(oldSelectionStart + cInput.length, oldSelectionStart + cInput.length);
	}
}

function getViewport() {

	var viewPortWidth;
	var viewPortHeight;

	// the more standards compliant browsers (mozilla/netscape/opera/IE7) use window.innerWidth and window.innerHeight
	if (typeof window.innerWidth != 'undefined') {
		viewPortWidth = window.innerWidth,
		viewPortHeight = window.innerHeight
	}

	// IE6 in standards compliant mode (i.e. with a valid doctype as the first line in the document)
	else if (typeof document.documentElement != 'undefined' && typeof document.documentElement.clientWidth != 'undefined' && document.documentElement.clientWidth != 0) {
		viewPortWidth = document.documentElement.clientWidth,
		viewPortHeight = document.documentElement.clientHeight
	}

	// older versions of IE
	else {
		viewPortWidth = document.getElementsByTagName('body')[0].clientWidth,
		viewPortHeight = document.getElementsByTagName('body')[0].clientHeight
	}

	return [viewPortWidth, viewPortHeight];
}

var Common = {
	Download: function(lnk,from)
	{
		location.href = lnk;
		document.body.focus();
	},

	getBounds : function(tag)
	{
		var ret = new Object();

		if(tag.getBoundingClientRect)
		{
			var rect = tag.getBoundingClientRect();
			ret.left =
			rect.left + (document.documentElement.scrollLeft || document.body.scrollLeft);
			ret.top =
			rect.top + (document.documentElement.scrollTop || document.body.scrollTop);
			ret.width = rect.right - rect.left;
			ret.height = rect.bottom - rect.top;
		}
		else
		{
			var box = document.getBoxObjectFor(tag);
			ret.left = box.x;
			ret.top = box.y;
			ret.width = box.width;
			ret.height = box.height;
		}
		return ret;
	},
		
	trim : function (str)
	{
		if (str == null || str == "") return ""
		var o = new String(str);
		o = o.replace(/^\s*/,'').replace(/\s*$/, '');

		return o;
	},

	funcCheckEmail : function (email)
	{
		var supported = 0;
		if (window.RegExp)
		{
			var tempStr = "a";
			var tempReg = new RegExp(tempStr);
			if (tempReg.test(tempStr)) supported = 1;
		}
		if (!supported) return (email.indexOf(".") > 2) && (email.indexOf("@") > 0);

		var r1 = new RegExp("(@.*@)|(\\.\\.)|(@\\.)|(^\\.)");
		var r2 = new RegExp("^.+\\@(\\[?)[a-zA-Z0-9\\-\\.]+\\.([a-zA-Z]{2,5}|[0-9]{1,3})(\\]?)$");

		return (!r1.test(email) && r2.test(email));
	},
		
	funcCheckJumin : function(number)
	{
		var patten = /\d{6}-\d{7}$/;
		if (!patten.test(number)) return false;

		return true;
	},

	checkPersonalNo : function(personal_no) {
		personal_no = personal_no.replace(/[^\d]+/g, '');
		pattern = /^[0-9]{6}[1-8][0-9]{6}$/;

		if(!pattern.test(personal_no)) {
			return false;
		}
		var birth = new Array();
		birth[0] = personal_no.substr(0, 2);
		switch(personal_no.charAt(6)) {
			case '1':
			case '2':
				birth[0] = ('19' + birth[0]) * 1;
				birth[3] = false;
			break;
			case '3':
			case '4':
				birth[0] = ('20' + birth[0]) * 1;
				birth[3] = false;
			break;
			case '5':
			case '6':
				birth[0] = ('19' + birth[0]) * 1;
				birth[3] = true;
			break;
			case '7':
			case '8':
				birth[0] = ('20' + birth[0]) * 1;
				birth[3] = true;
			break;
		}

		birth[1] = personal_no.substr(2, 2) * 1;
		birth[2] = personal_no.substr(4, 2) * 1;

		if(birth[1] < 1 || birth[1] > 12) {
			return false;
		}
		if(birth[2] < 1 || birth[2] > 31) {
			return false;
		}
		var check = 0;
		var mul = 2;

		if(birth[3]) {
			if(((personal_no.charAt(7) * 10 + personal_no.charAt(8)) % 2) != 0) {
				return false;
			}
		}
		for(i = 0; i < 12; i ++) {
			check += personal_no.charAt(i) * mul;
			mul ++;
			if(mul > 9) {
				mul = 2;
			}
		}

		check = 11 - (check % 11);

		if(check > 9) {
			check %= 10;
		}
		if(birth[3]) {
			check += 2;
			if(check > 9) {
				check %= 10;
			}
		}
		if(check != personal_no.charAt(12)) {
			return false;
		}
		return birth;
	},	

	funcCheckCompanyNo : function(number)
	{
		var patten = /\d{3}-\d{2}-\d{5}$/;
		if (!patten.test(number)) return false;
		return true;
	},

	funcValidCheckCompanyNo : function(number) {
		number = Common.trim(number.replace(/-/g, ''));

		if(number.length == 0) {
			return false;
		}

		var sum = 0;
		var getlist =new Array(10);
		var chkvalue =new Array("1","3","7","1","3","7","1","3","5");

		for(var i=0; i<10; i++) {
			getlist[i] = number.substring(i, i+1);
		}

		for(var i=0; i<9; i++) {
			sum += getlist[i]*chkvalue[i];
		}

		sum = sum + parseInt((getlist[8]*5)/10);
		var sidliy = sum % 10;
		var sidchk = 0;

		if(sidliy != 0) {
			sidchk = 10 - sidliy;
		} else {
			sidchk = 0;
		}

		if(sidchk != getlist[9]) { return false; }

		return true;
	},

	getOfficeType : function()
	{
		return pathHelper.getInfo("URLTYPE");
	},

	getDomain : function()
	{
		return pathHelper.getInfo("DOMAIN");
	},

	getGroupID : function()
	{
		return pathHelper.getInfo("GROUPID");
	},

	getRoot : function()
	{
		return pathHelper.getInfo("ROOT");
	},

	getServiceRoot : function(pType)
	{
		var return_url = '';	
		var service_root = pathHelper.getInfo("SERVICEROOT");

		if(pType === "mail"){
			return_url = service_root['MAIL_LINK'];
		}else if(pType === "board"){
			return_url = service_root['BOARD_LINK'];
		}else if(pType === "sms"){
			return_url = service_root['SMS_LINK'];
		}else if(pType === "webhard"){
			return_url = service_root['WEBHARD_LINK'];
		}else if(pType === "addr"){
			return_url = service_root['ADDR_LINK'];
		}else if(pType === "bill"){
			return_url = service_root['BILL_LINK'];
		}else if(pType === "schedule"){
			return_url = service_root['SCHEDULE_LINK'];
		}else if(pType === "org"){
			return_url = service_root['ORG_LINK'];
		}else if(pType === "shared"){
			return_url = service_root['SHARED_LINK'];
		}else if(pType === "ea"){
			return_url = service_root['EA_LINK'];
		}else if(pType === "approval"){
			return_url = service_root['APPROVAL_LINK'];
		}

		return (return_url === undefined ? '' : return_url) + Common.getRoot();
	},

	Logout : function()
	{		
		var unixtime = Date.parse(new Date());
		var param = typeof $H == 'function' ? $H({'unixtime' : unixtime}) : {'unixtime' : unixtime};

		getAjaxData(Common.getRoot() + 'home/Logout', param, function(){
			if(Common.getOfficeType() == "G"){
				document.location.href = "https://www.hiworks.com/";
			}else{
				document.location.href = Common.getRoot();
			}
		});		
	},

	goHome : function()
	{
		document.location.href = Common.getRoot();
	},
		
	getImagePath : function()
	{
		return (Common.getImageRoot() + Common.getLanguage() + "/");
	},

	getLanguage : function()
	{
		return pathHelper.getInfo("LANGUAGE");
	},

	getImageRoot : function()
	{
		return "/static/images/";
	},

	viewPopup: function(viewLayerId, backLayerId)
	{
		if(typeof(backLayerId) != "string"){
			// 인자값이 없으면 디폴트 레이어 사용
			backLayerId = "backLayer";
		}

		document.getElementById(viewLayerId).style.display = '';

		//가운데 상하 스크롤 반영
		document.getElementById(viewLayerId).toCenter();
		document.getElementById(viewLayerId).style.filter = "alpha(opacity:100)";

		if(!document.getElementById(backLayerId)){
			var ifmObj = document.createElement("iframe");

			ifmObj.id = backLayerId;
			ifmObj.src = Common.getRoot() + "addr/backLayer";
			ifmObj.style.width = "100%";
			ifmObj.style.height = "100%";
			ifmObj.scrolling = "no";
			ifmObj.frameBorder = "0";
			ifmObj.style.position = "absolute";
			ifmObj.style.display = "none";
			ifmObj.style.opacity = "60";
			ifmObj.style.MozOpacity = "0.6";
			ifmObj.style.filter = "alpha(opacity=60)";
			document.body.appendChild(ifmObj);
		}

		var ifmRef = document.getElementById(backLayerId);
		ifmRef.style.width = document.body.clientWidth;
		ifmRef.style.height = document.body.scrollHeight;
		ifmRef.style.top = "0px";
		ifmRef.style.left = "0px";
		ifmRef.style.zIndex = "1";
		ifmRef.style.display = "block";
	},

	closePopup: function(closeLayerId, backLayerId) // Main.closePopup
	{
		if(typeof(backLayerId) != "string"){
			// 인자값이 없으면 디폴트 레이어 사용
			backLayerId = "backLayer";
		}

		document.body.style.filter = "";
		$(closeLayerId).hide();

		if(document.getElementById(backLayerId)){
			document.getElementById(backLayerId).style.display = 'none';
		}
	}
	
	,_createBackGround : function()
	{
		try
		{
			if (document.getElementById("alphaDiv"))
			{
				document.getElementById("alphaDiv").style.height = document.body.scrollHeight + "px";
				document.getElementById("alphaDiv").style.display = "block";
				return;
			}
			var oAlphaDiv = document.createElement("iframe");
			oAlphaDiv.setAttribute("id", "alphaDiv");
			oAlphaDiv.style.height = "100%";
			oAlphaDiv.style.width = "100%";
			oAlphaDiv.style.display = "inline";
			oAlphaDiv.style.opacity = "0.6";
			document.getElementById("wrap").appendChild(oAlphaDiv);
			document.getElementById("alphaDiv").style.filter = 'alpha(opacity=100)';
		}
		catch(E)
		{
			alert(E);
		}
	}

	,_closeBackGround : function()
	{
		if (document.getElementById("progressDiv"))
		{
			if (document.getElementById("progressDiv").style.display == "")
				document.getElementById("progressDiv").style.display = "none";
		}

		if (document.getElementById("alphaDiv"))
		{
			if (document.getElementById("alphaDiv").style.display != "none")
				document.getElementById("alphaDiv").style.display = "none";

			return;
		}
	}

	,_closeProgress : function()
	{
		if (document.getElementById("progressDiv"))
		{
			if (document.getElementById("progressDiv").style.display == "")
				document.getElementById("progressDiv").style.display = "none";
		}
	}

	,_createProgress : function()
	{
		try
		{
			if (document.getElementById("progressDiv"))
			{
				document.getElementById("progressDiv").style.display = "";
				return;
			}
			var oProgressDiv = document.createElement("div");
			oProgressDiv.setAttribute("id", "progressDiv");

			oProgressDiv.innerHTML = "<img src=\"/assets/images/common/icon/progress_big.gif\" alt=\"progress..\" title=\"progress..\" />";
			document.getElementById("wrap").appendChild(oProgressDiv);
			document.getElementById("progressDiv").toCenter();
		}
		catch(E)
		{
			alert(E);
		}
	}

	,byte_check : function(pValue)
	{
		var str = "";
		var str_count = 0;
		var cut_count = 0;
		var inputLength = pValue.length;

		var newline=(document.all)?'%0A':'%0D%0A';

		for(var i=0 ; i < inputLength ; ++i)
		{
			str = pValue.charAt(i);
			// 네이버 문자 카운트 방법....빠르다..Orz..
			var ascii = str.charCodeAt();
			if (ascii > 127 && escape(str) != newline) str_count += 2;
			else if (escape(str) == newline) str_count += 0;
			else ++str_count;
		}

		return str_count;
	}

	,cut_str: function(str,limit, tail) {
		var tmpStr = str;
		var byte_count = 0;
		var len = str.length;
		var dot = "";
		if(tail == undefined) {
			tail = '';
		}

		for(i=0; i<len; i++) {
			byte_count += Common.chr_byte(str.charAt(i));
			if(byte_count == limit-1) {
				if(Common.chr_byte(str.charAt(i+1)) == 2) {
					tmpStr = str.substring(0,i+1);
					dot = tail;
				} else {
					if(i+2 != len) dot = tail;
					tmpStr = str.substring(0,i+2);
				}
				break;
			} else if(byte_count == limit) {
				if(i+1 != len) dot = tail;
				tmpStr = str.substring(0,i+1);
				break;
			}
		}
		return tmpStr+dot;
	}

	,chr_byte: function(chr) {
		if(escape(chr).length > 4) {
			return 2;
		} else if(chr == "\n") {
			return 0;
		} else {
			return 1;
		}
	}

	,getIEVersion : function()
	{
		var v = navigator.appVersion;
		if (v.indexOf("MSIE") > -1)
		{
			if (v.indexOf("MSIE 6") > -1) return 6;
			else if (v.indexOf("MSIE 7") > -1) return 7;
			else if (v.indexOf("MSIE 8") > -1) return 8;
			else if (v.indexOf("MSIE 9") > -1) return 9;
			else if (v.indexOf("MSIE 10") > -1) return 10;
			else return 5;
		}else if (v.indexOf("Trident/") > -1 &&  v.indexOf("rv:")> -1)
		{
			return 11;
		}

		return false;
	}

	,showLogout: function(pValue)
	{
		if(pValue.message){
			alert(pValue.message);
		}
		var redirect_url = Common.getRoot();
		if(pValue.result){
			redirect_url += '#loginUrl=' + pValue.result;
		}
		location.href = redirect_url;
	}

	,showTimeout: function()
	{
		window.clearInterval(CHECK_TIME_OUT);
		console.log("장기간 미사용 레이어 호출");

		jQuery.ajax({
			url : Common.getRoot() + "common/timeout/show",
			dataType: "json",
			data : {},
			type : 'post',
			async : true,
			success : function(data){
				if(data.resultCode === RT_OK){
					jQuery("#wrap").append(data.result);
					jQuery('#layer_timeout').css({'marginLeft': jQuery('#layer_timeout').outerWidth() / 2 * -1});
					jQuery('#layer_timeout').css({'marginTop': jQuery('#layer_timeout').outerHeight() / 2 * -1});
					jQuery('#dimmed2').show();
					jQuery('#layer_timeout').insertAfter(jQuery("#wrap"));
					jQuery('#layer_timeout').show();
				}else if(data.resultCode === RT_LOGOUT){
					Common.showLogout(data);
					return;
				}else{
					CHECK_TIME_OUT = window.setInterval(Common.showTimeout, parseFloat(data.result)*60*60*1000);
					console.log("CHECK_TIME_OUT");
					if(data.message){
						console.log(data.message);
					}
				}
			},
			error : function(){
			}
		});
	}

	,initTimeout: function()
	{
		
	}
}

var adminTop = {
	mouseFlag : false,
	timer : null,

	showSub : function(pMenu)
	{
		adminTop.clearSub();

		if (document.getElementById(pMenu)) document.getElementById(pMenu).style.display = "";
	},

	clearSub : function()
	{
		if (document.getElementById("org_sub")) document.getElementById("org_sub").style.display = "none";
		if (document.getElementById("bbs_sub")) document.getElementById("bbs_sub").style.display = "none";
		if (document.getElementById("stat_sub")) document.getElementById("stat_sub").style.display = "none";
		if (document.getElementById("conf_sub")) document.getElementById("conf_sub").style.display = "none";
	},

	frontAdminSubOn : function()
	{
		if (document.getElementById("frontAdminMenu"))
		{
			document.getElementById("frontAdminMenu").style.display = "block";
		}
	},

	frontAdminSubOff : function(event)
	{
		if (document.getElementById("frontAdminMenu"))
		{
			document.getElementById("frontAdminMenu").style.display = "none";
		}
	},

	initMouse : function()
	{
		if (document.getElementById("adminButtonLI"))
		{
			document.getElementById("adminButtonLI").onmouseover = function() { adminTop.mouseFlag = true; }
			document.getElementById("adminButtonLI").onmouseout = function() { adminTop.mouseFlag = false; }
			adminTop.timer = window.setInterval("adminTop.checkMouseOver()", 3);
		}
	},

	checkMouseOver : function()
	{
		if (!adminTop.mouseFlag)
		{
			adminTop.frontAdminSubOff();
		}
		else
		{
			if (document.getElementById("frontAdminMenu").style.display == "none")
			{
				adminTop.frontAdminSubOn();
			}
		}
	},
	goManagedBulit : function()
	{
		if (confirm("매니지드 메일 서비스를 이용하고 있지 않습니다.\n\n이용 안내를 확인하시겠습니까?"))	{
			window.open("https://biz.gabia.com/email/features/managed");
		}
	}	
}

/// 스트링 객체에 메소드 추가 ///
String.prototype.isEmail = function()
{
	return (/\w+([-+.]\w+)*@\w+([-.]\w+)*\.[a-zA-Z]{2,4}$/).test(this.trim());
}

String.prototype.isDomain = function()
{
	return (/^[A-Za-z0-9.-]+\.[A-Za-z]{2,6}$/).test(this.trim());
}

String.prototype.pad = function(c, n)
{
	var result=this;
	while(result.length<n)
	{
		result=c+result;
	}
	return result;
}

String.prototype.trim = function(str)
{
	str = this != window ? this : str;
	return str.replace(/^\s+/g,'').replace(/\s+$/g,'');
}

//javascript function added, tetsu
String.prototype.stripTags = function()
{
   replace(/<\/?[^>]+>/gi, '');
}
String.prototype.br2nl = function()
{
	return this.replace(/<br\s*\/?>/img,"\n");
}

String.prototype.p2nl = function()
{
	return this.replace(/<p\s*\/?>/img,"\n");
}

String.prototype.ext = function()
{
	 var arr = this.split(".");
	return arr[arr.length-1].toLowerCase();
}

String.prototype.img_ext = function()
{
	 var str = this.ext();
	 var arr_good = new Array("ai", "arj","avi","bat","bmp","com","doc","exe","gif","gz","hwp","jpg","jpeg","lha","mov","mp3","mpeg","mpg","pcx","pdf","ppt","ra","ram","rar","rm","zip","tar","txt","wav","xls","xlsx","pptx","docx");

	 if(arr_good.indexOf(str)<0)	return "unknown.gif";
	 else return str + ".gif";
}
String.prototype.uncomma = function()
{
	if(this===0) return '';
	return this.replace(/[^\d]+/g, '');
}

Number.prototype.comma = function()
{
	if(this===0) return 0;
	var n = String(this);
	return n.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}

Array.prototype.contains = function(v) {
	for(var i = 0; i < this.length; i++) {
		if(this[i] === v) return true;
	}
	return false;
};

Array.prototype.unique = function() {
	var arr = [];
	for(var i = 0; i < this.length; i++) {
		if(!arr.contains(this[i])) {
			arr.push(this[i]);
		}
	}
	return arr;
}

if(!Array.prototype.indexOf) {
	Array.prototype.indexOf = function(what, i) {
		i = i || 0;
		var L = this.length;
		while (i < L) {
			if(this[i] === what) return i;
			++i;
		}
		return -1;
	};
}

Array.prototype.remove = function() {
	var what, a = arguments, L = a.length, ax;
	while (L && this.length) {
		what = a[--L];
		while ((ax = this.indexOf(what)) !== -1) {
			this.splice(ax, 1);
		}
	}
	return this;
};

var elementPrototype = typeof HTMLElement !== "undefined"
		? HTMLElement.prototype : Element.prototype;

elementPrototype.toCenter = function()
{
	var element = this;
	var viewport = getViewport();

	var scTop = document.documentElement.scrollTop || document.body.scrollTop;
	element.style.left = ((viewport[0] - element.getWidth()) /2) + "px";
	element.style.top = ((viewport[1] - element.getHeight()) /2 + scTop) + "px";

	if(viewport[1] < element.getHeight()) {
		//element.style.top = (scTop+100) + 'px';
	}
	return element;
}

elementPrototype.getDimensions = function()
{
	var element = this;
	var display = element.style.display;
	if (display != 'none' && display != null) // Safari bug
	  return {width: element.offsetWidth, height: element.offsetHeight};

	// All *Width and *Height properties give 0 on elements with display none,
	// so enable the element temporarily
	var els = element.style;
	var originalVisibility = els.visibility;
	var originalPosition = els.position;
	var originalDisplay = els.display;
	els.visibility = 'hidden';
	els.position = 'absolute';
	els.display = 'block';
	var originalWidth = element.clientWidth;
	var originalHeight = element.clientHeight;
	els.display = originalDisplay;
	els.position = originalPosition;
	els.visibility = originalVisibility;
	return {width: originalWidth, height: originalHeight};
}

elementPrototype.getHeight = function() {
	return this.getDimensions().height;
}

elementPrototype.getWidth = function() {
	return this.getDimensions().width;
}

function setCookie(c_name,value,expiredays)
{
	var exdate=new Date();exdate.setDate(exdate.getDate()+expiredays);
	var cookiePath = '/';
	document.cookie=c_name+ "=" +escape(value)+((expiredays==null) ? "" : ";expires="+exdate.toGMTString()) + ";path=" + cookiePath;
}

function getCookie(c_name)
{
	if (document.cookie.length>0)
	{
			var cookiePath = '/';
			c_start=document.cookie.indexOf(c_name + "=");
			if (c_start!=-1)
			{
					c_start=c_start + c_name.length+1;
					c_end=document.cookie.indexOf(";",c_start);
					if (c_end==-1) c_end=document.cookie.length;
					return unescape(document.cookie.substring(c_start,c_end));
			}
	}
	return "";
}

function formatFileSize(numSize)
{
	if(numSize == 0 ) return "0 KB";
	numSize = Number(numSize / 1024);
	strReturn = String(numSize.toFixed(1) + " KB");

	if(numSize > 1024)
	{
		numSize = numSize / 1024;
		strReturn = String(numSize.toFixed(1) + " MB");

		if(numSize > 1024)
		{
			numSize = numSize / 1024;
			strReturn = String(numSize.toFixed(1) + " GB");
		}
	}
	return strReturn;
}

function showMenuConfig(){
	jQuery.ajax({
		url : Common.getRoot() + "menu/manage_ajax/setConfig",
		data : {},
		type : 'post',
		dataType : 'json',
		async : true,
		success : function(data){
				if(data.resultCode !== undefined && data.resultCode === RT_LOGOUT){
					console.log("logout");
					Common.showLogout(data);
					return;
				}

				var obj = document.createElement("div");
				obj.id = 'popupBase';
				document.body.appendChild(obj);
				jQuery("#popupBase").html(data.result);
				jQuery("#gnb_layer").html("");
				showPopup(jQuery('#layer_menu_setting'));
		},
		error : function(){
				func("FAIL");
				return;
		}
	});
}

//플래시
function flash(path, width, height, name){
	document.write('<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" width="'+width+'" height="'+height+'" codebase="https://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0" id="'+name+'" class="toplogo">'
	+'<param name="movie" value="'+path+'">'
	+'<param name="quality" value="high">'
	+'<param name="wmode" value="transparent">'
	+'<param name="allowScriptAccess" value="always">'
	+'<embed src="'+path+'" quality="high" wmode="transparent" pluginspage="https://www.macromedia.com/go/getflashplayer" width="'+width+'" height="'+height+'" type="application/x-shockwave-flash" showLiveConnect="true" name="'+name+'" allowScriptAccess="always"></embed>'
	+'</object>');
}

if (!Function.prototype.bind) {
	Function.prototype.bind = function(oThis) {
		if (typeof this !== 'function') {
			// closest thing possible to the ECMAScript 5
			// internal IsCallable function
			throw new TypeError('Function.prototype.bind - what is trying to be bound is not callable');
		}

		var aArgs   = Array.prototype.slice.call(arguments, 1),
		fToBind = this,
		fNOP    = function() {},
		fBound  = function() {
			return fToBind.apply(this instanceof fNOP && oThis ? this : oThis, aArgs.concat(Array.prototype.slice.call(arguments)));
		};

		fNOP.prototype = this.prototype;
		fBound.prototype = new fNOP();

		return fBound;
	};
}

String.prototype.format = String.prototype.format || function() {
	var formatted = this;
	for (var i = 0; i < arguments.length; i++) {
		var regexp = new RegExp('\\{'+i+'\\}', 'gi');
		formatted = formatted.replace(regexp, arguments[i]);
	}
	return formatted;
};

function showSuccessToast(pMessage, pSeconds) {
	if(pMessage){
		$j().toastmessage('showSuccessToast', pMessage, pSeconds);
	}
}
function showStickySuccessToast(pMessage) {
	if(pMessage){
		$j().toastmessage('showToast', {
			text     : pMessage,
			sticky   : true,
			position : 'top-center',
			type     : 'success',
			closeText: '',
			close    : function () {
				console.log("toast is closed ...");
			}
		});
	}
}
function showNoticeToast(pMessage, pSeconds) {
	if(pMessage){
		$j().toastmessage('showNoticeToast', pMessage, pSeconds);
	}
}
function showStickyNoticeToast(pMessage) {
	if(pMessage){
		$j().toastmessage('showToast', {
			 text     : pMessage,
			 sticky   : true,
			 position : 'top-center',
			 type     : 'notice',
			 closeText: '',
			 close    : function () {console.log("toast is closed ...");}
		});
	}
}
function showWarningToast(pMessage, pSeconds) {
	if(pMessage){
		$j().toastmessage('showWarningToast', pMessage, pSeconds);
	}
}
function showStickyWarningToast(pMessage) {
	if(pMessage){
		$j().toastmessage('showToast', {
			text     : pMessage,
			sticky   : true,
			position : 'top-center',
			type     : 'warning',
			closeText: '',
			close    : function () {
				console.log("toast is closed ...");
			}
		});
	}
}
function showErrorToast(pMessage, pSeconds) {
	if(pMessage){
		$j().toastmessage('showErrorToast', pMessage, pSeconds);
	}
}
function showStickyErrorToast(pMessage) {
	if(pMessage){
		$j().toastmessage('showToast', {
			text     : pMessage,
			sticky   : true,
			position : 'top-center',
			type     : 'error',
			closeText: '',
			close    : function () {
				console.log("toast is closed ...");
			}
		});
	}
}
