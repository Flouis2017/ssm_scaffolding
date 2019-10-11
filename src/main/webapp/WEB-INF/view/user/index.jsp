<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../common/header.jsp"%>
<div class="easyui-layout" data-options="fit:true">
    <!-- Begin of toolbar -->
    <div id="wu-toolbar">
        <div class="wu-toolbar-button">
            <%@include file="../common/menus.jsp"%>
        </div>
        <div class="wu-toolbar-search">
            <label>用户名:</label>
			<input id="search-username" class="wu-text" style="width:100px">&nbsp;&nbsp;
            <label>所属角色:</label>
            <select id="search-role" class="easyui-combobox" data-options="editable:false" panelHeight="auto" style="width:120px">
            	<option value="">全部</option>
            	<c:forEach items="${roleList}" var="role">
            		<option value="${role.id}">${role.name}</option>
            	</c:forEach>
            </select>&nbsp;&nbsp;
            <label>性别:</label>
            <select id="search-sex" class="easyui-combobox" data-options="editable:false" panelHeight="auto" style="width:120px">
            	<option value="">全部</option>
            	<option value="1">男</option>
            	<option value="2">女</option>
            </select>&nbsp;&nbsp;
            <a href="#" id="search-btn" class="easyui-linkbutton" iconCls="icon-search">搜索</a>
        </div>
    </div>
    <!-- End of toolbar -->
    <table id="data-datagrid" class="easyui-datagrid" toolbar="#wu-toolbar"></table>
</div>

<!-- 添加弹窗 -->
<div id="add-dialog" class="easyui-dialog" data-options="closed:true,iconCls:'icon-save'" style="width:420px; padding:10px;">
	<form id="add-form" method="post">
        <table>
            <tr>
                <td width="60" align="right">头像预览:</td>
                <td valign="middle">
                	<img id="preview-avatar" style="float:left;" src="${ctx}/static/upload/avatar/default_avatar.png" width="100px">
                	<a style="float:left;margin-top:40px;" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-upload" onclick="uploadAvatar()" plain="true">上传</a>
                </td>
            </tr>
            <tr>
                <td width="60" align="right">头像:</td>
                <td><input type="text" id="add-avatar" name="avatar" value="default_avatar.png" readonly="readonly" class="wu-text " /></td>
            </tr>
            <tr>
                <td width="60" align="right">用户名:</td>
                <td><input type="text" name="username" class="wu-text easyui-validatebox" data-options="required:true" /></td>
            </tr>
            <tr>
                <td width="60" align="right">密码:</td>
                <td><input type="password" name="password" class="wu-text easyui-validatebox" data-options="required:true" /></td>
            </tr>
            <tr>
                <td width="60" align="right">所属角色:</td>
                <td>
                	<select name="roleId" class="easyui-combobox" panelHeight="auto" style="width:268px" data-options="required:true,editable:false">
		                <c:forEach items="${roleList}" var="role">
		                	<option value="${role.id}">${role.name}</option>
		                </c:forEach>
		            </select>
                </td>
            </tr>
            <tr>
                <td width="60" align="right">性别:</td>
                <td>
                	<select name="gender" class="easyui-combobox" panelHeight="auto" style="width:268px">
            			<option value="1">男</option>
            			<option value="2">女</option>
		            </select>
                </td>
            </tr>
            <tr>
                <td width="60" align="right">年龄:</td>
                <td><input type="text" name="age" class="wu-text easyui-numberbox easyui-validatebox" data-options="required:false,min:18,precision:0"/></td>
            </tr>
            <tr>
                <td width="60" align="right">电子邮箱:</td>
                <td><input type="text" name="email" class="wu-text easyui-validatebox" data-options="required:false,validType:'email'"/></td>
            </tr>
        </table>
    </form>
</div>

<!-- 编辑弹窗 -->
<div id="edit-dialog" class="easyui-dialog" data-options="closed:true,iconCls:'icon-save'" style="width:450px; padding:10px;">
	<form id="edit-form" method="post">
        <input type="hidden" name="id" id="edit-id">
        <table>
            <tr>
                <td width="60" align="right">头像预览:</td>
                <td valign="middle">
                	<img id="edit-preview-avatar" style="float:left;" src="${ctx}/static/upload/avatar/default_avatar.png" width="100px">
                	<a style="float:left;margin-top:40px;" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-upload" onclick="uploadAvatar()" plain="true">上传</a>
                </td>
            </tr>
            <tr>
                <td width="60" align="right">头像:</td>
                <td><input type="text" id="edit-avatar" name="avatar" value="${ctx}/static/upload/avatar/default_avatar.png" readonly="readonly" class="wu-text " /></td>
            </tr>
            <tr>
                <td width="60" align="right">用户名:</td>
                <td><input type="text" id="edit-username" name="username" class="wu-text easyui-validatebox" data-options="required:true" /></td>
            </tr>
            <tr>
                <td width="60" align="right">所属角色:</td>
                <td>
                	<select id="edit-roleId" name="roleId" class="easyui-combobox" panelHeight="auto" style="width:268px" data-options="required:true">
		                <c:forEach items="${roleList}" var="role">
		                <option value="${role.id}">${role.name}</option>
		                </c:forEach>
		            </select>
                </td>
            </tr>
            <tr>
                <td width="60" align="right">性别:</td>
                <td>
                	<select id="edit-sex" name="gender" class="easyui-combobox" panelHeight="auto" style="width:268px">
            			<option value="1">男</option>
            			<option value="2">女</option>
		            </select>
                </td>
            </tr>
            <tr>
                <td width="60" align="right">年龄:</td>
                <td><input type="text" id="edit-age" name="age" value="1" class="wu-text easyui-numberbox easyui-validatebox" data-options="required:false,min:18,precision:0" /></td>
            </tr>
            <tr>
                <td width="60" align="right">电子邮箱:</td>
                <td><input type="text" id="edit-email" name="email" class="wu-text easyui-validatebox" data-options="required:false,validType:'email'"/></td>
            </tr>
        </table>
    </form>
</div>

<div id="process-dialog" class="easyui-dialog" data-options="closed:true,iconCls:'icon-upload',title:'正在上传图片'" style="width:450px; padding:10px;">
	<div id="p" class="easyui-progressbar" style="width:400px;" data-options="text:'正在上传中...'"></div>
</div>

<input type="file" id="avatar-file" style="display:none;" onchange="upload()">
<%@ include file="../common/footer.jsp"%>

<!-- End of easyui-dialog -->
<script type="text/javascript">
	var avatarDir = "${ctx}/static/upload/avatar/";

	//上传图片
	function start(){
		var value = $('#p').progressbar('getValue');
		if (value < 100){
			value += Math.floor(Math.random() * 10);
			$('#p').progressbar('setValue', value);
		}else{
			$('#p').progressbar('setValue',0)
		}
	}
	function upload(){
		if($("#avatar-file").val() == '')return;
		var formData = new FormData();
		formData.append('avatar', document.getElementById('avatar-file').files[0]);
		$("#process-dialog").dialog('open');
		var interval = setInterval(start, 200);
		$.ajax({
			url: '/user/uploadAvatar',
			type: 'post',
			data: formData,
			contentType: false,
			processData: false,
			success: function(res){
				clearInterval(interval);
				$("#process-dialog").dialog('close');
				if (res.flag){
					$("#preview-avatar").attr('src', avatarDir + res.data);
					$("#add-avatar").val(res.data);
					$("#edit-preview-avatar").attr('src', avatarDir + res.data);
					$("#edit-avatar").val(res.data);
				} else {
					$.messager.alert("消息提醒", res.msg, "warning");
				}
			},
			error: function(){
				clearInterval(interval);
				$("#process-dialog").dialog('close');
				$.messager.alert("消息提醒", "网络出错，请稍后重试！", "warning");
			}
		});
	}
	
	function uploadAvatar(){
		$("#avatar-file").click();
	}

	/**
	 * @description 添加记录
	 */
	function add(){
		var validate = $("#add-form").form("validate");
		if(!validate){
			$.messager.alert("消息提醒", "请检查你输入的数据!", "warning");
			return;
		}
		var data = $("#add-form").serialize();
		$.ajax({
			url: '/user/save',
			dataType: 'json',
			type: 'post',
			data: data,
			success: function(res){
				if (res.flag){
					$.messager.alert('信息提示', res.msg, 'info');
					$('#add-dialog').dialog('close');
					$('#data-datagrid').datagrid('reload');
				} else {
					$.messager.alert('信息提示', res.msg, 'warning');
				}
			}
		});
	}
	
	/**
	 * @description 修改记录
	 */
	function edit(){
		var validate = $("#edit-form").form("validate");
		if(!validate){
			$.messager.alert("消息提醒", "请检查你输入的数据!", "warning");
			return;
		}
		var data = $("#edit-form").serialize();
		$.ajax({
			url: '/user/save',
			dataType: 'json',
			type: 'post',
			data: data,
			success: function(res){
				if (res.flag){
					$.messager.alert('信息提示', res.msg, 'info');
					$('#edit-dialog').dialog('close');
					$('#data-datagrid').datagrid('reload');
				} else {
					$.messager.alert('信息提示', res.msg, 'warning');
				}
			}
		});
	}
	
	/**
	 * @description 删除记录
	 */
	function remove(){
		var items = $('#data-datagrid').datagrid('getSelections');
		if (items == null || items.length == 0 || items.length > 1){
			$.messager.alert('信息提示', '请选择一条记录进行删除！', 'error');
			return;
		}
		$.messager.confirm('信息提示', '确定要删除该记录？', function(result){
			if (result){
				$.ajax({
					url: '/user/delete',
					dataType: 'json',
					type: 'post',
					data: { id: items[0].id },
					success:function(res){
						if (res.flag){
							$.messager.alert('信息提示', res.msg, 'info');
							$('#data-datagrid').datagrid('reload');
						} else {
							$.messager.alert('信息提示', res.msg, 'warning');
						}
					}
				});
			}	
		});
	}
	
	/**
	 * @description 打开添加窗口
	 */
	function openAdd(){
		$('#add-form').form('clear');
		$('#add-dialog').dialog({
			closed: false,
			modal: true,
            title: "添加用户",
            buttons: [{
                text: '确定',
                iconCls: 'icon-ok',
                handler: add
            }, {
                text: '取消',
                iconCls: 'icon-cancel',
                handler: function () {
                    $('#add-dialog').dialog('close');                    
                }
            }],
            onBeforeOpen:function(){}
        });
	}
	
	/**
	 * @description 打开修改窗口
	 */
	function openEdit(){
		$('#edit-form').form('clear');
		var items = $('#data-datagrid').datagrid('getSelections');
		if (items == null || items.length == 0 || items.length > 1){
			$.messager.alert('信息提示', '请选择一条记录进行编辑！', 'info');
			return;
		}
		var item = items[0];
		$('#edit-dialog').dialog({
			closed: false,
			modal: true,
            title: "编辑用户",
            buttons: [{
                text: '确定',
                iconCls: 'icon-ok',
                handler: edit
            }, {
                text: '取消',
                iconCls: 'icon-cancel',
                handler: function () {
                    $('#edit-dialog').dialog('close');                    
                }
            }],
            onBeforeOpen:function(){
            	$("#edit-id").val(item.id);
            	$("#edit-preview-avatar").attr('src', avatarDir + item.avatar);
				$("#edit-avatar").val(item.avatar);
            	$("#edit-username").val(item.username);
            	$("#edit-roleId").combobox('setValue', item.roleId);
            	$("#edit-sex").combobox('setValue', item.gender);
            	$("#edit-age").val(item.age);
            	$("#edit-email").val(item.email);
            }
        });
	}
	
	
	/**
	 * @description 搜索事件
	 */
	$("#search-btn").click(function(){
		$('#data-datagrid').datagrid('load', {
			roleId: $("#search-role").combobox('getValue'),
			gender: $("#search-sex").combobox('getValue'),
			username: $.trim($("#search-username").val())
		});
	});
	
	/** 
	 * @description 载入数据
	 */
	$('#data-datagrid').datagrid({
		url: '/user/list',
		// singleSelect: true,
		// checkOnSelect: false,
		pageSize: 10,
		pagination: true,
		multiSort: false,
		fitColumns: true,
		idField: 'id',
	    treeField: 'name',
		fit: true,
		columns: [[
			{field:'chk',checkbox:true},
			{field:'id',title:'Id',width:20,align:'center',sortable:true},
			{field:'avatar',title:'用户头像',width:100,align:'center',formatter:function(value){
				return '<img style="margin-top:2px" src="${ctx}/static/upload/avatar/' + value + '" width="30px" />';
			}},
			{field:'username',title:'用户名',width:100,align:'center'},
			// {field:'password',title:'密码',width:100,hidden:true},
			{field:'roleId',title:'所属角色',width:50,align:'center',formatter:function(value){
				var roleList = $("#search-role").combobox('getData');
				for (var i=0; i<roleList.length; i++){
					if (value == roleList[i].value) return roleList[i].text;
				}
				return value;
			}},
			{field:'gender',title:'性别',width:40,align:'center',formatter:function(value){
				return value == 1 ? "男" : "女";
			}},
			{field:'age',title:'年龄',align:'center',width:20,sortable:true},
			{field:'email',title:'电子邮箱',align:'center',width:200}
		]],
		onLoadSuccess: function(data){
			if (data.total == 0) {
				var body = $(this).data().datagrid.dc.body2;
				$('.datagrid-view2 .datagrid-body').find('table tbody').append('<tr><td width="' + body.width() + '" style="height: 35px; text-align: center;">暂无数据</td></tr>');
			}
		}
	});
</script>