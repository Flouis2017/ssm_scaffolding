<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../common/header.jsp"%>
<div class="easyui-layout" data-options="fit:true">
    <!-- Begin of toolbar -->
    <div id="wu-toolbar">
        <div class="wu-toolbar-button">
           <%@include file="../common/menus.jsp"%>
        </div>
        <%--<div class="wu-toolbar-search">
            <label>菜单名称：</label>
			<input id="search-name" class="wu-text" style="width:100px">
            <a href="#" id="search-btn" class="easyui-linkbutton" iconCls="icon-search">
				搜索
			</a>
        </div>--%>
    </div>
    <!-- End of toolbar -->
    <table id="data-datagrid" class="easyui-treegrid" toolbar="#wu-toolbar"></table>
</div>

<style>
.selected{
	background:red;
}
</style>

<!-- 新增窗口 -->
<div id="add-dialog" class="easyui-dialog" data-options="closed:true,iconCls:'icon-save'" style="width:450px; padding:10px;">
	<form id="add-form" method="post">
        <table>
            <tr>
                <td width="60" align="right">菜单名称:</td>
                <td>
					<input type="text" name="name" class="wu-text easyui-validatebox" data-options="required:true"/>
				</td>
            </tr>
            <tr>
                <td align="right">上级菜单:</td>
                <td>
                	<select name="parentId" class="easyui-combobox" data-options="editable:false" panelHeight="auto" style="width:268px">
		                <option value="0">顶级菜单</option>
		                <c:forEach items="${topMenuList}" var="menu">
		                	<option value="${menu.id}">${menu.name}</option>
		                </c:forEach>
		            </select>
                </td>
            </tr>
            <tr>
                <td align="right">路径:</td>
                <td><input type="text" name="url" class="wu-text" /></td>
            </tr>
            <tr>
                <td align="right">菜单图标:</td>
                <td>
                	<input type="text" id="add-icon" name="icon"
						class="wu-text easyui-validatebox" data-options="required:true" />
                	<a href="#" class="easyui-linkbutton" iconCls="icon-add"
						onclick="selectIcon()" plain="true">选择</a>
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
                <td width="60" align="right">菜单名称:</td>
                <td>
					<input type="text" id="edit-name" name="name" class="wu-text easyui-validatebox" data-options="required:true"/>
				</td>
            </tr>
            <tr>
                <td align="right">上级菜单:</td>
                <td>
                	<select id="edit-parentId" name="parentId" class="easyui-combobox" data-options="editable:false" panelHeight="auto" style="width:268px">
		               	<option value="0">顶级菜单</option>
		                <c:forEach items="${topMenuList}" var="menu">
		                	<option value="${menu.id}">${menu.name}</option>
		                </c:forEach>
		            </select>
                </td>
            </tr>
            <tr>
                <td align="right">路径:</td>
                <td><input type="text" id="edit-url" name="url" class="wu-text" /></td>
            </tr>
            <tr>
                <td align="right">菜单图标:</td>
                <td>
                	<input type="text" id="edit-icon" name="icon" class="wu-text easyui-validatebox"
						data-options="required:true" />
                	<a href="#" class="easyui-linkbutton" iconCls="icon-add" onclick="selectIcon()" plain="true">选择</a>
                </td>
            </tr>
        </table>
    </form>
</div>

<!-- 添加按钮弹窗 -->
<div id="add-menu-dialog" class="easyui-dialog" data-options="closed:true,iconCls:'icon-save'" style="width:450px; padding:10px;">
	<form id="add-menu-form" method="post">
        <table>
            <tr>
                <td width="60" align="right">按钮名称:</td>
                <td><input type="text" name="name" class="wu-text easyui-validatebox" data-options="required:true, missingMessage:'请填写菜单名称'" /></td>
            </tr>
            <tr>
                <td align="right">上级菜单:</td>
                <td>
                	<input type="hidden" name="parentId" id="add-menu-parent-id">
                	<input type="text" readonly="readonly" id="parent-menu" class="wu-text easyui-validatebox" />
                </td>
            </tr>
            <tr>
                <td align="right">按钮事件:</td>
                <td><input type="text" name="url" class="wu-text" /></td>
            </tr>
            <tr>
                <td align="right">按钮图标:</td>
                <td>
                	<input type="text" id="add-menu-icon" name="icon" class="wu-text easyui-validatebox"
						data-options="required:true, missingMessage:'请填写菜单图标'" />
                	<a href="#" class="easyui-linkbutton" iconCls="icon-add" onclick="selectIcon()" plain="true">选择</a>
                </td>
            </tr>
        </table>
    </form>
</div>
<!-- 选择图标弹窗 -->
<div id="select-icon-dialog" class="easyui-dialog" data-options="closed:true,iconCls:'icon-save'" style="width:870px;height:450px;padding:5px;">
     <table id="icons-table" cellspacing="8"></table>
</div>
<%@include file="../common/footer.jsp"%>
<!-- End of easyui-dialog -->
<script type="text/javascript">

	/**
	 * @description 添加菜单
	 */
	function add(){
		var validate = $("#add-form").form("validate");
		if (!validate){
			$.messager.alert("消息提醒","请检查你输入的数据!","warning");
			return;
		}
		var data = $("#add-form").serialize();
		$.ajax({
			url: '/menu/save',
			dataType: 'json',
			type: 'post',
			data: data,
			success: function(res){
				if(res.flag){
					$.messager.alert('信息提示', res.msg, 'info');
					$('#add-dialog').dialog('close');
					$('#data-datagrid').treegrid('reload');
				} else {
					$.messager.alert('信息提示',res.msg,'warning');
				}
			}
		});
	}

	/**
	 * @description 选择图标
	 */
	function selectIcon(){
		if ($("#icons-table").children().length <= 0){
			$.ajax({
				url: '/system/getIcons',
				dataType: 'json',
				type: 'post',
				success:function(res){
					if(res.flag){
						var icons = res.data;
						var table = '';
						for(var i=0; i<icons.length; i++){
							var tbody = '<td class="icon-td"><a onclick="selected(this)" href="javascript:void(0)" class="' + icons[i] + '">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></td>';
							if(i == 0){
								table += '<tr>' + tbody;
								continue;
							}
							if((i+1)%24 === 0){
								table += tbody + '</tr><tr>';
								continue;
							}
							table += tbody;
						}
						table += '</tr>';
						$("#icons-table").append(table);
					} else {
						$.messager.alert('信息提示', res.msg, 'warning');
					}
				}
			});
		}
		// 开启图标选择弹窗
		$('#select-icon-dialog').dialog({
			closed: false,
			modal: true,
            title: "选择图标",
            buttons: [{
                text: '确定',
                iconCls: 'icon-ok',
                handler: function(){
                	var icon = $(".selected a").attr('class');
                	$("#add-icon").val(icon);
                	$("#edit-icon").val(icon);
                	$("#add-menu-icon").val(icon);
                	$('#select-icon-dialog').dialog('close'); 
                }
            }, {
                text: '取消',
                iconCls: 'icon-cancel',
                handler: function () {
                    $('#select-icon-dialog').dialog('close');                    
                }
            }]
        });
	}
	
	function selected(e){
		$(".icon-td").removeClass('selected');
		$(e).parent("td").addClass('selected');
	}

	/**
	* @description 打开修改菜单/按钮窗口
	*/
	function openEdit(){
		//$('#edit-form').form('clear');
		var item = $('#data-datagrid').treegrid('getSelected');
		if (item == null || item.length == 0){
			$.messager.alert('信息提示','请选择要修改的数据！','info');
			return;
		}

		$('#edit-dialog').dialog({
			closed: false,
			modal:true,
			title: "修改",
			buttons: [
				{
					text: '确定',
					iconCls: 'icon-ok',
					handler: edit
				},
				{
					text: '取消',
					iconCls: 'icon-cancel',
					handler: function () {
						$('#edit-dialog').dialog('close');
					}
				}
			],
			onBeforeOpen:function(){
				$("#edit-id").val(item.id);
				$("#edit-name").val(item.name);
				$("#edit-parentId").combobox('setValue', item.parentId);
				$("#edit-parentId").combobox('readonly', false);
				//判断是否是按钮
				var parent = $('#data-datagrid').treegrid('getParent', item.id);
				if (parent != null){
					if (parent.parentId != 0){
						$("#edit-parentId").combobox('setText', parent.name);
						$("#edit-parentId").combobox('readonly', true);
					}
				}

				$("#edit-url").val(item.url);
				$("#edit-icon").val(item.icon);
			}
		});
	}

	/**
	 * @description 修改
	 */
	function edit(){
		var validate = $("#edit-form").form("validate");
		if (!validate){
			$.messager.alert("消息提醒", "请检查你输入的数据!", "warning");
			return;
		}
		var data = $("#edit-form").serialize();
		debugger;
		$.ajax({
			url: '/menu/save',
			dataType: 'json',
			type: 'post',
			data: data,
			success:function(res){
				if (res.flag){
					$.messager.alert('信息提示', res.msg, 'info');
					$('#edit-dialog').dialog('close');
					$('#data-datagrid').treegrid('reload');
				} else {
					$.messager.alert('信息提示', res.msg, 'warning');
				}
			}
		});
	}
	
	/**
	 * @description 删除菜单/按钮
	 */
	function remove(){
		var treegrid = $('#data-datagrid');
		var item = treegrid.treegrid('getSelected');
		if ( item == null || item == undefined ){
			$.messager.alert("信息提示", "请选择删除的记录！", "error");
			return;
		} else {
			var nodes = treegrid.treegrid("getChildren", item.id);
			var tip = "确定删除吗？";
			if ( nodes != null && nodes.length > 0){
				tip = "确定删除吗？（该节点有子菜单，请谨慎操作！）";
			}
			$.messager.confirm('信息提示', tip, function(result){
				if(result){
					$.ajax({
						url: '/menu/delete',
						dataType: 'json',
						type: 'post',
						data: { id: item.id },
						success:function(res){
							if (res.flag){
								$.messager.alert('信息提示', res.msg, 'info');
								$('#data-datagrid').treegrid('reload');
							}else{
								$.messager.alert('信息提示', res.msg, 'warning');
							}
						}
					});
				}
			});
		}
	}
	
	/**
	 * @description 添加按钮弹窗
	 */
	function openAddButton(){
		//$('#add-form').form('clear');
		var item = $('#data-datagrid').treegrid('getSelected');
		if(item == null || item.length == 0){
			$.messager.alert('信息提示', '请选择要添加菜单的数据！', 'info');
			return;
		}
		if(item.parentId == 0){
			$.messager.alert('信息提示', '请选择二级菜单！', 'info');
			return;
		}
		var parent = $('#data-datagrid').treegrid('getParent', item.id);
		if(parent.parentId != 0){
			$.messager.alert('信息提示', '请选择二级菜单！', 'info');
			return;
		}
		$('#add-menu-dialog').dialog({
			closed: false,
			modal:true,
            title: "添加按钮",
            buttons: [{
                text: '确定',
                iconCls: 'icon-ok',
                handler: function(){
                	var validate = $("#add-menu-form").form("validate");
            		if(!validate){
            			$.messager.alert("消息提醒", "请检查你输入的数据!", "warning");
            			return;
            		}
            		var data = $("#add-menu-form").serialize();
            		$.ajax({
            			url: '/menu/save',
            			dataType: 'json',
            			type: 'post',
            			data: data,
            			success:function(res){
            				if (res.flag){
            					$.messager.alert('信息提示', res.msg, 'info');
            					$('#add-menu-dialog').dialog('close');
            					$('#data-datagrid').treegrid('reload');
            				} else {
            					$.messager.alert('信息提示', res.msg, 'warning');
            				}
            			}
            		});
                }
            }, {
                text: '取消',
                iconCls: 'icon-cancel',
                handler: function () {
                    $('#add-menu-dialog').dialog('close');                    
                }
            }],
            onBeforeOpen: function(){
            	$("#parent-menu").val(item.name);
            	$("#add-menu-parent-id").val(item.id);
            }
        });
	}
	
	/**
	 * @description 打开添加菜单弹窗
	 */
	function openAdd(){
		//$('#add-form').form('clear');
		$('#add-dialog').dialog({
			closed: false,
			modal:true,
            title: "添加菜单",
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
	 * @description 搜索按钮监听
	 */
	function refresh(){
		$('#data-datagrid').treegrid('load');
	}
	
	/** 
	 * @description 数据表初始化
	 */
	$('#data-datagrid').treegrid({
		url: '/menu/list',
		rownumbers: true,
		singleSelect: true,
		pageSize: 500,
		pageList: [500, 1000],
		pagination: true,
		multiSort: true,
		fitColumns: true,
		idField: 'id',
	    treeField: 'name',
		fit: true,
		columns: [[
			{
				field: 'id',
				title: 'Id',
				width: 40,
				hidden: true
			},
			{
				field: 'name',
				title: '菜单名称',
				width: 100,
				// align: 'center',
				sortable: true
			},
			{
				field: 'url',
				title: '路径',
				width: 100,
				align: 'center',
				sortable: true
			},
			{
				field: 'icon',
				title: '图标',
				width: 100,
				align: 'center',
				formatter: function (value){
					var test = '<a class="' + value + '">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>';
					return test + value;
				}
			}
		]]
	});
</script>