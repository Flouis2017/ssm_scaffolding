<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="copyright" content="All Rights Reserved, Copyright (C) 2017, Flouis, Ltd." />
<title>后台管理</title>
<link rel="shortcut icon" href="${ctx}/static/images/favicon.png"/>
<link rel="stylesheet" type="text/css" href="${ctx}/static/easyui/1.3.4/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/static/css/wu.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/static/css/icon.css" />

<script type="text/javascript" src="${ctx}/static/js/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="${ctx}/static/easyui/1.3.4/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${ctx}/static/easyui/1.3.4/locale/easyui-lang-zh_CN.js"></script>
<script>
    var pc; 
    //不要放在$(function(){});中
    $.parser.onComplete = function () {
        if (pc) clearTimeout(pc);
        pc = setTimeout(closes, 1000);
    };

    function closes() {
    	$('#loading').fadeOut('normal', function () {
            $(this).remove();
        });
    }
</script>
</head>
<body class="easyui-layout">
<div id="loading" style="position:absolute;z-index:1000;top:0px;left:0px;width:100%;height:100%;background:#FFFFFF;text-align :center;padding-top:6%;">
     <img src="${ctx}/static/images/loading.jpg" width="30%">
</div> 
<!-- begin of header -->
<div class="wu-header" data-options="region:'north',border:false,split:true">
	<div class="wu-header-left">
		<h1>SSM后台管理系统</h1>
	</div>
	<img src="/picture/show?filename=${adminUser.avatar}" style="width:35px;height:35px;cursor:pointer;float:right;margin-top:10px;margin-right:178px;"/>
	<div class="wu-header-right">
		<p>
			<strong class="easyui-tooltip">
				${role.name}：${adminUser.username}
			</strong>，欢迎您！
		</p>
		<p>
			<a style="cursor: pointer;" onclick="goHome()">主页</a>|
			<a style="cursor: pointer;" onclick="modifyPwd()">修改密码</a>|
			<a href="/system/logout">安全退出</a>
		</p>
	</div>
</div>

<script type="text/javascript">
	function goHome() {
		location.href = "/system/home";
	}
</script>
<!-- end of header -->

<!-- begin of sidebar -->
<div class="wu-sidebar" data-options="region:'west',split:true,border:true,title:'导航'">
	<div class="easyui-accordion" data-options="border:false,fit:true">
		<c:forEach items="${topMenuList}" var="topMenu">
		<div title="${topMenu.name }" data-options="iconCls:'${topMenu.icon}'" style="padding:5px;">
			<ul class="easyui-tree wu-side-tree">
				<c:forEach items="${secondMenuList}" var="secondMenu">
					<c:if test="${secondMenu.parentId == topMenu.id}">
						<li iconCls="${secondMenu.icon}">
							<a href="javascript:void(0)" data-icon="${secondMenu.icon}"
								data-link="${secondMenu.url}?_secondMenuId=${secondMenu.id}" iframe="1">${secondMenu.name}
							</a>
						</li>
					</c:if>
				</c:forEach>
			</ul>
		</div>
		</c:forEach>
	</div>
</div>
<!-- end of sidebar -->

<!-- begin of main -->
<div class="wu-main" data-options="region:'center'">
	<div id="wu-tabs" class="easyui-tabs" data-options="border:false,fit:true">
		<div title="首页" data-options="href:'welcome',closable:false,iconCls:'icon-tip',cls:'pd3'"></div>
	</div>
</div>
<!-- end of main -->

<!-- begin of footer -->
<div class="wu-footer" data-options="region:'south',border:true,split:true">
	&copy; 2019 Flouis All Rights Reserved
</div>
<!-- end of footer -->

<script type="text/javascript">
	$(function(){
		$('.wu-side-tree a').bind("click",function(){
			var title = $(this).text();
			var url = $(this).attr('data-link');
			var iconCls = $(this).attr('data-icon');
			var iframe = $(this).attr('iframe') == 1 ? true : false;
			addTab(title, url, iconCls, iframe);
		});
	});

	// 修改密码
	function modifyPwd() {
		addTab("修改密码", "/system/modifyPwd", "icon-lock-edit", 1);
	}

	/**
	* Name 添加菜单选项
	* Param title 名称
	* Param href 链接
	* Param iconCls 图标样式
	* Param iframe 链接跳转方式（true为iframe，false为href）
	*/
	function addTab(title, href, iconCls, iframe){
		var tabPanel = $('#wu-tabs');
		if(!tabPanel.tabs('exists',title)){
			var content = '<iframe scrolling="auto" frameborder="0"  src="'+ href +'" style="width:100%;height:100%;"></iframe>';
			if(iframe){
				tabPanel.tabs('add',{
					title:title,
					content:content,
					iconCls:iconCls,
					fit:true,
					cls:'pd3',
					closable:true
				});
			} else {
				tabPanel.tabs('add',{
					title:title,
					href:href,
					iconCls:iconCls,
					fit:true,
					cls:'pd3',
					closable:true
				});
			}
		} else {
			tabPanel.tabs('select',title);
		}
	}

	/**
	* Name 移除菜单选项
	*/
	function removeTab(){
		var tabPanel = $('#wu-tabs');
		var tab = tabPanel.tabs('getSelected');
		if (tab){
			var index = tabPanel.tabs('getTabIndex', tab);
			tabPanel.tabs('close', index);
		}
	}
</script>
</body>
</html>