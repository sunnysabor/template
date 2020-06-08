<%@ page language="java" import="java.util.*,com.wuye.pojo.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'MyWarranty.jsp' starting page</title>
    <%-- <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.min.js"></script> --%>
	
        
		<link rel="stylesheet" type="text/css" href="../../../../resources/static/jquery-easyui-1.3.3/themes/default/easyui.css">
		<link rel="stylesheet" type="text/css" href="../../../../resources/static/jquery-easyui-1.3.3/themes/icon.css">
		<script type="text/javascript" src="../../../../resources/static/jquery-easyui-1.3.3/jquery.min.js"></script>
		<script type="text/javascript" src="../../../../resources/static/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="../../../../resources/static/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
		
		  <script type="text/javascript">
	var url;
	//点击删除按钮
	 function deleteann(){
		var selectedRows=$('#dg').datagrid('getSelections');		
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
				$.post("ControllerServlet?op=deleteOneRepair",{delIds:ids},function(result){
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
	//点击添加按钮
	function addRepair(){
		$("#add").dialog("open").dialog("setTitle","添加报修");
		url="ControllerServlet?op=addUserRepair";
	}
	//点击保存按钮
	 function saveann(){
		$("#from").form("submit",{
			url:url,
			onSubmit:function(){
				 return $(this).form('validate');
			},
			success:function(result){
				if(result.errorMsg){
					$.messager.alert("系统提示",result.errorMsg);
					return;
				}else{
					$.messager.alert("系统提示","添加成功");
					$("#dg").datagrid("reload");
					$("#add").dialog("close");
					$("#bui_name").val("");
					$("#ins_name").val("");
					$("#room_number").val("");
					$("#rep_title").val("");
					$("#rep_date").val("");
				}
			}
		});
		} 
		//点击关闭按钮
 	function guanbi(){
		$("#add").dialog("close");
		/* resetValue(); */
	} 
    </script>
  </head>

  <body>
    	<center>
    	<div id="chatb">
			<div>		
				<!-- <a href="javascript:openStudentAddDialog()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a> -->
				<a href="javascript:addRepair()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
				<a href="javascript:deleteann()" class="easyui-linkbutton" iconCls="icon-remove" plain="true" >删除</a>
			</div>
		</div>
		<!-- 显示部分 -->
  	<div style="height:100%;width: 100% ;padding-top:-15px;">	
		<table id="dg" title="我的报修" class="easyui-datagrid" fitColumns="true"
	 	pagination="true" rownumbers="true" url='ControllerServlet?op=selectRepair' fit="true" toolbar="#chatb">
			<thead>
				<tr>
					<th field="cb" checkbox="true"></th>
					<th field="rep_id" width="150" align="center">报修编号</th>
					<th field="bui_name" width="100" align="center">楼宇名称</th>
					<th field="ins_name" width="100" align="center">单元名称</th>
					<th field="room_number" width="100" align="center">房间号</th>
					<th field="rep_title" width="150" align="center">报修内容</th>	
					<th field="rep_date" width="100" align="center">报修日期</th>
					<th field="state_name" width="100" align="center">是否审核</th>
					<th field="del_from" width="100" align="center">是否从维修基金扣除</th>
					<!-- <th data-options="field:'_operate',width:100,halign:'center' ,formatter:formatOper">操作</th> -->
				</tr>
			</thead>
		</table>
	</div>
		<!--信息添加开始  -->
	<div id="add" class="easyui-dialog" style="width: 400px;height: 300px;padding: 10px 20px"
		closed="true" buttons="#dlg-buttons">
		<form id="from" method="post">
			<table cellspacing="5px;">
			<!-- <tr><td><input type="hidden"  name="rep_id" id="rep_id" class="easyui-validatebox" required="true"/></td></tr> -->
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
				<td style="width:150px">报修内容:</td>
				<td><input type="text" name="rep_title" id="rep_title" class="easyui-validatebox" required="true"/></td>
				</tr>
				<tr>
				<td style="width:150px">报修日期：</td>
					<td><input class="easyui-datebox" name="rep_date" id="rep_date" required="true" editable="false" /></td>
				</tr>
				<tr>
					<td style="width:150px">是否从维修基金扣除：</td>
					<td><input type="text" name="del_from" id="del_from" class="easyui-validatebox" required="true"/></td>
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
