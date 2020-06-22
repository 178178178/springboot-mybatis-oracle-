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

      <div class="card" style="margin-top:5px;">
         <div class="card-body">
	
						<table style="margin-top:10px;">
							<tr style="height:26px;">
								<td style="padding-left: 15px;">在线人数：</td>
								<td>
									<div style="width:39px;" id="onlineCount">0</div>
								</td>
							</tr>
						</table>
	
						<table class="table table-hover mb-0">
							<thead>
								<tr>
									<th style="width: 50px;">
			                            <input type="checkbox" id="zcheckbox" style="margin-top: 2px;;">
									</th>
									<th style="width: 50px;">NO</th>
									<th>用户名</th>
									<th style="width: 100px;">操作</th>
								</tr>
							</thead>
												
							<tbody id="userlist">
							</tbody>
						</table>
							 
						
              <table style="width:100%;margin-top:15px;">
				<tr>
					<td style="vertical-align:top;">
						<a class="btn btn-light btn--icon-text" onclick="makeAll('确定要把这些用户强制下线吗?');" title="批量强制下线" >强制下线</a>
					</td>
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
		
		//初始化
		$(function(){
			online();
			//复选框控制全选,全不选 
			$('#zcheckbox').click(function(){
			 if($(this).is(':checked')){
				 $("input[name='ids']").click();
			 }else{
				 $("input[name='ids']").attr("checked", false);
			 }
			});
		});
		
		var websocketonline;//websocke对象
		var userCount = 0;	//在线总数
		function online(){
			if (window.WebSocket) {
				websocketonline = new WebSocket(encodeURI('ws://'+top.onlineAdress)); //oladress在main.jsp页面定义
				websocketonline.onopen = function() {
					websocketonline.send('[QQ313596790]fhadmin');//连接成功
				};
				websocketonline.onerror = function() {
					//连接失败
				};
				websocketonline.onclose = function() {
					//连接断开
				};
				//消息接收
				websocketonline.onmessage = function(message) {
					var message = JSON.parse(message.data);
					if (message.type == 'count') {
						userCount = message.msg;
					}else if(message.type == 'userlist'){
						$("#userlist").html('');
						 $.each(message.list, function(i, user){
							 $("#userlist").append(
								'<tr>'+	 
									 '<td>'+
										'<input type="checkbox" name="ids" value="'+user+'" />'+
									'</td>'+
									'<td>'+(i+1)+'</td>'+
									'<td><a onclick="editUser(\''+user+'\')" style="cursor:pointer;">'+user+'</a></td>'+
									'<td>'+
										'<a style="height:23px;" class="btn btn-light btn--icon-text" onclick="goOutTUser(\''+user+'\')"><div style="margin-top:-3px;margin-left: -5px;">&nbsp;强制下线</div></a>'+
									'</td>'+
								'</tr>'
							 );
							 userCount = i+1;
						 });
						 $("#onlineCount").html(userCount);
					}else if(message.type == 'addUser'){
						 $("#userlist").append(
							'<tr>'+	 
								 '<td>'+
									'<input type="checkbox" name="ids" value="'+message.user+'" />'+
								'</td>'+
								'<td>'+(userCount+1)+'</td>'+
								'<td><a onclick="editUser(\''+message.user+'\')" style="cursor:pointer;">'+message.user+'</a></td>'+
								'<td>'+
									'<a style="height:23px;"  class="btn btn-light btn--icon-text" onclick="goOutTUser(\''+message.user+'\')"><div style="margin-top:-3px;margin-left: -5px;">&nbsp;强制下线</div></a>'+
								'</td>'+
							'</tr>'
						);
						 userCount = userCount+1;
						 $("#onlineCount").html(userCount);
					}
				};
			}
		}
		
		//强制某用户下线
		function goOutUser(theuser){
			websocketonline.send('[goOut]'+theuser);
		}
		
		//强制某用户下线
		function goOutTUser(theuser){
			if('admin' == theuser){
				 swal({
	                    title: '操作失败!',
	                    text: '不能强制下线admin用户!',
	                    type: 'warning',
	                    buttonsStyling: false,
	                    showConfirmButton: false,
	                    confirmButtonClass: 'btn btn-light',
	                    background: 'rgba(0, 0, 0, 0.96)'
	                });
				return;
			}
			swal({
                title: "确定要强制["+theuser+"]下线吗?",
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
					goOutUser(theuser);
            }).catch(() => {});
		}
		
		//查看修改用户
		function editUser(USERNAME){
			if('admin' == USERNAME){
				swal({
                    title: '禁止查看!',
                    text: '不能查看修改admin用户!',
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
			 diag.URL = '<%=basePath%>user/goEditUfromOnline?USERNAME='+USERNAME;
			 diag.Width = 600;
			 diag.Height = 520;
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
    			for(var i=0;i < document.getElementsByName('ids').length;i++){
    				  if(document.getElementsByName('ids')[i].checked){
    				  	if('admin' != document.getElementsByName('ids')[i].value){
							  if(str=='') str += document.getElementsByName('ids')[i].value;
							  else str += ',' + document.getElementsByName('ids')[i].value;
						  }else{
							  document.getElementsByName('ids')[i].checked  = false;
							  $("#zcheckbox").tips({
									side:3,
						            msg:'admin用户不能强制下线',
						            bg:'#AE81FF',
						            time:5
						        });
						  }
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
    				var arField = str.split(',');
					for(var i=0;i<arField.length;i++){
						websocketonline.send('[goOut]'+arField[i]);
					}
    			}
            }).catch(() => {});
		}
		</script>
		
	</body>
</html>

