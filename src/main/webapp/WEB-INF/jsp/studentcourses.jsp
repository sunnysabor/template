<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
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
    <link rel="stylesheet" type="text/css" href="jquery-easyui-1.3.3/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="jquery-easyui-1.3.3/themes/icon.css">
    <script type="text/javascript" src="jquery-easyui-1.3.3/jquery.min.js"></script>
    <script type="text/javascript" src="jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
    <style type="text/css">
        table td {
            text-align: center;
            width: 150px;
        }

        table tr {
            height: 30px;
        }
    </style>
</head>

<body>
<center>
    <table>

        <tr>
            <td>学生姓名：</td>
            <td>${studentcourses.student_name }</td>
            <td>老师姓名：</td>
            <td>${studentcourses.teacher_name }</td>
        </tr>
        <tr>
            <td>志愿等级：</td>
            <td>${studentcourses.level }</td>
            <td>专业：</td>
            <td>${studentcourses.major }</td>
        </tr>
    </table>
</center>
</body>


</html>
