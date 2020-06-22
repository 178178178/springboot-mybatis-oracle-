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
	    
	    <form action="role/${msg}" name="Form" id="Form" method="post">
	    <input type="hidden" name="ROLE_ID" id="id" value="${pd.ROLE_ID}"/>
		<input name="PARENT_ID" id="parent_id" value="${pd.parent_id }" type="hidden">
	    <div id="showform">
	    
            <div class="input-group">
                <span class="input-group-addon" style="width: 79px;"><span style="width: 100%;">名称</span></span>
                <div class="form-group">
                    <input type="text" class="form-control" name="ROLE_NAME" id="ROLE_NAME" value="${pd.ROLE_NAME }" placeholder="这里输入这里输入名称" maxlength="10"  title="名称">
                    <i class="form-group__bar"></i>
                </div>
            </div>

            <div class="input-group" style="margin-top:10px;" >
            	<span style="width: 100%;text-align: center;">
            		<a class="btn btn-light btn--icon-text" onclick="save();">保存</a>
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
  
  <script type="text/javascript">
  
	//保存
	function save(){
		if($("#ROLE_NAME").val()==""){
			$("#ROLE_NAME").tips({
				side:3,
	            msg:'输入名称',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#ROLE_NAME").focus();
			return false;
		}
		$("#Form").submit();
		$("#showform").hide();
		$("#jiazai").show();
	}
	
  </script>
</body>
</html>
