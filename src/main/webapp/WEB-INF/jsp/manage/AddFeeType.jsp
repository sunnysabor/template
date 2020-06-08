<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title> 添加小区物业收费类型</title>
    
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
<script type="text/javascript" src = "../../../../resources/static/js/jspname.js"></script>
  </head>
  <%
  	Object message = request.getAttribute("message");
     if(message!=null && !"".equals(message))
		{%>
	      <script type="text/javascript">          
	      	alert("<%=message%>");
	      </script>
  		<%}
   %>
  <body>
	    <center>
	    <form id="ff" action="AdministratorsServlet?op=AddChargeType" method="post" >
	    <div style="margin:10px 0;"></div>
	    <div class="easyui-panel" title="添加小区物业收费类型" style="width:400px">
	        <div style="padding:10px 0 10px 60px">
	        
	            <table>
	                <tr>
	                <td>收费名称:</td>
	                <td><input type="text" name="shoufeiName"></td>
	            </tr>
	                  <tr>
	                <td>收费标准:</td>
	                <td><input type="text" name="sfbz"></td>
	            </tr>
	              
	                <tr>
	                    <td>内容:</td>
	                    <td><textarea name="message" style="height:60px;"></textarea></td>
	                </tr>
	               
	            </table>
	        
	        </div>
	        <div style="text-align:center;padding:5px">
	        	<input type="submit" value="添加">
	            <!-- <a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()">添加</a> -->
	            <!-- <a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()">取消</a> -->
	        </div>
	    </div>
	    </form>
	    </center>
	    <script>
	        /* function submitForm(){
	            $('#ff').form('submit');
	        } */
	        function clearForm(){
	            $('#ff').form('clear');
	        }
	    </script>
	</body>
</html>
