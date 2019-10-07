<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Page Missing</title>
<link href="${ctx}/static/h-ui/css/H-ui.min.css" rel="stylesheet" type="text/css"/>
<link href="${ctx}/static/h-ui/lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css"/>
</head>
<body>
	<div class="page-404 text-c">
		<p class="error-title"><i class="Hui-iconfont">&#xe688;</i>404</p>
		<p class="error-description">不好意思，您访问的页面不存在~</p>
	</div>
</body>
</html>