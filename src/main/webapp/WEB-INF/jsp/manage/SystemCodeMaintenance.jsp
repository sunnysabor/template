<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'SystemCodeMaintenance.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<link rel="stylesheet" type="text/css" href="../../../../resources/static/css/easyui.css">
<link rel="stylesheet" type="text/css" href="../../../../resources/static/css/icon.css">
<link rel="stylesheet" type="text/css" href="../../../../resources/static/css/demo.css">
<script type="text/javascript" src="../../../../resources/static/js/jquery.min.js"></script>
<script type="text/javascript" src="../../../../resources/static/js/jquery.easyui.min.js"></script>
</head>

<body>
	系统代码维护
	<center>
		<table>
			<tr>
				<td>请选择参数类别：</td>
				<td><select class="easyui-combobox"></select></td>
			</tr>
		</table>
		<table class="easyui-datagrid" title="编辑收费类型"
			style="width:810px;height:300px"
			collapsible:true,url:'../datagrid/datagrid_data1.json'" data-options="total:2000,pageSize:10">
			<thead>
				<tr>
					<th data-options="field:'itemid',width:100,halign:'center'">代码</th>
					<th data-options="field:'productid',width:200,halign:'center'">名称</th>
					<th
						data-options="field:'listprice',width:300,align:'right',halign:'center'">功能标准</th>
					<th
						data-options="field:'unitcost',width:100,align:'right',halign:'center'">编辑</th>
					<th data-options="field:'attr1',width:100,halign:'center'">删除</th>
				</tr>
			</thead>
		</table>
		<!-- 能不写添加就不写添加，这里是数据库的原因 -->
		<!-- <table>
    	<tr>
    	<td>代码：</td>
    	<td><input class="easyui-validatebox" type="text" name="name"></td>
    	</tr>
    	<tr>
    	<td>名称：</td>
    	<td><input class="easyui-validatebox" type="text" name="name"></td>
    	</tr>
    	</table> -->

	</center>
</body>
</html>
