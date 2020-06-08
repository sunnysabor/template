<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'EditingFeeType.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<link rel="stylesheet" type="text/css" href="../../../../resources/static/jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="../../../../resources/static/jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript" src="../../../../resources/static/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="../../../../resources/static/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../../../../resources/static/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript">
	var url;
	//点击删除按钮
	 function deleteEditCharge(){
		var selectedRows=$("#dg").datagrid('getSelections');		
		if(selectedRows.length==0){
			$.messager.alert("系统提示","请选择要删除的数据！");			
			return;
		}
		var strIds=[];
		for(var i=0;i<selectedRows.length;i++){
			strIds.push(selectedRows[i].cha_type_id);
		}
		var ids=strIds.join(",");
		$.messager.confirm("系统提示","您确认要删掉这<font color=red>"+selectedRows.length+"</font>条数据吗？",function(r){
			if(r){
				$.post("AdministratorsServlet?op=deleteCharge_type",{delIds:ids},function(result){
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
	//点击修改按钮
	function updateEditCharge(){
		var selectedRows=$("#dg").datagrid('getSelections');
		 if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要编辑的数据！");
			return;
		}
		var row=selectedRows[0];
		$("#update").dialog("open").dialog("setTitle","修改收费类型");
		$("#fm").form("load",row);
		//alert(row.ann_id);
		url="AdministratorsServlet?op=updateEditCharge&cha_type_id"+row.cha_type_id;
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
					$("#update").dialog("close");
					$("#ins_name").val("");
					$("#rep_title").val("");
					$("#rep_date").val("");
				}
			}
		});
	} 
		//保存关闭按钮
 	function guanbi(){
		$("#update").dialog("close");
		resetValue();
	} 
    </script>
  </head>
  <body>
    	<center>
		<div id="chatb">
			<div>
				<a href="javascript:updateEditCharge()" class="easyui-linkbutton" iconCls="icon-edit" plain="true"  >修改</a>
				<a href="javascript:deleteEditCharge()" class="easyui-linkbutton" iconCls="icon-remove" plain="true"  >删除</a>
			</div>
		</div>
		<!-- 显示部分 -->
  	<div style="height:100%;width: 100% ;padding-top:-15px;">	
		<table id="dg" title="编辑收费类型" class="easyui-datagrid" fitColumns="true"
	 	pagination="true" rownumbers="true" url='AdministratorsServlet?op=editCharge' fit="true" toolbar="#chatb">
			<thead>
				<tr>
					<th field="cb" checkbox="true"></th>
					<th field="cha_type_name" width="150" align="center">收费名称</th>
					<th field="cha_type_standard" width="100" align="center">收费标准</th>
					<th field="cha_type_instructions" width="150" align="center">收费说明</th>	
				</tr>
			</thead>
		</table>
	</div>
		<!--信息添加开始  -->
	<div id="update" class="easyui-dialog" style="width: 400px;height: 200px;padding: 10px 20px"
		closed="true" buttons="#dlg-buttons">
		<form id="fm" method="post">
			<table cellspacing="5px;">
			<tr><td><input type="hidden"  name="cha_type_id" id="cha_type_id" class="easyui-validatebox" required="true"/></td></tr>
				<tr>
				<tr>
				<td style="width:150px">收费名称:</td>
				<td><input type="text" name="cha_type_name" id="cha_type_name" class="easyui-validatebox" required="true"/></td>
				</tr>
				<tr>
				<td style="width:150px">收费标准:</td>
				<td><input type="text" name="cha_type_standard" id="cha_type_standard" class="easyui-validatebox" required="true"/></td>
				</tr>
				<tr>
				<td style="width:150px">收费说明：</td>
					<td><input type="text" name="cha_type_instructions" id="cha_type_instructions" class="easyui-validatebox" required="true"/></td>
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
