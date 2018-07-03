
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
        	     alert('selected ' + startDate.format() + ' to ' + endDate.format());
        	      
        
        	      between(startDate.format(),endDate.format());
        	      
        	      $("#startDate").val(startDate.format());
        	      $("#endDate").val(endDate.format());
        	      
            }
        	
        }); //fullCalnedar끝
        
        
    }); //ready 끝  
</script>

<div id="calendar3">
	<input type="hidden" name="startDate" id="startDate" />
	<input type="hidden" name="endDate" id="endDate"/>
</div>	
 선택일 수  :<span id="selectedDay"></span>일





