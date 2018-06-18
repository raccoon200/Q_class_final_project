<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
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
.fc-sat { color:#0066FF; }     /* 토요일 */
.fc-sun { color:#FF0000; }    /* 일요일 */

</style>
<script type="text/javascript">
    jQuery(document).ready(function() {
        jQuery("#calendar").fullCalendar({
        	header: { 
        		left: 'today'
        		, center: 'prev, title, next'
        		, right: 'month,basicWeek,basicDay,listWeek' 
        	},
              defaultDate : new Date()
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
            	 <c:if test="${not empty list }">
    			 <c:forEach var="seche" items="${list}" varStatus="vs">
    			 	<c:if test="${seche.writer eq 'share'}">
    			 	 {
        				 id : "${seche.schedule_no}"
        			    , color : "lightcoral"
        				, title : "${seche.title}"
        				, start : "${seche.startdate}"+"T" +"${seche.starttime}"
        				, end : "${seche.quitdate}" +"T" +"${seche.quittime}"
        				 
        			 },
    			 	</c:if>
        			 <c:if test="${seche.writer ne 'share'}">
    			 	 {
        				 id : "${seche.schedule_no}"
        				, color : "lightblue"
        				, title : "${seche.title}"
        				, start : "${seche.startdate}" +"T" +"${seche.starttime}"
        				, end : "${seche.quitdate}"  +"T" +"${seche.quittime}" 
        				 
        			 },
    			 	</c:if>

    			</c:forEach>
    		
    			</c:if>    

                {
                	id : 999
                    ,  title : "All Day Event"
                    , start : "2016-05-01"
                    , end : ""
                },
                {
                      title : "Birthday Party"
                    , start : "2018-06-13T07:00"
                },
                {
                      title : "Click for Google"
                    , url : "http://google.com/"
                    , start : "2016-05-28"
                }
            ]
        	
        	, dayClick: function(date, allDay, jsEvent, view) {
        		$(".fc-day").attr("data-toggle", "modal").attr("data-target", "#calendarInsert");
     		   var yy=date.format("YYYY");
     		   var mm=date.format("MM");
     		   var dd=date.format("DD");
     		   var ss=date.format("dd");
     		   $("#nows").html(yy+"-"+mm+"-"+dd); 
     		   
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
     		        				 html2 += "<select id='calendar_name' name='calendar_name' class='form-control'>"; 
     		               	     	 //html2 += "<option>캘린더 선택</option>";
     		                 	for(var index in data){
     		 						var c = data[index];

     		 						 html2 += "<option>"+ c.CALENDAR_NAME+"</option>";  

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
     		        				 html2 +="<input type='date' name='startdate' id='startdate' class='form-control' value='"+yy+"-"+mm+"-"+dd+"' required/>";
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
     		        				 html2 +="<input type='date' name='quitdate' id='quitdate' class='form-control' value='"+yy+"-"+mm+"-"+dd+"' required/>";
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
     		   
     	} //dayClick끝
        
        	, eventClick:function(event) {
        		$(".fc-content").attr("data-toggle", "modal").attr("data-target", "#calendarView");
        		$(".fc-widget-content").attr("data-toggle", "modal").attr("data-target", "#calendarView");
        		var html ="";
            	html += "<table>";
				   console.log("${memberLoggedIn.userId}");
						
        		  <c:forEach var="seche" items="${list}" varStatus="vs">
        		  	   if("${seche.schedule_no}" == event.id){
						console.log("찍히나??");
						
        		  		 html += "<tr><th>작성자</th>";  
	    				 html +="<th> ${seche.username} </th></tr>";
	    				 html += "<tr><th>일정 제목";
	    				 html += "<th> ${seche.title} </th></tr>";
	    				 html += "<tr><th>시작";
	    				 html += "<th> ${seche.startdate} </th>";
	    				 
	    		
	    				 html += "<th> ${seche.starttime} </th></tr>";
    					 html += "<tr><th>종료";
	    				 html += "<th> ${seche.quitdate} </th>";
	    				 html += "<th> ${seche.quittime}</th></tr>";
	    				 html += "<tr><th>내용";
	    				 html += "<th>" + "<textarea name='content' id='content' cols='30' rows='5' >"+"${seche.content}"+"</textarea>";
	    				 html += "</th></tr>";		 
        		  	   }

    				</c:forEach> 

            	html += "</table>";
            	console.log(html);
            	$("#scheduleInfo").html(html);
            	//$("#calendarView").show();
            	
            	//div하나 만들어서 일단 test
            	//$("#viewInfo").html(html);
            	//$("#viewTest").show();
            	
            	
        		
        	  } //eventClick끝        	
        	
        }); //fullCalnedar끝
        	

    
    }); //ready 끝
    

</script>



<div id="calendar"></div>	
<!-- view모달 대신 div 테스트용 -->
<div id="viewTest">
	<p id="viewInfo"></p>
</div>
<!-- Modal -->
<!-- 일정 추가 모달 -->
<div class="modal fade" id="calendarInsert" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="false" >
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
	else insertFrm.submit();
}
</script>

<!--일정추가 모달 끝  -->

<!-- Modal -->
<!-- 일정보기 모달 -->
<div class="modal fade" id="calendarView" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="false" >
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
        <button type="button" class="btn btn-primary" onclick="fn_submit();">일정 등록</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>
<!-- 일정보기 모달 끝 -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>