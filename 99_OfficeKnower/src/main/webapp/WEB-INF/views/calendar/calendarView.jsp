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
    }
</style>
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
            , editable : true
            , eventLimit : true
            , events: [
            	/* <c:if test="${not empty list }">
    			 <c:forEach var="seche" items="${list}" varStatus="vs">
    			 {
    				 title : "${seche.TITLE}"
    				, start : "${seche.STARTDATE}"
    				, end : "${seche.ENDDATE}"
    				 
    			 },
    			</c:forEach>
    		
    			</c:if>   */  
            	
            	
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
        });
    });
</script>

    <div id="calendar"></div>
	
</body>
</html>