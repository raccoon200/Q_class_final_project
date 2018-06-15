<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>일정 초안</title>
<style type="text/css">
body {
    margin :40px 10px;
    padding : 0;
    font-family : "Lucida Grande", Helvetica, Arial, Verdana,sans-serif;
    font-size : 14px;
}
#calendar {
    max-width : 900px;
    margin : 0 auto;
    position: relative;
    z-index: 1;
}
#back {
  position: relative;
  width : 1000px;
  
  z-index: 0;
} 

#calendarView {
  position: relative;
  top: 	10;
  width: 300px;
  height: 400px;
  background-color: lightgray;
  /* visibility: hidden;  */
  border: 1px solid black;
  z-index: 2;
} 
</style>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.3.1.js"></script>
<link href="${pageContext.request.contextPath }/resources/fullcalendar-3.9.0/fullcalendar.print.css" rel="stylesheet" media="print"/>
<link href="${pageContext.request.contextPath}/resources/fullcalendar-3.9.0/fullcalendar.css" rel="stylesheet"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/fullcalendar-3.9.0/lib/moment.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/fullcalendar-3.9.0/lib/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/fullcalendar-3.9.0/fullcalendar.js"></script>
</head>
<body>

<script type="text/javascript">
    jQuery(document).ready(function() {
        jQuery("#calendar").fullCalendar({
        	header: { 
        		left: 'prev,next today'
        		, center: 'title'
        		, right: 'month,basicWeek,basicDay,list' 
        	},
              defaultDate : new Date()
            , navLinks: true
            , editable : false
            , eventLimit : true
            , events: [
            	 <c:if test="${not empty list }">
    			 <c:forEach var="seche" items="${list}" varStatus="vs">
    			 {
    				 id : "${seche.schedule_no}"
    				, title : "${seche.title}"
    				, start : "${seche.startdate}"
    				, end : "${seche.quitdate}"
    				 
    			 },
    			</c:forEach>
    		
    			</c:if>    
            	
            	
                {
                	id : 999
                    ,  title : "All Day Event"
                    , start : "2016-05-01"
                    , end : ""
                },
                {
                      title : "Long Event"
                    , start : "2016-05-07"
                    , end : "2016-05-10"
                },
                {
                      id : 999
                    , title : "Repeating Event"
                    , start : "2016-05-09T16:00:00"
                },
                {
                      id : 999
                    , title : "Repeating Event"
                    , start : "2016-05-16T16:00:00"
                },
                {
                      title : "Conference"
                    , start : "2016-05-11"
                    , end : "2016-05-13"
                },
                {
                      title : "Meeting"
                    , start : "2016-05-12T10:30:00"
                    , end : "2016-05-12T12:30:00"
                },
                {
                      title : "Lunch"
                    , start : "2016-05-12T12:00:00"
                },
                {
                      title : "Meeting"
                    , start : "2016-05-12T14:30:00"
                },
                {
                      title : "Happy Hour"
                    , start : "2016-05-12T17:30:00"
                },
                {
                      title : "Dinner"
                    , start : "2016-05-12T20:00:00"
                },
                {
                      title : "Birthday Party"
                    , start : "2016-05-13T07:00:00"
                },
                {
                      title : "Click for Google"
                    , url : "http://google.com/"
                    , start : "2016-05-28"
                }
            ]
        	, eventClick:function(event) {
           
        		var schedule_no = event.id;
        		
        		$.ajax({
        			console.log("에이작스에 들어와요");
        			/* url : "${pageContext.request.contextPath}/member/checkIdDuplicate.do"; */ 
        			url : "scheduleView", /*현재 디렉토리에서 상대주소*/
        			data : {schedule_no : schedule_no},
        			dataType : "json",
        			data : {userId:userId},  /*속성값(키):입력값*/
        			success : function(data) {
        				console.log(data); //true/ false
        				
        					
        				}
        			},
        			error:function(jqxhr, textStatus, errorThrown) {
        				console.log("ajax실패!", jqxhr, textStatus, errorThrown);
        			}
        		});
        	});
        		
        		
                	var html ="";
                	html += "<table>";
                	html += "<tr>";
                	html += "<th>" + event.title + "</th></tr>";
                	html += "<tr><th>" + event.start + "/<th></tr>";
                	html += "<tr><th>" + event.end + "</th></tr>";
                	html += "</table>";
                	
                
                	$("#scheduleInfo").html(html);
                	$("#calendarView").show();
                	//$("#calendarView").show();
                    //window.open(event.title);
                    //alert(event.title + "\n" + event.url, "wicked", "width=700,height=600");
                    
                
            }
        });
    });
    $(function(){
    	$("#calendarView").hide();
    });
</script>


<div id="back">
    <div id="calendar">
    	<div id="calendarView">
    		<p id="scheduleInfo"></p>
    	</div>
    </div>
    
</div>	
      


	
</body>
</html>