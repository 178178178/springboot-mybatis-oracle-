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
			<form action="timingbackup/list" method="post" name="Form" id="Form">
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
                           <select name="STATUS" id="STATUS" class="select2 select2-hidden-accessible" data-placeholder="状态" tabindex="-1" aria-hidden="true" style="width: 120px;">
                           	<option value=""></option>
							<option value="1" <c:if test="${pd.STATUS == 1 }">selected="selected"</c:if>>正在运行</option>
							<option value="2" <c:if test="${pd.STATUS == 2 }">selected="selected"</c:if>>已经停止</option>
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
						<th >任务名称</th>
						<th>创建时间</th>
						<th>备份对象</th>
						<th>规则说明</th>
						<th>状态</th>
						<th>备注</th>
						<th>操作</th>
					</tr>
				</thead>
										
				<tbody>
				<!-- 开始循环 -->	
				<c:choose>
					<c:when test="${not empty varList}">
						<c:forEach items="${varList}" var="var" varStatus="vs">
							<tr>
								<td>
								  	<input type="checkbox" style="margin-top: 2px;" name='ids' value="${var.TIMINGBACKUP_ID}">
								</td>
								<td style="width: 30px;">${page.showCount*(page.currentPage-1)+vs.index+1}</td>
								<td>${var.JOBNAME}</td>
								<td>${var.CREATE_TIME}</td>
								<td>${var.TABLENAME == 'all' ? '整库' : var.TABLENAME }</td>
								<td>${var.TIMEEXPLAIN}</td>
								<td id="STATUS${vs.index+1}">${var.STATUS == '1' ? '正在运行<img src="static/img/loading.gif" width="12px;" />' : '已经停止'}</td>
								<td>${var.BZ}</td>
								<td>
									<div class="hidden-sm hidden-xs btn-group">
										<shiro:hasPermission name="timingbackup:edit">
										<a id="offing1${vs.index+1}" <c:if test="${var.STATUS == '1'}">style="display: none;"</c:if> title="启动" onclick="onoff('${var.TIMINGBACKUP_ID}','1',this.id,'${vs.index+1}');">
											<i class="zmdi zmdi-play zmdi-hc-fw"></i>
										</a>
										<a id="oning1${vs.index+1}" <c:if test="${var.STATUS == '2'}">style="display: none;"</c:if> title="关闭" onclick="onoff('${var.TIMINGBACKUP_ID}','2',this.id,'${vs.index+1}');">
											<i class="zmdi zmdi-pause zmdi-hc-fw"></i>
										</a>
										</shiro:hasPermission>
										<shiro:hasPermission name="timingbackup:edit"><a title="编辑" onclick="edit('${var.TIMINGBACKUP_ID}');"><i class="zmdi zmdi-edit zmdi-hc-fw"></i></a></shiro:hasPermission>
										<shiro:hasPermission name="timingbackup:del"><a title="删除" onclick="del('${var.TIMINGBACKUP_ID }');"><i class="zmdi zmdi-close zmdi-hc-fw"></i></a></shiro:hasPermission>
									</div>
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
						<shiro:hasPermission name="timingbackup:add"><a class="btn btn-light btn--icon-text" onclick="add();">新增</a></shiro:hasPermission>
						<shiro:hasPermission name="timingbackup:del"><a class="btn btn-light btn--icon-text" onclick="makeAll();" title="批量删除" >删除</a></shiro:hasPermission>
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
		
		//新增
		function add(){
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增";
			 diag.URL = '<%=basePath%>timingbackup/goAdd';
			 diag.Width = 688;
			 diag.Height = 389;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('showform').style.display == 'none'){
					 searchs();
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//删除
		function del(Id){
			swal({
                title: "确定要删除吗?",
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
            	$.ajax({
        			type: "POST",
        			url: '<%=basePath%>timingbackup/delete',
        	    	data: {TIMINGBACKUP_ID:Id,tm:new Date().getTime()},
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
			 diag.URL = '<%=basePath%>timingbackup/goEdit?TIMINGBACKUP_ID='+Id;
			 diag.Width = 688;
			 diag.Height = 389;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('showform').style.display == 'none'){
					 searchs();
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//启动 or 关闭
		function onoff(TIMINGBACKUP_ID,STATUS,ofid,VSID){
			$.ajax({
				type: "POST",
				url: '<%=basePath%>timingbackup/changeStatus?tm='+new Date().getTime(),
		    	data: {TIMINGBACKUP_ID:TIMINGBACKUP_ID,STATUS:STATUS},
				dataType:'json',
				cache: false,
				success: function(data){
					if("success" == data.result){
						 if(STATUS == '1'){
							 $("#"+ofid).tips({
									side:3,
						            msg:'启动成功',
						            bg:'#AE81FF',
						            time:2
						        });
							 $("#offing1"+VSID).hide();
							 $("#offing2"+VSID).hide();
							 $("#oning1"+VSID).show();
							 $("#oning2"+VSID).show();
							 $("#STATUS"+VSID).html('正在运行<img src="static/img/loadingi.gif" width="12px;" />');
						 }else{
							 $("#"+ofid).tips({
									side:3,
						            msg:'已经关闭',
						            bg:'#AE81FF',
						            time:2
						        });
							 $("#offing1"+VSID).show();
							 $("#offing2"+VSID).show();
							 $("#oning1"+VSID).hide();
							 $("#oning2"+VSID).hide();
							 $("#STATUS"+VSID).html('已经停止');
						 }
					}
				}
			});
		}
		
		//批量操作
		function makeAll(){
			swal({
                title: "确定要删除选中的数据吗?",
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
   						url: '<%=basePath%>timingbackup/deleteAll?tm='+new Date().getTime(),
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