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
	<!-- 日期框插件 -->
    <link rel="stylesheet" href="static/vendors/bower_components/flatpickr/dist/flatpickr.min.css">
    <!-- 下拉选择框插件 -->
    <link rel="stylesheet" href="static/vendors/bower_components/select2/dist/css/select2.min.css">
    <!-- App styles -->
    <link rel="stylesheet" href="static/css/app.min.css">
</head>

<body data-sa-theme="${r"${sessionScope.SKIN}"}">

 	<!-- 页面加载过程中的那个加载状态 -->
	<div class="page-loader">
	    <div class="page-loader__spinner">
	        <svg viewBox="25 25 50 50">
	            <circle cx="50" cy="50" r="20" fill="none" stroke-width="2" stroke-miterlimit="10"></circle>
	        </svg>
	    </div>
	</div>

	<div class="card-body">
					
		<form action="${objectNameLower}/${r"${msg }"}" name="Form" id="Form" method="post">
			<input type="hidden" name="${objectNameUpper}_ID" id="${objectNameUpper}_ID" value="${r"${pd."}${objectNameUpper}_ID${r"}"}"/>
			<input type="hidden" name="${faobject}_ID" id="${faobject}_ID" value="${r"${pd."}${faobject}_ID${r"}"}"/>
			<div id="showform">
<#list fieldList as var>
	<#if var[3] == "是">
		<#if var[1] == 'Date'>
			<div class="input-group" style="margin-top:3px;">
                <span class="input-group-addon" style="width: 79px;"><span style="width: 100%;">${var[2] }</span></span>
                <div class="form-group">
                    <input type="text" class="form-control date-picker flatpickr-input active" name="${var[0] }" id="${var[0] }" value="${r"${pd."}${var[0] }${r"}"}" maxlength="32" placeholder="这里输入${var[2] }" title="${var[2] }">
                    <i class="form-group__bar"></i>
                </div>
            </div>
		<#elseif var[1] == 'Integer'>
			<div class="input-group" style="margin-top:3px;">
                <span class="input-group-addon" style="width: 79px;"><span style="width: 100%;">${var[2] }</span></span>
                <div class="form-group">
                    <input type="number" class="form-control" name="${var[0] }" id="${var[0] }" value="${r"${pd."}${var[0] }${r"}"}" maxlength="32" placeholder="这里输入${var[2] }" title="${var[2] }">
                    <i class="form-group__bar"></i>
                </div>
            </div>
		<#elseif var[1] == 'Double'>
			<div class="input-group" style="margin-top:3px;">
                <span class="input-group-addon" style="width: 79px;"><span style="width: 100%;">${var[2] }</span></span>
                <div class="form-group">
                    <input type="number" class="form-control" name="${var[0] }" id="${var[0] }" value="${r"${pd."}${var[0] }${r"}"}" maxlength="32" placeholder="这里输入${var[2] }" title="${var[2] }">
                    <i class="form-group__bar"></i>
                </div>
            </div>
		<#else>
		<#if var[7] != 'null'>
			<div class="input-group" style="margin-top:3px;">
                <span class="input-group-addon" style="width: 79px; border:1px solid #596D88"><span style="width: 100%;">${var[2] }</span></span>
                <div class="form-group" style="padding-left: 15px;">
                    <select class="select2 select2-hidden-accessible" name="${var[0] }" id="${var[0] }"  title="${var[2] }"></select>
                </div>
            </div>
		<#else>
			<div class="input-group" style="margin-top:3px;">
                <span class="input-group-addon" style="width: 79px;"><span style="width: 100%;">${var[2] }</span></span>
                <div class="form-group">
                    <input type="text" class="form-control" name="${var[0] }" id="${var[0] }" value="${r"${pd."}${var[0] }${r"}"}" maxlength="${var[5] }" placeholder="这里输入${var[2] }" title="${var[2] }">
                    <i class="form-group__bar"></i>
                </div>
            </div>
		</#if>
		</#if>
	</#if>
</#list>

		 	<div class="input-group" style="margin-top:10px;" >
            	<span style="width: 100%;text-align: center;">
            		<a class="btn btn-light btn--icon-text" id="to-save" onclick="save();">保存</a>
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
    
    <!-- 日期框插件 -->
    <script src="static/vendors/bower_components/flatpickr/dist/flatpickr.min.js"></script>
	<!-- 下拉选择框插件 -->
    <script src="static/vendors/bower_components/select2/dist/js/select2.full.min.js"></script>
    
    <!-- 表单验证提示 -->
  	<script src="static/js/jquery.tips.js"></script>
		<script type="text/javascript">
		//保存
		function save(){
		<#list fieldList as var>
		<#if var[3] == "是">
			if($("#${var[0] }").val()==""){
				$("#${var[0] }").tips({
					side:3,
		            msg:'请输入${var[2] }',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#${var[0] }").focus();
			return false;
			}
		</#if>
		</#list>
			$("#Form").submit();
			$("#showform").hide();
			$("#jiazai").show();
		}
		
		$(function() {

<#list fieldList as var>
	<#if var[3] == "是">
		<#if var[1] == 'String'>
			<#if var[7] != 'null'>
				var ${var[0] } = "${r"${pd."}${var[0] }${r"}"}";
				$.ajax({
					type: "POST",
					url: '<%=basePath%>dictionaries/getLevels?tm='+new Date().getTime(),
			    	data: {DICTIONARIES_ID:'${var[7] }'},
					dataType:'json',
					cache: false,
					success: function(data){
						 $("#${var[0] }").append("<option value=''>请选择${var[2] }</option>");
						 $.each(data.list, function(i, dvar){
							 if(${var[0] } == dvar.BIANMA){
								 $("#${var[0] }").append("<option value="+dvar.BIANMA+" selected='selected'>"+dvar.NAME+"</option>");
							 }else{
								 $("#${var[0] }").append("<option value="+dvar.BIANMA+">"+dvar.NAME+"</option>");
							 }
						 });
					}
				});
			</#if>
		</#if>
	</#if>
</#list>

		});
		</script>
</body>
</html>