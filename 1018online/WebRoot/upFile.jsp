<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>文件上传</title>
<script type="text/javascript">
(function(window) {
	var file  = document.querySelector("input[type='file']").files[0];
	var reader = new FileReader();
	reader.onloadend = function () {
	 console.log(reader.result);
	}
	if (file) {
	 reader.readAsDataURL(file);
	}
	var submit=document.querySelector("input[type='submit']").files[0];
	function method1(){
		alert(reader.result);
	}
});



</script>
</head>
<body>
 文件：<input type="file"><br>
      <input type="submit" value="提交">
 
</body>
</html>