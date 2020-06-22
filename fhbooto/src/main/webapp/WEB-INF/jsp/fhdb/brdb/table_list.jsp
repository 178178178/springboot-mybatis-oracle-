<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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

      <div class="card" style="margin-top:5px;">
         <div class="card-body">
							
			<table style="margin-top:10px;">
				<tr>
					<td>
					<span class="btn btn-dark btn--icon-text"><i class="zmdi zmdi-codepen zmdi-hc-fw"></i> ${dbtype}</span>
					<span class="btn btn-dark btn--icon-text" id="backupts"><i class="zmdi zmdi-arrow-right zmdi-hc-fw"></i> ${databaseName}</span>
					</td>
					<td>
					<div id="backuping1" style="display:none">&nbsp;<img src="static/img/loading.gif" width="20" /></div>
					</td>
					<td>
					<div id="backuping2" style="padding-top: 8px; display:none">&nbsp;正在备份……</div>
					</td>
				</tr>
			</table>
		
			<table class="table table-hover mb-0">	
				<thead>
					<tr>
						<c:if test="${dbtype != 'sqlserver' }">
						<th style="width: 50px;">
                            <input type="checkbox" id="zcheckbox" style="margin-top: 2px;;">
						</th>
						</c:if>
						<th style="width:50px;">NO</th>
						<th class='left'>表名</th>
						<c:if test="${dbtype != 'sqlserver' }">
						<th class="center">操作</th>
						</c:if>
					</tr>
				</thead>
										
				<tbody>
				<!-- 开始循环 -->	
				<c:choose>
					<c:when test="${not empty varList}">
						<c:forEach items="${varList}" var="var" varStatus="vs">
							<tr>
								<c:if test="${dbtype != 'sqlserver' }">
								<td>
								  	<input type="checkbox" style="margin-top: 2px;" name='ids' value="${var}"  id='fhid${vs.index}'>
								</td>
								</c:if>
								<td style="width: 30px;">${vs.index+1}</td>
								<td class='left'>${var}</td>
								<c:if test="${dbtype != 'sqlserver' }">
								<td style="width:100px;">
									<shiro:hasPermission name="brdb:add">
										<a style="height:23px;" class="btn btn-light btn--icon-text" onclick="backupTable('${var}','fhid${vs.index}');"><div style="margin-top:-3px;margin-left: -5px;">备份</div></a>
									</shiro:hasPermission>
								</td>
								</c:if>
							</tr>
						
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr class="main_info">
							<td colspan="100" class="center" >没有相关数据</td>
						</tr>
					</c:otherwise>
				</c:choose>
				</tbody>
			</table>
			<table style="width:100%;">
				<tr>
					<td style="vertical-align:top;">
						<c:if test="${dbtype != 'sqlserver' }">
							<shiro:hasPermission name="brdb:add"><a class="btn btn-light btn--icon-text" onclick="makeAll('确定要批量备份这些表吗？');">备份表</a></shiro:hasPermission>
						</c:if>
						<shiro:hasPermission name="brdb:add"><a class="btn btn-light btn--icon-text" onclick="backupall();" id="alldata">备份整个库</a></shiro:hasPermission>
					</td>
					<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;"></div></td>
				</tr>
			</table>
						
         </div>
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
	
		$(function() {
			//复选框控制全选,全不选 
			$('#zcheckbox').click(function(){
			 if($(this).is(':checked')){
				 $("input[name='ids']").click();
			 }else{
				 $("input[name='ids']").attr("checked", false);
			 }
			});
		})
		
		//备份全库
		function backupall(){
			swal({
                title: "确定要备份整个数据库吗?",
                text: '',
                type: 'warning',
                showCancelButton: true,
                buttonsStyling: false,
                confirmButtonClass: 'btn btn-danger',
                confirmButtonText: '确定',
                cancelButtonClass: 'btn btn-light',
                cancelButtonText: '取消',
                background: 'rgba(0, 0, 0, 0.96)'
            }).then(function(){
            	$("#backuping1").show();
				$("#backuping2").show();
				 $.ajax({
						type: "POST",
						url: '<%=basePath%>brdb/backupAll',
				    	data: {tm:new Date().getTime()},
						dataType:'json',
						cache: false,
						success: function(data){
							 if("success" == data.result){
								 $("#backupts").tips({
										side:3,
							            msg:'备份成功,在数据还原里面查看记录',
							            bg:'#83CB4F',
							            time:15
							        });alldata
							        $("#alldata").tips({
										side:3,
							            msg:'备份成功,在数据还原里面查看记录',
							            bg:'#83CB4F',
							            time:15
							        });alldata
							 }else{
								 $("#backupts").tips({
										side:3,
							            msg:'备份失败,检查配置文件及备份保存路径',
							            bg:'#cc0033',
							            time:15
							        });
								 $("#alldata").tips({
										side:3,
							            msg:'备份失败,检查配置文件及备份保存路径',
							            bg:'#83CB4F',
							            time:15
							        });
							 }
							$("#backuping1").hide();
							$("#backuping2").hide();
						}
					});
            }).catch(() => {});
		}
		
		//备份单表
		function backupTable(fhtable,id){
			swal({
                title: "确定要备份这表[ "+fhtable+" ]吗?",
                text: '',
                type: 'warning',
                showCancelButton: true,
                buttonsStyling: false,
                confirmButtonClass: 'btn btn-danger',
                confirmButtonText: '确定',
                cancelButtonClass: 'btn btn-light',
                cancelButtonText: '取消',
                background: 'rgba(0, 0, 0, 0.96)'
            }).then(function(){
            	backupAjax(fhtable,id);
            }).catch(() => {});
		}
		
		/**请求备份
		* fhtable：表名
		* id ：提示对象的ID
		*/
		function backupAjax(fhtable,id){
			$("#backuping1").show();
			$("#backuping2").show();
				 $.ajax({
						type: "POST",
						url: '<%=basePath%>brdb/backupTable?tm='+new Date().getTime(),
				    	data: {fhtable:fhtable},
						dataType:'json',
						cache: false,
						success: function(data){
							 if("success" == data.result){
								 $("#"+id).tips({
										side:2,
							            msg:'备份成功',
							            bg:'#83CB4F',
							            time:5
							        });
							 }else{
								 $("#"+id).tips({
										side:3,
							            msg:'备份失败,检查配置文件及备份保存路径',
							            bg:'#cc0033',
							            time:15
							        });
							 }
							$("#backuping1").hide();
							$("#backuping2").hide();
						}
					});
		}
		
		//批量操作
		function makeAll(msg){
			swal({
                title: msg,
                text: '',
                type: 'warning',
                showCancelButton: true,
                buttonsStyling: false,
                confirmButtonClass: 'btn btn-danger',
                confirmButtonText: '确定',
                cancelButtonClass: 'btn btn-light',
                cancelButtonText: '取消',
                background: 'rgba(0, 0, 0, 0.96)'
            }).then(function(){
					var str = '';
					var fid = '';
					for(var i=0;i < document.getElementsByName('ids').length;i++){
					  if(document.getElementsByName('ids')[i].checked){
					  	if(str=='') str += document.getElementsByName('ids')[i].value;
					  	else str += ',fh,' + document.getElementsByName('ids')[i].value;
					  	
					  	if(fid=='') fid += document.getElementsByName('ids')[i].id;
					  	else fid += ',fh,' + document.getElementsByName('ids')[i].id;
					  }
					}
					if(str==''){
						$("#zcheckbox").tips({
	    					side:2,
	    		            msg:'点这里全选',
	    		            bg:'#AE81FF',
	    		            time:3
	    		        });
	    				swal({
	                        title: '您没有选择任何内容!',
	                        text: '',
	                        type: 'warning',
	                        buttonsStyling: false,
	                        confirmButtonClass: 'btn btn-sm btn-light',
	                        background: 'rgba(0, 0, 0, 0.96)'
	                    })
	    				return;
					}else{
						if(msg == '确定要批量备份这些表吗？'){
							var arrTable = str.split(',fh,');
							var arrFid = fid.split(',fh,');
							for(var fhi=0;fhi<arrTable.length;fhi++){
								backupAjax(arrTable[fhi],arrFid[fhi]);
							}
						}
					}
            }).catch(() => {});
		};
		
	</script>


</body>
</html>