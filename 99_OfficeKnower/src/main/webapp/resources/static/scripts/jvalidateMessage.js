var validateMessage = function(pValue){
	if(typeof message_eng == 'undefined'){
		window.message_eng = parent.message_eng;
	}
	if(typeof message_kor == 'undefined'){
		window.message_kor = parent.message_kor;
	}
	
	switch(Common.getLanguage()){
		case 'korean':
			this.m_Messages = message_kor;
		break;
		case 'english':
			this.m_Messages = message_eng;
		break;
		case 'chinese':
			this.m_Messages = message_cn;
		break;
		default:
			this.m_Messages = message_kor;
		break;
	}
};

validateMessage.prototype = {
	getMessage : function(pValue)
	{
		if (this.m_Messages == null) return "Message Data is null.";
		else {
			if(this.m_Messages[pValue] != undefined) {
				return this.m_Messages[pValue].replace(/&#039;/g, "'").replace(/\/n/g, "\n");
			} else {
				return '['+pValue+']Message Data is null.';
			}
		}	
	}
};

var pathInfo = function(pValue){
	if(typeof PATH_INFO == 'undefined'){
		window.PATH_INFO = parent.PATH_INFO;
	}
};

pathInfo.prototype = {
	getInfo : function(pValue)
	{
		var returnData = PATH_INFO[pValue];
		if(returnData) {
			return returnData;
		} else {
			return null;
		}
	}
};

var pathHelper = new pathInfo();