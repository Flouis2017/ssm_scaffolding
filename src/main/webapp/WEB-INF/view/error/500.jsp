<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Server Error</title>
<link href="${ctx}/static/h-ui/css/H-ui.min.css" rel="stylesheet" type="text/css"/>
<link href="${ctx}/static/h-ui/lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css"/>
</head>
<body>
	<div class="page-500 text-c">
		<p class="error-title"><i class="Hui-iconfont">&#xe688;</i>500</p>
		<p class="error-description">不好意思，服务器开小差啦~</p>
	</div>
</body>
</html>