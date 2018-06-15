<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/fullcalendar-3.9.0/lib/jquery.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.3.1.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
<link href="${pageContext.request.contextPath }/resources/fullcalendar-3.9.0/fullcalendar.print.css" rel="stylesheet" media="print"/>
<link href="${pageContext.request.contextPath}/resources/fullcalendar-3.9.0/fullcalendar.css" rel="stylesheet"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/fullcalendar-3.9.0/lib/moment.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/fullcalendar-3.9.0/fullcalendar.js"></script>
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

.fc-content{
	cursor: pointer;
} 
</style>
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
    			 	<c:if test="${seche.writer eq 'share'}">
    			 	 {
        				 id : "${seche.schedule_no}"
        			    , color : "lightcoral"
        				, title : "${seche.title}"
        				, start : "${seche.startdate}"
        				, end : "${seche.quitdate}"
        				 
        			 },
    			 	</c:if>
        			 <c:if test="${seche.writer ne 'share'}">
    			 	 {
        				 id : "${seche.schedule_no}"
        				, color : "lightblue"
        				, title : "${seche.title}"
        				, start : "${seche.startdate}"
        				, end : "${seche.quitdate}"
        				 
        			 },
    			 	</c:if>
    			 
    			/*  {
    				 id : "${seche.schedule_no}"
    				, title : "${seche.title}"
    				, start : "${seche.startdate}"
    				, end : "${seche.quitdate}"
    				 
    			 }, */
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
        		var html ="";
            	html += "<table>";

        		  <c:forEach var="seche" items="${list}" varStatus="vs">
        		  	   console.log("${seche.schedule_no}");
        		  	   console.log("${event.id}");
        		  	   console.log("${seche.schedule_no eq event.id}");
	    			   
        		  	   if(${seche.schedule_no} == event.id){
        		  		   
        		  		 html += "<tr><th>작성자</th>";  
	    				 html +="<th> ${seche.username} </th></tr>";
	    				 html += "<tr><th>일정 제목";
	    				 html += "<th> ${seche.title} </th></tr>";
	    				 html += "<tr><th>시작";
	    				 html += "<th> ${seche.startdate} </th></tr>";
	    				
	    				  if(${empty seche.quitdate}){
		    				 html += "<tr><th>종료";
		    				 html += "<th> ${seche.startdate} </th></tr>";
	    				 }else{
	    					 html += "<tr><th>종료";
		    				 html += "<th> ${seche.quitdate} </th></tr>";
	    				 } 
	    				  
	    				 html += "<tr><th>내용";
	    				 html += "<th>" + "<textarea name='content' id='content' cols='30' rows='5' >"+"${seche.content}"+"</textarea>";
	    				 html += "</th></tr>";
	    				 
	    				 
	    				 
	    				/*  html += "<th> ${seche.content} </th></tr>"; */
	    				
	    				 
        		  	   }

    				</c:forEach> 
        		
            	
            	html += "</table>";
            	
            	$("#scheduleInfo").html(html);
            	$("#calendarView").show();
            	//$("#calendarView").show();
                //window.open(event.title);
                //alert(event.title + "\n" + event.url, "wicked", "width=700,height=600");
        		
        		
        	  }
        	  
        

        });
        $(".fc-content").attr("data-toggle", "modal").attr("data-target", "#calendarView");
    });
</script>



<div id="calendar">
</div>	
   <!-- Modal -->
<div class="modal fade" id="calendarView" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="false">
  <div class="modal-dialog modal-dialog-centered" role="document">
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
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>
</body>
</html>