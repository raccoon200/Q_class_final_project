
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

</style>
<script type="text/javascript">
    jQuery(document).ready(function() {
    
        jQuery("#calendar2").fullCalendar({
        	header: { 
        		left: 'today'
        		, center: 'prev, title, next'
        		, right : null
        		
        	},
        	
              defaultDate : new Date()
        	, locale : "ko"
        	,	timezone : 'local'
            /* ,    height: 800 */
             ,   businessHours: true
            
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
            	<c:if test="${not empty breaklist}">
      		  	<c:forEach var="bre" items="${breaklist}">
	      		  {
	 				id : "${bre.BREAK_REQUEST_NO}"
	 			    , color : "white"
	 			    , textColor : "#0055FF"
	 				, title : "${bre.USERNAME}"
	 				, start : "${bre.STARTDATE}"
	 				, end : "${bre.ENDDATE}" 
	 				 
	 			 },
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
     		
     		   
        		
     		       
     	} //dayClick끝
        
        	, eventClick:function(event) {

        		$(".fc-content").attr("data-toggle", "modal").attr("data-target", "#breakInfo");
        		$(".fc-list-item-title").attr("data-toggle", "modal").attr("data-target", "#breakInfo");

        		var html ="";
        		html += "<table class='table'>";
        		html += "<thead>";
        		html += "<tr>";
        		html += "<th scope='col'></th>";
        		html += "<th scope='col'>휴가자</th>";
        		html += "<th scope='col'>소속</th>";
        		html += "<th scope='col'>종류</th>";
        		html += "</tr>";
        		html += " </thead> <tbody>";
        		
        		<c:if test="${not empty breaklist}">
      		  	<c:forEach var="bre" items="${breaklist}">
      		  	
		  	   if("${bre.BREAK_REQUEST_NO}" == event.id){
        		
	        		html += " <tr>";
	        		html += " <th scope='row'>1</th>";
	        	    html += " <td>${bre.USERNAME}</td>";
	        	    html += " <td>${bre.COM_NAME}</td>";
	        	    html += " <td>${bre.KIND}</td>";
	  				html += "</tr>";
  				
		  	   }	
  				</c:forEach>
       		   </c:if>
  				
  				html += "</tbody></table>";
        		   
    			$("#breakInfomation").html(html);
        	
        		
        	  } //eventClick끝        	
        	
        }); //fullCalnedar끝
        
        
    }); //ready 끝
</script>

<!-- Modal -->
<div class="modal fade" id="breakInfo" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">휴가 정보</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p id="breakInfomation">
        </p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>

<div id="calendar2"></div>	





