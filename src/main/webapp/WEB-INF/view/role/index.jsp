<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../common/header.jsp"%>
<div class="easyui-layout" data-options="fit:true">
    <!-- Begin of toolbar -->
    <div id="wu-toolbar">
        <div class="wu-toolbar-button">
        	<%@include file="../common/menus.jsp"%>
        </div>
        <div class="wu-toolbar-search">
            <label>角色名称:</label>
            <input id="search-name" class="wu-text" style="width:100px">
            <a href="#" id="search-btn" class="easyui-linkbutton" iconCls="icon-search">
                搜索
            </a>
        </div>
    </div>
    <!-- End of toolbar -->
    <table id="data-datagrid" class="easyui-datagrid" toolbar="#wu-toolbar"></table>
</div>
<style>
.selected{
	background:red;
}
</style>
<!-- Begin of easyui-dialog -->
<div id="add-dialog" class="easyui-dialog" data-options="closed:true,iconCls:'icon-save'" style="width:450px; padding:10px;">
	<form id="add-form" method="post">
        <table>
            <tr>
                <td width="60" align="right">角色名称:</td>
                <td>
                    <input type="text" name="name" class="wu-text easyui-validatebox" data-options="required:true"/>
                </td>
            </tr>
            <tr>
                <td align="right">角色备注:</td>
                <td>
                    <textarea name="remark" rows="6" class="wu-textarea" style="width:260px"></textarea>
                </td>
            </tr>
        </table>
    </form>
</div>
<!-- 修改窗口 -->
<div id="edit-dialog" class="easyui-dialog" data-options="closed:true,iconCls:'icon-save'" style="width:450px; padding:10px;">
	<form id="edit-form" method="post">
        <input type="hidden" name="id" id="edit-id">
        <table>
            <tr>
                <td width="60" align="right">角色名称:</td>
                <td>
                    <input type="text" id="edit-name" name="name" class="wu-text easyui-validatebox" data-options="required:true" />
                </td>
            </tr>
            <tr>
                <td align="right">角色备注:</td>
                <td>
                    <textarea id="edit-remark" name="remark" rows="6" class="wu-textarea" style="width:260px"></textarea>
                </td>
            </tr>
        </table>
    </form>
</div>
<!-- 选择权限弹窗 -->
<div id="select-authority-dialog" class="easyui-dialog" data-options="closed:true,iconCls:'icon-save'" style="width:220px; height:450px; padding:10px;">
     <ul id="authority-tree" url="/menu/getAll" checkbox="true"></ul>
</div>

<%@include file="../common/footer.jsp"%>

<!-- End of easyui-dialog -->
<script type="text/javascript">
	/**
	 * @description 添加记录
	 */
	function add(){
		var validate = $("#add-form").form("validate");
		if(!validate){
			$.messager.alert("消息提醒","请检查你输入的数据!","warning");
			return;
		}
		var data = $("#add-form").serialize();
		$.ajax({
			url: '/role/save',
			dataType: 'json',
			type: 'post',
			data: data,
			success:function(res){
				if(res.flag){
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
     * @description 编辑角色
     */
	function edit(){
		var validate = $("#edit-form").form("validate");
		if(!validate){
			$.messager.alert("消息提醒","请检查你输入的数据!","warning");
			return;
		}
		var data = $("#edit-form").serialize();
		$.ajax({
			url: '/role/save',
			dataType: 'json',
			type: 'post',
			data: data,
			success:function(res){
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
	 * @description 删除角色
	 */
	function remove(){
		var item = $('#data-datagrid').datagrid('getSelected');
		if (item == null || item == undefined){
			$.messager.alert('信息提示', "请选择删除的角色！", 'error');
			return;
		}
		$.messager.confirm('信息提示','确定删除该角色吗？', function(result){
			if (result){
				$.ajax({
					url: '/role/delete',
					dataType: 'json',
					type: 'post',
					data: { id: item.id },
					success: function(res){
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
		//$('#add-form').form('clear');
		$('#add-dialog').dialog({
			closed: false,
			modal: true,
            title: "添加角色信息",
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
            }]
        });
	}
	
	/**
	 * @description 打开修改窗口
	 */
	function openEdit(){
		//$('#edit-form').form('clear');
		var item = $('#data-datagrid').datagrid('getSelected');
		if(item == null || item.length == 0){
			$.messager.alert('信息提示','请选择需要编辑的角色！','info');
			return;
		}
		
		$('#edit-dialog').dialog({
			closed: false,
			modal: true,
            title: "修改信息",
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
            	$("#edit-name").val(item.name);
            	$("#edit-remark").val(item.remark);
            }
        });
	}

    var roleAuthorities = null;
	/**
     * @description 某个角色已经拥有的权限
     */
	function isAdded(row, rows){
		for(var k=0; k<roleAuthorities.length; k++){
			if (roleAuthorities[k].menuId == row.id && haveParent(rows, row.parentId)){
				return true;
			}
		}
		return false;
	}
	
	/**
     * @description 判断是否有父分类
     */
	function haveParent(rows,parentId){
		for(var i=0; i<rows.length; i++){
			if (rows[i].id == parentId){
				if(rows[i].parentId != 0) return true;
			}
		}
		return false;
	}
	
	/**
     * @description 判断是否有父类
     */
	function exists(rows, parentId){
		for(var i=0; i<rows.length; i++){
			if (rows[i].id == parentId) return true;
		}
		return false;
	}
	
	/**
     * @description 转换原始数据至符合tree的要求
     */
	function convert(rows){
		var nodes = [];
		// get the top level nodes
		//首先获取所有的父分类
		for(var i=0; i<rows.length; i++){
			var row = rows[i];
			if (!exists(rows, row.parentId)){
				nodes.push({
					id:row.id,
					text:row.name
				});
			}
		}
		
		var toDo = [];
		for(var i=0; i<nodes.length; i++){
			toDo.push(nodes[i]);
		}
		while(toDo.length){
			var node = toDo.shift();	// the parent node
			// get the children nodes
			for(var i=0; i<rows.length; i++){
				var row = rows[i];
				if (row.parentId == node.id){
					var child = {id:row.id,text:row.name};
					if (isAdded(row, rows)){
						child.checked = true;
					}
					if (node.children){
						node.children.push(child);
					} else {
						node.children = [child];
					}
					//把刚才创建的孩子再添加到父分类的数组中
					toDo.push(child);
				}
			}
		}
		return nodes;
	}
	
	/**
     * @description 打开权限选择框
     */
	function openAuthority(){
		var item = $('#data-datagrid').datagrid('getSelected');
		if(item == null || item.length == 0){
			$.messager.alert('信息提示','请选择角色！','info');
			return;
		}
		selectAuthority(item.id);
	}
	function selectAuthority(roleId){
		$('#select-authority-dialog').dialog({
			closed: false,
			modal: true,
            title: "权限设置",
            buttons: [{
                text: '确定',
                iconCls: 'icon-ok',
                handler: function(){
                	var checkedNodes = $("#authority-tree").tree('getChecked');
                	var ids = '';
                	for(var i=0;i<checkedNodes.length;i++){
                		ids += checkedNodes[i].id + ',';
                	}
                	var checkedParentNodes = $("#authority-tree").tree('getChecked', 'indeterminate');
                	for(var i=0;i<checkedParentNodes.length;i++){
                		ids += checkedParentNodes[i].id + ',';
                	}
                	if(ids != ''){
                		$.ajax({
                			url: '/role/saveAuthority',
                			type: "post",
                			data: { ids: ids, roleId: roleId },
                			dataType: 'json',
                			success: function(res){
                				if (res.flag){
                					$.messager.alert('信息提示', res.msg, 'info');
                					$('#select-authority-dialog').dialog('close');
                				} else {
                					$.messager.alert('信息提示', res.msg, 'warning');
                				}
                			}
                		});
                	} else {
                		$.messager.alert('信息提示', '请至少选择一条权限！', 'info');
                	}
                }
            }, {
                text: '取消',
                iconCls: 'icon-cancel',
                handler: function () {
                    $('#select-authority-dialog').dialog('close');                    
                }
            }],
            onBeforeOpen:function(){
        		// 首先获取该角色已经拥有的权限
        		$.ajax({
        			url: '/role/getRoleAuthorityList',
        			data: { roleId: roleId },
        			type: 'post',
        			dataType: 'json',
        			success: function(res){
        				// console.log(res);
        				roleAuthorities = res.data;
        				$("#authority-tree").tree({
                    		loadFilter: function(roleAuthorities){
                    			return convert(roleAuthorities);
                    		}
                    	});
        			}
        		});
            }
        });
	}

	/**
	 * @description 搜索
	 */
	$("#search-btn").click(function(){
		$('#data-datagrid').datagrid('load', {
			name: $.trim($("#search-name").val())
		});
	});
	
	/** 
     * @description 数据表初始化
     */
	$('#data-datagrid').datagrid({
		url: '/role/list',
		rownumbers: true,
		singleSelect: true,
		pageSize: 10,
		pagination: true,
		multiSort: true,
		fitColumns: true,
		idField: 'id',
	    treeField: 'name',
		fit: true,
		columns: [[
			// {
			//     field:'chk',
            //     checkbox:true
            // },
			{
			    field:'name',
                title:'角色名称',
                width:50,
				align: 'center',
                sortable:true
            },
			{
			    field:'remark',
                title:'角色备注',
                width:100,
				align: 'center',
                sortable:true
            }
		]],
		onLoadSuccess: function(){}
	});
</script>