<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">

    <title>My JSP 'xiugaimima.jsp' starting page</title>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <!--
    <link rel="stylesheet" type="text/css" href="styles.css">
    -->
    <link rel="stylesheet" type="text/css" href="css/easyui.css">
    <link rel="stylesheet" type="text/css" href="css/icon.css">
    <link rel="stylesheet" type="text/css" href="css/demo.css">
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="js/jspname.js"></script>
</head>

<body>
<center>
    <div class="easyui-panel" title="密码修改" style="width:250px;padding:10px;">
        <form id="ff" action="/business/changePassword" method="post">
            <table>
                <tr>
                    <td>原密码:</td>
                    <td><input name="oldPassword" type="text"></input></td>
                </tr>
                <tr>
                    <td>新密码:</td>
                    <td><input name="newPassword" type="password"></input></td>
                </tr>
                <tr>
                    <td>确认密码:</td>
                    <td><input name="confirmPassword" type="password"></input></td>
                </tr>
            </table>
            <div style="text-align:center;padding:5px">
                <input type="submit" value="确认修改"/>
                <!--  <a href="javascript:void(0)" class="easyui-linkbutton" onclick="">确认修改</a> -->
                <a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()">取消</a>
            </div>
        </form>

    </div>
</center>
</body>
<script>
    function clearForm() {
        $('#ff').form('clear');
    }
</script>
</html>
