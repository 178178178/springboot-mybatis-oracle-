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
    
	<!-- 下拉选择框插件 -->
    <link rel="stylesheet" href="static/vendors/bower_components/select2/dist/css/select2.min.css">
    
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
			<c:if test="${null != rpd}">
			<div class="input-group">
                <span class="input-group-addon" style="width: 79px;"><span style="width: 100%;">职位</span></span>
                <div class="form-group">
                    <input type="text" class="form-control" value="${rpd.ROLE_NAME }" disabled="disabled"  title="职位">
                    <i class="form-group__bar"></i>
                </div>
            </div>
			</c:if>
			
			<c:if test="${null == rpd}">
			<c:if test="${fx != 'head'}">
			<div class="input-group">
				<span class="input-group-addon" style="width: 79px; border:1px solid #596D88"><span style="width: 100%;">职位</span></span>
				<div class="form-group" style="padding-left: 15px;">
					<select name="ROLE_ID" id="ROLE_ID" class="select2 select2-hidden-accessible">
						<c:forEach items="${roleList}" var="role">
						<option value="${role.ROLE_ID }" <c:if test="${role.ROLE_ID == pd.ROLE_ID}">selected</c:if>>${role.ROLE_NAME }</option>
						</c:forEach>
					</select>
				</div>
            </div>
			</c:if>
			
			<div class="input-group" style="padding-top: 5px;">
                <span class="input-group-addon" style="width: 79px;"><span style="width: 100%;">用户名</span></span>
                <div class="form-group">
                    <input type="text" class="form-control" value="${null==pd?'无此用户名':pd.USERNAME }" disabled="disabled"  title="用户名">
                    <i class="form-group__bar"></i>
                </div>
            </div>
            
            <div class="input-group" style="padding-top: 5px;">
                <span class="input-group-addon" style="width: 79px;"><span style="width: 100%;">编号</span></span>
                <div class="form-group">
                    <input type="text" class="form-control" value="${pd.NUMBER }" disabled="disabled"  title="编号">
                    <i class="form-group__bar"></i>
                </div>
            </div>
			
			<div class="input-group" style="padding-top: 5px;">
                <span class="input-group-addon" style="width: 79px;"><span style="width: 100%;">姓名</span></span>
                <div class="form-group">
                    <input type="text" class="form-control" value="${pd.NAME }" disabled="disabled"  title="姓名">
                    <i class="form-group__bar"></i>
                </div>
            </div>
            
            <div class="input-group" style="padding-top: 5px;">
                <span class="input-group-addon" style="width: 79px;"><span style="width: 100%;">手机号</span></span>
                <div class="form-group">
                    <input type="text" class="form-control" value="${pd.PHONE }" disabled="disabled"  title="手机号">
                    <i class="form-group__bar"></i>
                </div>
            </div>
            
            <div class="input-group" style="padding-top: 5px;">
                <span class="input-group-addon" style="width: 79px;"><span style="width: 100%;">邮箱</span></span>
                <div class="form-group">
                    <input type="text" class="form-control" value="${pd.EMAIL }" disabled="disabled"  title="邮箱">
                    <i class="form-group__bar"></i>
                </div>
            </div>
            
            <div class="input-group" style="padding-top: 5px;">
                <span class="input-group-addon" style="width: 79px;"><span style="width: 100%;">备注</span></span>
                <div class="form-group">
                    <input type="text" class="form-control" value="${pd.BZ }" disabled="disabled"  title="备注">
                    <i class="form-group__bar"></i>
                </div>
            </div>
            
			</c:if>
	    
	</div>
        
    <!-- Javascript -->
    <!-- static/vendors -->
    <script src="static/vendors/bower_components/jquery/dist/jquery.min.js"></script>
    <script src="static/vendors/bower_components/popper.js/dist/umd/popper.min.js"></script>
    <script src="static/vendors/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
    <script src="static/vendors/bower_components/jquery.scrollbar/jquery.scrollbar.min.js"></script>
    <script src="static/vendors/bower_components/jquery-scrollLock/jquery-scrollLock.min.js"></script>
  	
  	<!-- 下拉选择框插件 -->
 	 <script src="static/vendors/bower_components/select2/dist/js/select2.full.min.js"></script>
  
    <!-- App functions and actions -->
    <script src="static/js/app.min.js"></script>
</html>