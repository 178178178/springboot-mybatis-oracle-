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
	    
	    <form action="head/saveSysSet1" name="Form" id="Form" method="post">
	    <input type="hidden" value="${fhsmsSound }" id="fhsmsSound" name="fhsmsSound" />
	    <div id="showform">
	    
            <div class="input-group">
                <span class="input-group-addon" style="width: 79px;"><span style="width: 100%;">系统名称</span></span>
                <div class="form-group">
                    <input type="text" class="form-control" name="sysName" id="sysName" value="${sysName }" placeholder="这里输入系统名称" maxlength="10"  title="系统名称">
                    <i class="form-group__bar"></i>
                </div>
            </div>
            
            <div class="input-group" style="margin-top:3px;">
                <span class="input-group-addon" style="width: 79px;"><span style="width: 100%;">每页条数</span></span>
                <div class="form-group">
                    <input type="number" class="form-control" name="showCount" id="showCount"  value="${showCount }"  maxlength="2" placeholder="这里输入每页条数" title="带分页的列表页面,每页显示条数" >
                    <i class="form-group__bar"></i>
                </div>
            </div>
            
            
            <h3 class="card-body__title" style="padding-left: 10px;margin-top:23px;">邮箱服务器配置</h3>
            <div class="input-group" style="margin-top:3px;">
                <span class="input-group-addon" style="width: 79px;"><span style="width: 100%;">SMTP</span></span>
                <div class="form-group">
                    <input type="text" class="form-control" name="SMTP" id="SMTP" value="${SMTP }" placeholder="这里输入SMTP" maxlength="32"  title="SMTP">
                    <i class="form-group__bar"></i>
                </div>
                <span class="input-group-addon" style="width: 79px;"><span style="width: 100%;">端口</span></span>
                <div class="form-group">
                    <input type="number" class="form-control" name="PORT" id="PORT"  value="${PORT }"  maxlength="5" placeholder="这里输入端口" title="端口" >
                    <i class="form-group__bar"></i>
                </div>
            </div>
            <div class="input-group" style="margin-top:3px;">
                <span class="input-group-addon" style="width: 79px;"><span style="width: 100%;">邮箱</span></span>
                <div class="form-group">
                    <input type="text" class="form-control" name="EMAIL" id="EMAIL" value="${EMAIL }" placeholder="这里输入邮箱服务器邮箱" maxlength="32"  title="邮箱服务器邮箱">
                    <i class="form-group__bar"></i>
                </div>
                <span class="input-group-addon" style="width: 79px;"><span style="width: 100%;">密码</span></span>
                <div class="form-group">
                    <input type="password" class="form-control" name="PAW" id="PAW"  value="${PAW }"  maxlength="100" placeholder="这里输入密码:" title="密码:" >
                    <i class="form-group__bar"></i>
                </div>
            </div>
            
            <h3 class="card-body__title" style="padding-left: 10px;margin-top:23px;">在线管理(站内信)服务器IP和端口配置</h3>
            <div class="input-group" style="margin-top:3px;">
                <span class="input-group-addon" style="width: 79px;"><span style="width: 100%;">IP地址</span></span>
                <div class="form-group">
                    <input type="text" class="form-control" name="onlineIp" id="onlineIp" value="${onlineIp }" placeholder="这里输入IP地址" maxlength="32"  title="IP地址">
                    <i class="form-group__bar"></i>
                </div>
                <span class="input-group-addon" style="width: 79px;"><span style="width: 100%;">端口</span></span>
                <div class="form-group">
                    <input type="number" class="form-control" name="onlinePort" id="onlinePort"  value="${onlinePort }"  maxlength="5" placeholder="这里输入端口" title="端口" >
                    <i class="form-group__bar"></i>
                </div>
            </div>
            
            <h3 class="card-body__title" style="padding-left: 10px;margin-top:23px;">即时聊天服务器IP和端口配置</h3>
            <div class="input-group" style="margin-top:3px;">
                <span class="input-group-addon" style="width: 79px;"><span style="width: 100%;">IP地址</span></span>
                <div class="form-group">
                    <input type="text" class="form-control" name="imIp" id="imIp" value="${imIp }" placeholder="这里输入IP地址" maxlength="32"  title="IP地址">
                    <i class="form-group__bar"></i>
                </div>
                <span class="input-group-addon" style="width: 79px;"><span style="width: 100%;">端口</span></span>
                <div class="form-group">
                    <input type="number" class="form-control" name="imPort" id="imPort"  value="${imPort }"  maxlength="5" placeholder="这里输入端口" title="端口" >
                    <i class="form-group__bar"></i>
                </div>
            </div>
            
            <h3 class="card-body__title" style="padding-left: 10px;margin-top:23px;">新消息提示音</h3>
            <label class="custom-control custom-radio">
               <input type="radio" name="radio-inline" class="custom-control-input" <c:if test="${fhsmsSound == 'm0' }">checked="checked"</c:if> onclick="setFhsmsSoundType('m0');">
               <span class="custom-control-indicator"></span>
               <span class="custom-control-description">静音</span>
            </label>
            <label class="custom-control custom-radio">
               <input type="radio" name="radio-inline" class="custom-control-input" <c:if test="${fhsmsSound == 'm1' }">checked="checked"</c:if> onclick="setFhsmsSoundType('m1');">
               <span class="custom-control-indicator"></span>
               <span class="custom-control-description">歪歪音效</span>
            </label>
            <label class="custom-control custom-radio">
               <input type="radio" name="radio-inline" class="custom-control-input" <c:if test="${fhsmsSound == 'm2' }">checked="checked"</c:if> onclick="setFhsmsSoundType('m2');">
               <span class="custom-control-indicator"></span>
               <span class="custom-control-description">美女音效</span>
            </label>
            <label class="custom-control custom-radio">
               <input type="radio" name="radio-inline" class="custom-control-input" <c:if test="${fhsmsSound == 'm3' }">checked="checked"</c:if> onclick="setFhsmsSoundType('m3');">
               <span class="custom-control-indicator"></span>
               <span class="custom-control-description">飞信音效</span>
            </label>
            <label class="custom-control custom-radio">
               <input type="radio" name="radio-inline" class="custom-control-input" <c:if test="${fhsmsSound == 'm4' }">checked="checked"</c:if> onclick="setFhsmsSoundType('m4');">
               <span class="custom-control-indicator"></span>
               <span class="custom-control-description">IOS短信音效</span>
            </label>
            <label class="custom-control custom-radio">
               <input type="radio" name="radio-inline" class="custom-control-input" <c:if test="${fhsmsSound == 'm5' }">checked="checked"</c:if> onclick="setFhsmsSoundType('m5');">
               <span class="custom-control-indicator"></span>
               <span class="custom-control-description">iPhoneQQ音效</span>
            </label>
            
            <div class="input-group" style="margin-top:10px;" >
            	<span style="width: 100%;text-align: center;">
            		<a class="btn btn-light btn--icon-text" onclick="save1();">保存</a>
            		<a class="btn btn-light btn--icon-text" onclick="top.Dialog.close();">取消</a>
            	</span>
            </div>
            
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
	<div style="display: none;" id="fhsmsobjsys"></div>
  <!-- Javascript -->
  <!-- static/vendors -->
  <script src="static/vendors/bower_components/jquery/dist/jquery.min.js"></script>
  <script src="static/vendors/bower_components/popper.js/dist/umd/popper.min.js"></script>
  <script src="static/vendors/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
  <script src="static/vendors/bower_components/jquery.scrollbar/jquery.scrollbar.min.js"></script>
  <script src="static/vendors/bower_components/jquery-scrollLock/jquery-scrollLock.min.js"></script>

  <!-- App functions and actions -->
  <script src="static/js/app.min.js"></script>
  
  <!-- 表单验证提示 -->
  <script src="static/js/jquery.tips.js"></script>
  <!-- 本页面依赖 --> 
  <script src="static/js/sys.js"></script>
</body>
</html>
