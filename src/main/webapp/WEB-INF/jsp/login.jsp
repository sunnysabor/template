<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">

    <title>学生选导师系统</title>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <link href="css/main.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="js/jQuery.js"></script>
    <script type="text/javascript" src="js/fun.base.js"></script>
    <script type="text/javascript" src="js/script.js"></script>
    <link rel="stylesheet" type="text/css" href="jquery-easyui-1.3.3/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="jquery-easyui-1.3.3/themes/icon.css">
    <script type="text/javascript" src="jquery-easyui-1.3.3/jquery.min.js"></script>
    <script type="text/javascript" src="jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript">
        function resetValue() {
            //	alert(1);
            document.getElementById("account").value = "";
            document.getElementById("password").value = "";
        }

        function changeimg() {

            var imgobj = Document().getElementById("img");
            //imgobj.src="/check"+Math.random();
            imgobj.src = "/check";
        }

    </script>


    <style type="text/css">
        .tip {
            margin-top: 35px;
            /* border: 1px solid red; */
            text-align: center;
            margin-left: 35px;
        }

        #shenfen {
            margin-top: -20px;
            /* border: 1px solid red;  */
            text-align: center;
        }
    </style>
</head>
<body>

<form action="/login" method="get">
    <div class="login">
        <div class="box png">
            <div class="logo png">智慧社区</div>
            <div class="input">

                <div class="log">
                    <p id="shenfen"><span><input type="radio" name="role" checked="" value="student">学生</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span><input type="radio" name="role"
                                                                                     value="teacher">老师</span>
                        <span><input type="radio" name="role" value="userAdmin">管理员</span>
                    </p>
                    &nbsp;
                    <!-- <p id="wz">小区物业管理系统</p> -->
                    <div class="name">
                        <label>用户名</label><input type="text" class="text" value="${ming}" placeholder="用户名"
                                                 value="${Account }" name="username" id="account" tabindex="1">
                    </div>
                    <div class="pwd">
                        <label>密　码</label><input type="password" class="text" value="${mima}" name="password"
                                                 id="password" placeholder="密码" tabindex="2">
                    </div>
                    <div>
                        <label>验证码</label><input type="text" style="width: 70px;" class="text" value="" name="inputstr"
                                                 id="inputstr" placeholder="" tabindex="3">
                        <label><img src="/check" id="img"></label>
                        <button class="easyui-linkbutton" onclick="changeimg()">换一张</button>
                        <input type="submit" class="submit" tabindex="4" id="dl" value="登录"><span><input type="button"
                                                                                                         class="submit"
                                                                                                         onclick="resetValue()"
                                                                                                         tabindex="5"
                                                                                                         id="reset"
                                                                                                         value="重置"></span>
                        <div class="check"></div>
                    </div>
                    <div class="tip">
                        <font color="red" style="font-size: 15px;">${error }</font>
                    </div>
                </div>
            </div>
        </div>
        <div class="footer"></div>
    </div>


</form>

<!--[if IE 6]>
<script src="js/DD_belatedPNG.js" type="text/javascript"></script>
<script>DD_belatedPNG.fix('.png')</script>
<![endif]-->

</body>
</html>
