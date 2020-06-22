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
	<!-- 日期框插件 -->
    <link rel="stylesheet" href="static/vendors/bower_components/flatpickr/dist/flatpickr.min.css">
    <!-- 下拉选择框插件 -->
    <link rel="stylesheet" href="static/vendors/bower_components/select2/dist/css/select2.min.css">
    <!-- alert插件 -->
    <link rel="stylesheet" href="static/vendors/bower_components/sweetalert2/dist/sweetalert2.min.css">
    
    <!-- App styles -->
    <link rel="stylesheet" href="static/css/app.min.css">
    
</head>

<body style="background-color: rgba(255,255,255,0);">

      <div class="card" style="margin-top:5px;">
         <div class="card-body">
							
			<!-- 检索  -->
			<form action="brdb/list" method="post" name="Form" id="Form">
			<table style="margin-top:5px;">
				<tr>
					<td>
						<div class="form-group">
                            <input class="form-control" id="keywords" type="text" name="keywords" value="${pd.keywords }" placeholder="这里输入关键词" />
                            <i class="form-group__bar"></i>
                        </div>
					</td>
					<td style="padding-left:2px;">
						<div class="form-group">
                            <input class="form-control date-picker flatpickr-input active" name="lastStart" id="lastStart"  value="${pd.lastStart}" type="text" readonly="readonly" style="width:88px;" placeholder="开始日期" title="开始日期"/>
                            <i class="form-group__bar"></i>
                        </div>	
					</td>
					<td style="padding-left:2px;">
						<div class="form-group">
                            <input class="form-control date-picker flatpickr-input active" name="lastEnd" id="lastEnd"  value="${pd.lastEnd}" type="text" readonly="readonly" style="width:88px;" placeholder="结束日期" title="结束日期"/>
                            <i class="form-group__bar"></i>
                        </div>	
					</td>
					<td style="vertical-align:top;padding-left:2px;">
					  	<div class="form-group">
                           <select name="TYPE" id="id" class="select2 select2-hidden-accessible" data-placeholder="请选择" tabindex="-1" aria-hidden="true" style="width: 120px;">
                           	<option value=""></option>
							<option value="1" <c:if test="${pd.TYPE==1}">selected</c:if>>整库</option>
							<option value="2" <c:if test="${pd.TYPE==2}">selected</c:if>>单表</option>
                           </select>
                        </div>
					</td>
					<td style="vertical-align:top;padding-left:5px;">
						<a class="btn btn-light btn--icon-text" onclick="searchs();" style="width: 23px;height:23px;margin-top:8px;" title="检索"><i style="margin-top:-3px;margin-left: -5px;"  class="zmdi zmdi-search"></i></a>
					</td>
				</tr>
			</table>
			<!-- 检索  -->
		
			<table class="table table-hover mb-0">
				<thead>
					<tr>
						<th>
                            <input type="checkbox" id="zcheckbox" style="margin-top: 2px;;">
						</th>
						<th style="width:50px;">NO</th>
						<th>表名</th>
						<th>备份时间</th>
						<th>操作用户</th>
						<th>存储位置</th>
						<c:if test="${remoteDB == 'no' }"><th>数据大小</th></c:if>
						<th>备注</th>
						<th id="tsmsg">操作</th>
					</tr>
				</thead>
				<tbody>
				<!-- 开始循环 -->	
				<c:choose>
					<c:when test="${not empty varList}">
						<c:forEach items="${varList}" var="var" varStatus="vs">
							<tr>
								<td>
								  	<input type="checkbox" style="margin-top: 2px;" name='ids' value="${var.FHDB_ID}">
								</td>
								<td style="width: 30px;">${page.showCount*(page.currentPage-1)+vs.index+1}</td>
								<td>${var.TABLENAME}</td>
								<td>${var.BACKUP_TIME}</td>
								<td>${var.USERNAME}</td>
								<td>${var.SQLPATH}</td>
								<c:if test="${remoteDB == 'no' }"><td>${var.DBSIZE}&nbsp;KB</td></c:if>
								<td>${var.BZ}</td>
								<td>
									<shiro:hasPermission name="brdb:edit"><a title="还原" onclick="dbRecover('${var.TABLENAME}','${var.SQLPATH}');"><i class="zmdi zmdi-rotate-left zmdi-hc-fw"></i></a></shiro:hasPermission>
									<shiro:hasPermission name="brdb:edit"><a title="修改" onclick="edit('${var.FHDB_ID}');"><i class="zmdi zmdi-edit zmdi-hc-fw"></i></a></shiro:hasPermission>
                   					<shiro:hasPermission name="brdb:del"><a title="删除" onclick="del('${var.FHDB_ID }');"><i class="zmdi zmdi-close zmdi-hc-fw"></i></a></shiro:hasPermission>
								</td>
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
			<table style="width:100%;margin-top:15px;">
				<tr>
					<td style="vertical-align:top;">
						<shiro:hasPermission name="brdb:del"><a class="btn btn-light btn--icon-text" onclick="makeAll();" title="批量删除">删除</a></shiro:hasPermission>
					</td>
					<td>
					<div id="backuping1" style="display:none;float: right;">&nbsp;<img src="static/img/loading.gif" width="20" /></div>
					</td>
					<td>
					<div id="backuping2" style="padding-top: 8px; display:none;float:left;">&nbsp;正在还原……</div>
					</td>
					<td style="vertical-align:top;"><div style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
				</tr>
			</table>
			</form>
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
    
    <!-- 日期框插件 -->
    <script src="static/vendors/bower_components/flatpickr/dist/flatpickr.min.js"></script>
	<!-- 下拉选择框插件 -->
    <script src="static/vendors/bower_components/select2/dist/js/select2.full.min.js"></script>
    <!-- alert插件 -->
    <script src="static/vendors/bower_components/sweetalert2/dist/sweetalert2.min.js"></script>
	<!-- 表单验证提示 -->
  	<script src="static/js/jquery.tips.js"></script>
  	
	<c:if test="${dbtype == 'oracle' }">
	<script type="text/javascript">
	$(function() {
		oracleMsg = "当数据库为Oracle时进行还原, 请先手动删除要还原的表或整库, 否则还原提示成功也无效！";
	});
	</script>
	</c:if>
	<script type="text/javascript">
	
		//检索
		function searchs(){
			$("#Form").submit();
		}
		
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
		
		//还原操作
		var oracleMsg="";// 数据库为oracle时，提示消息(本页js上面处理)
		function dbRecover(TABLENAME,SQLPATH){
			swal({
                title: "确定要进行还原["+TABLENAME+"]吗? ",
                text: oracleMsg,
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
							url: '<%=basePath%>brdb/dbRecover?tm='+new Date().getTime(),
					    	data: {TABLENAME:TABLENAME,SQLPATH:SQLPATH},
							dataType:'json',
							cache: false,
							success: function(data){
								if("success" == data.result){
									 $("#tsmsg").tips({
											side:3,
								            msg:'还原成功',
								            bg:'#009933',
								            time:15
								        });
								 }else{
									 $("#tsmsg").tips({
											side:3,
								            msg:'还原失败,检查配置文件及是否远程数据库',
								            bg:'#cc0033',
								            time:15
								        });
								 }
								$("#backuping1").hide();
								$("#backuping2").hide();
							}
						});
            }).catch(() => {});
		}
		
		//删除
		function del(Id){
			swal({
                title: "确定要删除此记录吗？",
                text: '确保数据安全性,只删除记录,不删除物理硬盘数据',
                type: 'warning',
                showCancelButton: true,
                buttonsStyling: false,
                confirmButtonClass: 'btn btn-danger',
                confirmButtonText: '确定',
                cancelButtonClass: 'btn btn-light',
                cancelButtonText: '取消',
                background: 'rgba(0, 0, 0, 0.96)'
            }).then(function(){
            	$.ajax({
        			type: "POST",
        			url: '<%=basePath%>brdb/delete',
        	    	data: {FHDB_ID:Id,tm:new Date().getTime()},
        			dataType:'json',
        			cache: false,
        			success: function(data){
        				 if("success" == data.result){
        					 swal({
        		                    title: '删除成功',
        		                    text: '已经从列表中删除',
        		                    type: 'success',
        		                    buttonsStyling: false,
        		                    showConfirmButton: false,
        		                    confirmButtonClass: 'btn btn-light',
        		                    background: 'rgba(0, 0, 0, 0.96)'
        		                });
        				 }
        				 setTimeout(searchs, 1500);
        			}
        		});
            }).catch(() => {});
		}
		
		//修改
		function edit(Id){
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑";
			 diag.URL = '<%=basePath%>brdb/goEdit?FHDB_ID='+Id;
			 diag.Width = 600;
			 diag.Height = 236;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('showform').style.display == 'none'){
					 searchs();
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//批量操作
		function makeAll(){
			swal({
                title: "确定要删除选中的记录吗?",
                text: '确保数据安全性,只删除记录,不删除物理硬盘数据',
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
    			for(var i=0;i < document.getElementsByName('ids').length;i++){
    				  if(document.getElementsByName('ids')[i].checked){
    				  	if(str=='') str += document.getElementsByName('ids')[i].value;
    				  	else str += ',' + document.getElementsByName('ids')[i].value;
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
   					$.ajax({
   						type: "POST",
   						url: '<%=basePath%>brdb/deleteAll?tm='+new Date().getTime(),
   				    	data: {DATA_IDS:str},
   						dataType:'json',
   						cache: false,
   						success: function(data){
   							if("success" == data.result){
   	        					 swal({
   	        		                    title: '删除成功',
   	        		                    text: '已经从列表中删除',
   	        		                    type: 'success',
   	        		                    buttonsStyling: false,
   	        		                    showConfirmButton: false,
   	        		                    confirmButtonClass: 'btn btn-light',
   	        		                    background: 'rgba(0, 0, 0, 0.96)'
   	        		                });
   	        				 }
   	        				 setTimeout(searchs, 1500);
   						}
   					});
    			}
            }).catch(() => {});
		}
		
	</script>


</body>
</html>