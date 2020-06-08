<%@page import="java.text.SimpleDateFormat" %>
<%@page import="com.taobao.chenbao.template.entity.Teacher" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">

    <title>教师主页面</title>

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
    <style type="text/css">
        #result {
            color: red;
            margin-top: 5px;
        }
    </style>
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="js/jspname.js"></script>
    <script type="text/javascript">
        $(function () {
            start();
            //欢迎
            setTimeout(function () {
                $("#welcome").fadeIn(1500);
            }, 1000);
            //6秒之后
            setTimeout(function () {
                $("#welcome").fadeOut(2000);
            }, 4000);
            // 数据
            var treeData = [
                {

                    text: "教师信息",
                    children: [{
                        text: "基本信息",
                        attributes: {
                            url: "/business/teacherinfo"
                        }
                    }, {
                        text: "志愿信息",
                        attributes: {
                            url: "/business/studentcourses"
                        },

                    }],

                },
                {

                    text: "我的信息",
                    children: [{
                        text: "修改密码",
                        attributes: {
                            url: "/business/changepwd"
                        }
                    }, {
                        text: "我的详细信息",
                        attributes: {
                            url: "jsp/user/Myinfo.jsp"
                        }
                    }],

                }];

            // 实例化树菜单
            $("#tree").tree({
                data: treeData,
                lines: true,
                onClick: function (node) {
                    if (node.attributes) {
                        openTab(node.text, node.attributes.url);
                    }
                }
            });

            // 新增Tab
            function openTab(text, url) {
                if ($("#tabs").tabs('exists', text)) {
                    $("#tabs").tabs('select', text);
                } else {
                    var content = "<iframe frameborder='0' scrolling='auto' style='width:100%;height:100%' src="
                        + url + "></iframe>";
                    $("#tabs").tabs('add', {
                        title: text,
                        closable: true,
                        content: content
                    });
                }

                //获取最后一个tabs 在新加的选项卡后面添加"关闭全部"
                var li = $(".tabs-wrap ul li:last-child");
                $("#close").remove();
                li
                    .after("<li id='close'><a class='tabs-inner' href='javascript:void()' onClick='javascript:closeAll()'>关闭全部</a></li>");

            }

        });


        //退出
        function ask(str) {

            return window.confirm(str) ? true : false;
        }

        //退出系统
        function logout() {
            var reult = ask("是否要退出系统?");
            if (reult) {
                window.location.href = "/business/logout";
            }

        }

        //关闭所有标签
        function closeAll() {

            var reult = ask("是否关闭所有标签?");
            if (reult) {
                $(".tabs li").each(function (index, obj) {
                    //获取所有可关闭的选项卡
                    var tab = $(".tabs-closable", this).text();
                    $(".easyui-tabs").tabs("close", tab);
                });
                $("#close").remove();//同时把此按钮关闭
            }
        }

        //收缩所有树
        function collapseAll() {
            $('#tree').tree('collapseAll');
        }

        //展开所有
        function expandAll() {
            $('#tree').tree('expandAll');
        }


        //在网页上输出：今天的日期、星期、现在的时间（动态时钟）
        function start() {
            var today = new Date();
            var year = today.getFullYear();
            var month = today.getMonth() + 1;
            var day = today.getDate();
            var hours = today.getHours();
            var minutes = today.getMinutes();
            var seconds = today.getSeconds();
            //如果是单位数字，前面补0
            month = month < 10 ? "0" + month : month;
            day = day < 10 ? "0" + day : day;
            hours = hours < 10 ? "0" + hours : hours;
            minutes = minutes < 10 ? "0" + minutes : minutes;
            seconds = seconds < 10 ? "0" + seconds : seconds;
            //时间信息连成字符串
            var str = year + "年" + month + "月" + day + "日 " + hours + ":" + minutes + ":" + seconds;
            //获取id=result的内容
            var obj = document.getElementById("result");
            obj.innerHTML = str;
            //延时器
            window.setTimeout("start()", 1000);
        }
    </script>

</head>

<body class="easyui-layout">
<%
    //非法登录

    Teacher str = (Teacher) request.getSession().getAttribute(
            "userinfo");
    if (str == null) {
        request.setAttribute("error", "请你登录!");
        request.getRequestDispatcher("login.jsp").forward(request,
                response);
        return;
    }
%>
<div region="north" style="height: 80px;background-color: #E0EDFF">
    <div align="left" style="width: 80%;float: left;font-size: 30px;margin-left: 40px;">
        选课系统
    </div>


    <div
            id="tips" style="padding-top: 20px; padding-right: 20px;float:right;margin-right: 50px;font-size: 13px;">
        当前用户：&nbsp;<font color="#CD0000" style="font-size: 15px">${userinfo.name }老师</font>
        <div id="result">
        </div>
    </div>


</div>
<div region="center">
    <div class="easyui-tabs" fit="true" border="false" id="tabs">
        <div title="首页">
            <!-- <div align="center" style="padding-top: 100px;"><font color="red" size="10">欢迎使用</font></div> -->
            <p id="welcome"
               style="color: red; display:none;font-size: 50px; text-align: center">亲爱的:${userinfo.name
                    }欢迎使用!</p>
        </div>
    </div>

</div>
<div region="west" style="width: 150px;" title="导航菜单" split="true">

    <a onclick="expandAll()" class="easyui-linkbutton">展开</a> <a
        onclick="collapseAll()" class="easyui-linkbutton">收缩</a>
    <ul id="tree" data-options=" animate:true, lines:true"></ul>
    <!-- <button style="width:100%;height:30px;margin-top:50px" onclick="logout()">退出系统</button> -->
    <a onclick="logout()" class="easyui-linkbutton">安全退出系统</a>
</div>
<div region="south" style="height: 25px;" align="center">
    版权所有<a href="student.jsp">@琛宝软件工作室</a>
</div>
</body>
</html>
