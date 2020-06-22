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

<body style="background-color: rgba(255,255,255,0);">

	<!-- 页面加载过程中的那个加载状态 -->
	<div class="page-loader">
	    <div class="page-loader__spinner">
	        <svg viewBox="25 25 50 50">
	            <circle cx="50" cy="50" r="20" fill="none" stroke-width="2" stroke-miterlimit="10"></circle>
	        </svg>
	    </div>
	</div>
	<div class="card">
	<div class="card-body">
	    
	    <h4 class="card-title">上级菜单：${null == pds.MENU_NAME ?'(无) 此项为顶级菜单':pds.MENU_NAME}</h4>
	    
	    <form action="menu/${MSG }" name="Form" id="Form" method="post">
	    <input type="hidden" name="MENU_ID" id="menuId" value="${pd.MENU_ID }"/>
		<input type="hidden" name="MENU_TYPE" id="MENU_TYPE" value="1"/>
		<input type="hidden" name="MENU_STATE" id="MENU_STATE" value="${pd.MENU_STATE }"/>
		<input type="hidden" name="PARENT_ID" id="PARENT_ID" value="${null == pd.PARENT_ID ? MENU_ID:pd.PARENT_ID}"/>
	    <div id="showform">
	    
	    	<div class="input-group" style="margin-top:3px;">
                <span class="input-group-addon" style="width: 79px;"><span style="width: 100%;">菜单名称 </span></span>
                <div class="form-group">
                    <input type="text" class="form-control" name="MENU_NAME" id="MENU_NAME"  value="${pd.MENU_NAME }"  maxlength="32" placeholder="这里输入菜单名称" title="菜单名称" >
                    <i class="form-group__bar"></i>
                </div>
            </div>
	    
            <div class="input-group">
                <span class="input-group-addon" style="width: 79px;"><span style="width: 100%;">菜单链接</span></span>
                <div class="form-group">
                    <c:if test="${null != pds.MENU_NAME}">
					<input type="text" name="MENU_URL" id="MENU_URL" value="${pd.MENU_URL }" placeholder="这里输入菜单链接" class="form-control" maxlength="250" title="菜单链接" />
					</c:if>
					<c:if test="${null == pds.MENU_NAME}">
					<input type="text" name="MENU_URL" id="MENU_URL" value="" readonly="readonly" placeholder="顶级菜单禁止输入" class="form-control" />
					</c:if>
                    <i class="form-group__bar"></i>
                </div>
            </div>
            
            <div class="input-group" style="margin-top:3px;">
                <span class="input-group-addon" style="width: 79px;"><span style="width: 100%;">权限标识 </span></span>
                <div class="form-group">
                	<c:if test="${null != pds.MENU_NAME}">
                    <input type="text" class="form-control" name="SHIRO_KEY" id="SHIRO_KEY"  value="${pd.SHIRO_KEY }"  maxlength="32" placeholder="这里输入菜单权限标识(选填)" title="权限标识" >
                    </c:if>
                    <c:if test="${null == pds.MENU_NAME}">
					<input type="text" name="SHIRO_KEY" id="SHIRO_KEY" value="(无)" readonly="readonly" placeholder="顶级菜单禁止输入" class="form-control" />
					</c:if>
                    <i class="form-group__bar"></i>
                </div>
            </div>
            
            <div class="input-group" style="margin-top:3px;">
                <span class="input-group-addon" style="width: 79px;"><span style="width: 100%;">菜单序号</span></span>
                <div class="form-group">
                    <input type="number" class="form-control" name="MENU_ORDER" id="MENU_ORDER"  value="${pd.MENU_ORDER }"  maxlength="2" placeholder="这里输入菜单序号" title="菜单序号" >
                    <i class="form-group__bar"></i>
                </div>
            </div>
            
            <div class="input-group" style="margin-top:12px;">
                <h3 class="card-body__title" style="padding-left: 10px;">菜单状态：</h3>
                <div class="form-group" style="padding-left: 25px;">
            		<label class="custom-control custom-radio">
                        <input type="radio" name="radio-inline" class="custom-control-input" <c:if test="${pd.MENU_STATE == 1 }">checked="checked"</c:if> onclick="setType(1);"/>
                        <span class="custom-control-indicator"></span>
                        <span class="custom-control-description">显示</span>
                    </label>
    				<label class="custom-control custom-radio">
                        <input type="radio" name="radio-inline" class="custom-control-input" <c:if test="${pd.MENU_STATE == 0 }">checked="checked"</c:if> onclick="setType(0);"/>
                        <span class="custom-control-indicator"></span>
                        <span class="custom-control-description">隐藏</span>
                    </label>
                </div>
            </div>
            
            <div class="input-group" style="margin-top:10px;" >
            	<span style="width: 100%;text-align: center;">
            		<a class="btn btn-light btn--icon-text" onclick="save();">保存</a>
            		<a class="btn btn-light btn--icon-text" onclick="goback('${MENU_ID}');">取消</a>
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
  
	//取消
	function goback(MENU_ID){
		window.location.href="<%=basePath%>menu/list?MENU_ID="+MENU_ID;
	}
	
	//保存
	function save(){
		if($("#MENU_NAME").val()==""){
			$("#MENU_NAME").tips({
				side:3,
	            msg:'请输入菜单名称',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#MENU_NAME").focus();
			return false;
		}
		if($("#MENU_URL").val()==""){
			$("#MENU_URL").val('#');
		}
		//状态值为空默认为显示
		if($("#MENU_STATE").val()==""){
			$("#MENU_STATE").val(1);
		}
		if($("#SHIRO_KEY").val()==""){
			$("#SHIRO_KEY").val('(无)');
		}
		if($("#MENU_ORDER").val()==""){
			$("#MENU_ORDER").tips({
				side:1,
	            msg:'请输入菜单序号',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#MENU_ORDER").focus();
			return false;
		}
		if(isNaN(Number($("#MENU_ORDER").val()))){
			$("#MENU_ORDER").tips({
				side:1,
	            msg:'请输入菜单序号',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#MENU_ORDER").focus();
			$("#MENU_ORDER").val(1);
			return false;
		}
		$("#Form").submit();
	}
	
	//设置菜单类型or状态
	function setType(value){
		$("#MENU_STATE").val(value);
	}
	
  </script>
</body>
</html>
