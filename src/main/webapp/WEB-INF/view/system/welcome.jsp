<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<title>欢迎页面</title>
<link rel="shortcut icon" href="${ctx}/static/images/favicon.png"/>
</head>
<body>
<div title="欢迎使用" style="padding:20px;overflow:hidden; color:red; " >
	<p style="font-size: 50px; line-height: 60px; height: 60px;">${adminUser.username}</p>
	<p style="font-size: 25px; line-height: 30px; height: 30px;">欢迎使用SSM后台管理系统</p>
  	<p>开发人员：【Flouis】</p>
  	<p>开发周期：2019/10/02 --- 2019/10/07（共计6天）</p>
  	
  	<hr/>
  	<h2>系统环境</h2>
  	<p>系统环境：Windows7</p>
	<p>开发工具：IntelliJ IDEA</p>
	<p>Java版本：JDK 1.8</p>
	<p>服务器：tomcat 7</p>
	<p>数据库：MySQL 5.7.19</p>
	<p>系统采用技术：Spring+SpringMVC+Mybatis+EasyUI+JQuery+Ajax+面向接口编程</p>
</div>
</body>
</html>