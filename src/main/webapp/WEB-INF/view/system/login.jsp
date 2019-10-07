<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link rel="shortcut icon" href="${ctx}/static/images/favicon.png"/>
<link rel="stylesheet" media="screen" href="${ctx}/static/login/css/style.css">
<link rel="stylesheet" type="text/css" href="${ctx}/static/login/css/reset.css">

<script src="${ctx}/static/js/jquery-1.8.0.min.js"></script>
<body>

<div id="particles-js">
	<div class="login" style="display: block;">
		<div class="login-top">
			登录
		</div>
		<div class="login-center clearfix">
			<div class="login-center-img">
				<img src="${ctx}/static/login/images/name.png">
			</div>
			<div class="login-center-input">
				<input type="text" name="username" id="username" value="" placeholder="请输入用户名">
				<div class="login-center-input-text">用户名</div>
			</div>
		</div>
		<div class="login-center clearfix">
			<div class="login-center-img">
				<img src="${ctx}/static/login/images/password.png">
			</div>
			<div class="login-center-input">
				<input type="password" name="password" id="password" value="" placeholder="请输入密码">
				<div class="login-center-input-text">密码</div>
			</div>
		</div>
		<div class="login-center clearfix">
			<div class="login-center-img">
				<img src="${ctx}/static/login/images/cpacha.png">
			</div>
			<div class="login-center-input">
				<input style="width:50%;" type="text" name="cpacha" id="cpacha" value="" placeholder="请输入验证码">
				<div class="login-center-input-text">验证码</div>
				<img id="cpacha-img" title="点击切换验证码" style="cursor:pointer;" width="110px" height="30px"
					 src="/system/getCpacha?vl=4&w=150&h=40&type=loginCpacha" onclick="changeCpacha()">
			</div>
		</div>
		<div class="login-button" onclick="doLogin()">
			登录
		</div>
	</div>
	<div class="sk-rotating-plane"></div>
	<canvas class="particles-js-canvas-el" width="1147" height="952" style="width: 100%; height: 100%;"></canvas>
</div>

<script type="text/javascript">
	function hasClass(elem, cls) {
	  cls = cls || '';
	  if (cls.replace(/\s/g, '').length == 0) return false; //当cls没有参数时，返回false
	  return new RegExp(' ' + cls + ' ').test(' ' + elem.className + ' ');
	}
	 
	function addClass(ele, cls) {
	  if (!hasClass(ele, cls)) {
	    ele.className = ele.className == '' ? cls : ele.className + ' ' + cls;
	  }
	}
	 
	function removeClass(ele, cls) {
	  if (hasClass(ele, cls)) {
	    var newClass = ' ' + ele.className.replace(/[\t\r\n]/g, '') + ' ';
	    while (newClass.indexOf(' ' + cls + ' ') >= 0) {
	      newClass = newClass.replace(' ' + cls + ' ', ' ');
	    }
	    ele.className = newClass.replace(/^\s+|\s+$/g, '');
	  }
	}

	// “换一张”验证码
	function changeCpacha(){
		$("#cpacha-img").attr("src",'/system/getCpacha?vl=4&w=150&h=40&type=loginCpacha&t=' + new Date().getTime());
	}

	// 登录
	function doLogin(){
		var username = $.trim($("#username").val());
		var password = $.trim($("#password").val());
		var cpacha = $.trim($("#cpacha").val());
		if(username == '' || username == 'undefined'){
			alert("请填写用户名！");
			return;
		}
		if(password == '' || password == 'undefined'){
			alert("请填写密码！");
			return;
		}
		if(cpacha == '' || cpacha == 'undefined'){
			alert("请填写验证码！");
			return;
		}
		addClass(document.querySelector(".login"), "active")
		addClass(document.querySelector(".sk-rotating-plane"), "active")
		document.querySelector(".login").style.display = "none"
		$.ajax({
			url: '/system/doLogin',
			data: { username: username, password: password, cpacha: cpacha },
			type: 'post',
			dataType: 'json',
			success: function(res){
				if (res.flag){
					location.href = '/system/home';
				} else {
					removeClass(document.querySelector(".login"), "active");
					removeClass(document.querySelector(".sk-rotating-plane"), "active");
					document.querySelector(".login").style.display = "block";
					alert(res.msg);
					changeCpacha();
				}
			}
		});
	}

	$('#cpacha').keydown(function (event){
		if (event.keyCode == 13){
			doLogin();
		}
	});

</script>
</body>
</html>