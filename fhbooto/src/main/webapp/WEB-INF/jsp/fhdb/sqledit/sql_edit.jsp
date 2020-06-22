<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"  %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<base href="<%=basePath%>">
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

	<!-- Vendor styles -->
	<link rel="stylesheet" href="static/vendors/bower_components/material-design-iconic-font/dist/css/material-design-iconic-font.min.css">
	<link rel="stylesheet" href="static/vendors/bower_components/animate.css/animate.min.css">
	<link rel="stylesheet" href="static/vendors/bower_components/jquery.scrollbar/jquery.scrollbar.css">
	<!-- alert插件 -->
    <link rel="stylesheet" href="static/vendors/bower_components/sweetalert2/dist/sweetalert2.min.css">
	<!-- App styles -->
	<link rel="stylesheet" href="static/css/app.min.css">
</head>

<body style="background-color: rgba(255,255,255,0);">

<!-- 页面加载过程中的那个加载状态 -->
<div class="page-loader">
	<div class="page-loader__spinner">
		<svg viewBox="25 25 50 50">
			<circle cx="50" cy="50" r="20" fill="none" stroke-width="2" stroke-miterlimit="10"></circle>
		</svg>
	</div>
</div>

<div class="card-body">

		<div class="input-group" style="margin-top:3px;">
			<span class="input-group-addon" style="width: 130px;"><span style="width: 100%;">SQL脚本编辑语句</span></span>
			<div class="form-group">
				<textarea class="form-control" rows="2" cols="10" id="updateSQL" style="width:98%;"  title="INSERT、UPDATE 或 DELETE 语句" placeholder="这里输入： INSERT、UPDATE 或 DELETE 语句"></textarea>
			</div>
			<div style="float: right;margin-right: 12px;margin-top: 3px;" style="width:19%">
				<shiro:hasPermission name="sqledit:edit"><a class='btn btn-light btn--icon-text' title="执行SQL" onclick="executeUpdate();"><i style="margin-top:3px;margin-left: 5px;"  class="zmdi zmdi-play zmdi-hc-fw"></i></a></shiro:hasPermission>
			</div>
		</div>
		<div class="input-group" style="margin-top:3px;">
			<span class="input-group-addon" style="width: 130px;"><span style="width: 100%;">SQL脚本查询语句</span></span>
			<div class="form-group">
				<textarea class="form-control" rows="2" cols="10" id="querySQL"  style="width:98%;"  title="SELECT语句" placeholder="这里输入： SELECT 语句"></textarea>
			</div>
			<div style="float: right;margin-right: 12px;margin-top: 3px;" style="width:19%">
				<shiro:hasPermission name="sqledit:cha"><a class='btn btn-light btn--icon-text' title="执行SQL" onclick="executeQuery();"><i style="margin-top:3px;margin-left: 5px;"  class="zmdi zmdi-play zmdi-hc-fw"></i></a></shiro:hasPermission>
			</div>
		</div>

		<div style="overflow: scroll; scrolling: yes;width: 100%;">
		<table id="simple-table" class="table table-bordered mb-0" style="margin-top:10px;">
			<thead id="theadid">
				<tr id="columnList">
					<th>字段</th>
				</tr>
			</thead>
	
			<tbody id="valuelist">
				<tr class='center'>
					<td>数据显示区</td>
				</tr>
			</tbody>
		</table>
		</div>	
		<table style="margin-top:10px;" border="0">
			<tr style="height:26px;">
				<td>
					<div style="width:120px;" id="theadid2">查询时间 &nbsp;s</div>
				</td>
				<td>
					<div style="width:66px;" id="fhcount">共 &nbsp;条</div>
				</td>
				<td style="float: right;padding-top: 5px;">
					<div id="exceldiv">
						<shiro:hasPermission name="toExcel">
								<i class="zmdi zmdi-download zmdi-hc-fw" style="cursor:pointer;" onclick="toExcel();" title="导出到EXCEL"></i>
						</shiro:hasPermission>
					</div>
				</td>
			</tr>
		</table>
		<textarea rows="" cols="" id="sqlstrforExcel" style="display: none;"></textarea>

</div>

<!-- Javascript -->
<!-- static/vendors -->
<script src="static/vendors/bower_components/jquery/dist/jquery.min.js"></script>
<script src="static/vendors/bower_components/popper.js/dist/umd/popper.min.js"></script>
<script src="static/vendors/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<script src="static/vendors/bower_components/jquery.scrollbar/jquery.scrollbar.min.js"></script>
<script src="static/vendors/bower_components/jquery-scrollLock/jquery-scrollLock.min.js"></script>

<!-- App functions and actions -->
<script src="static/js/app.min.js"></script>
<!-- alert插件 -->
<script src="static/vendors/bower_components/sweetalert2/dist/sweetalert2.min.js"></script>
<!-- 表单验证提示 -->
<script src="static/js/jquery.tips.js"></script>

	<script type="text/javascript">
		//执行编辑语句
		function executeUpdate(){
			var sql = $("#updateSQL").val();
			if("" == sql){
				$("#updateSQL").tips({
					side:3,
		            msg:'什么也没输入！',
		            bg:'#AE81FF',
		            time:3
		        });
				return;
			}
			 $.ajax({
					type: "POST",
					url: '<%=basePath%>sqledit/executeUpdate?tm='+new Date().getTime(),
			    	data: {sql:sql},
					dataType:'json',
					cache: false,
					success: function(data){
						 if("success" == data.result){
							 $("#updateSQL").tips({
									side:3,
						            msg:'执行成功, 用时：'+data.rTime+' s',
						            bg:'#009933',
						            time:10
						        });
						 }else{
							 $("#updateSQL").tips({
									side:3,
						            msg:'执行失败,sql语句错误 或 非编辑语句or查询数据库连接错误',
						            bg:'#cc0033',
						            time:15
						        });
						 }
					}
				});
		}
	</script>

	<script type="text/javascript">
		//执行查询语句
		function executeQuery(){
			var sql = $("#querySQL").val();
			if("" == sql){
				$("#querySQL").tips({
					side:3,
		            msg:'什么也没输入！',
		            bg:'#AE81FF',
		            time:3
		        });
				return;
			}
			 $.ajax({
					type: "POST",
					url: '<%=basePath%>sqledit/executeQuery?tm='+new Date().getTime(),
			    	data: {sql:sql},
					dataType:'json',
					cache: false,
					success: function(data){
						 if("success" == data.result){
							 $("#theadid").tips({
									side:3,
						            msg:'执行成功, 查询时间：'+data.rTime+' s',
						            bg:'#009933',
						            time:15
						        });
							 $("#theadid2").html('查询时间：'+data.rTime+' s');
							 $("#columnList").html('');	//初始清空字段名称
							 $("#valuelist").html('');	//初始清空值列表
							 $.each(data.columnList, function(m, column){ 	//列出字段名
								 $("#columnList").append(
									'<th>'+column+'</th>'	 
								 );
							 });
							 var fhcount = 0;
							 $.each(data.dataList, function(n, fhdata){ 	//列出每条记录
								 var str1 = '<tr>';
								 var str2 = '';
								 $.each(fhdata, function(f, fhvalue){ 		//列出字段名
									 str2 += '<td>'+fhvalue+'</d>'; 
								 });
								 var str3 = '</tr>';
								 $("#valuelist").append(str1+str2+str3);
								 fhcount ++;
							 });
							 $("#fhcount").html('共  '+fhcount+' 条');
							 $("#sqlstrforExcel").val(sql);
						 }else{
							 $("#querySQL").tips({
									side:3,
						            msg:'查询失败,sql语句错误或非查询语句or查询数据库连接错误',
						            bg:'#cc0033',
						            time:15
						        });
						 }
					}
				});
		}
		
		//导出excel
		function toExcel(){
			var sqlstrforExcel = $("#sqlstrforExcel").val();
			if("" == sqlstrforExcel){
				swal({
                    title: '什么数据都没有，你导出什么?',
                    text: '',
                    type: 'warning',
                    buttonsStyling: false,
                    confirmButtonClass: 'btn btn-sm btn-light',
                    background: 'rgba(0, 0, 0, 0.96)'
                })
				return
			}else{
				window.location.href='<%=basePath%>sqledit/excel?sql='+sqlstrforExcel;
			}
		}
	</script>

</body>
</html>