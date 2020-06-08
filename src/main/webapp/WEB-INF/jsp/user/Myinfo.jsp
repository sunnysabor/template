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

<title>My JSP 'gerenxinxi.jsp' starting page</title>

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
<style type="text/css">
table td{
text-align:center;
width:150px;
}
table tr{
height:30px;
}
</style>
</head>

<body>
	<center>
		<table >
		<!-- 	<tr>
				<td>小区名称：</td>
				<td>建宏中央花园</td>
				<td>所住楼栋：</td>
				<td>一号楼</td>
			</tr> -->
			<tr>
				<!-- <td>所住单元：</td>
				<td>一单元</td> -->
				<td>所住房间：</td>
				<td>${userinfo.room_id }</td>
			</tr>
			<tr>
				<td>姓名：</td>
				<td>${userinfo.res_name }</td>
				<td>联系电话：</td>
				<td>${userinfo.res_phone }</td>
			</tr>
			<tr>
				<td>电子邮箱：</td>
				<td>${userinfo.res_email }</td>
				<td>工作单位：</td>
				<td>${userinfo.res_units }</td>
			</tr>
			<tr>
				<td>房产证号：</td>
				<td>${userinfo.res_house_card_number }</td>
				<td>手机：</td>
				<td>${userinfo.res_mobile_phone }</td>
			</tr>
			<tr>
				<td>身份证：</td>
				<td>${userinfo.res_id_card }</td>
				<td>联系地址：</td>
				<td>${userinfo.res_address }</td>
			</tr>
			<tr>
				<td>用户名：</td>
				<td>${userinfo.res_user_id }</td>
				<td>备注信息：</td>
				<td>${userinfo.res_note }</td>
			</tr>
			<tr>
				<td>维修基金：</td>
				<td>${userinfo.fix_fee }</td>
			</tr>
		</table>
	</center>
</body>


     
</html>
