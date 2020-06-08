<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
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

<title>My JSP 'EditHouseholdInfo.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<link rel="stylesheet" type="text/css"
	href="../../../../resources/static/jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"
	href="../../../../resources/static/jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript" src="../../../../resources/static/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript"
	src="../../../../resources/static/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="../../../../resources/static/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>

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
		xmlhttp.open("post", "houseServlet?op=selectoptionsforlouyu" + "&ts="
				+ new Date().getTime().toString(), true); //servlet 对应相应的 servlet url
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
					for ( var i = 0; i < strs.length - 1; i++) {
						//$("#combox").options.add(new Option(strs[i])); 
						$("#louyu").append("<option>" + strs[i] + "</option>");
					}
				} else {
					alert("无法获取区域信息");
				}
			}
		}
	}

	//区域的select控件的值更改时，同时查询对应的楼栋
	function changeSelect(louyu) {
		createXMLHttp();//&buildingName="+combox.value
		xmlhttp.open("post", "houseServlet?op=danyuanSelect&louyu="
				+ louyu.value + "&ts=" + new Date().getTime().toString(), true); //servlet 对应相应的 servlet url
		xmlhttp.send(null); //发送数据
		xmlhttp.onreadystatechange = change2;
	}
	function change2() {
		if (xmlhttp.readyState == 4) {
			if (xmlhttp.status == 200) {
				var strs = new Array(); //定义一数组
				var value = xmlhttp.responseText; //字符串方式返回（与Servlet中对应）
				if (typeof value == 'string') {
					strs = value.split(",");
					danyuan.length = 0;
					for ( var i = 0; i < strs.length - 1; i++) {
						danyuan.options.add(new Option(strs[i]));
					}
				} else {
					alert("无法获取单元信息");
				}
			}
		}
	}
</script>
<script type="text/javascript">
	var url;
	//获取数据--多条件查询 
	function sousuo() {
		//alert($('#loucheng').val());
		$('#dg').datagrid('load', {

			room_id : $('#loucheng').val(),
		});

	}

	//点击修改按钮
	function xiugaiann() {
		var selectedRows = $("#dg").datagrid('getSelections');
		if (selectedRows.length != 1) {
			$.messager.alert("系统提示", "请选择一条要编辑的数据！");
			return;
		}
		var row = selectedRows[0];
		$("#dlg").dialog("open").dialog("setTitle", "编辑公住户信息");
		$("#fm").form("load", row);
		//alert(row.res_id);
		url = "houseServlet?op=updateres&res_id" + row.res_id;
	}

	//点击保存按钮
	function saveres() {
		$("#fm").form("submit", {
			url : url,
			onSubmit : function() {
				return $(this).form("validate");
			},
			success : function(result) {
				if (result.errorMsg) {
					$.messager.alert("系统提示", result.errorMsg);
					return;
				} else {
					$.messager.alert("系统提示", "保存成功");
					//调用此方法
					resetValue();
					$("#dlg").dialog("close");
					$("#dg").datagrid("reload");
				}
			}
		});
	}

	//保存成功
	function resetValue() {
		$("#res_name").val("");
		$("#res_phone").val("");
		$("#res_address").val("");
		$("#res_mobile_phone").val("");
		$("#res_id_card").val("");
		$("#res_units").val("");
		$("#res_email").val("");
		$("#res_note").val("");
	}

	//保存关闭按钮
	function guanbi() {
		$("#dlg").dialog("close");
		resetValue();
	}

	//点击删除按钮
	function deleteann() {
		var selectedRows = $('#dg').datagrid('getSelections');
		if (selectedRows.length == 0) {
			$.messager.alert("系统提示", "请选择要删除的数据！");
			return;
		}

		var strIds = [];
		for ( var i = 0; i < selectedRows.length; i++) {
			strIds.push(selectedRows[i].res_id);
		}
		var ids = strIds.join(",");
		//alert();
		//var Deleteann=Deleteann;
		$.messager.confirm("系统提示", "您确认要删掉这<font color=red>"
				+ selectedRows.length + "</font>条数据吗？", function(r) {
			if (r) {
				$.post("houseServlet?op=deleteres", {
					delIds : ids
				}, function(result) {
					if (result.success) {
						$.messager.alert("系统提示", "您已成功删除<font color=red>"
								+ result.delNums + "</font>条数据！");
						$("#dg").datagrid("reload");
					} else {
						$.messager.alert('系统提示', result.errorMsg);
					}
				}, "json");
			}
		});
	}

	//导出
	function exportUser() {
		window.location.href = "houseServlet?op=daochu";
		//alert(1);
	}
	//导入
	function importUser() {
		$("#dlg2").dialog('open').dialog('setTitle', '批量导入数据');
	}
	
	function downloadTemplate(){
			window.open('template/userExporTemplate.xls');
		}
		
	function uploadFile() {
		$("#uploadForm").form("submit", {
			success : function(result) {
				var result = eval('(' + result + ')');
				if (result.errorMsg) {
					$.messager.alert("系统提示", result.errorMsg);
				} else {
					$.messager.alert("系统提示", "上传成功");
					$("#dlg2").dialog("close");
					$("#dg").datagrid("reload");
				}
			}
		});
	}
</script>



</head>

<body>
	<!--修改开始  -->
	<div id="dlg" class="easyui-dialog"
		style="width: 570px;height: 450px;padding: 10px 20px" closed="true"
		buttons="#dlg-buttons">
		<form id="fm" method="post">
			<table cellspacing="5px;">
				<tr>
					<td><input type="hidden" name="res_id" id="ann_id"
						class="easyui-validatebox" required="true" />
					</td>
				</tr>
				<tr>
					<td>姓名:</td>
					<td><input type="text" name="res_name" id="res_name"
						class="easyui-validatebox" required="true" />
					</td>
				</tr>
				<tr>
					<td>电话:</td>
					<td><input type="" name="res_phone" id="res_phone"
						class="easyui-numberbox" required
						data-options=" onChange: function(value){$('#vv').text(value);}" />
					</td>
				</tr>
				<tr>
					<td>联系地址:</td>
					<td><input type="text" name="res_address" id="res_address"
						class="easyui-validatebox" required="true" />
					</td>
				</tr>
				<tr>
					<td>手机:</td>
					<td><input name="res_mobile_phone" id="res_mobile_phone"
						class="easyui-numberbox" required
						data-options=" onChange: function(value){$('#vv').text(value);}">
					</td>
				</tr>
				<tr>
				<tr>
					<td>身份证:</td>
					<td><input type="text" name="res_id_card" id="res_id_card"
						class="easyui-validatebox" required="true" />
					</td>
				</tr>
				<tr>
					<td>工作单位:</td>
					<td><input type="text" name="res_units" id="res_units"
						class="easyui-validatebox" required="true" />
					</td>
				</tr>
				<tr>
					<td>电子邮箱:</td>
					<td><input type="text" name="res_email" id="res_email"
						class="easyui-validatebox" required="true" />
					</td>
				</tr>
				<tr>
					<td valign="top">备注信息:</td>
					<td colspan="4"><textarea rows="7" cols="50" name="res_note"
							id="res_note"></textarea>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div id="dlg-buttons">
		<a href="javascript:saveres()" class="easyui-linkbutton"
			iconCls="icon-ok">保存</a> <a href="javascript:guanbi()"
			class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
	<!-- 修改结束 -->
	
	<!-- 查询开始 -->
	<center>
		<div id="cha">
			<!-- <a href="javascript:openStudentAddDialog()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a> -->
			<a href="javascript:xiugaiann()" class="easyui-linkbutton"
				iconCls="icon-edit" plain="true">修改</a> <a
				href="javascript:deleteann()" class="easyui-linkbutton"
				iconCls="icon-remove" plain="true">删除</a>
				 <%--<a--%>
				<%--href="javascript:void(0)" class="easyui-linkbutton"--%>
				<%--iconCls="icon-import" plain="true" onclick="importUser()">导入用户</a>--%>
				 <%--<a--%>
				<%--href="javascript:void(0)" class="easyui-linkbutton"--%>
				<%--iconCls="icon-export" plain="true" onclick="exportUser()">导出用户</a>--%>
			<div>
				房间号: <input class="easyui-validatebox" type="text" name="loucheng"
					id="loucheng"></input> <a href="javascript:sousuo()"
					class="easyui-linkbutton" iconCls="icon-search" plain="true"
					name="fanghao" id="fanghao">搜索</a>
			</div>

		</div>
		<!--查询结束  -->
		
		<!--  上传开始-->
		<div id="dlg2" class="easyui-dialog"
			style="width:400px;height:180px;padding:10px 20px" closed="true"
			buttons="#dlg-buttons2">
			<form id="uploadForm" action="houseServlet?op=daoru" method="post"
				enctype="multipart/form-data">
				<table>
					<tr>
        			<td>下载模版：</td>
        			<td><a href="javascript:void(0)" class="easyui-linkbutton"  onclick="downloadTemplate()">导入模版</a></td>
        		</tr> 
					<tr>
						<td>上传文件：</td>
						<td><input type="file" name="userUploadFile">
						</td>
					</tr>
				</table>
			</form>
		</div>

		<div id="dlg-buttons2">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				iconCls="icon-ok" onclick="uploadFile()">上传</a> <a
				href="javascript:void(0)" class="easyui-linkbutton"
				iconCls="icon-cancel"
				onclick="javascript:$('#dlg2').dialog('close')">关闭</a>
		</div>
		<!--上传结束  -->
		<!--显示部分开始  -->
		<div style="height: 99%;width:100%">
			<table id="dg" title="编辑住户信息" class="easyui-datagrid"
				fitColumns="true" pagination="true" rownumbers="true"
				url="houseServlet?op=edituserinfo" fit="true" toolbar="#cha">

				<thead>
					<tr height="200px">
						<th field="cb" checkbox="true"></th>
						<th field="res_id" width="100" align="center">编号</th>
						<th field="res_name" width="120" align="center">姓名</th>
						<th field="res_phone" width="120" align="center">电话</th>
						<th field="room_id" width="120" align="center">房间号</th>
						<th field="res_address" width="120" align="center">联系地址</th>
						<th field="res_mobile_phone" width="120" align="center">手机</th>
						<th field="res_id_card" width="120" align="center">身份证</th>
						<th field="res_house_card_number" width="120" align="center">房产证</th>
						<th field="res_units" width="120" align="center">工作单位</th>
						<th field="res_email" width="120" align="center">电子邮箱</th>
						<th field="res_note" width="120" align="center">备注信息</th>
					</tr>
				</thead>
			</table>
		</div>
		<!--显示部分结束 -->
	</center>
</body>
</html>
