<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<base href="<%=basePath%>">
	<meta charset="utf-8" />
	<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
	<link type="text/css" rel="stylesheet" href="plugins/zTree/2.6/zTreeStyle.css"/>
	<script type="text/javascript" src="plugins/zTree/2.6/jquery.ztree-2.6.min.js"></script>
	<style type="text/css">
		span{ color:black;}
	</style>
<body>

</head>
<body>

	<div style="overflow: scroll; scrolling: yes;height:422px;width: 328px;">
	<ul id="tree" class="tree" style="overflow:auto;"></ul>
	</div>
	
	<input name="DICTIONARIES_ID" id="DICTIONARIES_ID" value="" type="hidden" />
	
	<script type="text/javascript">
		var zTree;
		$(document).ready(function(){
			
			var setting = {
			    showLine: true,
			    checkable: false
			};
			var zTreeNodes = eval(${zTreeNodes});
			zTree = $("#tree").zTree(setting, zTreeNodes);
		});
	
		//设置ID给父窗口
		 function setDID(DICTIONARIES_ID){
			$("#DICTIONARIES_ID").val(DICTIONARIES_ID);
			top.Dialog.close();
		 }
	
	</script>
</body>
</html>