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
          <form action="user/listUsers" method="post" name="Form" id="Form">
			<!-- 检索条件  -->
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
                           <select name="ROLE_ID" id="ROLE_ID" class="select2 select2-hidden-accessible" data-placeholder="请选择角色" tabindex="-1" aria-hidden="true" style="width: 120px;">
                            <option value=""></option>
                            <c:forEach items="${roleList}" var="role">
									<option value="${role.ROLE_ID }" <c:if test="${ROLE_ID==role.ROLE_ID}">selected</c:if>>${role.ROLE_NAME }</option>
							</c:forEach>
                           </select>
                        </div>
					</td>
					<td style="vertical-align:top;padding-left:5px;">
						<shiro:hasPermission name="user:cha"><a class="btn btn-light btn--icon-text" onclick="searchs();" style="width: 23px;height:23px;margin-top:8px;" title="检索"><i style="margin-top:-3px;margin-left: -5px;"  class="zmdi zmdi-search"></i></a></shiro:hasPermission>
						<shiro:hasPermission name="toExcel"><a class="btn btn-light btn--icon-text" onclick="toExcel();" style="width: 23px;height:23px;margin-top:8px;" title="导出到excel表格"><i style="margin-top:-3px;margin-left: -10px;" class="zmdi zmdi-cloud-download zmdi-hc-fw"></i></a></shiro:hasPermission>
						<shiro:hasPermission name="fromExcel"><a class="btn btn-light btn--icon-text" onclick="fromExcel();" style="width: 23px;height:23px;margin-top:8px;" title="从EXCEL导入到系统"><i style="margin-top:-3px;margin-left: -10px;" class="zmdi zmdi-cloud-upload zmdi-hc-fw"></i></a></shiro:hasPermission>
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
	                    <th>NO</th>
						<th>编号</th>
						<th>用户名</th>
						<th>姓名</th>
						<th>角色</th>
						<th>邮箱</th>
						<th>最近登录</th>
						<th>上次登录IP</th>
						<th>操作</th>
	                 </tr>
                 </thead>
                 <tbody>
                 <!-- 开始循环 -->	
				 <c:choose>
					<c:when test="${not empty userList}">
                 	 <c:forEach items="${userList}" var="user" varStatus="vs">
		                 <tr>
							 <td>
							  	<c:if test="${user.USERNAME != 'admin'}"><input type="checkbox" style="margin-top: 2px;" name='ids' value="${user.USER_ID }" id="${user.EMAIL }" title="${user.USERNAME }"></c:if>
							  	<c:if test="${user.USERNAME == 'admin'}"><input type="checkbox" disabled="disabled" style="margin-top: 2px;"></c:if>
							 </td>
		                     <td>${page.showCount*(page.currentPage-1)+vs.index+1}</td>
		                     <td>${user.NUMBER }</td>
		                     <td>${user.USERNAME }</td>
		                     <td>${user.NAME }</td>
		                     <td>${user.ROLE_NAME }</td>
		                     <td>
		                    	<a title="发送电子邮件" style="text-decoration:none;cursor:pointer;" <shiro:hasPermission name="email">onclick="sendEmail('${user.EMAIL }');"</shiro:hasPermission>>${user.EMAIL }&nbsp;<i class="zmdi zmdi-email-open zmdi-hc-fw"></i></a>
		                     </td>
		                     <td>${user.LAST_LOGIN }</td>
		                     <td>${user.IP }</td>
		                     <td>
                     			<shiro:hasPermission name="fhSms">
								<a title='发送站内信' onclick="sendFhsms('${user.USERNAME}');">
									<i class="zmdi zmdi-email zmdi-hc-fw"></i>
								</a>
								</shiro:hasPermission>
		                     	<shiro:hasPermission name="user:edit"><a title="修改" onclick="editUser('${user.USER_ID}');"><i class="zmdi zmdi-edit zmdi-hc-fw"></i></a></shiro:hasPermission>
		                     	<shiro:hasPermission name="user:del"><a title="删除" onclick="delUser('${user.USER_ID }','${user.NAME }');"><i class="zmdi zmdi-close zmdi-hc-fw"></i></a></shiro:hasPermission>
		                     </td>
		                 </tr>
	                 </c:forEach>
	                </c:when>
					<c:otherwise>
						<tr>
							<td colspan="10">没有相关数据</td>
						</tr>
					</c:otherwise>
				 </c:choose>
                 </tbody>
             </table>
             
             <table style="width:100%;margin-top:15px;">
				<tr>
					<td style="vertical-align:top;">
						<shiro:hasPermission name="user:add"><a class="btn btn-light btn--icon-text" onclick="add();">新增</a></shiro:hasPermission>
                 		<shiro:hasPermission name="user:del"><a class="btn btn-light btn--icon-text" onclick="makeAll('确定要删除选中的用户吗?');">删除</a></shiro:hasPermission>
                 		<shiro:hasPermission name="email"><a title="批量发送站内信" class="btn btn-light btn--icon-text" onclick="makeAll('确定要给选中的用户发送邮件?');">发邮件</a></shiro:hasPermission>
                 		<shiro:hasPermission name="fhSms"><a title="批量发送站内信" class="btn btn-light btn--icon-text" onclick="makeAll('确定要给选中的用户发送站内信吗?');">发站内信</a></shiro:hasPermission>
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
		
		//新增
		function add(){
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增";
			 diag.URL = '<%=basePath%>user/goAddUser';
			 diag.Width = 600;
			 diag.Height = 530;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮 
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('showform').style.display == 'none'){
					 searchs();
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//删除
		function delUser(USER_ID,NAME){
			swal({
                title: '确定要删除 '+NAME+' 吗?',
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
        			url: '<%=basePath%>user/deleteUser',
        	    	data: {USER_ID:USER_ID,tm:new Date().getTime()},
        			dataType:'json',
        			cache: false,
        			success: function(data){
        				 if("success" == data.result){
        					 swal({
        		                    title: '删除成功',
        		                    text: NAME+' 已经从列表中删除',
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
            	var emstr = '';
            	var username = '';
    			for(var i=0;i < document.getElementsByName('ids').length;i++){
    				  if(document.getElementsByName('ids')[i].checked){
    				  	if(str=='') str += document.getElementsByName('ids')[i].value;
    				  	else str += ',' + document.getElementsByName('ids')[i].value;
    				  	
    				  	if(emstr=='') emstr += document.getElementsByName('ids')[i].id;
    				  	else emstr += ';' + document.getElementsByName('ids')[i].id;
    				  	
    				  	if(username=='') username += document.getElementsByName('ids')[i].title;
    				  	else username += ';' + document.getElementsByName('ids')[i].title;
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
    				if(msg == '确定要删除选中的用户吗?'){
    					$.ajax({
    						type: "POST",
    						url: '<%=basePath%>user/deleteAllUser?tm='+new Date().getTime(),
    				    	data: {USER_IDS:str},
    						dataType:'json',
    						cache: false,
    						success: function(data){
    							if("success" == data.result){
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
    						}
    					});
    				}else if(msg == '确定要给选中的用户发送站内信吗?'){
    					sendFhsms(username);
    				}else if(msg == '确定要给选中的用户发送邮件?'){
    					sendEmail(emstr);
    				}
    			}
            }).catch(() => {});
		}
		
		//修改
		function editUser(USER_ID){
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="资料";
			 diag.URL = '<%=basePath%>user/goEditUser?USER_ID='+USER_ID;
			 diag.Width = 600;
			 diag.Height = 530;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮 
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('showform').style.display == 'none'){
					 searchs();
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//导出excel
		function toExcel(){
			var KEYWORDS = $("#KEYWORDS").val();
			var STRARTTIME = $("#STRARTTIME").val();
			var ENDTIME = $("#ENDTIME").val();
			var ROLE_ID = $("#ROLE_ID").val();
			window.location.href='<%=basePath%>user/excel?KEYWORDS='+KEYWORDS+'&STRARTTIME='+STRARTTIME+'&ENDTIME='+ENDTIME+'&ROLE_ID='+ROLE_ID;
		}

		//打开上传excel页面
		function fromExcel(){
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="从EXCEL导入到系统";
			 diag.URL = '<%=basePath%>user/goUploadExcel';
			 diag.Width = 600;
			 diag.Height = 150;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('showform').style.display == 'none'){
					 searchs();
				}
				diag.close();
			 };
			 diag.show();
		}	
		
		//发站内信
		function sendFhsms(USERNAME){
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="站内信";
			 diag.URL = '<%=basePath%>fhsms/goAdd?USERNAME='+USERNAME;
			 diag.Width = 700;
			 diag.Height = 530;
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
			 };
			 diag.show();
		}
		
		//去发送电子邮件页面
		function sendEmail(EMAIL){
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="发送电子邮件";
			 diag.URL = '<%=basePath%>head/goSendEmail?EMAIL='+EMAIL;
			 diag.Width = 1000;
			 diag.Height = 700;
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
			 };
			 diag.show();
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
		
	</script>
</body>
</html>
