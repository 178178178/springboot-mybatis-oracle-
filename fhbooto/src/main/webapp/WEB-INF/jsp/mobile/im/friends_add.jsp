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
	<title>添加好友</title>
    <meta charset="utf-8">
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, width=device-width"/>
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
					
		<form action="mobfriends/search" name="Form" id="Form" method="post">
			<div id="showform" style="padding-top: 13px;">
				<table>
				<tr>
					<td>
						<div class="form-group">
                            <input class="form-control" id="keywords" type="text" name="keywords" value="${pd.keywords }" placeholder="用户名或者姓名" />
                            <i class="form-group__bar"></i>
                        </div>
					</td>
					<td style="float: left;padding-left: 10px;">
							<a class="btn btn-light btn--icon-text" onclick="tosearch();" style="width: 23px;height:23px;margin-top:8px;" title="检索"><i style="margin-top:-3px;margin-left: -5px;"  class="zmdi zmdi-search"></i></a>&nbsp;&nbsp;
							<a class="btn btn-light btn--icon-text" href="mobqgroup/goAdd" title="找群" style="height: 30px;" >找群</a>
					</td>
				</tr>
				</table>
				<table>
					<tr>
						<!-- 开始循环 -->	
						<c:choose>
							<c:when test="${not empty varList}">
								<c:forEach items="${varList}" var="var" varStatus="vs">
									<td>
										<div style="padding-left:26px;padding-top:15px;padding-bottom:15px" class="center">
										    <li data-uid="${var.USERNAME}" data-fromGroup="0" data-username="${var.NAME}" data-avatar="${(null == var.PHOTO1 or '' == var.PHOTO1)?'static/img/photo.jpg':var.PHOTO1}" >
										      <a data-type="agree" class="layui-fh" style="cursor:pointer;" onclick="add('${var.USERNAME}');">
										        <img src="${(null == var.PHOTO2 or '' == var.PHOTO2)?'static/img/photo.jpg':var.PHOTO2}" class="layui-circle layim-msgbox-avatar">
										      </a>
										      <p class="layim-msgbox-user" style="text-align: center;">
										        <a data-type="agree" class="layui-fh1" onclick="viewUser('${var.USERNAME}');" style="cursor:pointer;">${var.NAME}</a>
										      </p>
										    </li>
										</div>
									</td>
									${vs.index % 2 == 0 && vs.index > 0?"</tr><tr>":"" }
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="100">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${null == pd.keywords?"请先搜索":'没有相关好友'}</td>
								</tr>
							</c:otherwise>
						</c:choose>
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
	            msg:'用户名或姓名',
	            bg:'#AE81FF',
	            time:2
	        });
		});
	
		//检索
		function tosearch(){
			$("#Form").submit();
			$("#jiazai").show();
		}
		
		//查看用户资料
		function viewUser(USERNAME){
			if("admin" == USERNAME){
				layer.alert('不能查看admin用户');
				return;
			}
			layer.open({
			    type: 2,
			    title: '他(她)的资料',
			    shadeClose: true,
			    shade: false,
			    maxmin: false, //开启最大化最小化按钮
			    area: ['300px', '368px'],
			    content: '<%=basePath%>user/view?USERNAME='+USERNAME
			  });
		}
		
		function add(uid){
			//询问框
			layer.confirm('<font color="black">您是要加他(她)好友吗?</font>', {
			  btn: ['申请','<font color="black">取消</font>'] //按钮
			}, function(){
			  $.ajax({
					type: "POST",
					url: 'appiminterface/addFriends',	//添加好友接口
			    	data: {FUSERNAME:uid,FGROUP_ID:'9999',BZ:'申请加好友',tm:new Date().getTime()},
					dataType:'json',
					cache: false,
					success: function(data){
						if('01' == data.result){
							layer.msg('<font color="black">添加成功,等待对方同意</font>', {icon: 1});
						}else{
							layer.msg('<font color="black">您已经添加过他(她)了,无需再添加了</font>', {icon: 2});
						}
					}
				});
			}, function(){
			  
			});
		}
				
		layui.use(['layim', 'flow'], function(){
		});
	</script>
</body>
</html>