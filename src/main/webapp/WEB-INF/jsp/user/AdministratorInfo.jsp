<%@page import="com.wuye.pojo.Property_management"%>
<%@page import="net.sf.json.JSONArray"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'AdministratorInfo.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="../../../../resources/static/jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="../../../../resources/static/jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript" src="../../../../resources/static/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="../../../../resources/static/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../../../../resources/static/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
<script>

	//动态添加超链接
	function formatOper(val, row, index) {
		return '<a href="javascript:void(0)" onclick="servlet(' + row.pm_id + ')" >详细</a>';
	}
	//传值
	function searchInfo(){
		$("#dg").datagrid('load',{
		name:$("#name").val(),
		work:$("#combox option:selected").text(),
		phone:$("#phone").val()
		});
	}
	//选择行的ID 跳往servlet
	function servlet(row_id) {
		$('#dlg').dialog('open');
		$.ajax({
			/* async : false,
			cache : false, */
			type : "POST",
			url : "Userservlet?id=queryrowwuye&pm_id=" + row_id + "",
			dataType : 'json',
			error : function(data) {
				alert(error) ;
			},
			success : function(data) {
				//刷新数据表
				//$('#dg').datagrid('loadData',{'total':eval(jsonData).length, rows:jsonData });
				$("#xiangxi").empty();
				$("#xiangxi").append(
					"	<tr><td>人员编号：</td>  " +
					"		<td>" + data.pm_number + "</td>            " +
					"		<td>部门：</td>      " +
					"		<td>" + data.dep_id + "</td>            " +
					"	</tr>                    " +
					"	<tr>                     " +
					"		<td>人员姓名：</td>  " +
					"		<td>" + data.pm_name + "</td>            " +
					"		<td>性别：</td>      " +
					"		<td>" + data.pm_gender + "</td>            " +
					"	</tr>                    " +
					"	<tr>                     " +
					"		<td>职务：</td>      " +
					"		<td>" + data.pm_position + "</td>            " +
					"		<td>工作安排：</td>  " +
					"		<td>" + data.pm_work + "</td>            " +
					"	</tr>                    " +
					"	<tr>                     " +
					"		<td>居住地址：</td>  " +
					"		<td>" + data.pm_address + "</td>            " +
					"		<td>联系电话：</td>  " +
					"		<td>" + data.pm_phone + "</td>            " +
					"	</tr>                    "
				);
			}
		});
	}
	var xmlhttp; //核心对象; 
	function createXMLHttp() {
		//这个函数用来创建一个 核心对象XmlHttpRequest 根据浏览器的不同，创建不同的
		if (window.XMLHttpRequest) {
			xmlhttp = new XMLHttpRequest();
		} else {
			xmlhttp = new ActiveXObject("MSXML2.XMLHTTP"); //IE浏览器
		}
	}
	//窗体加载时为区域下拉列表框中读取数据库数据
	window.onload = function() {
		createXMLHttp();
		xmlhttp.open("post", "Userservlet?id=selectoptionsforzhiwu", true); //servlet 对应相应的 servlet url
		xmlhttp.send(null); //发送数据
		xmlhttp.onreadystatechange = change1; //回调函数;显示服务器返回的数据的函数
	}
	function change1() {
		if (xmlhttp.readyState == 4) {
			if (xmlhttp.status == 200) {
				var strs = new Array(); //定义一数组
				var value = xmlhttp.responseText; //字符串方式返回（与Servlet中对应）
				if (typeof value == 'string') {
					strs = value.split(",");
					$("#combox").append("<option value='全部'>全部人员</option>");
					for (var i = 0; i < strs.length - 1; i++) {
						//$("#combox").options.add(new Option(strs[i])); 
						$("#combox").append("<option value="+strs[i]+">" + strs[i] + "</option>");
					}
				} else {
					alert("无法获取职务信息");
				}
			}
		}
	}
</script>
</head>

<body>
	<center>
	<table id="dg" class="easyui-datagrid" title="物业管理人员"
			style="width:640px;height:500px" collapsible:true fitColumns="false"
			pagination="true" rownumbers="true" singleSelect="true" toolbar="#tb"
			url='Userservlet?id=AdministratorInfo'
			data-options="total:2000,pageSize:10">
			<thead>
				<tr>
					<th data-options="field:'pm_id',width:100,halign:'center',align:'center'">编号</th>
					<th data-options="field:'pm_name',width:100,halign:'center',align:'center'">姓名</th>
					<th
						data-options="field:'pm_position',width:100,align:'center',halign:'center'">职务</th>
					<th
						data-options="field:'pm_work',width:100,align:'center',halign:'center'">工作安排</th>
					<th data-options="field:'pm_phone',width:100,halign:'center',align:'center'">联系电话</th>
					<th
						data-options="field:'operate',width:100,align:'center',formatter:formatOper">详细信息</th>
				</tr>
			</thead>
		</table>
	<div id="tb">
		<form action="Userservlet?id=AdministratorInfo" method="post">
			<table>
				<tr>
					<td>姓名：</td>
					<td><input class="easyui-validatebox" type="text" name="name" id="name"></input></td>
					<td>职务：</td>
					<td><select id="combox" name="work">
					</select></td>
					<td>电话：</td>
					<td><input class="easyui-validatebox" type="text" name="phone" id="phone"></input></td>
					<td><a href="javascript:searchInfo()" class="easyui-linkbutton">查询</a></td>
				</tr>
			</table>
		</form>
		</div>
		<div id="dlg" class="easyui-dialog" title="详细信息" closed="true"
			style="width:400px;height:200px;padding:10px"
			data-options="
                iconCls: 'icon-save',
                toolbar: '#dlg-toolbar',
                buttons: '#dlg-buttons'
           ">
			<table id="xiangxi" style="font-size:14px">

			</table>
		</div>
		<div id="dlg-buttons">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="javascript:$('#dlg').dialog('close')">关闭</a>
		</div>
	</center>
</body>
</html>
