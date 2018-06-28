var getAjaxData = function(URL, params, func, pSync, interID){
	var bSync = (pSync == false)?pSync : true;
	if(URL == undefined) return false;
	if(params == undefined) params = {};

	jQuery.ajax({
		url : URL,
		data : params,
		type : 'post',
		async :	bSync,
		success : function(data){
			if (typeof data == "object") {
				var data = data;
			} else {
				var data = (new Function('return ' + '(' + data + ')'))();
			}

			if (URL.indexOf("admin/Orgmain/checkMailStatus") == 0)
				if(!ajaxReturnErrorCheck(data)) return;

			if(data.resultCode !== undefined && data.resultCode === RT_LOGOUT){
				Common.showLogout(data);
				return;
			}

			func(data);
		},
		error : function(){
			func("FAIL");
			return;
		}
	});
};
