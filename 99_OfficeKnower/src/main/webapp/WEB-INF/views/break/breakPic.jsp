<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
</head>
<script>

/* $(function() {
    $("#datepicker1, #datepicker2").datepicker({
        dateFormat: 'yy.mm.dd',
      	regional: "ko",

	beforeShowDay: function(date){

		var day = date.getDay();

		return [(day != 0 && day != 6)];

	}	
    });
});*/

$(document).ready(function(){
	$("#datepicker1").datepicker({
		dateFormat: 'yy-mm-dd',
	      	regional: "ko",
	    minDate: 0,
		beforeShowDay: function(date){
			day = date.getDay();
			date = date.get
			

			return [(day != 0 && day != 6)]
		},
		
		 onSelect: function(selected) {
			$("#datepicker2").datepicker("option","minDate", selected)
		} 
	});
	
	$("#datepicker2").datepicker({
		dateFormat: 'yy-mm-dd',
      	regional: "ko",
		beforeShowDay: function(date){
			day = date.getDay();
			
	
			return [(day != 0 && day != 6)]
		}
		
		/* onSelect: function(selected) {
			$("#datepicker1").datepicker("option","maxDate", selected)
		} */
		
	});
	
	 $("#btn").on('click',function(){
		/* var day1 =  new Date($("#datepicker1").datepicker("getDate"));
		var day2 = new Date($("#datepicker2").datepicker("getDate"));
		console.log(day1);
		console.log(day2);
		 
		 var html = day2 - day1;
		$("#betweenDay").html(html);
		
		
		 */
		
		 diffDate_1 = new Date($("#datepicker1").datepicker("getDate"));
	     diffDate_2 = new Date($("#datepicker2").datepicker("getDate"));
		 
	    var diff = Math.abs(diffDate_2.getTime() - diffDate_1.getTime());
	    diff = Math.ceil(diff / (1000 * 3600 * 24));

	    $("#betweenDay").html(diff);
		
		
		
		
		
		
	}); 
	
});

</script>
<body>

<p>조회기간:
    <input type="text" id="datepicker1"> ~
    <input type="text" id="datepicker2">
</p>

<button id="btn"> 선택</button>

선택일 수 : <span id="betweenDay"></span>

</body>
</html>