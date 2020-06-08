<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<base href="<%=basePath%>">

	<title>费用提醒</title>
	<link rel="stylesheet" type="text/css" href="../../../../resources/static/jquery-easyui-1.3.3/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="../../../../resources/static/jquery-easyui-1.3.3/themes/icon.css">
	<script type="text/javascript" src="../../../../resources/static/jquery-easyui-1.3.3/jquery.min.js"></script>
	<script type="text/javascript" src="../../../../resources/static/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../../../../resources/static/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="../../js/jquery-3.2.1.min.js"></script>

	<script type="text/javascript">
        var xmlhttp; //核心对象;
        function createXMLHttp() {
            //这个函数用来创建一个 核心对象XmlHttpRequest 根据浏览器的不同，创建不同的
            if (window.XMLHttpRequest) {
                xmlhttp = new XMLHttpRequest();
            } else {
                xmlhttp = new ActiveXObject("MSXML2.XMLHTTP"); //IE浏览器
            }
        }

	</script>
</head>
<body>
<center>
	<div style="height: 95%;width: 100% padding-top:30px;">
		<table id="dg" title="费用提醒" class="easyui-datagrid" fitColumns="true"
			   pagination="true" rownumbers="true" url='ParkingServlet?op=queryTips&res_id=${userinfo.res_id }' fit="true" toolbar="#chatb">
			<thead>
			<tr>
				<th field="cb" checkbox="true"></th>
				<th data-options="field:'cha_id',width:85,align:'center'">收费编号</th>
				<th data-options="field:'bui_name',width:85,align:'center'">楼宇名称</th>
				<th data-options="field:'ins_name',width:85,align:'center'">单元名称</th>
				<th data-options="field:'room_number',width:85,align:'center'">房间号</th>
				<th data-options="field:'res_id',width:85,align:'center'">住户编号</th>
				<th data-options="field:'cha_type_name',width:85,align:'center'">收费名称</th>
				<th data-options="field:'cha_type_standard',width:85,align:'center'">收费标准</th>
				<th data-options="field:'cha_number',width:85,align:'center'">数量</th>
				<th data-options="field:'cha_price',width:85,align:'center'">应付金额</th>
				<th data-options="field:'cha_balance',width:85,align:'center'">余额</th>
				<th data-options="field:'cha_begin_date',width:85,align:'center'">收费时间</th>
				<th data-options="field:'cha_head',width:85,align:'center'">经手人</th>
			</tr>
			</thead>
		</table>
	</div>

</center>
</body>
</html>
