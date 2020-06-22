<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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

	<link rel="stylesheet" href="plugins/fhim/dist/css/layui.css?v=1">
	<!-- alert插件 -->
    <link rel="stylesheet" href="static/vendors/bower_components/sweetalert2/dist/sweetalert2.min.css">
    <!-- App styles -->
    <link rel="stylesheet" href="static/css/app.min.css">
    
</head>

<body data-sa-theme="${sessionScope.SKIN}">

 	<!-- 页面加载过程中的那个加载状态 -->
	<div class="page-loader">
	    <div class="page-loader__spinner">
	        <svg viewBox="25 25 50 50">
	            <circle cx="50" cy="50" r="20" fill="none" stroke-width="2" stroke-miterlimit="10"></circle>
	        </svg>
	    </div>
	</div>

	<div class="card-body">
					
		<form action="qgroup/search" name="Form" id="Form" method="post">
			<div id="showform" style="padding-top: 13px;">
			<table style="width: 900px;">
				<tr>
					<td>
						<div class="form-group">
                            <input class="form-control" id="keywords" type="text" name="keywords" value="${pd.keywords }" placeholder="请输入群名称" />
                            <i class="form-group__bar"></i>
                        </div>
					</td>
					<td style="float: left;padding-left: 10px;">
							<a class="btn btn-light btn--icon-text" onclick="tosearch();" style="width: 23px;height:23px;margin-top:8px;" title="检索"><i style="margin-top:-3px;margin-left: -5px;"  class="zmdi zmdi-search"></i></a>&nbsp;&nbsp;
							<a class="btn btn-light btn--icon-text" href="friends/goAdd" title="找人" style="height: 30px;" >找人</a>
					</td>
				</tr>
			</table>
			<table>
				
				<tr>
					<td>
						<table>
							<tr>
								<!-- 开始循环 -->	
								<c:choose>
									<c:when test="${not empty varList}">
										<c:forEach items="${varList}" var="var" varStatus="vs">
											<td>
												<div style="padding-left:30px;padding-top:15px;padding-bottom:15px" class="center">
												    <li data-uid="${var.QGROUP_ID}" data-fromGroup="0" data-username="${var.NAME}" data-avatar="${(null == var.PHOTO or '' == var.PHOTO)?'static/ace/avatars/userb.jpg':var.PHOTO}" >
												      <a data-type="agree" class="layui-fh" style="cursor:pointer;">
												        <img src="${(null == var.PHOTO or '' == var.PHOTO)?'static/img/photo.jpg':var.PHOTO}" width="50" height="50" class="layui-circle layim-msgbox-avatar">
												      </a>
												      <p class="layim-msgbox-user" style="text-align: center;">
												        <a data-type="agree" class="layui-fh" style="cursor:pointer;">${var.NAME}</a>
												      </p>
												    </li>
												</div>
											</td>
											${vs.index % 10 == 0 && vs.index > 0?"</tr><tr>":"" }
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td colspan="100">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${null == pd.keywords?"请先搜索":'没有相关群'}</td>
										</tr>
									</c:otherwise>
								</c:choose>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			</div>
			<div id="jiazai" style="display:none;width: 100%;text-align: center;" class="page-loader" >
			   <div class="page-loader__spinner">
			        <svg viewBox="25 25 50 50">
			            <circle cx="50" cy="50" r="20" fill="none" stroke-width="2" stroke-miterlimit="10"></circle>
			        </svg>
			   </div>
			   <br/>
		   </div>
		</form>
					
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
	<script src="plugins/fhim/dist/layui.js?v=1"></script>
	<script type="text/javascript">
	
		$(function(){
			$("#keywords").tips({
				side:3,
		           msg:'群名',
		           bg:'#AE81FF',
		           time:2
		       });
		});
	
		//检索
		function tosearch(){
			$("#Form").submit();
			$("#jiazai").show();
		}
		
		//点击群的头像
		var cache = {}; //用于临时记录请求到的数据
		layui.use(['layim', 'flow'], function(){
			  var layim = layui.layim
			  ,layer = layui.layer
			  ,laytpl = layui.laytpl
			  ,$ = layui.jquery
			  ,flow = layui.flow;
			  //操作
			  var active = { 
				agree: function(othis){
					var li = othis.parents('li')
				      ,uid = li.data('uid')
				      ,from_group = li.data('fromGroup')
				      ,username = li.data('username')
				      ,avatar = li.data('avatar')
					
					layim.add({
						  type: 'group' 			//friend：申请加好友、group：申请加群
						  ,groupname: username 		//好友昵称，若申请加群，参数为：groupname
						  ,avatar: avatar		 	//头像
						  ,submit: function(group, remark, index){ 
						    console.log(remark); 	//获取附加信息
						    layer.close(index); 	//关闭改面板
							$.ajax({
								type: "POST",
								url: 'iminterface/addQGroup',	//添加群接口
						    	data: {QGROUP_ID:uid,BZ:remark,tm:new Date().getTime()},
								dataType:'json',
								cache: false,
								success: function(data){
									if('01' == data.result){
										swal({
		        		                    title: '申请成功',
		        		                    text: '等待群主同意',
		        		                    type: 'success',
		        		                    buttonsStyling: false,
		        		                    showConfirmButton: false,
		        		                    confirmButtonClass: 'btn btn-light',
		        		                    background: 'rgba(0, 0, 0, 0.96)'
		        		                });
										top.applyQgroup(uid);	//申请加群消息发送给群主，此函数在 im.jsp页面
									}else{
										swal({
		        		                    title: '申请失败',
		        		                    text: '您已经在此群了,无需再申请',
		        		                    type: 'info',
		        		                    buttonsStyling: false,
		        		                    showConfirmButton: false,
		        		                    confirmButtonClass: 'btn btn-light',
		        		                    background: 'rgba(0, 0, 0, 0.96)'
		        		                });
									}
								}
							});
						  }
						});
				}
			  };
			  $('body').on('click', '.layui-fh', function(){
				    var othis = $(this), type = othis.data('type');
				    active[type] ? active[type].call(this, othis) : '';
				  });
		});
	</script>
</body>
</html>