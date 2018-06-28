if(Common.getIEVersion() == '8' || Common.getIEVersion() == '9'){
	FileAPI = {	jsUrl: '/static/scripts/AngularJS/file-upload/FileAPI.min.js',flashUrl: '/static/scripts/AngularJS/file-upload/FileAPI.flash.swf',html5: false,forceLoad: true}
}else{
	//FileAPI = {	jsUrl: '/static/scripts/AngularJS/file-upload/FileAPI.min.js',flashUrl: '/static/scripts/AngularJS/file-upload/FileAPI.flash.swf'}
}

var AddrNewCommon = {

	showPopup : function (obj) {
		var popup_window = obj; 
		var focusableElementsString = "a[href], area[href], input:not([disabled]), select:not([disabled]), textarea:not([disabled]), button:not([disabled]), iframe, object, embed, *[tabindex], *[contenteditable]";

		popup_window.css({'marginLeft': popup_window.outerWidth() / 2 * -1});
		popup_window.css({'marginTop': popup_window.outerHeight() / 2 * -1});
		$j('#dimmed').show();
		popup_window.show();
		var o = popup_window.find('*');
		o.filter('p');
		o.filter(focusableElementsString).filter(':visible').first().focus();

	},


	hidePopup :function (obj) {
		var popup_window = obj;
		$j('#dimmed').hide();
		popup_window.hide();
	},
 
	showOrderMenu : function(id){
		var $_this = $j('#'+id);
		$_this.toggleClass('show');	
		$_this.css('x',(event.clientY)+"px")
		$_this.css('y',(event.clientX)+"px")
	},

	isEmail: function(email) 
	{
		var invalidChars = "\"|&;<>!*\'\\".split('');

		for (var i = 0; i < invalidChars.length; i++)
		{
			if (email.indexOf(invalidChars[i]) != -1)
			{
				return false;
			}
		}

		if (email.indexOf("@")==-1)
		{
			return false;
		}

		if (email.indexOf(" ") != -1)
		{
			return false;
		}

		if (window.RegExp)
		{
			var reg1str = "(@.*@)|(\\.\\.)|(@\\.)|(\\.@)|(^\\.)";
			var reg2str = "^.+\\@(\\[?)[a-zA-Z0-9\\-\\.]+\\.([a-zA-Z]{2,7}|[0-9]{1,3})(\\]?)$";
			var reg1 = new RegExp (reg1str);
			var reg2 = new RegExp (reg2str);

			if (reg1.test(email) || !reg2.test(email))
			{
				
				return false;
			}
		}
		return true;
	},

	phone : function(pValue)
	{
		pValue = Common.trim(String(pValue));
		if (pValue == null || pValue == "") return false;

		var regExp = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/;
		return regExp.test(pValue);
	},

	cellphone : function(pValue)
	{
		pValue = Common.trim(String(pValue));
		if (pValue == null || pValue == "") return false;

		var regExp = /^(01[016789]{1})-?[0-9]{3,4}-?[0-9]{4}$/;
		return regExp.test(pValue);
	},

	phone_foreign  : function(pValue)
	{
		pValue = Common.trim(String(pValue));
		if (pValue == null || pValue == "") return false;

		var regExp = /^[0-9-+]*$/;
		return regExp.test(pValue);
	},



	address_availabilityCheck : function (data ,flag){
		var return_arr = [];
		
		if(flag == 'email'){
			data.each(function(key,item){ 
				if(item.value != '' && AddrNewCommon.isEmail(item.value)){
					return_arr.push(item.value);
				}else if ( item.value != ''){
					alert(lang.getMessage("JAEMailChk"));
					return_arr =  false ;
					return false;
				}
			});
			return return_arr;

		}else if(flag == 'phone'){
			data.each(function(key,item){ 
				var type =  $j(item).find('select').val() ? $j(item).find('select').val() : '';
				var phone = $j(item).find('input').val();

				if(AddrNewCommon.phone_foreign(phone)){
					return_arr.push({phone: phone , type: type });
				}else if(  phone != '' ){
					alert(lang.getMessage('INVALID_PHONE'));
					return_arr =  false ;
					return false;
				}
			});

			return return_arr;

		}else if(flag == 'website'){
			data.each(function(key,item){
				if(item.value.trim() != '' ){
					return_arr.push(item.value);
				}
			});
			return return_arr;
		}else if(flag == 'anniversary' ){
			data.each(function(key,item){
				var name = $j(item).find('input').val();
				if(name != ''){
					return_arr.push({name: name , lunar: $j(item).find('input:radio:checked').val() , date : $j(item).find('select[name="year"]').val()+'/'+$j(item).find('select[name="month"]').val()+'/'+$j(item).find('select[name="date"]').val() });
				}
			});
			return return_arr;
		}else if (flag == 'address'){

			data.each(function(key,item){ 
				var type =  $j(item).find('select').val() ? $j(item).find('select').val() : '';
				var address = $j(item).find('input').val();
				if(address != ''){
					return_arr.push({ content: address , type: type });
				}
			});
			return return_arr;
		}
	},

	getGroupID : function()
	{
		var currentUrl = document.location.href.replace("http://", "").split("/");

		var pattern = /^([a-zA-Z0-9\-]*)\.hiworks.co.kr/i;

		if (pattern.test(currentUrl[0])) return currentUrl[1];
		else return "";
	},

	getRoot : function()
	{
		var g = Common.getGroupID();

		if (g == "") return "/";
		else return "/" + g + "/";
	},

	_keyStr: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=",

	encode: function(input) {
		var output = "";
		var chr1, chr2, chr3, enc1, enc2, enc3, enc4;
		var i = 0;

		input = this._utf8_encode(input);

		while (i < input.length) {

			chr1 = input.charCodeAt(i++);
			chr2 = input.charCodeAt(i++);
			chr3 = input.charCodeAt(i++);

			enc1 = chr1 >> 2;
			enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);
			enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);
			enc4 = chr3 & 63;

			if (isNaN(chr2)) {
				enc3 = enc4 = 64;
			} else if (isNaN(chr3)) {
				enc4 = 64;
			}

			output = output + this._keyStr.charAt(enc1) + this._keyStr.charAt(enc2) + this._keyStr.charAt(enc3) + this._keyStr.charAt(enc4);

		}

		return output;
	},

	decode: function(input) {
		var output = "";
		var chr1, chr2, chr3;
		var enc1, enc2, enc3, enc4;
		var i = 0;

		input = input.replace(/[^A-Za-z0-9\+\/\=]/g, "");

		while (i < input.length) {

			enc1 = this._keyStr.indexOf(input.charAt(i++));
			enc2 = this._keyStr.indexOf(input.charAt(i++));
			enc3 = this._keyStr.indexOf(input.charAt(i++));
			enc4 = this._keyStr.indexOf(input.charAt(i++));

			chr1 = (enc1 << 2) | (enc2 >> 4);
			chr2 = ((enc2 & 15) << 4) | (enc3 >> 2);
			chr3 = ((enc3 & 3) << 6) | enc4;

			output = output + String.fromCharCode(chr1);

			if (enc3 != 64) {
				output = output + String.fromCharCode(chr2);
			}
			if (enc4 != 64) {
				output = output + String.fromCharCode(chr3);
			}
		}
		output = this._utf8_decode(output);
		return output;
	},

	_utf8_encode: function(string) {
		string = string.replace(/\r\n/g, "\n");
		var utftext = "";

		for (var n = 0; n < string.length; n++) {
			var c = string.charCodeAt(n);

			if (c < 128) {
				utftext += String.fromCharCode(c);
			}
			else if ((c > 127) && (c < 2048)) {
				utftext += String.fromCharCode((c >> 6) | 192);
				utftext += String.fromCharCode((c & 63) | 128);
			}
			else {
				utftext += String.fromCharCode((c >> 12) | 224);
				utftext += String.fromCharCode(((c >> 6) & 63) | 128);
				utftext += String.fromCharCode((c & 63) | 128);
			}
		}
		return utftext;
	},

	_utf8_decode: function(utftext) {
		var string = "";
		var i = 0;
		var c = c1 = c2 = 0;

		while (i < utftext.length) {

			c = utftext.charCodeAt(i);

			if (c < 128) {
				string += String.fromCharCode(c);
				i++;
			}
			else if ((c > 191) && (c < 224)) {
				c2 = utftext.charCodeAt(i + 1);
				string += String.fromCharCode(((c & 31) << 6) | (c2 & 63));
				i += 2;
			}
			else {
				c2 = utftext.charCodeAt(i + 1);
				c3 = utftext.charCodeAt(i + 2);
				string += String.fromCharCode(((c & 15) << 12) | ((c2 & 63) << 6) | (c3 & 63));
				i += 3;
			}
		}
		return string;
	},

	getHashObject : function(hash_string)
	{
		var vars = new Object();
		var hash;
		var hashes = this.decode(hash_string).split('&');
		for(var i = 0; i < hashes.length; i++)
		{
			hash = hashes[i].split('=');

			if(this.permitObjectValueName(hash[0]))
				vars[hash[0]] = hash[1];
		}
		return vars;
	},

	permitObjectValueName : function(str){	// 원치 않는 값이 들어가지 못하게 막는다
		var permitArr = [ 'countPerPage' , 'startPage' , 'order', 'orderby', 'chosung','star','kind','tagNo', 'search_word' ,'search_type'];
		if(jQuery.inArray(str, permitArr) == -1){
			return false;
		}else{
			return true ;
		}
	},

	generateHashUrlSubmit : function (search_word, search_type){

		var search_obj = { kind : "P" , search_word : "" , search_type : ""  }
		var tmp_str ='';

		if(search_word == '' ){
			alert(lang.getMessage("JOInputSearchKeyword"));
			return;
		}

		if(window.location.pathname.indexOf("shared") !== -1 ){
			search_obj.kind = 'S';
		}else if(window.location.pathname.indexOf("trash") !== -1 ){
			search_obj.kind = 'T';
		}

		search_obj.search_word	= search_word;
		search_obj.search_type	= search_type;

		$j.each(search_obj, function( key, value ) {
			tmp_str += key+'='+value+'&'
		});

		tmp_str =  AddrNewCommon.encode(tmp_str.slice(0,-1))
		document.location.hash = tmp_str
		document.location.reload()

	},

	reset_search_word : function(){
		if(window.location.pathname.indexOf("personal") !== -1){
			window.location = Common.getRoot() + "addr/main/personal";
		}else if(window.location.pathname.indexOf("shared") !== -1){
			window.location = Common.getRoot() + "addr/main/shared";
		}else{
			window.location = Common.getRoot() + "addr/main/trash";
		}
	}

}


	 