﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
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

<body data-sa-theme="${sessionScope.SKIN}">

      <div class="card" style="margin-top:15px;">
         <div class="card-body">
							
			<!-- 检索  -->
			<form action="fhsms/list" method="post" name="Form" id="Form">
			<input type="hidden" name="TYPE" value="${pd.TYPE}" />
			<table>
				<tr>
					<td>
						<div class="form-group">
                            <input class="form-control" id="KEYWORDS" type="text" name="KEYWORDS" value="${pd.KEYWORDS }" placeholder="这里输入关键词" />
                            <i class="form-group__bar"></i>
                        </div>
					</td>
					<td style="padding-left:2px;">
						<div class="form-group">
                            <input class="form-control date-picker flatpickr-input active" name="STRARTTIME" id="STRARTTIME"  value="${pd.STRARTTIME}" type="text" readonly="readonly" style="width:88px;" placeholder="开始日期" title="最近登录开始时间"/>
                            <i class="form-group__bar"></i>
                        </div>	
					</td>
					<td style="padding-left:2px;">
						<div class="form-group">
                            <input class="form-control date-picker flatpickr-input active" name="ENDTIME" id="ENDTIME"  value="${pd.ENDTIME}" type="text" readonly="readonly" style="width:88px;" placeholder="结束日期" title="最近登录截止时间"/>
                            <i class="form-group__bar"></i>
                        </div>	
					</td>
					<td style="vertical-align:top;padding-left:2px;">
					  	<div class="form-group">
                           <select name="STATUS" id="STATUS" class="select2 select2-hidden-accessible" data-placeholder="状态" tabindex="-1" aria-hidden="true">
                            <option value=" ">全部</option>
							<option value="1" <c:if test="${pd.STATUS == '1' }">selected</c:if>>已读</option>
							<option value="2" <c:if test="${pd.STATUS == '2' }">selected</c:if>>未读</option>
                           </select>
                        </div>
					</td>
					<td style="vertical-align:top;padding-left:10px;">
						<a class="btn btn-light btn--icon-text" onclick="searchs();" style="width: 23px;height:23px;margin-top:8px;" title="检索"><i style="margin-top:-3px;margin-left: -5px;"  class="zmdi zmdi-search"></i></a>
					</td>								
					<td style="padding-left:20px;vertical-align:top;"><a href="fhsms/list?TYPE=1" class="${pd.TYPE != '2'?'btn btn-dark':'btn btn-light btn--icon-text'}">收信箱</a></td>
					<td style="padding-left:5px;vertical-align:top;"><a href="fhsms/list?TYPE=2" class="${pd.TYPE == '2'?'btn btn-dark':'btn btn-light btn--icon-text'}">发信箱</a></td>
				</tr>
			</table>
			<!-- 检索  -->
		
			<table class="table table-hover mb-0">
				<thead>
					<tr>
	                 	<th style="width: 50px;">
                            <input type="checkbox" id="zcheckbox" style="margin-top: 2px;;">
						</th>
						<th style="width:50px;">NO</th>
						<th>发信人</th>
						<th>收信人</th>
						<th>发信时间</th>
						<th>状态</th>
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
								  	<input type="checkbox" style="margin-top: 2px;" name='ids' id="${var.TO_USERNAME}" value="${var.FHSMS_ID}" >
								 </td>
								<td style="width: 30px;">${page.showCount*(page.currentPage-1)+vs.index+1}</td>
								<c:if test="${pd.TYPE != '2' }">
								<td><a onclick="viewUser('${var.TO_USERNAME}')" style="cursor:pointer;">${var.TO_USERNAME}</a></td>
								<td><a onclick="viewUser('${var.FROM_USERNAME}')" style="cursor:pointer;">${var.FROM_USERNAME}</a></td>
								</c:if>
								<c:if test="${pd.TYPE == '2' }">
								<td><a onclick="viewUser('${var.FROM_USERNAME}')" style="cursor:pointer;">${var.FROM_USERNAME}</a></td>
								<td><a onclick="viewUser('${var.TO_USERNAME}')" style="cursor:pointer;">${var.TO_USERNAME}</a></td>
								</c:if>
								<td>${var.SEND_TIME}</td>
								<td id="STATUS${vs.index+1}"><c:if test="${var.STATUS == '2' }"><span class="label label-important arrowed-in">未读</span></c:if><c:if test="${var.STATUS == '1' }"><span class="label label-success arrowed">已读</span></c:if></td>
								<td>
									<div class="hidden-sm hidden-xs btn-group">
										<a title="查看" onclick="viewx('STATUS${vs.index+1}','${var.STATUS}','${pd.TYPE == '2'?'2':'1' }','${var.FHSMS_ID}','${var.SANME_ID}');">
											<i class="zmdi zmdi-eye zmdi-hc-fw"></i>
										</a>
										<shiro:hasPermission name="fhSms">
										<a title='发送站内信' onclick="sendFhsms('${var.TO_USERNAME}');">
											<i class="zmdi zmdi-email zmdi-hc-fw"></i>
										</a>
										</shiro:hasPermission>
										<a title="删除" onclick="del('STATUS${vs.index+1}','${var.STATUS}','${pd.TYPE == '2'?'2':'1' }','${var.FHSMS_ID}','${var.SANME_ID}');"><i class="zmdi zmdi-close zmdi-hc-fw"></i></a>
									</div>
								</td>
							</tr>
						
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr class="main_info">
							<td colspan="100" >没有相关数据</td>
						</tr>
					</c:otherwise>
				</c:choose>
				</tbody>
			</table>
			
			<table style="width:100%;margin-top:15px;">
				<tr>
					<td style="vertical-align:top;">
						<shiro:hasPermission name="fhSms"><a title="批量发送站内信" class="btn btn-light btn--icon-text" onclick="makeAll('确定要发站内信吗?');">发信</a></shiro:hasPermission>
						<a class="btn btn-light btn--icon-text" onclick="makeAll('确定要删除选中的数据吗?');" title="批量删除" >批量删除</a>
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
			$("#STATUS").val($("#STATUS").val().replace(" ",""));
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
		
		//发站内信
		function sendFhsms(USERNAME){
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="站内信";
			 diag.URL = '<%=basePath%>fhsms/goAdd?USERNAME='+USERNAME;
			 diag.Width = 700;
			 diag.Height = 530;
			 diag.CancelEvent = function(){ //关闭事件
				 setTimeout("self.location=self.location",100);
				diag.close();
			 };
			 diag.show();
		}
		
		//删除
		function del(ztid,STATUS,type,Id,SANME_ID){
			swal({
                title: '确定要删除 吗?',
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
            	if(type == "1" && STATUS == '2' && $("#"+ztid).html() == '<span class="label label-important arrowed-in">未读</span>'){
					top.readFhsms();//读取站内信时减少未读总数  <!-- readFhsms()函数在 WebRoot\static\js\index.js中 -->
				}
            	$.ajax({
        			type: "POST",
        			url: '<%=basePath%>fhsms/delete',
        	    	data: {FHSMS_ID:Id,tm:new Date().getTime()},
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
		
		//查看信件
		function viewx(ztid,STATUS,type,Id,SANME_ID){
			if(type == "1" && STATUS == '2' && $("#"+ztid).html() == '<span class="label label-important arrowed-in">未读</span>'){
				$("#"+ztid).html('<span class="label label-success arrowed">已读</span>');
				top.readFhsms();//读取站内信时减少未读总数  <!-- readFhsms()函数在 WebRoot\static\js\index.js中 -->
			}
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="站内信";
			 diag.URL = '<%=basePath%>fhsms/goView?FHSMS_ID='+Id+'&TYPE='+type+'&SANME_ID='+SANME_ID+'&STATUS='+STATUS;
			 diag.Width = 800;
			 diag.Height = 500;
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮 
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
			 };
			 diag.show();
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
            	var username = '';
    			for(var i=0;i < document.getElementsByName('ids').length;i++){
    				  if(document.getElementsByName('ids')[i].checked){
    				  	if(str=='') str += document.getElementsByName('ids')[i].value;
    				  	else str += ',' + document.getElementsByName('ids')[i].value;
    				  	if(username=='') username += document.getElementsByName('ids')[i].id;
					  	else username += ';' + document.getElementsByName('ids')[i].id;
    				  }
    			}
    			if(str=='' && msg != '确定要发站内信吗?'){
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
					if(msg == '确定要删除选中的数据吗?'){
						$.ajax({
							type: "POST",
							url: '<%=basePath%>fhsms/deleteAll?tm='+new Date().getTime(),
					    	data: {DATA_IDS:str},
							dataType:'json',
							cache: false,
							success: function(data){
								 if("success" == data.result){
									 top.getFhsmsCount();//更新未读站内信
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
					}else if(msg == '确定要发站内信吗?'){
						sendFhsms(username);
					}
    			}
            }).catch(() => {});
		}
		
		//查看用户
		function viewUser(USERNAME){
			if('admin' == USERNAME){
				swal({
                    title: '禁止查看!',
                    text: '不能查看admin用户!',
                    type: 'warning',
                    buttonsStyling: false,
                    showConfirmButton: false,
                    confirmButtonClass: 'btn btn-light',
                    background: 'rgba(0, 0, 0, 0.96)'
                });
				return;
			}
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="资料";
			 diag.URL = '<%=basePath%>user/view?USERNAME='+USERNAME;
			 diag.Width = 600;
			 diag.Height = 330;
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
			 };
			 diag.show();
		}
	</script>

</body>
</html>