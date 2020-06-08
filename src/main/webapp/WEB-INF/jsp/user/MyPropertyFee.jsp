<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>我的物业费</title>
    
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
		//点击删除按钮
	function deleteann() {
		var selectedRows = $('#dg').datagrid('getSelections');
		if (selectedRows.length == 0) {
			$.messager.alert("系统提示", "请选择要删除的数据！");
			return;
		}

		var strIds = [];
		for ( var i = 0; i < selectedRows.length; i++) {
			strIds.push(selectedRows[i].cha_id);
		}
		var ids = strIds.join(",");
		//alert();
		//var Deleteann=Deleteann;
		$.messager.confirm("系统提示", "您确认要删掉这<font color=red>"
				+ selectedRows.length + "</font>条数据吗？", function(r) {
			if (r) {
				$.post("ControllerServlet?op=deletefee", {
					delIds : ids
				}, function(result) {
					if (result.success) {
						$.messager.alert("系统提示", "您已成功删除<font color=red>"
								+ result.delNums + "</font>条数据！");
						$("#dg").datagrid("reload");
					} else {
						$.messager.alert('系统提示', result.errorMsg);
					}
				}, "json");
			}
		});
	}
	
	//获取数据--多条件查询 
	function sousuo() {
		//alert($('#loucheng').val());
		$('#dg').datagrid('load', {
			cha_type_name : $('#feetype').val(),
		});

	}
	
	//ajax 显示用户的搜索框下拉值
	$(function(){
		$.ajax({
			url:"ControllerServlet",
			data:"op=getfeetype",
			type:"post",
			success:function(data){
				//alert(data);
				var strs= data.split(",");
				$("#feetype").empty();
				$("#feetype").append("<option >搜索全部</option>");
				for(var i=0;i<strs.length-1;i++)
				{
					$("#feetype").append("<option value='"+strs[i]+"'>"+strs[i]+"</option>");
				}
			},
			
		});
	});
</script>
  </head>
  
  <body>
    <center>
    <div id="cha">
    
    	<a href="javascript:deleteann()" class="easyui-linkbutton" iconCls="icon-remove" plain="true" >删除</a>
    	 收费类型: <select id="feetype" name="feetype"></select>
    	<a href="javascript:sousuo()" class="easyui-linkbutton" iconCls="icon-search" plain="true"  name="fanghao" id="fanghao">搜索</a>
    </div>
   <div style='width: 100%;height:100%'>
	<table title="我的物业费" class="easyui-datagrid" fitColumns="true" 
	 pagination="true" rownumbers="true" url="ControllerServlet?op=Mypropertyfee" fit=true  id="dg" toolbar="#cha">
			<thead>
				<tr>	
					<th field="cb" checkbox="true"></th>
					<th field="cha_id" width="50" align="center">收费编号</th>						
					<th field="cha_begin_date" width="50" align="center">收费时间</th>
					<th field="cha_type_name" width="50" align="center">收费类型</th>
					<th field="cha_price" width="50" align="center">价格</th>
					<th field="cha_number" width="50" align="center">数量</th>
					<th field="cha_type_standard" width="50" align="center">单位</th>														
					<!-- <th field="cha_balance" width="50" align="center">余额</th>		 -->			
					<th field="cha_head" width="50" align="center">收费人</th>											
				</tr>				
			</thead>
		<tr>
		<td></td>
		</tr>
		</table>
		</div>
</center>
  </body>
</html>
