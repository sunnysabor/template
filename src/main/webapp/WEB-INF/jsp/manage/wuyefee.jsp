<%@ page language="java" pageEncoding="utf-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">

    <title>编辑住户费用</title>
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

        //多条件查询
        function chaxun() {
            var year = $("#year").val() == "" ? 0 : $("#year").val();
            var month = $("#month").val() == "" ? 0 : $("#month").val();
            $.ajax({
                /* async : false,
                cache : false, */
                type: "POST",
                url: "ParkingServlet?op=queryChargCount&res_id=0&year=" + year + "&month=" + month + "",
                dataType: 'json',
                error: function (data) {
                    alert(data);
                },
                success: function (data) {
                    $("#finishCount").html(data.finishCount);
                    $("#notCount").html(data.notCount);
                }
            });
        }
    </script>
</head>
<body>
<center>
    <div style="margin-top:-5px">年份：
        <input class="easyui-validatebox" type="text" name="year"
               id="year">
        月份：
        <input class="easyui-validatebox" type="text" name="month"
               id="month">
        <input type="button" value="查询" onclick="chaxun()">
    </div>
    <div>
        <div style="box-shadow: 0 0 0 10px #f80, 0 0 0 20px #8f0, 0 0 0 30px #ff0, 0 0 0 40px #08f;width: 100px;border-radius: 50%!important;height: 100px;margin-top: 60px;line-height: 50px;
">
            应交物业费：<span id="finishCount"></span>
        </div>
        <div style="box-shadow: 0 0 0 10px #f80, 0 0 0 20px #8f0, 0 0 0 30px #ff0, 0 0 0 40px #08f;width: 100px;border-radius: 50%!important;height: 100px;margin-top: 90px;line-height: 50px;
">
            未交物业费：<span id="notCount"></span>
        </div>
    </div>

</center>
</body>
</html>
