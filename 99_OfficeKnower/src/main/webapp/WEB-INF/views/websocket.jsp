<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="X-UA-Compatible" content="ie=edge">
	<link rel="shortcut icon" href="${pageContext.request.contextPath }/resources/images/common/favicon.ico">
	<title>websocketTest</title>
	<script src="${pageContext.request.contextPath }/resources/js/jquery-3.3.1.js"></script>
	<script src="${pageContext.request.contextPath }/resources/js/sockjs.min.js"></script>
	<!-- 부트스트랩관련 라이브러리 -->
	<link rel="stylesheet"
		href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"
		integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4"
		crossorigin="anonymous">
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
		integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"
		integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm"
		crossorigin="anonymous"></script>
	<script type="text/javascript">
		var sock = new SockJS('http://localhost:9090/ok/websocket.do');
		/* sock.onopen = function(message) {
			$("#console").append('websocket opened' + '<br>');
		};
		sock.onmessage = function(message){
			$('#console').append("receive message : " + message.data + "<br>");
		};
		sock.onclose = function(event){
			$('#console').append('websocket closed : ' + event);
		};
		function messageSend(){
			sock.send($('#message').val());
		}; */
		sock.onmessage = onMessage;
		sock.onclose = onClose;
		$(function(){
			$("#sendBtn").click(function(){
				console.log('send message...');
				sendMessage();
			});
		});
		function sendMessage(){
			sock.send($("#message").val());
		}
		function onMessage(evt){
			var data = evt.data;
			var sessionid = null;
			var message = null;
			
			var strArray = data.split('|');
			
			for(var i = 0; i < strArray.length; i++){
				console.log('str['+i+'] : ' + strArray[i]);
			}
			
			var currentuser_session = $('#sessionuserid').val();
			console.log('current session id : ' + currentuser_session);
			
			sessionid = strArray[0];
			message = strArray[1];
			
			if(sessionid == currentuser_session){
				var printHtml = "<div class='well'>";
				printHtml += "<div class = 'alert alert-info'>";
				printHtml += "<strong>["+sessionid+"] -> " + message + "</strong>";
				printHtml += "</div>";
				printHtml += "</div>";
				
				$("#chatdata").append(printHtml);
			}else{
				var printHtml = "<div class='well'>";
				printHtml += "<div class = 'alert alert-warning'>";
				printHtml += "<strong>["+sessionid+"] -> " + message + "</strong>";
				printHtml += "</div>";
				printHtml += "</div>";
				
				$("#chatdata").append(printHtml);
			}
			console.log('chatting data : ' + data);
		}
		function onClose(evt){
			console.log("연결끊김");
		}
	</script>
</head>
<body>
	<h1>Chatting page (id: ${userid})</h1>
	<input type="hidden" id="sessionuserid" value="${userid }" />
	<input type="text" id="message"/>
	<input type="button" value="전송" id="sendBtn"/>
	<div id="chatdata"></div>
</body>
</html>