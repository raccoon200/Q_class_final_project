
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

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

<style>
.fc-sat { color:#0066FF; }     /* 토요일 */
.fc-sun { color:#FF0000; } 
#calendar3 {
    width: 90%;
    display: inline-block;
}
h2{
	font-size: 20px;
}

</style>
<script>
function between(start,end){
	diffDate_1 = new Date(start);
    diffDate_2 = new Date(end);
	 
   var diff = Math.abs(diffDate_2.getTime() - diffDate_1.getTime());
   diff = Math.ceil(diff / (1000 * 3600 * 24));

   
   $("#breakdays").val(diff);
   $("#selectedDay").html(diff);
 
	
}

</script>
<script type="text/javascript">

 /* $(function() {

	  $('#calendar3').fullCalendar({
	    selectable: true,
	    hiddenDays: [ 0, 6 ],
	    height: 400,
	    defaultDate : new Date(),
    	locale : "ko",
    	timezone : 'local',
    	eventSources : [
            // 대한민국의 공휴일
            {
               googleCalendarId : "ko.south_korea#holiday@group.v.calendar.google.com"
             , className : "koHolidays"
             , color : "white"
             , textColor : "red"
            }
         ],
        navLinks: true,
        editable : false,
	    header: {
	      left: 'prev,next today',
	      center: 'title',
	      right: 'month'
	    },
	    dayClick: function(date) {
	      alert('clicked ' + date.format());
	    },
	    select: function(startDate, endDate) {
	      alert('selected ' + startDate.format() + ' to ' + endDate.format());
	    }
	  });

	});  */


      jQuery(document).ready(function() {
    
        jQuery("#calendar3").fullCalendar({
        	header: { 
        		left: 'today'
        		, center: 'prev, title, next'
        		, right : null
        		
        	},
        	
              defaultDate : new Date()
        	, locale : "ko"
        	,	timezone : 'local'
        	,   selectable: true
        	,select: function(startDate, endDate) {
      	      alert('selected ' + startDate.format() + ' to ' + endDate.format());
    	    }
        	,   hiddenDays: [ 0, 6 ]
        	,   height: 400
            ,   businessHours: true
       		, googleCalendarApiKey : "AIzaSyDcnW6WejpTOCffshGDDb4neIrXVUA1EAE"
            , eventSources : [
                // 대한민국의 공휴일
                {
                   googleCalendarId : "ko.south_korea#holiday@group.v.calendar.google.com"
                 , className : "koHolidays"
                 , color : "darkgray"
                 , textColor : "red"
                }
  
                
             ]
            , navLinks: true
            , editable : false
            , eventLimit : true
            , events: [
            	
            ]
        	
        	, dayClick: function(date, allDay, jsEvent, view) {
        	
        	
     		} //dayClick끝
        
        	, eventClick:function(event) {

        	  } //eventClick끝  
        	,select: function(startDate, endDate) {
        		
        		
        	     //alert('selected ' + startDate.format() + ' to ' + endDate.format());
        	     //alert('selected ' + startDate.format() + ' to ' + endDate.format());
        	     console.log("endDate" + endDate);
        	     console.log("endDate.format()" + endDate.format()+"T02:00");
        	     
        	      $("#start").html(startDate.format()+"~");
        	     //$(".fc-highlight").css("background", "red");
        		  enddateSolve(endDate.format());
        	     
        	      between(startDate.format(),endDate.format());
        	      
        	      $("#startdate").val(startDate.format());
        	     // $("#start").html(startDate.format()+ "~");
        	      $("#enddate").val(endDate.format());
        	   //   $("#end").html(endDate.format());
        		  checkToday(startDate.format());
        	      
            }
        	
        }); //fullCalnedar끝
         
        
    }); //ready 끝  
</script>
<script>


function checkToday(s){
	var selectedYear = s.substring(0,4);
	var selectedmm = s.substring(5,7);
	var selecteddd = s.substring(8,10);
	var selectedDate = new Date(selectedYear,selectedmm-1,selecteddd)
	var todayYear = new Date().toString().substring(11,15);
	var today = new Date();
	
	console.log("selectedYear" + selectedYear);
	console.log("selectedmm" + selectedmm);
	console.log("selecteddd" + selecteddd);
	console.log("selectedDate = "+ selectedDate);
	console.log("today = "+ today);
	
	if(today>=selectedDate){
		alert("현재 날짜 혹은 현재 날짜보다 이전 날짜를 선택하실 수 없습니다.");
		$(".fc-highlight").removeClass();
		$("#selectedDay").html(" ");
		$("#start").html(" ");
		$("#end").html(" ");
		return;
	}
	
	
	if(selectedYear !=todayYear){
		alert("현재년도 날짜만 선택 가능합니다.");
		$(".fc-highlight").removeClass();
		$("#selectedDay").html(" ");
		$("#start").html(" ");
		$("#end").html(" ");
		return;
	}
	//alert("날짜 체크" + todayYear);
	
}
$(".fc-highlight").css("background", "red");

function enddateSolve(endDate){
	var year = endDate.substring(0,4);
	var month = endDate.substring(5,7)*1;
	var day = endDate.substring(8,11)*1;
	console.log("year" +year);
	console.log("month" +month);
	console.log("day" +day);
	
	var end = new Date(year,month-1,day-1);
	
	
	var y = end.getFullYear();
	
	var m="";
	var d="";
	if((end.getMonth()*1)<10){
		m = "0" +(end.getMonth()+1);
	}else{
		m= end.getMonth()+1;
	}
	if((end.getDate()*1)<10){
		d = "0" +end.getDate();
	}else{
		d= end.getDate();
	}
	
	var realEndDate = y+"-"+m+"-"+d;
	$("#enddate2").val(realEndDate);
	
	$("#end").html(realEndDate);
	console.log("realEndDate"+realEndDate);
	
	console.log(y+"-"+m+"-"+d);
	console.log("풀캘린더 날짜" + endDate);
	console.log("날짜빼기" + end.toString().substring(0,4));
	

}  
</script>


<div id="calendar3">
	<input type="hidden" name="startdate" id="startdate" />
	
	<input type="hidden" name="enddate" id="enddate2"/>
</div>
<br />	
  휴가 신청 : <span id="start"></span> <span id="end"></span> 
 <br />

 선택일 수  :<span id="selectedDay"></span>일
 <input type="hidden" name="breakdays" id="breakdays"/>





