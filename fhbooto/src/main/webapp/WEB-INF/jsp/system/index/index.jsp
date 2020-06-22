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
		<title>${sessionScope.sysName}</title>
        <!-- Vendor styles -->
        <link rel="stylesheet" href="static/vendors/bower_components/material-design-iconic-font/dist/css/material-design-iconic-font.min.css">
        <link rel="stylesheet" href="static/vendors/bower_components/animate.css/animate.min.css">
        <link rel="stylesheet" href="static/vendors/bower_components/jquery.scrollbar/jquery.scrollbar.css">

		<!--引入弹窗组件-->
		<link type="text/css" rel="stylesheet" href="plugins/fhdrag/style.css" />
		
		<!-- 及时通讯css -->
		<link rel="stylesheet" href="plugins/fhim/dist/css/layui.css">
		<link rel="stylesheet" href="plugins/fhim/dist/css/contextMenu.css">
		
		<!-- alert插件 -->
    	<link rel="stylesheet" href="static/vendors/bower_components/sweetalert2/dist/sweetalert2.min.css">
        <!-- App styles -->
        <link rel="stylesheet" href="static/css/app.min.css">
        
        <style type="text/css">
        	.layim-list-friend span{
        		color:#505050;
        	}
        	#layui-layim-close span{
        		color:black;
        	}
        </style>
        
    </head>

    <body data-sa-theme="${SKIN}">
        <main class="main">
            <div class="page-loader">
                <div class="page-loader__spinner">
                    <svg viewBox="25 25 50 50">
                        <circle cx="50" cy="50" r="20" fill="none" stroke-width="2" stroke-miterlimit="10" />
                    </svg>
                </div>
            </div>

            <header class="header">
                <div id="shmenu" class="navigation-trigger hidden-xl-up" data-sa-action="aside-open" data-sa-target=".sidebar">
                    <i class="zmdi zmdi-menu"></i>
                </div>

                <div class="logo hidden-sm-down">
                    <h1><a href="main/index">${sessionScope.sysName}</a></h1>
                </div>

				<!-- 头部页面 -->
				<%@ include file="head.jsp"%>

                <div class="clock hidden-md-down">
                    <div class="time">
                        <span class="time__hours"></span>
                        <span class="time__min"></span>
                        <span class="time__sec"></span>
                    </div>
                </div>
            </header>

            <aside id="allmenu" class="sidebar">
                <div class="scrollbar-inner">

                    <div class="user">
                        <div class="user__info" data-toggle="dropdown">
                            <img class="user__img" src="static/img/photo.jpg" id="userPhoto">
                            <div>
                                <div class="user__name" id="user_name"></div>
                                <div class="user__email" id="role_name"></div>
                            </div>
                        </div>

                        <div class="dropdown-menu">
                            <a class="dropdown-item" onclick="editPhoto();">修改头像</a>
                            <a class="dropdown-item" onclick="goEditMyInfo();">修改资料</a>
                            <a class="dropdown-item" href="main/logout">退出系统</a>
                        </div>
                    </div>
                    
   					<!-- 左侧菜单 -->
					<%@ include file="leftMenu.jsp"%>
                    
                </div>
            </aside>

            <div class="themes">
			    <div class="scrollbar-inner">
			        <a onclick="saveSkin('1')" class="themes__item ${SKIN=='1'?'active':''}" data-sa-value="1"><img src="static/img/bg/1.jpg" alt=""></a>
			        <a onclick="saveSkin('2')" class="themes__item ${SKIN=='2'?'active':''}" data-sa-value="2"><img src="static/img/bg/2.jpg" alt=""></a>
			        <a onclick="saveSkin('3')" class="themes__item ${SKIN=='3'?'active':''}" data-sa-value="3"><img src="static/img/bg/3.jpg" alt=""></a>
			        <a onclick="saveSkin('4')" class="themes__item ${SKIN=='4'?'active':''}" data-sa-value="4"><img src="static/img/bg/4.jpg" alt=""></a>
			        <a onclick="saveSkin('5')" class="themes__item ${SKIN=='5'?'active':''}" data-sa-value="5"><img src="static/img/bg/5.jpg" alt=""></a>
			        <a onclick="saveSkin('6')" class="themes__item ${SKIN=='6'?'active':''}" data-sa-value="6"><img src="static/img/bg/6.jpg" alt=""></a>
			        <a onclick="saveSkin('7')" class="themes__item ${SKIN=='7'?'active':''}" data-sa-value="7"><img src="static/img/bg/7.jpg" alt=""></a>
			        <a onclick="saveSkin('8')" class="themes__item ${SKIN=='8'?'active':''}" data-sa-value="8"><img src="static/img/bg/8.jpg" alt=""></a>
			        <a onclick="saveSkin('9')" class="themes__item ${SKIN=='9'?'active':''}" data-sa-value="9"><img src="static/img/bg/9.jpg" alt=""></a>
			        <a onclick="saveSkin('10')" class="themes__item ${SKIN=='10'?'active':''}" data-sa-value="10"><img src="static/img/bg/10.jpg" alt=""></a>
			    </div>
			</div>

            <section class="content" id="fhcontent">

				<iframe name="mainFrame" id="mainFrame" frameborder="0" src="<%=basePath%>main/tab" style="margin:0 auto;width:100%;height:100%;"></iframe>

            </section>
          
        </main>
          
        <!-- Javascript -->
        <!-- static/vendors -->
        <script src="static/vendors/bower_components/jquery/dist/jquery.min.js"></script>
        <script src="static/vendors/bower_components/popper.js/dist/umd/popper.min.js"></script>
        <script src="static/vendors/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
        <script src="static/vendors/bower_components/jquery.scrollbar/jquery.scrollbar.min.js"></script>
        <script src="static/vendors/bower_components/jquery-scrollLock/jquery-scrollLock.min.js"></script>

		<!--引入弹窗组件start-->
		<script type="text/javascript" src="plugins/fhdrag/drag.js"></script>
		<script type="text/javascript" src="plugins/fhdrag/dialog.js"></script>
		<!--引入弹窗组件end-->

		<!-- alert插件 -->
    	<script src="static/vendors/bower_components/sweetalert2/dist/sweetalert2.min.js"></script>
        <!-- App functions and actions -->
        <script src="static/js/app.min.js"></script>
        <script src="static/js/index.js"></script>
        <script src="static/js/jquery.cookie.js"></script>
        <!-- 提示 -->
  		<script src="static/js/jquery.tips.js"></script>
  		
		<script type="text/javascript">
        	var wlocal = "<%=basePath%>";
        	$(document).ready(function(){
        		$.cookie('SKIN', '${SKIN}', { expires: 7, path: '/' });
        		getInfo();
        	});
        </script>
        <!-- 及时通讯js¨ -->
		<script src="plugins/fhim/dist/layui.js"></script>
  		<!-- 及时通讯页面¨ -->
		<%@ include file="im.jsp"%>
        
    </body>
</html>
