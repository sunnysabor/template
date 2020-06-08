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

<title>My JSP 'EditAdmin.jsp' starting page</title>

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
<script type="text/javascript">
	 function submitform(){
		if($('#name').val().trim()==""){
			$.messager.alert("系统提示","请填写账号",'error');
			return false;
		}
		if($('#oldPassword').val().trim()==""){
			$.messager.alert("系统提示","请填原密码",'error');
			return false;
		}
		if($('#newPassword').val().trim()==""){
			$.messager.alert("系统提示","请填写新密码",'error');
			return false;
		}
		if($('#confirmPassword').val().trim()==""){
			$.messager.alert("系统提示","请填写确认密码",'error');
			return false;
		}
		if ($('#confirmPassword').val().trim() != $("#newPassword").val().trim()) {
			$.messager.alert("系统提示", "两次密码不一致！",'error');
			return;
		}
	 	$.ajax({
			type : "POST",
			url : "Userservlet?id=managerChangePassword&oldPassword=" + $('#oldPassword').val().trim() + "&newPassword=" + $('#newPassword').val().trim() + "&name="+$('#name').val().trim()+"",
			dataType : 'json',
			success : function(data) {
				if (data.flag == "true")
					$.messager.alert('提示消息', '修改成功!', 'info');
				else
					$.messager.alert('提示消息', '修改失败!', 'error');
				resetValue();

			}
		});
	}
	//保存成功
	function resetValue(){
		$("#name").val("");
		$("#oldPassword").val("");
		$("#newPassword").val("");
		$("#confirmPassword").val("");
	}
</script>
</head>

<body>
	<center>
	<div class="easyui-panel" title="密码修改" style="width:300px;padding:10px;"> 
			<table>			
				<tr>
					<td>登录账号：</td>
					<td><input class="easyui-validatebox" type="text" name="name" id="name"></td>
					<td></td>
				</tr>
				<tr>
					<td>原密码：</td>
					<td><input class="easyui-validatebox" type="password" name="oldPassword" id="oldPassword"></td>
					<td></td>
				</tr>
				<tr>
					<td>新密码：</td>
					<td><input class="easyui-validatebox" type="password" name="newPassword" id="newPassword"></td>
					<td></td>
				</tr>
				<tr>
					<td>确认密码：</td>
					<td><input class="easyui-validatebox" type="password" name="confirmPassword" id="confirmPassword"></td>
					<td></td>
				</tr>
			</table>
		</div>
		<div style="text-align:center;padding:5px">
		<a href="javascript:submitform()" class="easyui-linkbutton">提交</a> 
			<a href="javascript:void(0)"
			class="easyui-linkbutton" onclick="clearForm()">清空</a>
		</div>
	</center>
	
</body>
<script>
		function clearForm() {
			$('#ff').form('clear');
		}
	</script>
</html>
