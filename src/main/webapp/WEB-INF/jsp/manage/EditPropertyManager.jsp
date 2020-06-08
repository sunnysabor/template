<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>编辑物业管理人员</title>
    
	<link rel="stylesheet" type="text/css" href="../../../../resources/static/jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="../../../../resources/static/jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript" src="../../../../resources/static/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="../../../../resources/static/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../../../../resources/static/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">
	//点击修改按钮
	var url;
	function updatePropert(){
		var selectedRows=$("#dg").datagrid('getSelections');
		 if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要编辑的数据！");
			return;
		}
		var row=selectedRows[0];
		$("#modify").dialog("open").dialog("setTitle","修改管理员信息");
		$("#fm").form("load",row);
		//alert(row.ann_id);
		url="AdministratorsServlet?op=updatePropertyManager&pm_id"+row.pm_id;
	} 
		//点击保存按钮
	 function saveann(){
		$("#fm").form("submit",{
			url:url,
			onSubmit:function(){
				return $(this).form("validate");
			},
			success:function(result){
				if(result.errorMsg){
					$.messager.alert("系统提示",result.errorMsg);
					return;
				}else{
					$.messager.alert("系统提示","修改成功");
					$("#dg").datagrid("reload");
					$("#modify").dialog("close");
					$("#pm_id").val("");
					$("#pm_name").val("");
					$("#pm_position").val("");
					$("#pm_work").val("");
					$("#pm_card_id").val("");
					$("#pm_address").val("");
					$("#pm_phone").val("");
					
				}
			}
		});
	} 
		//保存关闭按钮
 	function guanbi(){
		$("#modify").dialog("close");
		resetValue();
	} 
	
	//点击删除按钮
	 function deletePropert(){
		var selectedRows=$("#dg").datagrid('getSelections');		
		if(selectedRows.length==0){
			$.messager.alert("系统提示","请选择要删除的数据！");			
			return;
		}
		var strIds=[];
		for(var i=0;i<selectedRows.length;i++){
			strIds.push(selectedRows[i].pm_id);
		}
		var ids=strIds.join(",");
		$.messager.confirm("系统提示","您确认要删掉这<font color=red>"+selectedRows.length+"</font>条数据吗？",function(r){
			if(r){
				$.post("AdministratorsServlet?op=deletePropertyManager",{delIds:ids},function(result){
					if(result.success){
						$.messager.alert("系统提示","您已成功删除<font color=red>"+result.delNums+"</font>条数据！");
						$("#dg").datagrid("reload");
					}else{
						$.messager.alert('系统提示',result.errorMsg);
					}
				},"json");
			}
		});
	} 
     </script>


  </head>
  
  <body>
		<center>
		<div id="chatb">
			<div>
				<!-- <a href="javascript:HandleRepair()" class="easyui-linkbutton" iconCls="icon-ok" plain="true">通过</a>		 -->
				<a href="javascript:updatePropert()" class="easyui-linkbutton" iconCls="icon-edit" plain="true"  >修改</a>
				<a href="javascript:deletePropert()" class="easyui-linkbutton" iconCls="icon-remove" plain="true"  >删除</a>
			</div>
		</div>
		<div style="height: 100%;width: 100% padding-top:30px;">	
		<table id="dg" title="编辑物业管理人员" class="easyui-datagrid" fitColumns="true"
	 	pagination="true" rownumbers="true" url='AdministratorsServlet?op=SelectProperty' fit="true" toolbar="#chatb">
			<thead>
				<tr>
					<th field="cb" checkbox="true"></th>
					<th data-options="field:'pm_id',width:120,align:'center'">编号</th>
					<th data-options="field:'pm_name',width:120,align:'center'">姓名</th>
					<th data-options="field:'pm_position',width:120,align:'center'">职务</th>
					<th data-options="field:'pm_work',width:120,align:'center'">工作安排</th>
					<th data-options="field:'pm_card_id',width:120,align:'center'">身份证号</th>
					<th data-options="field:'pm_phone',width:120,align:'center'">联系电话</th>
					<th data-options="field:'pm_address',width:120,align:'center'">住址</th>
				</tr>
			</thead>
		</table>
	</div>
	<div id="modify" class="easyui-dialog" style="width: 300px;height: 330px;padding: 10px 20px"
		closed="true" buttons="#dlg-buttons">
		<form id="fm" method="post">
			<table cellspacing="5px;">
			<tr><td><input type="hidden"  name="pm_id" id="pm_id" class="easyui-validatebox" required="true"/></td></tr>
				<tr>
				<tr>
				<td style="width:150px">姓名:</td>
				<td><input type="text" name="pm_name" id="pm_name" class="easyui-validatebox" required="true"/></td>
				</tr>
				<tr>
				<td style="width:150px">职务:</td>
				<td><input type="text" name="pm_position" id="pm_position" class="easyui-validatebox" required="true"/></td>
				</tr>
				<tr>
				<td style="width:150px">工作安排:</td>
				<td><input type="text" name="pm_work" id="pm_work" class="easyui-validatebox" required="true"/></td>
				</tr>
				<tr>
				<td style="width:150px">身份证号:</td>
				<td><input type="text" name="pm_card_id" id="pm_card_id" class="easyui-validatebox" required="true"/></td>
				</tr>
				<tr>
				<td style="width:150px">联系电话:</td>
				<td><input type="text" name="pm_phone" id="pm_phone" class="easyui-validatebox" required="true"/></td>
				</tr>
				<tr>
				<td style="width:150px">住址：</td>
					<td><input type="text" name="pm_address" id="pm_address" class="easyui-validatebox" required="true"/></td>
				</tr>
			</table>
		</form>
	</div>
	<!--信息添加结束 -->
	<div id="dlg-buttons">
		<a href="javascript:saveann()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
		<a href="javascript:guanbi()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
	</center>
  </body>
</html>
