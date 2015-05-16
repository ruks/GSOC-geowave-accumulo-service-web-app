<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="application/javascript">
	
	var ar;
function loadJSON()
{
   var data_file = "http://localhost:8080/com.eclipse.geowave.accumulo.service/MainServlet";
   var http_request = new XMLHttpRequest();
   try{
      // Opera 8.0+, Firefox, Chrome, Safari
      http_request = new XMLHttpRequest();
   }catch (e){
      // Internet Explorer Browsers
      try{
         http_request = new ActiveXObject("Msxml2.XMLHTTP");
      }catch (e) {
         try{
            http_request = new ActiveXObject("Microsoft.XMLHTTP");
         }catch (e){
            // Something went wrong
            alert("Your browser broke!");
            return false;
         }
      }
   }
   
   
   http_request.onreadystatechange  = function(){
      if (http_request.readyState == 4  )
      {
        // Javascript function JSON.parse to parse JSON data
        try {
        	var jsonObj = JSON.parse(http_request.responseText);	
        	ar=jsonObj;
		} catch (e) {
			// TODO: handle exception
			console.log(e);
		}
        
		//console.log(http_request.responseText);
		
      }
   }
   
   http_request.open("GET", data_file, true);
   http_request.send();
   
}


</script>

</head>
<body>

</body>
</html>