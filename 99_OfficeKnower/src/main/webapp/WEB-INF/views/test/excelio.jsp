<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <script
		src="${pageContext.request.contextPath }/resources/js/jquery-3.3.1.js"></script>
	<!-- 부트스트랩관련 라이브러리 -->
	<link rel="stylesheet"
		href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"
		integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4"
		crossorigin="anonymous">
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
		integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"
		integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm"
		crossorigin="anonymous"></script>
	    <title>excelIOTest</title>
</head>
<script>
	function fn_addinput(){
		$("#form2").children("table").append('<tr><td><input type="text" name="name" id="name" /></td><td><input type="number" name="age" id="age" /></td><td><input type="text" name="gender" id="gender" /></td><td><input type="text" name="etc" id="etc" /></td></tr>');
	}
</script>
<body>
    <form action="${pageContext.request.contextPath }/test/excelIOTest.do" method="POST" enctype="multipart/form-data">
    	<input type="file" name="file" id="file" />
    	<input type="submit" value="전송" />
    </form>
    <button onclick="fn_addinput();">추가</button>
    <form action="${pageContext.request.contextPath }/test/textToExcel.do" method="post" id="form2">
    	<table>
    		<tr>
    			<th>
    				이름
    			</th>
    			<th>
    				나이
    			</th>
    			<th>
    				성별
    			</th>
    			<th>
    				비고
    			</th>
    		</tr>
    		<tr>
    			<td>
    				<input type="text" name="name" id="name" />
    			</td>
    			<td>
    				<input type="number" name="age" id="age" />
    			</td>
    			<td>
    				<input type="text" name="gender" id="gender" />
    			</td>
    			<td>
    				<input type="text" name="etc" id="etc" />
    			</td>
    		</tr>
    	</table>
    	<input type="submit" value="excel" />
    </form>
</body>
</html>