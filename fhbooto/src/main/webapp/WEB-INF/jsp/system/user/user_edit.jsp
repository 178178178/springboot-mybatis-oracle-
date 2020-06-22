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
	    
	    <form action="user/${msg }" name="Form" id="Form" method="post">
	    <input type="hidden" name="USER_ID" id="USER_ID" value="${pd.USER_ID }"/>
	    <textarea style="display: none;" name="ROLE_IDS" id="ROLE_IDS" >${pd.ROLE_IDS }</textarea>
	    <c:if test="${fx == 'head'}">
			<input name="ROLE_ID" id="role_id" value="${pd.ROLE_ID }" type="hidden" />
			<input name="NUMBER" id="NUMBER" value="${pd.NUMBER }" type="hidden" />
		</c:if>
	    <div id="showform">
	    
	    	<c:if test="${fx != 'head'}">
			<div class="form-group" id="rolets">
				<select name="ROLE_ID" id="ROLE_ID" class="select2 select2-hidden-accessible" data-placeholder="请选择主职角色" tabindex="-1" aria-hidden="true">
					<option value=""></option>
					<c:forEach items="${roleList}" var="role">
					<option value="${role.ROLE_ID }" <c:if test="${role.ROLE_ID == pd.ROLE_ID}">selected</c:if>>${role.ROLE_NAME }</option>
					</c:forEach>
				</select>
            </div>
	    	</c:if>
	    	
	    	<c:if test="${fx != 'head'}">
			<div class="form-group">
				<select name="ZROLE_IDS" id="ZROLE_IDS" data-placeholder="请选择副职角色" class="select2" multiple>
					<option value=""></option>
					<c:forEach items="${roleList}" var="role">
					<option value="${role.ROLE_ID }" <c:if test="${role.RIGHTS == '1' }">selected</c:if>>${role.ROLE_NAME }</option>
					</c:forEach>
				</select>
            </div>
	    	</c:if>
	    
            <div class="input-group">
                <span class="input-group-addon" style="width: 79px;"><span style="width: 100%;">用户名</span></span>
                <div class="form-group">
                    <input type="text" class="form-control" name="USERNAME" id="USERNAME" value="${pd.USERNAME }" maxlength="32" placeholder="这里输入用户名" title="用户名">
                    <i class="form-group__bar"></i>
                </div>
            </div>
            
            <c:if test="${fx != 'head'}">
            <div class="input-group" style="margin-top:3px;">
                <span class="input-group-addon" style="width: 79px;"><span style="width: 100%;">编号</span></span>
                <div class="form-group">
                    <input type="text" class="form-control" name="NUMBER" id="NUMBER" value="${pd.NUMBER }" maxlength="32" placeholder="这里输入编号" title="编号" onblur="hasNumber('${pd.USERNAME }')">
                    <i class="form-group__bar"></i>
                </div>
            </div>
			</c:if>

            <div class="input-group" style="margin-top:3px;">
                <span class="input-group-addon" style="width: 79px;"><span style="width: 100%;">密码</span></span>
                <div class="form-group">
                    <input class="form-control" type="password" name="PASSWORD" id="PASSWORD"  maxlength="32" placeholder="输入密码" title="密码">
                    <i class="form-group__bar"></i>
                </div>
            </div>
            
            <div class="input-group" style="margin-top:3px;">
                <span class="input-group-addon">确认密码</span>
                <div class="form-group">
                    <input class="form-control" type="password" name="chkpwd" id="chkpwd"  maxlength="32" placeholder="确认密码" title="确认密码">
                    <i class="form-group__bar"></i>
                </div>
            </div>
            
            <div class="input-group" style="margin-top:3px;">
                <span class="input-group-addon" style="width: 79px;"><span style="width: 100%;">姓名</span></span>
                <div class="form-group">
                    <input type="text" class="form-control" name="NAME" id="NAME"  value="${pd.NAME }"  maxlength="32" placeholder="这里输入姓名" title="姓名" >
                    <i class="form-group__bar"></i>
                </div>
            </div>
            
            <div class="input-group" style="margin-top:3px;">
                <span class="input-group-addon" style="width: 79px;"><span style="width: 100%;">手机号</span></span>
                <div class="form-group">
                    <input class="form-control" type="number" name="PHONE" id="PHONE"  value="${pd.PHONE }"  maxlength="32" placeholder="这里输入手机号" title="手机号" >
                    <i class="form-group__bar"></i>
                </div>
            </div>
            
            <div class="input-group" style="margin-top:3px;">
                <span class="input-group-addon" style="width: 79px;"><span style="width: 100%;">邮箱</span></span>
                <div class="form-group">
                    <input class="form-control" type="email" name="EMAIL" id="EMAIL"  value="${pd.EMAIL }" maxlength="32" placeholder="这里输入邮箱" title="邮箱" onblur="hasEmail('${pd.USERNAME }')">
                    <i class="form-group__bar"></i>
                </div>
            </div>
            
            <div class="input-group" style="margin-top:3px;">
                <span class="input-group-addon" style="width: 79px;"><span style="width: 100%;">备注</span></span>
                <div class="form-group">
                    <input class="form-control" type="text" name="BZ" id="BZ"value="${pd.BZ }" placeholder="这里输入备注" maxlength="64" title="备注">
                    <i class="form-group__bar"></i>
                </div>
            </div>
            
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
  
  <!-- 下拉选择框插件 -->
  <script src="static/vendors/bower_components/select2/dist/js/select2.full.min.js"></script>
  <!-- 表单验证提示 -->
  <script src="static/js/jquery.tips.js"></script>
  
  <script type="text/javascript">
  
	$(document).ready(function(){
		if($("#USER_ID").val()!=""){
			$("#USERNAME").attr("readonly","readonly"); //用户禁止修改
		}
	});
  
	//键盘回车事件，执行保存
	$(document).keyup(function(event) {
		if (event.keyCode == 13) {
			$("#to-save").trigger("click");
		}
	});
	
	//保存
	function save(){
		
		if($("#ROLE_ID").val()==""){
			$("#rolets").tips({
				side:3,
	            msg:'选择主职角色',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#ROLE_ID").focus();
			return false;
		}
		
		if('null' != $("#ZROLE_IDS").val()){
			$("#ROLE_IDS").val($("#ZROLE_IDS").val());
		}		
		
		if($("#USERNAME").val()=="" || $("#USERNAME").val()=="此用户名已存在!"){
			$("#USERNAME").tips({
				side:3,
	            msg:'输入用户名',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#USERNAME").focus();
			$("#USERNAME").val('');
			return false;
		}else{
			$("#USERNAME").val(jQuery.trim($('#USERNAME').val()));
		}
		if($("#NUMBER").val()==""){
			$("#NUMBER").tips({
				side:3,
	            msg:'输入编号',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#NUMBER").focus();
			return false;
		}else{
			$("#NUMBER").val($.trim($("#NUMBER").val()));
		}
		if($("#USER_ID").val()=="" && $("#PASSWORD").val()==""){
			$("#PASSWORD").tips({
				side:3,
	            msg:'输入密码',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#PASSWORD").focus();
			return false;
		}
		if($("#PASSWORD").val()!=$("#chkpwd").val()){
			
			$("#chkpwd").tips({
				side:3,
	            msg:'两次密码不相同',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#chkpwd").focus();
			return false;
		}
		if($("#NAME").val()==""){
			$("#NAME").tips({
				side:3,
	            msg:'输入姓名',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#NAME").focus();
			return false;
		}
		var myreg = /^(((13[0-9]{1})|159)+\d{8})$/;
		if($("#PHONE").val()==""){
			$("#PHONE").tips({
				side:3,
	            msg:'输入手机号',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#PHONE").focus();
			return false;
		}else if($("#PHONE").val().length != 11 && !myreg.test($("#PHONE").val())){
			$("#PHONE").tips({
				side:3,
	            msg:'手机号格式不正确',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#PHONE").focus();
			return false;
		}
		if($("#EMAIL").val()==""){
			$("#EMAIL").tips({
				side:3,
	            msg:'输入邮箱',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#EMAIL").focus();
			return false;
		}else if(!ismail($("#EMAIL").val())){
			$("#EMAIL").tips({
				side:3,
	            msg:'邮箱格式不正确',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#EMAIL").focus();
			return false;
		}
		if($("#USER_ID").val()==""){
			hasUser();
		}else{
			$("#Form").submit();
			$("#showform").hide();
			$("#jiazai").show();
		}
	}
	function ismail(mail){
		return(new RegExp(/^(?:[a-zA-Z0-9]+[_\-\+\.]?)*[a-zA-Z0-9]+@(?:([a-zA-Z0-9]+[_\-]?)*[a-zA-Z0-9]+\.)+([a-zA-Z]{2,})+$/).test(mail));
	}
	
	//判断用户名是否存在
	function hasUser(){
		var USERNAME = $.trim($("#USERNAME").val());
		$.ajax({
			type: "POST",
			url: '<%=basePath%>user/hasUser',
	    	data: {USERNAME:USERNAME,tm:new Date().getTime()},
			dataType:'json',
			cache: false,
			success: function(data){
				 if("success" == data.result){
					$("#Form").submit();
					$("#showform").hide();
					$("#jiazai").show();
				 }else{
					$("#USERNAME").tips({
						side:3,
			            msg:'此用户名已存在',
			            bg:'#AE81FF',
			            time:2
			        });
					setTimeout("$('#USERNAME').val('此用户名已存在!')",500);
				 }
			}
		});
	}
	
	//判断邮箱是否存在
	function hasEmail(USERNAME){
		var EMAIL = $.trim($("#EMAIL").val());
		$.ajax({
			type: "POST",
			url: '<%=basePath%>user/hasEmail',
	    	data: {EMAIL:EMAIL,USERNAME:USERNAME,tm:new Date().getTime()},
			dataType:'json',
			cache: false,
			success: function(data){
				 if("success" != data.result){
					 $("#EMAIL").tips({
							side:3,
				            msg:'邮箱 '+EMAIL+' 已存在',
				            bg:'#AE81FF',
				            time:3
				        });
					 $("#EMAIL").val('');
				 }
			}
		});
	}
	
	//判断编码是否存在
	function hasNumber(USERNAME){
		var NUMBER = $.trim($("#NUMBER").val());
		$.ajax({
			type: "POST",
			url: '<%=basePath%>user/hasNumber',
	    	data: {NUMBER:NUMBER,USERNAME:USERNAME,tm:new Date().getTime()},
			dataType:'json',
			cache: false,
			success: function(data){
				 if("success" != data.result){
					 $("#NUMBER").tips({
							side:3,
				            msg:'编号 '+NUMBER+' 已存在',
				            bg:'#AE81FF',
				            time:3
				        });
					 $("#NUMBER").val('');
				 }
			}
		});
	}
  
  </script>
</body>
</html>
