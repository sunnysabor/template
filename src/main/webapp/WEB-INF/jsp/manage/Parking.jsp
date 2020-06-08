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

<title>My JSP 'HouseholdRepair.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<!-- <link rel="stylesheet" type="text/css" href="css/easyui.css">
<link rel="stylesheet" type="text/css" href="css/icon.css">
<link rel="stylesheet" type="text/css" href="css/demo.css">
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/jquery.easyui.min.js"></script> -->

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
		xmlhttp.open("post", "AdministratorsServlet?op=selectoptionsforlouyu"+"&ts="+new Date().getTime().toString(), true); //servlet 对应相应的 servlet url
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
		
		//楼宇的select控件的值更改时，同时查询对应的单元
		 function changeSelect(louyu)
		{
			createXMLHttp();//&buildingName="+combox.value
		    xmlhttp.open("post","AdministratorsServlet?op=danyuanSelect&louyu="+louyu.value+"&ts="+new Date().getTime().toString(),true); //servlet 对应相应的 servlet url
		    xmlhttp.send(null);     //发送数据
		    xmlhttp.onreadystatechange=change2;
		}
		function change2(){   
	    if(xmlhttp.readyState==4){
	        if(xmlhttp.status==200){
	        	var strs= new Array(); //定义一数组
	           var value= xmlhttp.responseText;    //字符串方式返回（与Servlet中对应）
	           if(typeof value == 'string')
	           {
	           		strs = value.split(",");
	           		danyuan.length=0;
	           		for(var i=0;i<strs.length-1;i++)
	           		{
	           			danyuan.options.add(new Option(strs[i])); 
	           		}
	           }
	           else
	           {
	           		alert("无法获取单元信息");
	           }
	        }
	        }
        }
        
        
    //获取数据--多条件查询
	/* function select(){	
		$('#dg').datagrid('load',{	
			 louyu:$('#fangjian').val(),
			danyuan:$('#danyuan').val(),
			fangjian:$('#danyuan').val(),
		 });
	} */
	function chaxun()
	{
		//取文本框的内容
		 var build_no = $("#build_no").val();
		 var danyuan = $("#danyuan").val();
		 var car_no = $("#car_no").val();
    	 $("#dg").datagrid("load",{
             build_no:build_no,
             room_no:room_no,
             car_no:car_no
    	 });
	}
	function queryAll()
	{
		$("#dg").datagrid("load",{
    	 	url:"ParkingServlet?op=queryParking"
    	 });
    	 
	}
     </script>
</head>

<body>
	<center>
		<div id="chatb">

		</div>
				<div style="margin-top:-5px">楼号：
					<input class="easyui-validatebox" type="text" name="build_no"
						   id="build_no">
					房号:
				<input type="text" name="room_no" id="room_no"></input>
					车牌号:
					<input type="text" name="car_no" id="car_no"></input>
			<a href="javascript:select()" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="chaxun()">搜索</a>
			<input type="button" value="查询全部" onclick="queryAll()">
			</div>
		<div style="height:96%;width: 100% padding-top:30px;">	
		<table id="dg" title="车位信息" class="easyui-datagrid" fitColumns="true"
	 	pagination="true" rownumbers="true" url='ParkingServlet?op=queryParking' fit="true" toolbar="#chatb">
			<thead>
				<tr>
					<th field="cb" checkbox="true"></th>
					<th data-options="field:'id',width:60,align:'center'">停车位编号</th>
					<th data-options="field:'build_no',width:60,align:'center'">楼号</th>
					<th data-options="field:'room_no',width:60,align:'center'">房号</th>
					<th data-options="field:'car_no',width:60,align:'center'">车牌号</th>
					<th data-options="field:'fee',width:60,align:'center'">费用</th>
				</tr>
			</thead>
		</table>
	</div>
	</center>
</body>
</html>
