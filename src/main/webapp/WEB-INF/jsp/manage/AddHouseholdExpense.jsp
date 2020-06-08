<%@ page language="java" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">

    <title>My JSP 'tianjiazhuhushoufeixinxi.jsp' starting page</title>

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
    <link rel="stylesheet" type="text/css" href="../../../../resources/static/jquery-easyui-1.3.3/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="../../../../resources/static/jquery-easyui-1.3.3/themes/icon.css">
    <script type="text/javascript" src="../../../../resources/static/jquery-easyui-1.3.3/jquery.min.js"></script>
    <script type="text/javascript" src="../../../../resources/static/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../../../../resources/static/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript">
        function myformatter(date) {
            var y = date.getFullYear();
            var m = date.getMonth() + 1;
            var d = date.getDate();
            return y + '/' + (m < 10 ? ('0' + m) : m) + '/' + (d < 10 ? ('0' + d) : d);
        }

        function myparser(s) {
            if (!s) return new Date();
            var ss = (s.split('/'));
            var y = parseInt(ss[0], 10);
            var m = parseInt(ss[1], 10);
            var d = parseInt(ss[2], 10);
            if (!isNaN(y) && !isNaN(m) && !isNaN(d)) {
                return new Date(y, m - 1, d);
            } else {
                return new Date();
            }
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

        //窗体加载时为楼宇下拉列表框中读取数据库数据
        window.onload = function () {
            createXMLHttp();
            xmlhttp.open("post", "AdministratorsServlet?op=selectoptionsforlouyu" + "&ts=" + new Date().getTime().toString(), true); //servlet 对应相应的 servlet url
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
                        for (var i = 0; i < strs.length - 1; i++) {
                            //$("#combox").options.add(new Option(strs[i]));
                            $("#louyu").append("<option>" + strs[i] + "</option>");
                        }
                    } else {
                        alert("无法获取区域信息");
                    }
                }
            }
        }

        /* //窗体加载时为收费名称下拉列表框中填充数据
       window.onload = function() {
           createXMLHttp();
           xmlhttp.open("post", "AdministratorsServlet?op=selectoptionsforCharge"+"&ts="+new Date().getTime().toString(), true); //servlet 对应相应的 servlet url
           xmlhttp.send(null); //发送数据
           xmlhttp.onreadystatechange = change4; //回调函数;显示服务器返回的数据的函数
       };
       function change4() {
           if (xmlhttp.readyState == 4) {
               if (xmlhttp.status == 200) {
                   var strs = new Array(); //定义一数组
                   var value = xmlhttp.responseText; //字符串方式返回（与Servlet中对应）
                   if (typeof value == 'string') {
                       strs = value.split(",");
                       for (var i = 0; i < strs.length - 1; i++) {
                           //$("#combox").options.add(new Option(strs[i]));
                           $("#shoufei").append("<option>" + strs[i] + "</option>");
                       }
                   } else {
                       alert("无法获取区域信息");
                   }
               }
           }
           } */

        //楼宇的select控件的值更改时，同时查询对应的单元
        function changeSelect(louyu) {
            createXMLHttp();//&buildingName="+combox.value
            xmlhttp.open("post", "AdministratorsServlet?op=danyuanSelect&louyu=" + louyu.value + "&ts=" + new Date().getTime().toString(), true); //servlet 对应相应的 servlet url
            xmlhttp.send(null);     //发送数据
            xmlhttp.onreadystatechange = change2;
        }

        function change2() {
            if (xmlhttp.readyState == 4) {
                if (xmlhttp.status == 200) {
                    var strs = new Array(); //定义一数组
                    var value = xmlhttp.responseText;    //字符串方式返回（与Servlet中对应）
                    if (typeof value == 'string') {
                        strs = value.split(",");
                        danyuan.length = 0;
                        for (var i = 0; i < strs.length - 1; i++) {
                            danyuan.options.add(new Option(strs[i]));
                        }
                    }
                    else {
                        alert("无法获取单元信息");
                    }
                }
            }
        }


        //单元的select控件的值更改时，同时查询对应的房间号
        function changeSelectfj(danyuan) {
            createXMLHttp();//&buildingName="+combox.value
            xmlhttp.open("post", "AdministratorsServlet?op=fangjianSelect&danyuan=" + danyuan.value + "&ts=" + new Date().getTime().toString(), true); //servlet 对应相应的 servlet url
            xmlhttp.send(null);     //发送数据
            xmlhttp.onreadystatechange = change3;
        }

        function change3() {
            if (xmlhttp.readyState == 4) {
                if (xmlhttp.status == 200) {
                    var strs = new Array(); //定义一数组
                    var value = xmlhttp.responseText;    //字符串方式返回（与Servlet中对应）
                    if (typeof value == 'string') {
                        strs = value.split(",");
                        fangjian.length = 0;
                        for (var i = 0; i < strs.length - 1; i++) {
                            fangjian.options.add(new Option(strs[i]));
                        }
                    }
                    else {
                        alert("无法获取单元信息");
                    }
                }
            }
        }

        /* function addHouseholdCharge()
        {	
        	alert($("#louyu option:selected").val());
        	alert($("#louyu").val());
        	louyu:$("#danyuan option:selected").val();
        	fangjian:$("#fangjian option:selected").val();
        	shoufei:$("#shoufei option:selected").val();	
        	zhuhuID:$("#zhuhuID").val();	
        	number:$("#number").val();
        	biaozhun:$("#biaozhun").val();
        	yingfu:$("#yingfu").val();
        	yue:$("#yue").val();
        	rep_date:$("#rep_date").val();
        	jingshou:$("#jingshou").val();
        	alert($("#jingshou").val());
        	window.location.href="AdministratorsServlet?op=addHouseholdCharge";
        } */
        /* function add()
        {
            window.location.href="AdministratorsServlet?op=addHouseholdCharge";
        } */
    </script>
</head>
<%
    Object message = request.getAttribute("message");
    if (message != null && !"".equals(message)) {%>
<script type="text/javascript">
    alert("<%=message%>");
</script>
<%
    }
%>
<body>
<center>
    <form action="AdministratorsServlet?op=addHouseholdCharge" method="post">
        <table>
            <tr>
                <td>收费名称:</td>
                <td><select id="shoufei" name="shoufei">
                    <option>物业费</option>
                    <option>停车费</option>
                </select></td>
            </tr>
            <tr>
                <td>楼宇名称：</td>
                <td><input class="easyui-validatebox" type="text" name="louyu" id="louyu"></td>
            </tr>
            <tr>
                <td>单元：</td>
                <td><input class="easyui-validatebox" type="text" name="danyuan"
                           id="danyuan"></td>
            </tr>
            <tr>
                <td>房间号:</td>
                <td><input class="easyui-validatebox" type="text" name="fangjian"
                           id="fangjian"></td>
            </tr>
            <tr>
                <td>住户编号:</td>
                <td><input name="zhuhuID" type="text" id="zhuhuID"/></td>
            </tr>
            <tr>
                <td>数量:</td>
                <td><input name="number" type="text" id="number"/></td>
            </tr>
            <tr>
                <td>收费标准:</td>
                <td><input name="biaozhun" type="text" id="biaozhun"/></td>
            </tr>
            <tr>
                <td>应付金额:</td>
                <td><input name="yingfu" type="text" id="yingfu"/></td>
            </tr>
            <tr>
                <td>余额:</td>
                <td><input name="yue" type="text" id="yue"/></td>
            </tr>
            <tr>
                <td>开始收费时间:</td><!-- required="true" -->
                <td><input class="easyui-datebox" name="rep_date" id="rep_date" editable="false"></input></td>
            </tr>
            <tr>
                <td>经手人:</td>
                <td><input name="jingshou" type="text" id="jingshou"></input></td>
            </tr>
            <tr>
                <td><input type="submit" value="添加" style="margin-top:30px"></td>
            </tr>
        </table>
    </form>
</center>
</body>
</html>
