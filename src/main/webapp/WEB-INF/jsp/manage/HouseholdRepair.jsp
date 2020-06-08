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
		 var louyu = $("#louyu").val();
		 var danyuan = $("#danyuan").val();
		 var fangjian = $("#fangjian").val();
    	 $("#dg").datagrid("load",{
    	 	louyu:louyu,
    	 	danyuan:danyuan,
    	 	fangjian:fangjian
    	 });
	}
	function queryAll()
	{
		$("#dg").datagrid("load",{
    	 	url:"AdministratorsServlet?op=SelectRepairInfo"
    	 });
    	 
	}
	
	//点击修改按钮
	var url;
	function modifyRepair(){
		var selectedRows=$("#dg").datagrid('getSelections');
		 if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要编辑的数据！");
			return;
		}
		var row=selectedRows[0];
		$("#modify").dialog("open").dialog("setTitle","修改住户报修信息");
		$("#fm").form("load",row);
		//alert(row.ann_id);
		url="AdministratorsServlet?op=modifyUserRepair&rep_id"+row.rep_id;
	} 
		//点击保存按钮
	 function saveann(){
		$("#fm").form("submit",{
			url:url,
			onSubmit:function(){
				return $(this).form("validate");
			},
			success:function(result){
				if(result.errorMsg){
					$.messager.alert("系统提示",result.errorMsg);
					return;
				}else{
					$.messager.alert("系统提示","修改成功");
					$("#dg").datagrid("reload");
					$("#modify").dialog("close");
					$("#bui_name").val("");
					$("#ins_name").val("");
					$("#room_number").val("");
					$("#rep_id").val("");
					$("#rep_title").val("");
					$("#rep_date").val("");
					$("#state_name").val("");
					
				}
			}
		});
	} 
		//保存关闭按钮
 	function guanbi(){
		$("#modify").dialog("close");
		resetValue();
	} 
	
	//点击删除按钮
	 function deleteRepair(){
		var selectedRows=$("#dg").datagrid('getSelections');		
		if(selectedRows.length==0){
			$.messager.alert("系统提示","请选择要删除的数据！");			
			return;
		}
		var strIds=[];
		for(var i=0;i<selectedRows.length;i++){
			strIds.push(selectedRows[i].rep_id);
		}
		var ids=strIds.join(",");
		$.messager.confirm("系统提示","您确认要删掉这<font color=red>"+selectedRows.length+"</font>条数据吗？",function(r){
			if(r){
				$.post("AdministratorsServlet?op=deleteUserRepair",{delIds:ids},function(result){
					if(result.success){
						$.messager.alert("系统提示","您已成功删除<font color=red>"+result.delNums+"</font>条数据！");
						$("#dg").datagrid("reload");
					}else{
						$.messager.alert('系统提示',result.errorMsg);
					}
				},"json");
			}
		});
	} 
	
     </script>
</head>

<body>
	<center>
		<div id="chatb">
			<div>
				<!-- <a href="javascript:HandleRepair()" class="easyui-linkbutton" iconCls="icon-ok" plain="true">通过</a>		 -->
				<a href="javascript:modifyRepair()" class="easyui-linkbutton" iconCls="icon-edit" plain="true"  >修改</a>
				<a href="javascript:deleteRepair()" class="easyui-linkbutton" iconCls="icon-remove" plain="true"  >删除</a>
			</div>
		</div>
				<div style="margin-top:-5px">楼宇：
					<input class="easyui-validatebox" type="text" name="louyu"
						   id="louyu"></input>
				</select>
				单元：
					<input class="easyui-validatebox" type="text" name="danyuan"
						   id="danyuan"></input>
				房间号:
				<input type="text" name="fangjian" id="fangjian"></input>

			<a href="javascript:select()" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="chaxun()">搜索</a>
			<input type="button" value="查询全部" onclick="queryAll()">
			</div>
		<div style="height:96%;width: 100% padding-top:30px;">	
		<table id="dg" title="我的报修" class="easyui-datagrid" fitColumns="true"
	 	pagination="true" rownumbers="true" url='AdministratorsServlet?op=SelectRepairInfo' fit="true" toolbar="#chatb">
			<thead>
				<tr>
					<th field="cb" checkbox="true"></th>
					<th data-options="field:'rep_id',width:60,align:'center'">报修编号</th>
					<th data-options="field:'bui_name',width:60,align:'center'">楼宇名称</th>
					<th data-options="field:'ins_name',width:60,align:'center'">单元名称</th>
					<th data-options="field:'room_number',width:60,align:'center'">房间号</th>
					<th data-options="field:'res_id',width:60,align:'center'">住户编号</th>
					<th data-options="field:'rep_title',width:60,align:'center'">报修内容</th>
					<th data-options="field:'rep_date',width:60,align:'center'">报修日期</th>
					<th data-options="field:'state_name',width:60,align:'center'">是否审核</th>
				</tr>
			</thead>
		</table>
	</div>
	<div id="modify" class="easyui-dialog" style="width: 300px;height: 330px;padding: 10px 20px"
		closed="true" buttons="#dlg-buttons">
		<form id="fm" method="post">
			<table cellspacing="5px;">
			<tr><td><input type="hidden"  name="rep_id" id="rep_id" class="easyui-validatebox" required="true"/></td></tr>
				<tr>
				<tr>
				<td style="width:150px">楼宇名称:</td>
				<td><input type="text" name="bui_name" id="bui_name" class="easyui-validatebox" required="true"/></td>
				</tr>
				<tr>
				<td style="width:150px">单元名称:</td>
				<td><input type="text" name="ins_name" id="ins_name" class="easyui-validatebox" required="true"/></td>
				</tr>
				<tr>
				<td style="width:150px">房间号:</td>
				<td><input type="text" name="room_number" id="room_number" class="easyui-validatebox" required="true"/></td>
				</tr>
				<tr>
				<td style="width:150px">住户编号:</td>
				<td><input type="text" name="res_id" id="res_id" class="easyui-validatebox" required="true"/></td>
				</tr>
				<tr>
				<td style="width:150px">报修内容：</td>
					<td><input type="text" name="rep_title" id="rep_title" class="easyui-validatebox" required="true"/></td>
				</tr>
				<tr>
				<td style="width:150px">报修日期：</td>
					<td><input type="text" name="rep_date" id="rep_date" class="easyui-validatebox" required="true"/></td>
				</tr>
				<tr>
				<td style="width:150px">审核状态：</td>
					<td><input type="text" name="state_name" id="state_name" class="easyui-validatebox" required="true"/></td>
				</tr>
			</table>
		</form>
	</div>
	<!--信息添加结束 -->
	<div id="dlg-buttons">
		<a href="javascript:saveann()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
		<a href="javascript:guanbi()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
	</center>
</body>
</html>
