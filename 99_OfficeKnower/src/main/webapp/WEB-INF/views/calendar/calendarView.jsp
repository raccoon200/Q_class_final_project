<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="일정관리" name="pageTitle"></jsp:param>
</jsp:include>
<jsp:include page="/WEB-INF/views/common/nav.jsp">
	<jsp:param value="일정관리" name="pageTitle"></jsp:param>
</jsp:include>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/fullcalendar-3.9.0/lib/jquery.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.3.1.js"></script>
<link href="${pageContext.request.contextPath }/resources/fullcalendar-3.9.0/fullcalendar.print.css" rel="stylesheet" media="print"/>
<link href="${pageContext.request.contextPath}/resources/fullcalendar-3.9.0/fullcalendar.css" rel="stylesheet"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/fullcalendar-3.9.0/lib/moment.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/fullcalendar-3.9.0/fullcalendar.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/fullcalendar-3.9.0/locale-all.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/fullcalendar-3.9.0/gcal.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB" crossorigin="anonymous">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js" integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T" crossorigin="anonymous"></script>
<style type="text/css">
body {
    /* margin :40px 10px;
    padding : 0; */
    font-family : "Lucida Grande", Helvetica, Arial, Verdana,sans-serif;
    font-size : 14px;
}
#calendar {
    display: inline-block;
    width: 90%;
    
}
.fc-view-container{
	display: inline-block;
}

.fc-content{
	cursor: pointer;
} 
.fc-sat { color:#0066FF; }     /* 토요일 */
.fc-sun { color:#FF0000; }    /* 일요일 */

#calendarNav{
	background:lightgray;
	display: inline-block;
	width: 300px;
	height: 1000px;
	position: relative;
	text-align: center;
	margin-right: 50px;
}

#cal-mini{
	position: absolute;
}
#cal-name{
	position: absolute;
 	top: 200px;
 	left : 50px;
}
.container{
	margin-left: 100px;
	margin-right:100px;
}


.fc-view-container{
	width : 100%;
}

.calupdate{
	color : #6B66FF;
	cursor: pointer;
	float: right;
	padding-right: 20px;
}

.calinsert{
	color : #4641D9;
	cursor: pointer;
}
.delete{
	color : #6B66FF;
	cursor: pointer;
}

#divCal{
	font-size: 20px;
	color : darkgray;
	display: inline-block;
}
.divBox{
	width: 16px;
	height: 16px;
	display: inline-block;
	border: 2px solid darkgray;
	float: left;
	margin-right: 10px;
}
.fc-day-header{
	
	background: #EAEAEA;
	font-size: 18px;
	padding: 0;
}
.red{color: #F15F5F;}
.yellow{color: #F2CB61; }
.orange{color: #F29661; }
.green{color: #BCE55C; }
.blue{color: #5CD1E5; }
.navy{color: #6B66FF; }
.purple{color: #D1B2FF; }

</style>

<script>

function day(day){
	/* 캘린더 이름 가지고 오는 ajax / 캘린더 이름 가지고 온 다음 insert용 form만듦 */
 $.ajax({
      url : "<%=request.getContextPath()%>/cal/selectCalendar",
            type: "post",
            dataType : "json",
            success: function(data){
               console.log(data);
               data = data["list"];
               
                 if(data==null){
           	  
               }else {
              	 
               	var html2 = "";
               		 html2 +="<form action='<%=request.getContextPath()%>/cal/scheduleInsert' id='insertFrm' method='post' >";
                 		 html2 += "<div class='form-group row'>";
                 		 html2 += "<label for='calendarName' class='col-sm-2 col-form-label'>캘린더</label>";
                 		 html2 += "<div class='col-sm-10'>";
        				 html2 += "<select id='calendarid' name='calendarid' class='form-control'>"; 
               	     	 //html2 += "<option>캘린더 선택</option>";
                 	for(var index in data){
 						var c = data[index];

 						 if(c.TYPE=='내 캘린더'){
 							 
 						 	html2 += "<option value='"+c.CALENDARID+"'>"+ c.CALENDAR_NAME+"(내 캘린더) </option>";  
 						 }else if(c.TYPE=='공유 캘린더'){
 							html2 += "<option value='"+c.CALENDARID+"'>"+ c.CALENDAR_NAME+"(공유 캘린더) </option>";  
 						 }
 						// html2 += "<option>"+ c.CALENDAR_NAME+"</option>";  

                 	}
                 	
        				 html2 +="</select></div></div>";
        				 
        				 html2 +="<div class='form-group row'>";
        				 html2 +="<label for='title' class='col-sm-2 col-form-label'>일정 제목</label>";
        				 html2 +="<div class='col-sm-10'>";
        				 html2 +="<input type='text' name='title' id='title' class='form-control' required/></div></div>";
        				
        				 html2 +="<div class='form-group row'>";
        				 html2 +="<label for='title' class='col-sm-2 col-form-label'>작성자</label>";
        				 html2 +="<div class='col-sm-10'>";
        				 html2 +="<input type='hidden' value=${memberLoggedIn.com_no} name='com_no' id='com_no' />";
        				 html2 +="<input type='text' name='writer' id='writer' class='form-control' value=${memberLoggedIn.userId} readonly/></div></div>";
        				
        				 html2 +="<div class='form-group row'>";
        				 html2 +="<label for='startdate' class='col-sm-2 col-form-label'>시작</label>";
        				 html2 += "<div class='row'>";
        				 html2 += "<div class='col'>";
        				 html2 +="<input type='date' name='startdate' id='startdate' class='form-control' value='"+day+"' required/>";
        				 html2 += "</div>";
        				 html2 += "<div class='col'>";
        				 html2 += "<select class='form-control' name='starttime' id='starttime'>";
        				 html2 += "<option>시작 시간 선택</option>";
        				 html2 += "<option value='00:00'>오전 12:00</option>";
        				 html2 += "<option value='01:00'>오전 01:00</option>";
        				 html2 += "<option value='02:00'>오전 02:00</option>";
        				 html2 += "<option value='03:00'>오전 03:00</option>";
        				 html2 += "<option value='04:00'>오전 04:00</option>";
        				 html2 += "<option value='05:00'>오전 05:00</option>";
        				 html2 += "<option value='06:00'>오전 06:00</option>";
        				 html2 += "<option value='07:00'>오전 07:00</option>";
        				 html2 += "<option value='08:00'>오전 08:00</option>";
        				 html2 += "<option value='09:00'>오전 09:00</option>";
        				 html2 += "<option value='10:00'>오전 10:00</option>";
        				 html2 += "<option value='11:00'>오전 11:00</option>";
        				 html2 += "<option value='12:00'>오전 12:00</option>";
        				 html2 += "<option value='13:00'>오후 01:00</option>";
        				 html2 += "<option value='14:00'>오후 02:00</option>";
        				 html2 += "<option value='15:00'>오후 03:00</option>";
        				 html2 += "<option value='16:00'>오후 04:00</option>";
        				 html2 += "<option value='17:00'>오후 05:00</option>";
        				 html2 += "<option value='18:00'>오후 06:00</option>";
        				 html2 += "<option value='19:00'>오후 07:00</option>";
        				 html2 += "<option value='20:00'>오후 08:00</option>";
        				 html2 += "<option value='21:00'>오후 09:00</option>";
        				 html2 += "<option value='22:00'>오후 10:00</option>";
        				 html2 += "<option value='23:00'>오후 11:00</option>";
        				 html2 += "</select>";
        				 html2 += "</div></div></div>";
        				 
        				 html2 +="<div class='form-group row'>";
        				 html2 +="<label for='quitdate' class='col-sm-2 col-form-label'>종료</label>";
        				 html2 += "<div class='row'>";
        				 html2 += "<div class='col'>";
        				 html2 +="<input type='date' name='quitdate' id='quitdate' class='form-control' value='"+day+"' required/>";
        				 html2 += "</div>";
        				 html2 += "<div class='col'>";
        				 html2 += "<select class='form-control' name='quittime' id='quittime'>";
        				 html2 += "<option>종료 시간 선택</option>";
        				 html2 += "<option value='00:00'>오전 12:00</option>";
        				 html2 += "<option value='01:00'>오전 01:00</option>";
        				 html2 += "<option value='02:00'>오전 02:00</option>";
        				 html2 += "<option value='03:00'>오전 03:00</option>";
        				 html2 += "<option value='04:00'>오전 04:00</option>";
        				 html2 += "<option value='05:00'>오전 05:00</option>";
        				 html2 += "<option value='06:00'>오전 06:00</option>";
        				 html2 += "<option value='07:00'>오전 07:00</option>";
        				 html2 += "<option value='08:00'>오전 08:00</option>";
        				 html2 += "<option value='09:00'>오전 09:00</option>";
        				 html2 += "<option value='10:00'>오전 10:00</option>";
        				 html2 += "<option value='11:00'>오전 11:00</option>";
        				 html2 += "<option value='12:00'>오전 12:00</option>";
        				 html2 += "<option value='13:00'>오후 01:00</option>";
        				 html2 += "<option value='14:00'>오후 02:00</option>";
        				 html2 += "<option value='15:00'>오후 03:00</option>";
        				 html2 += "<option value='16:00'>오후 04:00</option>";
        				 html2 += "<option value='17:00'>오후 05:00</option>";
        				 html2 += "<option value='18:00'>오후 06:00</option>";
        				 html2 += "<option value='19:00'>오후 07:00</option>";
        				 html2 += "<option value='20:00'>오후 08:00</option>";
        				 html2 += "<option value='21:00'>오후 09:00</option>";
        				 html2 += "<option value='22:00'>오후 10:00</option>";
        				 html2 += "<option value='23:00'>오후 11:00</option>";
        				 html2 += "</select>";
        				 html2 += "</div></div></div>";
        				 
        	
        				 
        				 html2 +="<div class='form-group row'>";
        				 html2 +="<label for='content' class='col-sm-2 col-form-label'>내용</label>";
       				     html2 +="<div class='col-sm-10'>";
        			 	 html2 +="<textarea name='content' id='content' cols='30' rows='5' class='form-control' required></textarea> </div></div>";

        				 
        				 $("#nows").html(html2).show();

                 } 

              },
              error:function(jqxhr,textStatus,errorThrown){
                 console.log("ajax 처리실패!");
                 console.log(jqxhr);
                 console.log(textStatus);
                 console.log(errorThrown);
              }
                   
  }); // ajax end
} //day function end

//캘린더 수정 모달 함수
function calendarUpdateFrm(cal, id, color,type){
	
	$(".calupdate").attr("data-toggle", "modal").attr("data-target", "#calendarUpdate");

	var html ="";
	
	html +="<div style='display:inline-block; width:17px; height:17px; border:2px solid lightgray; background:"+color+";'></div>";
	html +="&nbsp;&nbsp;&nbsp; <div id='divCal'>" + cal + "</div><br><br>";
	html +="<form action='<%=request.getContextPath()%>/cal/calUpdate' id='updateCalFrm' method='post'>";
	html +="<div class='form-group row'>";
 	html +="<label for='name' class='col-sm-2 col-form-label'>캘린더 이름</label>";
 	html +="<div class='col-sm-10'>";
	html +="<input type='hidden' name='calendarid' id='calid' value='"+id+"'/>";
 	html +="<input type='text' name='calendar_name' id='name' class='form-control' value='"+cal+"'/></div></div>";
 	
 	html +="<div class='form-group row'>";
 	html +="<label for='Red' class='col-sm-2 col-form-label'>색상</label>";
 	html +="<div class='col-sm-10'>";
 
	if(type=='내 캘린더') {
 		
	 	html += "&nbsp;&nbsp;<span class='red'>빨강</span>";
	 	html += " &nbsp;<input type='radio' id='red' name='colorSelect' value='#F15F5F' />";
	 	
	 	html += "&nbsp;&nbsp;<span class='yellow'>노랑</span>";
	 	html += " &nbsp;<input type='radio' id='yellow' name='colorSelect' value='#F2CB61' />";
	 	
	 	html += "&nbsp;&nbsp;<span class='orange'>주황</span>";
	 	html += " &nbsp;<input type='radio' id='orange' name='colorSelect' value='#F29661' />";
	 	
	 	html += "&nbsp;&nbsp;<span class='green'>초록</span>";
	 	html += " &nbsp;<input type='radio' id='green' name='colorSelect' value='#BCE55C'/>";
	 	
	 	html += "<br><span class='blue'>파랑</span>";
	 	html += " &nbsp;<input type='radio' id='blue' name='colorSelect' value='#5CD1E5' />";
	 	
	 	html += "&nbsp;&nbsp;<span class='navy'>남색</span>";
	 	html += " &nbsp;<input type='radio' id='navy' name='colorSelect' value='#6B66FF'/>";
	 	
	 	html += "&nbsp;&nbsp;<span class='purple'>보라</span>";
	 	html += " &nbsp;<input type='radio' id='purple' name='colorSelect' value='#D1B2FF'/>"; 
	 	html += "</div></div>";
	 	
 	}else if(type=='공유 캘린더'){
 		html += "&nbsp;&nbsp;<span style='color:red'>빨강</span>";
	 	html += " &nbsp;<input type='radio' id='red' name='colorSelect' value='red' />";
	 	
	 	html += "&nbsp;&nbsp;<span style='color:yellow'>노랑</span>";
	 	html += " &nbsp;<input type='radio' id='yellow' name='colorSelect' value='yellow' />";
	 	
	 	html += "&nbsp;&nbsp;<span style='color:orange'>주황</span>";
	 	html += " &nbsp;<input type='radio' id='orange' name='colorSelect' value='orange' />";
	 	
	 	html += "&nbsp;&nbsp;<span style='color:greed'>초록</span>";
	 	html += " &nbsp;<input type='radio' id='green' name='colorSelect' value='green'/>";
	 	
	 	html += "<br><span style='color:blue'>파랑</span>";
	 	html += " &nbsp;<input type='radio' id='blue' name='colorSelect' value='blue' />";
	 	
	 	html += "&nbsp;&nbsp;<span style='color:navy'>남색</span>";
	 	html += " &nbsp;<input type='radio' id='navy' name='colorSelect' value='navy'/>";
	 	
	 	html += "&nbsp;&nbsp;<span style='color:purple'>보라</span>";
	 	html += " &nbsp;<input type='radio' id='purple' name='colorSelect' value='purple'/>"; 
	 	html += "</div></div>";
 	}
 	
 	
 	html += "</form>";
 	
 	$("#calInfo").html(html);
	
} //캘린더 수정 모달 함수 끝

//캘린더 등록 모달 함수
function calendarInsertFrm(cal){
	$(".calinsert").attr("data-toggle", "modal").attr("data-target", "#calendarNameInsert");
	
	var html ="";
	
	html +="<div id='divCal'>" + cal + "</div><br><br>";
	html +="<form action='<%=request.getContextPath()%>/cal/calInsert' id='insertCalFrm' method='post'>";
	html +="<div class='form-group row'>";
 	html +="<label for='name' class='col-sm-2 col-form-label'>캘린더 이름</label>";
 	html +="<div class='col-sm-10'>";
	html +="<input type='hidden' name='calendarType' value='"+cal+"'/>";
	html +="<input type='hidden' name='userid' value=${memberLoggedIn.userId}  />";
 	html +="<input type='text' id='calName' name='calendar_name' class='form-control' /></div></div>";
 	
 	html +="<div class='form-group row'>";
 	html +="<label for='Red' class='col-sm-2 col-form-label'>색상</label>";
 	html +="<div class='col-sm-10'>";
 	
 	
 	if(cal=='내 캘린더') {
 		
	 	html += "&nbsp;&nbsp;<span class='red'>빨강</span>";
	 	html += " &nbsp;<input type='radio' id='red' name='colorSelect' value='#F15F5F' />";
	 	
	 	html += "&nbsp;&nbsp;<span class='yellow'>노랑</span>";
	 	html += " &nbsp;<input type='radio' id='yellow' name='colorSelect' value='#F2CB61' />";
	 	
	 	html += "&nbsp;&nbsp;<span class='orange'>주황</span>";
	 	html += " &nbsp;<input type='radio' id='orange' name='colorSelect' value='#F29661' />";
	 	
	 	html += "&nbsp;&nbsp;<span class='green'>초록</span>";
	 	html += " &nbsp;<input type='radio' id='green' name='colorSelect' value='#BCE55C'/>";
	 	
	 	html += "<br><span class='blue'>파랑</span>";
	 	html += " &nbsp;<input type='radio' id='blue' name='colorSelect' value='#5CD1E5' />";
	 	
	 	html += "&nbsp;&nbsp;<span class='navy'>남색</span>";
	 	html += " &nbsp;<input type='radio' id='navy' name='colorSelect' value='#6B66FF'/>";
	 	
	 	html += "&nbsp;&nbsp;<span class='purple'>보라</span>";
	 	html += " &nbsp;<input type='radio' id='purple' name='colorSelect' value='#D1B2FF'/>"; 
	 	html += "</div></div>";
	 	
 	}else if(cal=='공유 캘린더'){
 		html += "&nbsp;&nbsp;<span style='color:red'>빨강</span>";
	 	html += " &nbsp;<input type='radio' id='red' name='colorSelect' value='red' />";
	 	
	 	html += "&nbsp;&nbsp;<span style='color:yellow'>노랑</span>";
	 	html += " &nbsp;<input type='radio' id='yellow' name='colorSelect' value='yellow' />";
	 	
	 	html += "&nbsp;&nbsp;<span style='color:orange'>주황</span>";
	 	html += " &nbsp;<input type='radio' id='orange' name='colorSelect' value='orange' />";
	 	
	 	html += "&nbsp;&nbsp;<span style='color:greed'>초록</span>";
	 	html += " &nbsp;<input type='radio' id='green' name='colorSelect' value='green'/>";
	 	
	 	html += "<br><span style='color:blue'>파랑</span>";
	 	html += " &nbsp;<input type='radio' id='blue' name='colorSelect' value='blue' />";
	 	
	 	html += "&nbsp;&nbsp;<span style='color:navy'>남색</span>";
	 	html += " &nbsp;<input type='radio' id='navy' name='colorSelect' value='navy'/>";
	 	
	 	html += "&nbsp;&nbsp;<span style='color:purple'>보라</span>";
	 	html += " &nbsp;<input type='radio' id='purple' name='colorSelect' value='purple'/>"; 
	 	html += "</div></div>";
 	}
 		
 		
 	html += "</form>";
 	
 	$("#calInsertInfo").html(html);
}

function calendardelete(id){
	
	if (confirm("캘린더를 삭제하시면 등록된 일정도 삭제됩니다.") == true){    //확인
		location.href="<%=request.getContextPath()%>/cal/caldelete.do?calid="+id;
	   
	}else{   //취소
	    return;
	}


	
}


</script>
<script type="text/javascript">
    jQuery(document).ready(function() {
        jQuery("#calendar").fullCalendar({
        	header: { 
        		left: 'today'
        		, center: 'prev, title, next'
        		, left: 'month,basicWeek,basicDay,listWeek' 
        	},
              defaultDate : new Date()
        	,buttonText: {
        	    today : "오늘",
        	    month : "월간",
        	    basicWeek : "주간",
        	    basicDay : "일간"
        	    
        	}
        	
        	, locale : "ko"
       		, googleCalendarApiKey : "AIzaSyDcnW6WejpTOCffshGDDb4neIrXVUA1EAE"
            , eventSources : [
                // 대한민국의 공휴일
                {
                   googleCalendarId : "ko.south_korea#holiday@group.v.calendar.google.com"
                 , className : "koHolidays"
                 , color : "white"
                 , textColor : "red"
                }
             ]
            , navLinks: true
            , editable : false
            , eventLimit : true
            
            , events: [
            	 <c:if test="${not empty list}">
    			 <c:forEach var="seche" items="${list}" varStatus="vs">
    			 	<c:if test="${seche.type eq '공유 캘린더'}">
    			 	 {
        				 id : "${seche.schedule_no}"
        			    , color : "${seche.color}"
        			    , textColor : "white"
        				, title : "${seche.title}"
        				, start : "${seche.startdate}"+"T" +"${seche.starttime}"
        				, end : "${seche.quitdate}" +"T" +"${seche.quittime}"
        				 
        			 },
    			 	</c:if>
        			 <c:if test="${seche.type eq '내 캘린더'}">
    			 	 {
        				 id : "${seche.schedule_no}"
        				, color : "${seche.color}"
        				, title : "${seche.title}"
        				, start : "${seche.startdate}" +"T" +"${seche.starttime}"
        				, end : "${seche.quitdate}"  +"T" +"${seche.quittime}" 
        				 
        			 },
    			 	</c:if>

    			</c:forEach>
    		
    			</c:if>    

            ]
        	
        	, dayClick: function(date, allDay, jsEvent, view) {
        	
        		
        		$(".fc-day").attr("data-toggle", "modal").attr("data-target", "#calendarInsert");
        		//$(".fc-day-top").attr("data-toggle", "modal").attr("data-target", "#calendarInsert");
        		//$(".fc-event-container").attr("data-toggle", "modal").attr("data-target", "#calendarInsert");
        		$(".fc-content-skeleton").children("table").children("tbody").children("tr").children("td").each(function(item){
        			if($(this).attr("class") == null){
        				$(this).attr("data-toggle", "modal").attr("data-target", "#calendarInsert");
        			}
        		});
        		
     		   var yy=date.format("YYYY");
     		   var mm=date.format("MM");
     		   var dd=date.format("DD");
     		   var ss=date.format("dd");
     		   $("#nows").html(yy+"-"+mm+"-"+dd); 
     		   
     		   var date = yy+"-"+mm+"-"+dd;
     		   day(date);
     		//   $("#calendarid").attr("value",$("#calendar_name option:selected"));
     		   
     		   
        		
     		       
     	} //dayClick끝
        
        	, eventClick:function(event) {

        		$(".fc-content").attr("data-toggle", "modal").attr("data-target", "#calendarView");
        		$(".fc-list-item-title").attr("data-toggle", "modal").attr("data-target", "#calendarView");

        		var html ="";
            	html += "<form action='<%=request.getContextPath()%>/cal/scheduleUpdate' id='updateFrm' method='post'>";
				   console.log("${memberLoggedIn.userId}");
						
        		  <c:forEach var="seche" items="${list}" varStatus="vs">
        		  	   if("${seche.schedule_no}" == event.id){
            			 
            			 html +="<div class='form-group row'>";
       				 	 html +="<label for='calendar_nameView' class='col-sm-2 col-form-label'>캘린더</label>";
       					 html +="<div class='col-sm-10'>";
       				 	 html +="<input type='text' name='calendar_name' id='calendar_nameView' class='form-control' value='${seche.calendar_name}' readonly/></div></div>";
            			 

						 html +="<div class='form-group row'>";
       				 	 html +="<label for='titleView' class='col-sm-2 col-form-label'>일정 제목</label>";
       					 html +="<div class='col-sm-10'>";
       					 html += "<input type='hidden' name='schedule_no' id='schedule_noView'  value='${seche.schedule_no}'/>"
       				 	 html +="<input type='text' name='title' id='titleView' class='form-control' value='${seche.title}'/></div></div>";
						
	       				 html +="<div class='form-group row'>";
	    				 html +="<label for='writerView' class='col-sm-2 col-form-label'>작성자</label>";
	    				 html +="<div class='col-sm-10'>";
	    				 html += "<input type='hidden' name='userId' value='${seche.writer}'/>"
	    				 html +="<input type='text' name='writer' id='writerView' class='form-control' value='${seche.username}' readonly/></div></div>";
						
	    				 html +="<div class='form-group row'>";
        				 html +="<label for='startdateView' class='col-sm-2 col-form-label'>시작</label>";
        				 html += "<div class='row'>";
        				 html += "<div class='col'>";
	        		     html +="<input type='date' name='startdate' id='startdateView' class='form-control' value='${seche.startdate}' required/>";
        				 html += "</div>";
        				 html += "<div class='col'>";
	        		     html += "<select class='form-control' name='starttime' id='starttimeView'>";
	        			 
        				 html += "<option value='00:00' ${seche.starttime eq '00:00'?'selected':''}>오전 12:00</option>";
        				 html += "<option value='01:00' ${seche.starttime eq '01:00'?'selected':''}>오전 01:00</option>";
        				 html += "<option value='02:00' ${seche.starttime eq '02:00'?'selected':''}>오전 02:00</option>";
        				 html += "<option value='03:00' ${seche.starttime eq '03:00'?'selected':''}>오전 03:00</option>";
        				 html += "<option value='04:00' ${seche.starttime eq '04:00'?'selected':''}>오전 04:00</option>";
        				 html += "<option value='05:00' ${seche.starttime eq '05:00'?'selected':''}>오전 05:00</option>";
        				 html += "<option value='06:00' ${seche.starttime eq '06:00'?'selected':''}>오전 06:00</option>";
        				 html += "<option value='07:00' ${seche.starttime eq '07:00'?'selected':''}>오전 07:00</option>";
        				 html += "<option value='08:00' ${seche.starttime eq '08:00'?'selected':''}>오전 08:00</option>";
        				 html += "<option value='09:00' ${seche.starttime eq '09:00'?'selected':''}>오전 09:00</option>";
        				 html += "<option value='10:00' ${seche.starttime eq '10:00'?'selected':''}>오전 10:00</option>";
        				 html += "<option value='11:00' ${seche.starttime eq '11:00'?'selected':''}>오전 11:00</option>";
        				 html += "<option value='12:00' ${seche.starttime eq '12:00'?'selected':''}>오전 12:00</option>";
        				 html += "<option value='13:00' ${seche.starttime eq '13:00'?'selected':''}>오후 01:00</option>";
        				 html += "<option value='14:00' ${seche.starttime eq '14:00'?'selected':''}>오후 02:00</option>";
        				 html += "<option value='15:00' ${seche.starttime eq '15:00'?'selected':''}>오후 03:00</option>";
        				 html += "<option value='16:00' ${seche.starttime eq '16:00'?'selected':''}>오후 04:00</option>";
        				 html += "<option value='17:00' ${seche.starttime eq '17:00'?'selected':''}>오후 05:00</option>";
        				 html += "<option value='18:00' ${seche.starttime eq '18:00'?'selected':''}>오후 06:00</option>";
        				 html += "<option value='19:00' ${seche.starttime eq '19:00'?'selected':''}>오후 07:00</option>";
        				 html += "<option value='20:00' ${seche.starttime eq '20:00'?'selected':''}>오후 08:00</option>";
        				 html += "<option value='21:00' ${seche.starttime eq '21:00'?'selected':''}>오후 09:00</option>";
        				 html += "<option value='22:00' ${seche.starttime eq '22:00'?'selected':''}>오후 10:00</option>";
        				 html += "<option value='23:00' ${seche.starttime eq '23:00'?'selected':''}>오후 11:00</option>";
        				 html += "</select>";
        				 html += "</div></div></div>";
        				 
        				 
        				 html +="<div class='form-group row'>";
        				 html +="<label for='quitdateView' class='col-sm-2 col-form-label'>종료</label>";
        				 html += "<div class='row'>";
        				 html += "<div class='col'>";
	        		     html +="<input type='date' name='quitdate' id='quitdateView' class='form-control' value='${seche.quitdate}' required/>";
        				 html += "</div>";
        				 html += "<div class='col'>";
	        		     html += "<select class='form-control' name='quittime' id='quittimeView'>";
	        			 
        				 html += "<option value='00:00' ${seche.quittime eq '00:00'?'selected':''}>오전 12:00</option>";
        				 html += "<option value='01:00' ${seche.quittime eq '01:00'?'selected':''}>오전 01:00</option>";
        				 html += "<option value='02:00' ${seche.quittime eq '02:00'?'selected':''}>오전 02:00</option>";
        				 html += "<option value='03:00' ${seche.quittime eq '03:00'?'selected':''}>오전 03:00</option>";
        				 html += "<option value='04:00' ${seche.quittime eq '04:00'?'selected':''}>오전 04:00</option>";
        				 html += "<option value='05:00' ${seche.quittime eq '05:00'?'selected':''}>오전 05:00</option>";
        				 html += "<option value='06:00' ${seche.quittime eq '06:00'?'selected':''}>오전 06:00</option>";
        				 html += "<option value='07:00' ${seche.quittime eq '07:00'?'selected':''}>오전 07:00</option>";
        				 html += "<option value='08:00' ${seche.quittime eq '08:00'?'selected':''}>오전 08:00</option>";
        				 html += "<option value='09:00' ${seche.quittime eq '09:00'?'selected':''}>오전 09:00</option>";
        				 html += "<option value='10:00' ${seche.quittime eq '10:00'?'selected':''}>오전 10:00</option>";
        				 html += "<option value='11:00' ${seche.quittime eq '11:00'?'selected':''}>오전 11:00</option>";
        				 html += "<option value='12:00' ${seche.quittime eq '12:00'?'selected':''}>오전 12:00</option>";
        				 html += "<option value='13:00' ${seche.quittime eq '13:00'?'selected':''}>오후 01:00</option>";
        				 html += "<option value='14:00' ${seche.quittime eq '14:00'?'selected':''}>오후 02:00</option>";
        				 html += "<option value='15:00' ${seche.quittime eq '15:00'?'selected':''}>오후 03:00</option>";
        				 html += "<option value='16:00' ${seche.quittime eq '16:00'?'selected':''}>오후 04:00</option>";
        				 html += "<option value='17:00' ${seche.quittime eq '17:00'?'selected':''}>오후 05:00</option>";
        				 html += "<option value='18:00' ${seche.quittime eq '18:00'?'selected':''}>오후 06:00</option>";
        				 html += "<option value='19:00' ${seche.quittime eq '19:00'?'selected':''}>오후 07:00</option>";
        				 html += "<option value='20:00' ${seche.quittime eq '20:00'?'selected':''}>오후 08:00</option>";
        				 html += "<option value='21:00' ${seche.quittime eq '21:00'?'selected':''}>오후 09:00</option>";
        				 html += "<option value='22:00' ${seche.quittime eq '22:00'?'selected':''}>오후 10:00</option>";
        				 html += "<option value='23:00' ${seche.quittime eq '23:00'?'selected':''}>오후 11:00</option>";
        				 html += "</select>";
        				 html += "</div></div></div>";
        				 
        				 html +="<div class='form-group row'>";
	        		     html +="<label for='contentView' class='col-sm-2 col-form-label'>내용</label>";
       				     html +="<div class='col-sm-10'>";
        			 	 html +="<textarea name='content' id='contentView' cols='30' rows='5' class='form-control'>"+"${seche.content}"+"</textarea> </div></div>";
	    				 
				
        		  	   }

    				</c:forEach> 

            	html += "</from>";
            	console.log(html);
            	$("#scheduleInfo").html(html);
            	console.log("4",$(".fc-content"));
            	//$("#calendarView").show();
         
        		
        	  } //eventClick끝        	
        	
        }); //fullCalnedar끝
        
        
        //$(".fc-event").attr("data-toggle", "modal").attr("data-target", "#calendarView");
        //$(".fc-event-container").attr("data-toggle", "modal").attr("data-target", "#calendarView");
    }); //ready 끝
</script>




<script>
function buttonInsert(){
	
	var today = new Date();
	var dd = today.getDate();
	var mm = today.getMonth()+1; //January is 0!
	var yyyy = today.getFullYear();
	
	
	console.log(today);
	var TODAY="";
	if(mm<10){
		TODAY = yyyy+"-0"+mm+"-"+dd;
	}else{
		
	 	TODAY = yyyy+"-"+mm+"-"+dd;
	}
	console.log(TODAY);
	
	
	day(TODAY);
}

</script>

<div id="calendar"></div>	


<!-- Modal -->
<!-- 일정 추가 모달 -->
<div class="modal fade" id="calendarInsert" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true" >
  <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalCenterTitle">일정추가</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p class="date" id="nows"></p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="fn_submit();">일정 등록</button> 
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>
<script>
function fn_submit(){
	var title = $("#title").val().trim().length;
	var content = $("#content").val().trim().length;
	var starttime = $("#starttime option:selected").val().substring(0,2);
	var quittime = $("#quittime option:selected").val().substring(0,2);
	var stratdate = $("#startdate").val().split('-');
	var quitdate = $("#quitdate").val().split('-');
	
	var sdate = new Date(stratdate[0], stratdate[1] - 1, stratdate[2]); 
	var qdate = new Date(quitdate[0], quitdate[1] - 1, quitdate[2]); 

	console.log(sdate.toDateString());
	console.log(qdate.toDateString());


	 if(title==0){
		alert("일정 제목을 입력해주세요.");
		return;
	}else if(starttime=="시작" || quittime=="종료"){
		alert("시작 시간과 종료 시간을 선택해주세요.");
		return;
	}else if(content==0){
		alert("내용을 입력해주세요.");
		return;
	}else if(parseInt(starttime)>parseInt(quittime)){
		alert("시간을 잘못 입력하셨습니다.");
		return;
	}else if (sdate>qdate) {
		alert("날짜를 잘못 입력하셨습니다.");
		return;
	}
	else insertFrm.submit();
}

</script>

<!--일정추가 모달 끝  -->

<!-- Modal -->
<!-- 일정보기 모달 -->
<div class="modal fade" id="calendarView" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true" >
  <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalCenterTitle">일정</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p id="scheduleInfo"></p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="fn_submitUpdate();" >일정 수정</button>
        <button type="button" class="btn btn-primary" onclick="fn_delete();">일정 삭제</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>
<script>
function fn_delete(){
	var sid = $("#schedule_noView").val();
	location.href = '${pageContext.request.contextPath}/cal/scheduleDelete?sid='+sid;
	
}

function fn_submitUpdate(){
	
	var title = $("#titleView").val().trim().length;
	var content = $("#contentView").val().trim().length;
	var starttime = $("#starttimeView option:selected").val().substring(0,2);
	var quittime = $("#quittimeView option:selected").val().substring(0,2);
	var stratdate = $("#startdateView").val().split('-');
	var quitdate = $("#quitdateView").val().split('-');
	
	var sdate = new Date(stratdate[0], stratdate[1] - 1, stratdate[2]); 
	var qdate = new Date(quitdate[0], quitdate[1] - 1, quitdate[2]); 

	console.log(sdate.toDateString());
	console.log(qdate.toDateString());


	 if(title==0){
		alert("일정 제목을 입력해주세요.");
		return;
	}else if(starttime=="시작 시간 선택" || quittime=="종료 시간 선택"){
		alert("시작 시간과 종료 시간을 선택해주세요.");
		return;
	}else if(content==0){
		alert("내용을 입력해주세요.");
		return;
	}else if(parseInt(starttime)>parseInt(quittime)){
		alert("시간을 잘못 입력하셨습니다.");
		return;
	}else if (sdate>qdate) {
		alert("날짜를 잘못 입력하셨습니다.");
		return;
	}
	else updateFrm.submit();
}
$(function(){
	$('#calendarInsert').on('shown.bs.modal', function (e) {
		console.log("123");
	    if ($('#calendarView').hasClass('show')){
	        $(this).hide();
	        $("#calendarView").focus();
	        $(this).modal("hide");
	    }
	});
});

</script>
<!-- 일정보기 모달 끝 -->
<!-- 캘린더 수정 모달 시작 --><!-- Modal -->
<div class="modal fade" id="calendarUpdate" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">캘린더 수정</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p id="calInfo">
        </p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="fn_submitCalSubmit();">수정</button>
        <button type="button" class="btn btn-primary" onclick="fn_calDelete()">삭제</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>

<script>
function fn_submitCalSubmit(){
	
	var name = $("#name").val().trim().length;
	var radio = $('input:radio[name=colorSelect]').is(':checked');
	console.log(radio);

	if(name==0){
		alert("수정할 캘린더 이름을 입력해주세요.");
		return;
	}else if(radio==false){
		alert("색상을 선택해주세요.");
		return;
	}else{
		updateCalFrm.submit();
	}
	
}

function fn_calDelete(){
	
	var id = $("#calid").val();
	console.log("deleteid=" +id);
	
	if (confirm("정말 삭제하시겠습니까??") == true){    //확인
		location.href="<%=request.getContextPath()%>/cal/caldelete.do?calid="+id;
	   
	}else{   //취소
	    return;
	}

	
}

</script>

<!-- 캘린더 등록 시작 --><!-- Modal -->
<div class="modal fade" id="calendarNameInsert" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">캘린더 등록</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p id="calInsertInfo">
        </p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="fn_calInsertSubmit();">등록</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>
<script>
function fn_calInsertSubmit(){
	var name = $("#calName").val().trim().length;
	var radio = $('input:radio[name=colorSelect]').is(':checked');
	console.log(radio);

	if(name==0){
		alert("등록할 캘린더 이름을 입력해주세요.");
		return;
	}else if(radio==false){
		alert("색상을 선택해주세요.");
		return;
	}else{
		insertCalFrm.submit();
	}
	
}

</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>