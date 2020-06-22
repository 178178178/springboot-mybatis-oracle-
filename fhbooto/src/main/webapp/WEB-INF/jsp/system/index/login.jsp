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
        <meta name="author" content="fhadmin-qq:313596790">
        <title>${sessionScope.sysName}</title>
        <!-- Vendor styles -->
        <link rel="stylesheet" href="static/vendors/bower_components/material-design-iconic-font/dist/css/material-design-iconic-font.min.css">
        <link rel="stylesheet" href="static/vendors/bower_components/animate.css/animate.min.css">
        
        <!-- alert插件 -->
    	<link rel="stylesheet" href="static/vendors/bower_components/sweetalert2/dist/sweetalert2.min.css">
        
        <!-- App styles -->
        <link rel="stylesheet" href="static/css/app.min.css">
    </head>

    <body data-sa-theme="7">
        <div class="login">

            <!-- Login -->
            <div class="login__block active" id="l-login">
                <div class="login__block__header">
                    <i class="zmdi zmdi-account-circle"></i>
                    FH Admin
                    <div class="actions actions--inverse login__block__actions">
                        <div class="dropdown">
                            <i data-toggle="dropdown" class="zmdi zmdi-more-vert actions__item"></i>

                            <div class="dropdown-menu dropdown-menu-right">
                                <a class="dropdown-item" data-sa-action="login-switch" data-sa-target="#l-register" onclick="setNowLR('r');">创建一个账户</a>
                                <a class="dropdown-item" data-sa-action="login-switch" data-sa-target="#l-forget-password" onclick="setNowLR('w');">忘记密码?</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="login__block__body">
                    <div class="form-group">
                        <input type="text" class="form-control text-center" placeholder="请输入用户名" name="USERNAME" id="USERNAME">
                    </div>
                    <div class="form-group">
                        <input type="password" class="form-control text-center" placeholder="请输入密码" name="PASSWORD" id="PASSWORD">
                    </div>
                    <a id="to-login" onclick="check();" class="btn btn--icon login__block__btn"><i class="zmdi zmdi-long-arrow-right"></i></a>
                </div>
            </div>

            <!-- Register -->
            <div class="login__block" id="l-register">
                <div class="login__block__header">
                    <i class="zmdi zmdi-account-circle"></i>
                    		注册用户
                    <div class="actions actions--inverse login__block__actions">
                        <div class="dropdown">
                            <i data-toggle="dropdown" class="zmdi zmdi-more-vert actions__item"></i>

                            <div class="dropdown-menu dropdown-menu-right">
                                <a class="dropdown-item" data-sa-action="login-switch" data-sa-target="#l-login" id="hasUser" onclick="setNowLR('l');">已经有账户了?</a>
                                <a class="dropdown-item" data-sa-action="login-switch" data-sa-target="#l-forget-password" onclick="setNowLR('w');">忘记密码?</a>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="login__block__body">
                    <div class="form-group">
                        <input type="text" class="form-control text-center" placeholder="您的姓名" name="RNAME" id="RNAME">
                    </div>

                    <div class="form-group form-group--centered">
                        <input type="text" class="form-control text-center" placeholder="请输入用户名" name="RUSERNAME" id="RUSERNAME">
                    </div>

                    <div class="form-group form-group--centered">
                        <input type="password" class="form-control text-center" placeholder="请输入密码" name="RPASSWORD" id="RPASSWORD">
                    </div>
                    <a class="btn btn--icon login__block__btn" onclick="register();" id="to-register"><i class="zmdi zmdi-plus"></i></a>
                </div>
            </div>

            <!-- Forgot Password -->
            <div class="login__block" id="l-forget-password">
                <div class="login__block__header">
                    <i class="zmdi zmdi-account-circle"></i>
                    	忘记密码?
                    <div class="actions actions--inverse login__block__actions">
                        <div class="dropdown">
                            <i data-toggle="dropdown" class="zmdi zmdi-more-vert actions__item"></i>
                            <div class="dropdown-menu dropdown-menu-right">
                                <a class="dropdown-item" data-sa-action="login-switch" data-sa-target="#l-login" onclick="setNowLR('l');">已经有账户了?</a>
                                <a class="dropdown-item" data-sa-action="login-switch" data-sa-target="#l-register" onclick="setNowLR('r');">创建一个账户</a>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="login__block__body">
                    <p class="mb-5">您好,忘记密码请联系管理员找回, 邮箱xxxxx@xx.com.</p>
                </div>
            </div>
        </div>

        <!-- Older IE warning message -->
            <!--[if IE]>
                <div class="ie-warning">
                    <h1>Warning!!</h1>
                    <p>您正在使用过时的Internet Explorer版本，请升级到以下任何Web浏览器以访问该网站.</p>

                    <div class="ie-warning__downloads">
                        <a href="http://www.google.com/chrome">
                            <img src="img/browsers/chrome.png" alt="">
                        </a>

                        <a href="https://www.mozilla.org/en-US/firefox/new">
                            <img src="img/browsers/firefox.png" alt="">
                        </a>

                        <a href="http://www.opera.com">
                            <img src="img/browsers/opera.png" alt="">
                        </a>

                        <a href="https://support.apple.com/downloads/safari">
                            <img src="img/browsers/safari.png" alt="">
                        </a>

                        <a href="https://www.microsoft.com/en-us/windows/microsoft-edge">
                            <img src="img/browsers/edge.png" alt="">
                        </a>

                        <a href="http://windows.microsoft.com/en-us/internet-explorer/download-ie">
                            <img src="img/browsers/ie.png" alt="">
                        </a>
                    </div>
                    <p>Sorry for the inconvenience!</p>
                </div>
            <![endif]-->

        <!-- Javascript -->
        <!-- Vendors -->
        <script src="static/vendors/bower_components/jquery/dist/jquery.min.js"></script>
        <script src="static/vendors/bower_components/popper.js/dist/umd/popper.min.js"></script>
        <script src="static/vendors/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
	
		<!-- alert插件 -->
    	<script src="static/vendors/bower_components/sweetalert2/dist/sweetalert2.min.js"></script>

        <!-- App functions and actions -->
        <script src="static/js/app.min.js"></script>
        
        <script src="static/js/login.js"></script>
        <script src="static/js/jquery.tips.js"></script>
        <script src="static/js/jquery.cookie.js"></script>
        <script src="static/js/jQuery.md5.js"></script>
        <script type="text/javascript">
        	var local = "<%=basePath%>";
        </script>
        
        <c:if test="${'1' == msg}">
			<script type="text/javascript">
				$(tsMsg());
				function tsMsg(){
					 swal({
		                    title: '登录失败!',
		                    text: '此用户在其它终端已经早于您登录,您暂时无法登录!',
		                    type: 'warning',
		                    buttonsStyling: false,
		                    showConfirmButton: false,
		                    confirmButtonClass: 'btn btn-light',
		                    background: 'rgba(0, 0, 0, 0.96)'
		                });
				}
			</script>
		</c:if>
		<c:if test="${'2' == msg}">
			<script type="text/javascript">
				$(tsMsg());
				function tsMsg(){
					 swal({
		                    title: '强制下线!',
		                    text: '您被系统管理员强制下线或您的帐号在别处登录!',
		                    type: 'warning',
		                    buttonsStyling: false,
		                    showConfirmButton: false,
		                    confirmButtonClass: 'btn btn-light',
		                    background: 'rgba(0, 0, 0, 0.96)'
		                });
				}
			</script>
		</c:if>
		
    </body>
</html>
