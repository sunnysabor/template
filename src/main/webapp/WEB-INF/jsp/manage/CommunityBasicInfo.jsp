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

<title>My JSP 'CommunityBasicInfo.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="../../../../resources/static/css/easyui.css">
<link rel="stylesheet" type="text/css" href="../../../../resources/static/css/icon.css">
<link rel="stylesheet" type="text/css" href="../../../../resources/static/css/demo.css">
<script type="text/javascript" src="../../../../resources/static/js/jquery.min.js"></script>
<script type="text/javascript" src="../../../../resources/static/js/jquery.easyui.min.js"></script>
<script type="text/javascript">
	window.onload = upload();
	function upload() {
		$.ajax({
			type : "post",
			url : "Userservlet?id=showCommunityBasicInfo",
			dataType : 'json',
			success : function(data) {
				$("#xiangxi").empty();
				$("#xiangxi").append(
					"	<tr>" +
					"		<td>小区名称：</td>  " +
					"		<td>" + data.com_name + "</td>            " +
					"		<td>联系电话：</td>      " +
					"		<td>" + data.com_phone + "</td>            " +
					"	</tr>                    " +
					"	<tr>                     " +
					"		<td>主要负责人：</td>      " +
					"		<td>" + data.com_head + "</td>            " +
					"		<td>停车场面积：</td>  " +
					"		<td>" + data.com_parking_area + "</td>            " +
					"	</tr>  " +
					"	<tr>                     " +
					"		<td>建造日期：</td>  " +
					"		<td>" + data.com_date + "</td>            " +
					"		<td>道路面积：</td>" +
					"		<td>" + data.com_road_area + "</td>" +
					"	</tr>                   " +
					"	<tr>                     " +
					"		<td>建筑面积：</td>      " +
					"		<td>" + data.com_building_area + "</td>" +
					"		<td>绿化面积：</td>" +
					"		<td>" + data.com_green_area + "</td>" +
					"	</tr>" +
					"	<tr>" +
					"		<td>小区地址：</td>      " +
					"		<td colspan='3'>" + data.com_address + "</td>" +
					"		<td></td>" +
					"		<td></td>" +
					"	</tr>" +
					"	<tr>" +
					"		<td>小区说明：</td>      " +
					"		<td colspan='3'>" + data.com_introduction + "</td>" +
					"		<td></td>" +
					"		<td></td>" +
					"	</tr>"
				);
			}
		});
	}
	function update() {
		$('#dlg').dialog('open');
		$.ajax({
			type : "post",
			url : "Userservlet?id=showCommunityBasicInfo",
			dataType : 'json',
			success : function(data) {
				$("#xiangxi1").empty();
				$("#xiangxi1").append(
					"	<tr>" +
					"		<td >小区编号：</td>  " +
					"		<td colspan='3' id='com_id'>" + data.com_id + "</td>            " +
					"		<td></td>      " +
					"		<td></td>            " +
					"	</tr>                    " +
					"	<tr>" +
					"		<td>小区名称：</td>  " +
					"		<td><input type='text' id='com_name' name='com_name' value='" + data.com_name + "'/></td>            " +
					"		<td>联系电话：</td>      " +
					"		<td><input type='text' id='com_phone' name='com_phone' validType='phone' value='" + data.com_phone + "'/></td>            " +
					"	</tr>                    " +
					"	<tr>                     " +
					"		<td>主要负责人：</td>      " +
					"		<td><input type='text' id='com_head' name='com_head' value='" + data.com_head + "'/></td>            " +
					"		<td>停车场面积：</td>  " +
					"		<td><input type='text' id='com_parking_area' name='com_parking_area' value='" + data.com_parking_area + "'/></td>            " +
					"	</tr>  " +
					"	<tr>                     " +
					"		<td>建造日期：</td>  " +
					"		<td>" + data.com_date + "<input type='hidden' id='com_date' value='" + data.com_date + "'></td>            " +
					"		<td>道路面积：</td>" +
					"		<td><input type='text' id='com_road_area' name='com_road_area' value='" + data.com_road_area + "'/></td>" +
					"	</tr>                   " +
					"	<tr>                     " +
					"		<td>建筑面积：</td>      " +
					"		<td><input type='text' id='com_building_area' name='com_building_area' value='" + data.com_building_area + "'/></td>" +
					"		<td>绿化面积：</td>" +
					"		<td><input type='text' id='com_green_area' name='com_green_area' value='" + data.com_green_area + "'/></td>" +
					"	</tr>" +
					"	<tr>" +
					"		<td>小区地址：</td>      " +
					"		<td colspan='3'><textarea  id='com_address' name='message' style='height:100px;width:350px;outline:none;resize:none;'> " + data.com_address + "</textarea></td>" +
					"		<td></td>" +
					"		<td></td>" +
					"	</tr>" +
					"	<tr>" +
					"		<td>小区说明：</td>      " +
					"		<td colspan='3'><textarea  id='com_introduction' name='message' style='height:100px;width:350px;outline:none;resize:none;'> " + data.com_introduction + "</textarea></td>" +
					"		<td></td>" +
					"		<td></td>" +
					"	</tr>"
				);
				$('#com_parking_area').numberbox({
					min : 0,
					precision : 2,
					max : 1000000
				});
				$('#com_road_area').numberbox({
					min : 0,
					precision : 2,
					max : 1000000
				});
				$('#com_building_area').numberbox({
					min : 0,
					precision : 2,
					max : 1000000
				});
				$('#com_green_area').numberbox({
					min : 0,
					precision : 2,
					max : 1000000
				});
			}
		});
	}
	function save() {
		//alert($("#com_date").val());
		$('#dlg').dialog('close');
		$.ajax({
			type : "post",
			url : "Userservlet?id=changeCommunityBasicInfo&com_name=" + $("#com_name").val() +
				"&com_id=" + $("#com_id").text() +
				"&com_phone=" + $("#com_phone").val() + "&com_head=" + $("#com_head").val() +
				"&com_parking_area=" + $("#com_parking_area").val() +
				"&com_date=" + $("#com_date").val() + "&com_road_area=" + $("#com_road_area").val() +
				"&com_building_area=" + $("#com_building_area").val() + "&com_green_area=" + $("#com_green_area").val() +
				"&com_count=" + "&com_address=" + $("#com_address").val() +
				"&com_introduction=" + $("#com_introduction").val() + "",
			dataType : 'json',
			success : function(data) {
				if (data.flag == "true") {
					$.messager.alert("系统提示", "修改成功！", 'info');
				} else {
					$.messager.alert("系统提示", "修改失败！", 'error');
				}
				upload();
			}
		})
	}
</script>
</head>

<body>
	小区基本信息
	<center>
		<table id="xiangxi">
		</table>
		<a href="javascript:update()" class='easyui-linkbutton'>修改</a>
		<div>
			<div id="dlg" class="easyui-dialog" title="编辑小区信息"
				style="width:600px;height:500px;padding:10px" closed="true"
				data-options="
               iconCls: 'icon-save',
               toolbar: '#dlg-toolbar',
               buttons: '#dlg-buttons'
          ">
				<table id="xiangxi1">
				</table>
			</div>
			<div id="dlg-buttons">
				<a href="javascript:save()" class="easyui-linkbutton">保存</a> <a
					href="javascript:$('#dlg').dialog('close')"
					class="easyui-linkbutton">关闭</a>
			</div>
		</div>
	</center>
</body>
</html>
