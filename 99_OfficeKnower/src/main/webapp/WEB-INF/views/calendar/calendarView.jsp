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
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
<link href="${pageContext.request.contextPath }/resources/fullcalendar-3.9.0/fullcalendar.print.css" rel="stylesheet" media="print"/>
<link href="${pageContext.request.contextPath}/resources/fullcalendar-3.9.0/fullcalendar.css" rel="stylesheet"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/fullcalendar-3.9.0/lib/moment.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/fullcalendar-3.9.0/fullcalendar.js"></script>
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
<script type="text/javascript">
    jQuery(document).ready(function() {
        jQuery("#calendar").fullCalendar({
        	header: { 
        		left: 'prev,next today'
        		, center: 'title'
        		, right: 'month' 
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
        	
        	, dayClick: function(date, allDay, jsEvent, view) {
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
     		                 		 html2 +="<form action='<%=request.getContextPath()%>/cal/scheduleInsert' id='insertFrm' method='post'>";
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
    		        				 html2 +="<div class='col-sm-10'>";
     		        				 html2 +="<input type='date' name='startdate' id='startdate' class='form-control' value='"+yy+"-"+mm+"-"+dd+"' required/></div></div>";
     		        				 
     		        				 html2 +="<div class='form-group row'>";
    		        				 html2 +="<label for='quitdate' class='col-sm-2 col-form-label'>종료</label>";
    		        				 html2 +="<div class='col-sm-10'>";
     		        				 html2 +="<input type='date' name='quitdate' id='quitdate' class='form-control' value='"+yy+"-"+mm+"-"+dd+"' required/></div></div>";
     		        				 
     		        	
     		        				 
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
     		   
     		   
     	} 
        
        	, eventClick:function(event) {
        		var html ="";
            	html += "<table>";
						console.log("${memberLoggedIn.userId}");
        		  <c:forEach var="seche" items="${list}" varStatus="vs">
        		  	   /* console.log("${seche.schedule_no}");
        		  	   console.log("${event.id}");
        		  	   console.log("${seche.schedule_no eq event.id}"); */
	    			   
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
        $(".fc-day").attr("data-toggle", "modal").attr("data-target", "#calendarInsert");
    });
    
 
    
</script>



<div id="calendar">

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
	insertFrm.submit();
}
</script>

<!--일정추가 모달 끝  -->

<!-- Modal -->
<!-- 일정보기 모달 -->
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
<!-- 일정보기 모달 끝 -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>