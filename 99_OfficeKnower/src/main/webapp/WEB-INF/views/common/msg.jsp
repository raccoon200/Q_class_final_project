<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	String msg = (String)request.getAttribute("msg");
	String loc = request.getContextPath()+(String)request.getAttribute("loc");
	String script = (String)request.getAttribute("script");
	
	//System.out.println("msg@msg.jsp="+msg);
	//System.out.println("loc@msg.jsp="+loc);
%>

<script>
alert('<%=msg %>');
/* 스크립트에 값이 담겨있을때만 실행함. */
<%= script!=null?script:""%>
location.href = '<%=loc %>';
</script>
