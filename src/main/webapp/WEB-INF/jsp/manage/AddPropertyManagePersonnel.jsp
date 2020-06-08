<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>添加物业管理员</title>
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
		function clearForm() {
			$('#ff').form('clear');
		}
	</script>
  </head>
  
  <body>
    	
    	<center>
    	<form  method="post" action="propertyManageServlet?op=addpro"    id="ff">
    	<font color="red">${oktips }</font>
    	
    	<table>
    		<tr>
    			<td>账号：</td>
    			<td><input class="easyui-validatebox" data-options="required:true,validType:''"  type="text" name="pm_userid"></td>
    			<td>密码：</td>
    			<td><input class="easyui-validatebox" type="text" name="pm_password" data-options="required:true,validType:''" ></td>
    			
    		</tr>
    		<tr>
    			<td>性别：</td>
    			<td> <input type="radio" name="pm_gender" value="男">男 <input type="radio" name="pm_gender" value="女">女</td>
    			<td>职务：</td>
    			<td><input class="easyui-validatebox" type="text" name="pm_position" data-options="required:true,validType:''" ></td>
    		</tr>
    		<tr>
    			<td>工作安排：</td>
    			<td><input class="easyui-validatebox" type="text" name="pm_work" data-options="required:true,validType:''" ></td>
    			<td>身份证号码：</td>
    			<td><input class="easyui-validatebox" type="text" name="pm_card_id" data-options="required:true,validType:''" ></td>
    		</tr>
    		<tr>
    			<td>居住地址：</td>
    			<td><input class="easyui-validatebox" type="text" name="pm_address"></td>
    			<td>联系电话：</td>
    			<td><input class="easyui-validatebox" type="text" name="pm_phone"></td>
    		</tr>
    		<tr>
    			<td>手机号码：</td>
    			<td><input class="easyui-validatebox" type="text" name="pm_mobile_phone" data-options="required:true,validType:''" ></td>
    			<td>姓名：</td>
    			<td><input class="easyui-validatebox" data-options="required:true,validType:''"  type="text" name="pm_name"></td>
    		</tr>
    		<tr>
    		<td></td>
    		<td></td>
    			<td><button type="submit" >提交</button></td>
    			<td><button type="button" onclick="clearForm()" >清空</button></td>
    		</tr>
    	</table>
    	</form>
    	</center>
  </body>
</html>
