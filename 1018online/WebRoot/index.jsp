<%--suppress ALL --%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html style="height: 374px; ">
<head>
<base href="<%=basePath%>">

<title>My JSP 'index.jsp' starting page</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
     <meta http-equiv="x-pjax-version" content="v173">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="this is my page">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta http-equiv="-+escription" content="This is my page">
<style type="text/css">
body {
	text-align: center;
	background-color:purple;
}

#content {
	color: white;
	background-color: black;
	text-align: left;
	border: 1px solid black;
	height: 250px;
}

#box {
	background-color: black;
	border: 1px solid black;
	height: 300px;
}

#titile {
	color: white;
	text-align: center;
	background-color:  rgb(22,179,248);
	font-size: 36px;
	font-family: Microsoft YaHei;
	height: 50px;
}

#titile, #box, #content {
	width: 640px;
	margin: 0 auto;
}

button {
	color: white;
	background-color: #13A89E;
	border: 0px;
}
</style>

<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	
	<script type="text/javascript" src="scripts/web_socket.js"></script>
   <script type="text/javascript" src="scripts/jquery.WebSocket.js"></script>
    <script type="text/javascript" src="scripts/jquery.js"></script>
    -->


</head>

<body>

	<div id="body">
		<div id="titile">欢迎来到青年直播</div>
		<div id="box">
			<canvas id="canvas" width="640" height="480"></canvas>
		</div>
		
		<div id="content"></div>
	</div>
	<input type="file">
	<button onclick="sendMsg1();">点击发送</button><br>
	<input type="text" id="msg" />
	<button onclick="sendMsg();">点击发送</button>
	<br>
	

	<script type="text/javascript">
          //H5 浏览器都支持WebSocket对象的创建  ws协议的服务地址 websocket
		  var isPlay = false;
          var client =new WebSocket("ws://"+window.location.host+"/server");
          client.binaryType = 'arraybuffer';
          client.onopen = function() {
              console.log("连接webSocket服务器成功!");
          };
          client.onclose=function(){
          console.log("跟服务器断开连接!");
          };
          // 缓冲
          client.onmessage = function(result) {
              if (typeof(result.data) == "string") {
                  if (!(result.data).startsWith("data")) {
                      document.getElementById("content").innerHTML += "<div>" + result.data + "</div>";
                  } else {
                      document.getElementById("pic").src = result.data;
                  }
              } else {
                  renderFrame(new Uint8ClampedArray(result.data));
              }
          };

          function stop() {

          }

          function renderFrame(data) {
              var canvas = document.getElementById("canvas"),
                      url = bytes2DataURL(data),
                      img = new Image();
              img.onload = function() {
                  var ctx = canvas.getContext("2d");
                  ctx.drawImage(img, 0, 0, canvas.width, canvas.height);
                  img = null;
              };
              img.src = url;
          }

          function bytes2DataURL(u8arr) {
              var i = 0, n = u8arr.length, str = '';
              while (i < n) {
                  str += String.fromCharCode(u8arr[i++]);
              }
              return 'data:image/jpeg;base64,' + btoa(str);
          }
		function sendMsg(){
         // alert(document.getElementById("msg").value);
           client.send(document.getElementById("msg").value);
           document.getElementById("msg").value='';
           console.log(navigator.appName);
           console.log(navigator.systemLanguage);
          };
          function sendMsg1() {
         	 var file  = document.querySelector('input[type=file]').files[0];
         	 var reader = new FileReader();
         	 reader.onload = function () {
         	 console.log(reader.result);
         	 client.send(dataURLtoBytes(reader.result));
         	 }
              if(file){
                  reader.readAsDataURL(file);
              }

          }
          function dataURLtoBytes(dataUrl) {
              var arr = dataUrl.split(','),
                  data = atob(arr[1]),
                  n = data.length,
                  u8arr = new Uint8Array(n);
              while (n--) {
                  u8arr[n] = data.charCodeAt(n);
              }
              return u8arr;
          }
   </script>
</body>
</html>
