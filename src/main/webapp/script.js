var width = 960, height = 600;

var rateById = d3.map();

var quantize = d3.scale.quantize().domain([ 0, .15 ]).range(
		d3.range(9).map(function(i) {
			return "q" + i + "-9";
		}));

var projection = d3.geo.albersUsa().scale(1280).translate(
		[ width / 2, height / 2 ]);

var path = d3.geo.path().projection(projection);

var svg = d3.select("body").append("svg").attr("width", width).attr("height",
		height);

queue().defer(d3.json, "us.json").defer(d3.tsv, "unemployment.tsv",
		function(d) {
			rateById.set(d.id, +d.rate);
		}).await(ready);

function ready(error, us) {
	svg.append("g").attr("class", "counties").selectAll("path").data(
			topojson.feature(us, us.objects.counties).features).enter().append(
			"path").attr("class", function(d) {
		return quantize(rateById.get(d.id));
	}).attr("d", path);

	svg.append("path").datum(
			topojson.mesh(us, us.objects.states, function(a, b) {
				return a !== b;
			})).attr("class", "states").attr("d", path);
}

d3.select(self.frameElement).style("height", height + "px");

var ar;
function loadJSON() {
	var data_file = "http://localhost:8080/com.eclipse.geowave.accumulo.service/MainServlet";
	var http_request = new XMLHttpRequest();
	try {
		// Opera 8.0+, Firefox, Chrome, Safari
		http_request = new XMLHttpRequest();
	} catch (e) {
		// Internet Explorer Browsers
		try {
			http_request = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {
			try {
				http_request = new ActiveXObject("Microsoft.XMLHTTP");
			} catch (e) {
				// Something went wrong
				alert("Your browser broke!");
				return false;
			}
		}
	}

	http_request.onreadystatechange = function() {
		if (http_request.readyState == 4) {
			// Javascript function JSON.parse to parse JSON data
			try {
				var jsonObj = JSON.parse(http_request.responseText);
				ar = jsonObj;
			} catch (e) {
				// TODO: handle exception
				console.log(e);
			}

			// console.log(http_request.responseText);

		}
	}

	http_request.open("GET", data_file, true);
	http_request.send();
}