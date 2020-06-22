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

    <!-- Vendor styles -->
    <link rel="stylesheet" href="static/vendors/bower_components/material-design-iconic-font/dist/css/material-design-iconic-font.min.css">
    <link rel="stylesheet" href="static/vendors/bower_components/animate.css/animate.min.css">
    <link rel="stylesheet" href="static/vendors/bower_components/jquery.scrollbar/jquery.scrollbar.css">

    <!-- App styles -->
    <link rel="stylesheet" href="static/css/app.min.css">	

	<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
	<link type="text/css" rel="stylesheet" href="plugins/zTree/2.6/zTreeStyle.css"/>
	<script type="text/javascript" src="plugins/zTree/2.6/jquery.ztree-2.6.min.js"></script>
<body>

</head>
<body>

		<!-- 页面加载过程中的那个加载状态 -->
		<div class="page-loader">
		    <div class="page-loader__spinner">
		        <svg viewBox="25 25 50 50">
		            <circle cx="50" cy="50" r="20" fill="none" stroke-width="2" stroke-miterlimit="10"></circle>
		        </svg>
		    </div>
		</div>

		<div id="showform">
			<div style="overflow: scroll; scrolling: yes;height:421px;width: 319px;">
			<ul id="tree" class="tree" style="overflow:auto;"></ul>
			</div>
		</div>
	
		<div id="jiazai" style="display:none;width: 100%;text-align: center;" class="page-loader" >
		   <div class="page-loader__spinner">
		        <svg viewBox="25 25 50 50">
		            <circle cx="50" cy="50" r="20" fill="none" stroke-width="2" stroke-miterlimit="10"></circle>
		        </svg>
		   </div>
		   <br/>
		</div>
	
		<div style="width: 100%;padding-top: 5px;text-align: center;">
			<a class="btn btn-dark" onclick="save();">保存</a>
			<a class="btn btn-dark" onclick="top.Dialog.close();">取消</a>
		</div>
	
	  <!-- App functions and actions -->
  <script src="static/js/app.min.js"></script>
	
	<script type="text/javascript">
		var zTree;
		$(document).ready(function(){
			var setting = {
			    showLine: true,
			    checkable: true
			};
			var zTreeNodes = eval(${zTreeNodes});
			zTree = $("#tree").zTree(setting, zTreeNodes);
		});
	
		//保存
		 function save(){
			var nodes = zTree.getCheckedNodes();
			var tmpNode;
			var ids = "";
			for(var i=0; i<nodes.length; i++){
				tmpNode = nodes[i];
				if(i!=nodes.length-1){
					ids += tmpNode.id+",";
				}else{
					ids += tmpNode.id;
				}
			}
			var ROLE_ID = "${ROLE_ID}";
			var url = "<%=basePath%>role/saveMenuqx";
			var postData;
			postData = {"ROLE_ID":ROLE_ID,"menuIds":ids};
			$("#showform").hide();
			$("#jiazai").show();
			$.post(url,postData,function(data){
				top.Dialog.close();
			});
		 }
	
	</script>
</body>
</html>