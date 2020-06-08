<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
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
        
        //点击结账按钮
	var url;
	function Checkout(){
		var selectedRows=$("#dg").datagrid('getSelections');
		 if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要结账的数据！");
			return;
		}
		
		var row=selectedRows[0];
		$("#Pay").dialog("open").dialog("setTitle","结账缴费");
		
		$("#form").form("load",row);
		//alert(row.ann_id);
		url="AdministratorsServlet?op=AddPayment&cha_id"+row.cha_id;
	} 
		//点击保存按钮
	 function saveann(){
		$("#form").form("submit",{
			url:url,
			onSubmit:function(){
				return $(this).form("validate");
			},
			success:function(result){
				if(result.errorMsg){
					$.messager.alert("系统提示",result.errorMsg);
					return;
				}else{
					$.messager.alert("系统提示","缴费成功");
					$("#dg").datagrid("reload");
					$("#Pay").dialog("close");
					$("#addPay").val("");
					$("#cha_balance").val("");
					
				}
			}
		});
	} 
	
	 //点击修改按钮
	var url;
	function CostModification(){
		var selectedRows=$("#dg").datagrid('getSelections');
		 if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要修改的数据！");
			return;
		}
		
		var row=selectedRows[0];
		$("#update").dialog("open").dialog("setTitle","修改费用");
		
		$("#fm").form("load",row);
		//alert(row.ann_id);
		url="AdministratorsServlet?op=UpdatePayInfo&cha_id"+row.cha_id;
	} 
		//点击修改按钮
	 function Preservation(){
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
					$("#update").dialog("close");
					$("#addPay").val("");
					$("#cha_balance").val("");
					
				}
			}
		});
	} 
	//关闭按钮
 	function close(){
		$("#update").dialog("close");
		resetValue();
	} 
		//关闭按钮
 	function guanbi(){
		$("#Pay").dialog("close");
		resetValue();
	} 
	
	//点击删除按钮
	 function deletePay(){
		var selectedRows=$("#dg").datagrid('getSelections');		
		if(selectedRows.length==0){
			$.messager.alert("系统提示","请选择要删除的数据！");			
			return;
		}
		var strIds=[];
		for(var i=0;i<selectedRows.length;i++){
			strIds.push(selectedRows[i].cha_id);
		}
		var ids=strIds.join(",");
		$.messager.confirm("系统提示","您确认要删掉这<font color=red>"+selectedRows.length+"</font>条数据吗？",function(r){
			if(r){
				$.post("AdministratorsServlet?op=deletePayHouse",{delIds:ids},function(result){
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
	//多条件查询
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
	//查询全部
	function queryAll()
	{
		$("#dg").datagrid("load",{
    	 	url:"AdministratorsServlet?op=SelectRepairInfo"
    	 });
    	 
	}
</script>
</head>
<body>
<center>
	<div id="chatb">
			<div>
				<a href="javascript:Checkout()" class="easyui-linkbutton" iconCls="icon-ok" plain="true">缴费</a>	
				<a href="javascript:CostModification()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
				<a href="javascript:deletePay()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
			</div>
		</div>

	<div style="margin-top:-5px">楼宇：
		<input class="easyui-validatebox" type="text" name="louyu"
			   id="louyu">
				单元：
		<input class="easyui-validatebox" type="text" name="danyuan"
			   id="danyuan">
		房间号:
		<input class="easyui-validatebox" type="text" name="fangjian"
			   id="fangjian">
			<a href="javascript:select()" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="chaxun()">搜索</a>
			<input type="button" value="查询全部" onclick="queryAll()">
			</div>
		<div style="height: 95%;width: 100% padding-top:30px;">	
		<table id="dg" title="编辑住户费用" class="easyui-datagrid" fitColumns="true"
	 	pagination="true" rownumbers="true" url='AdministratorsServlet?op=SelectUserCost' fit="true" toolbar="#chatb">
			<thead>
				<tr>
					<th field="cb" checkbox="true"></th>
					<th data-options="field:'cha_id',width:85,align:'center'">收费编号</th>
					<th data-options="field:'bui_name',width:85,align:'center'">楼宇名称</th>
					<th data-options="field:'ins_name',width:85,align:'center'">单元名称</th>
					<th data-options="field:'room_number',width:85,align:'center'">房间号</th>
					<th data-options="field:'res_id',width:85,align:'center'">住户编号</th>
					<th data-options="field:'cha_type_name',width:85,align:'center'">收费名称</th>
					<th data-options="field:'cha_type_standard',width:85,align:'center'">收费标准</th>
					<th data-options="field:'cha_number',width:85,align:'center'">数量</th>
					<th data-options="field:'cha_price',width:85,align:'center'">应付金额</th>
					<th data-options="field:'cha_balance',width:85,align:'center'">余额</th>
					<th data-options="field:'cha_begin_date',width:85,align:'center'">收费时间</th>
					<th data-options="field:'cha_head',width:85,align:'center'">经手人</th>
					<th data-options="field:'status',width:85,align:'center'">是否已缴费</th>
				</tr>
			</thead>
		</table>
	</div>
		<!-- 结账缴费 -->
		<div id="Pay" class="easyui-dialog" style="width: 300px;height:180px;padding: 10px 20px"
		closed="true" buttons="#dlg-buttons">
		<form id="form" method="post">
			<table cellspacing="5px;">
			<tr><td><input type="hidden"  name="cha_id" id="cha_id" class="easyui-validatebox" required="true"/></td></tr>
				 <tr>
				<td style="width:150px">缴费金额:</td>
				<td><input type="text" name="addPay" id="addPay" class="easyui-validatebox" required="true"/></td>
				</tr>
				<tr>
				<td style="width:150px">当前余额:</td>
				<td><input type="text" name="cha_balance" id="cha_balance" class="easyui-validatebox" required="true"/></td>
				</tr>
			</table>
		</form>
	</div>
	<!-- 结账缴费结束 -->
	<!-- 修改 -->
	<div id="update" class="easyui-dialog" style="width: 300px;height:400px;padding: 10px 20px"
		closed="true" buttons="#dlg-buttons">
		<form id="fm" method="post">
			<table cellspacing="5px;">
			<tr><td><input type="hidden"  name="cha_id" id="cha_id" class="easyui-validatebox" required="true"/></td></tr>
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
				<td style="width:150px">收费名称:</td>
				<td><input type="text" name="cha_type_name" id="cha_type_name" class="easyui-validatebox" required="true"/></td>
				</tr>
				<tr>
				<td style="width:150px">收费标准:</td>
				<td><input type="text" name="cha_type_standard" id="cha_type_standard" class="easyui-validatebox" required="true"/></td>
				</tr>
				<tr>
				<td style="width:150px">数量:</td>
				<td><input type="text" name="cha_number" id="cha_number" class="easyui-validatebox" required="true"/></td>
				</tr>
				<tr>
				<td style="width:150px">应付金额:</td>
				<td><input type="text" name="cha_price" id="cha_price" class="easyui-validatebox" required="true"/></td>
				</tr>
				<tr>
				<td style="width:150px">当前余额:</td>
				<td><input type="text" name="cha_balance" id="cha_balance" class="easyui-validatebox" required="true"/></td>
				</tr>
				<tr>
				<td style="width:150px">缴费时间:</td>
				<td><input type="text" name="cha_begin_date" id="cha_begin_date" class="easyui-validatebox" required="true"/></td>
				</tr>
				<tr>
				<td style="width:150px">经手人:</td>
				<td><input type="text" name="cha_head" id="cha_head" class="easyui-validatebox" required="true"/></td>
				</tr>
			</table>
		</form>
	</div>
	<!-- 修改结束 -->
	<!-- 结账功能的保存和关闭 -->
	<div id="dlg-buttons">
		<a href="javascript:saveann()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
		<a href="javascript:guanbi()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
	<!-- 修改功能的保存和关闭 -->
	<div id="dlg-buttons">
		<a href="javascript:Preservation()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
		<a href="javascript:close()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
</center>
</body>
</html>
