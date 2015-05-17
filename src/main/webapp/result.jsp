<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<style>
.counties {
	fill: none;
}

.states {
	fill: none;
	stroke: #fff;
	stroke-linejoin: round;
}

.q0-9 {
	fill: rgb(247, 251, 255);
}

.q1-9 {
	fill: rgb(222, 235, 247);
}

.q2-9 {
	fill: rgb(198, 219, 239);
}

.q3-9 {
	fill: rgb(158, 202, 225);
}

.q4-9 {
	fill: rgb(107, 174, 214);
}

.q5-9 {
	fill: rgb(66, 146, 198);
}

.q6-9 {
	fill: rgb(33, 113, 181);
}

.q7-9 {
	fill: rgb(8, 81, 156);
}

.q8-9 {
	fill: rgb(8, 48, 107);
}
</style>

<body>	

<script src="http://d3js.org/d3.v3.min.js"></script>
<script src="http://d3js.org/queue.v1.min.js"></script>
<script src="http://d3js.org/topojson.v1.min.js"></script>

<script type="application/javascript">
	

var width = 960,
height = 600;

var rateById = d3.map();

var quantize = d3.scale.quantize()
.domain([0, .15])
.range(d3.range(9).map(function(i) { return "q" + i + "-9"; }));

var projection = d3.geo.albersUsa()
.scale(1280)
.translate([width / 2, height / 2]);

var path = d3.geo.path()
.projection(projection);

var svg = d3.select("body").append("svg")
.attr("width", width)
.attr("height", height);

queue()
.defer(d3.json, "us.json")
.defer(d3.tsv, "unemployment.tsv", function(d) { rateById.set(d.id, +d.rate); })
.await(ready);

function ready(error, us) {
svg.append("g")
  .attr("class", "counties")
.selectAll("path")
  .data(topojson.feature(us, us.objects.counties).features)
.enter().append("path")
  .attr("class", function(d) { return quantize(rateById.get(d.id)); })
  .attr("d", path);

svg.append("path")
  .datum(topojson.mesh(us, us.objects.states, function(a, b) { return a !== b; }))
  .attr("class", "states")
  .attr("d", path);
}

d3.select(self.frameElement).style("height", height + "px");

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