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

<title>My JSP 'AddUserInfo.jsp' starting page</title>

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
	var xmlhttp; //核心对象; 
	function createXMLHttp() {
		//这个函数用来创建一个 核心对象XmlHttpRequest 根据浏览器的不同，创建不同的
		if (window.XMLHttpRequest) {
			xmlhttp = new XMLHttpRequest();
		} else {
			xmlhttp = new ActiveXObject("MSXML2.XMLHTTP"); //IE浏览器
		}
	}
	//窗体加载时为楼宇下拉列表框中读取数据库数据
	window.onload = function() {
		createXMLHttp();
		xmlhttp.open("post", "houseServlet?op=selectoptionsforlouyu" + "&ts="
				+ new Date().getTime().toString(), true); //servlet 对应相应的 servlet url
		xmlhttp.send(null); //发送数据
		xmlhttp.onreadystatechange = change1; //回调函数;显示服务器返回的数据的函数
	};
	function change1() {
		if (xmlhttp.readyState == 4) {
			if (xmlhttp.status == 200) {
				var strs = new Array(); //定义一数组
				var value = xmlhttp.responseText; //字符串方式返回（与Servlet中对应）
				if (typeof value == 'string') {
					strs = value.split(",");
					for ( var i = 0; i < strs.length - 1; i++) {
						//$("#combox").options.add(new Option(strs[i])); 
						$("#louyu").append("<option>" + strs[i] + "</option>");
					}
				} else {
					alert("无法获取区域信息");
				}
			}
		}
	}

	//区域的select控件的值更改时，同时查询对应的楼栋
	function changeSelect(louyu) {
		createXMLHttp();//&buildingName="+combox.value
		xmlhttp.open("post", "houseServlet?op=danyuanSelect&louyu="
				+ louyu.value + "&ts=" + new Date().getTime().toString(), true); //servlet 对应相应的 servlet url
		xmlhttp.send(null); //发送数据
		xmlhttp.onreadystatechange = change2;
	}
	function change2() {
		if (xmlhttp.readyState == 4) {
			if (xmlhttp.status == 200) {
				var strs = new Array(); //定义一数组
				var value = xmlhttp.responseText; //字符串方式返回（与Servlet中对应）
				if (typeof value == 'string') {
					strs = value.split(",");
					danyuan.length = 0;
					for ( var i = 0; i < strs.length - 1; i++) {
						danyuan.options.add(new Option(strs[i]));
					}
				} else {
					alert("无法获取单元信息");
				}
			}
		}
	}
	//单元下拉加载房间
	function danyuanchange(){
		//alert( $("#danyuan").val());
		var danyuan=$("#danyuan").val();
		$.ajax({
			url:"houseServlet?op=getroom&danyuan="+danyuan,
			type:"post",
			success:function(data){
				//alert(data);
				var strs=data.split(",");
				$("#room").empty();
				for(var i=0;i<strs.length-1;i++)
				{
					$("#room").append("<option value="+strs[i]+">"+strs[i]+"</option>");
				}
			},
		});
	}
</script>
</head>

<body>
	<center>
	<form action="houseServlet?op=addzhuhu" method="post">
		<table>
			<tr>
				<td>选择楼宇：</td>
				<td><input class="easyui-validatebox" type="text" name="louyu"
						   id="louyu"></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<td>选择单元：</td>
				<td><input class="easyui-validatebox" type="text" name="danyuan"
						   id="danyuan"></td>
				<td colspan="2"></td>
			</tr>
			
			<tr>
				<td>选择房间：</td>
				<td><input class="easyui-validatebox" type="text" name="fangjian"
						   id="fangjian"></td>
				<!-- <td><input type="text" name="room"></td>
				<td colspan="2"></td> -->
			</tr>
			<tr>
				<td><font color="red" >*</font>业主姓名：</td>
				<td><input  type="text" name="res_name" ></td>
				<td><font color="red">*</font>房产证号：</td>
				<td><input  type="text" name="res_house_card_number" ></td>
			</tr>
			<tr>
				<td><font color="red">*</font>联系电话：</td>
				<td><input  type="text" name="res_phone" ></td>
				<td><font color="red">*</font>手机：</td>
				<td><input  type="text" name="res_mobile_phone"></td>
			</tr>
			<tr>
				<td><font color="red">*</font>电子邮箱：</td>
				<td><input  type="text" name="res_email" ></td>
				<td><font color="red">*</font>身份证：</td>
				<td><input  type="text" name="res_id_card" ></td>
			</tr>
			<tr>
				<td><font color="red">*</font>工作单位：</td>
				<td><input  type="text" name="res_units" ></td>
				<td><font color="red">*</font>联系地址：</td>
				<td><input  type="text" name="res_address" ></td>
			</tr>
			<tr><td colspan="4">以下是住户用户名和密码<font color="red">（默认都为身份证号）</font></td></tr>
			<tr><td>性别:<td><input type="radio" value="男" name="sex">男<input type="radio" name="sex" value="女">女</td></tr>
			<tr>
				<td>用户名：</td>
				<td><input  type="text" name="res_user_id" ></td>
				<td>密码：</td>
				<td><input  type="text" name="res_user_password" ></td>
			</tr>
			<tr>
				<td>备注信息：</td>
				<td><textarea name="res_note" style="height:60px;">（备注内容!）</textarea></td>
			</tr>
			<%--<tr>--%>
				<%--<td>维修基金：</td>--%>
				<%--<td><input  type="text" name="fix_fee" ></td>--%>
			<%--</tr>--%>
			<tr>
				<td></td>
				<td><input type="submit" value="保存数据"></td>
			</tr>
			<tr><font color="red">${oktips }</font></tr>
		</table>
		</form>
	</center>
</body>
</html>
