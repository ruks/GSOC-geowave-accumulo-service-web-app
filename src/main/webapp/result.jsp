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

	<script src="d3.v3.min.js"></script>
	<script src="queue.v1.min.js"></script>
	<script src="topojson.v1.min.js"></script>
	<script src="script.js"></script>