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
	    
	   <form action="dictionaries/${msg }" name="Form" id="Form" method="post">
		<input type="hidden" name="DICTIONARIES_ID" id="DICTIONARIES_ID" value="${pd.DICTIONARIES_ID}"/>
		<input type="hidden" name="PARENT_ID" id="PARENT_ID" value="${null == pd.PARENT_ID ? DICTIONARIES_ID:pd.PARENT_ID}"/>
		<input type="hidden" name="YNDEL" id="YNDEL" value="no"/>
	    <div id="showform">
	    
	    	<h4 class="card-title">上级：${null == pds.NAME ?'(无) 此项为顶级':pds.NAME}</h4>
	    
            <div class="input-group">
                <span class="input-group-addon" style="width: 79px;"><span style="width: 100%;">名称</span></span>
                <div class="form-group">
                    <input type="text" class="form-control" name="NAME" id="NAME" value="${pd.NAME }" maxlength="32" placeholder="这里输入名称" title="名称">
                    <i class="form-group__bar"></i>
                </div>
            </div>
            
			<div class="input-group" style="margin-top:3px;">
                <span class="input-group-addon" style="width: 79px;"><span style="width: 100%;">英文</span></span>
                <div class="form-group">
                    <input type="text" class="form-control" name="NAME_EN" id="NAME_EN" value="${pd.NAME_EN }" maxlength="32" placeholder="这里输入英文名称" title="英文名称">
                    <i class="form-group__bar"></i>
                </div>
            </div>
            
            <div class="input-group" style="margin-top:3px;">
                <span class="input-group-addon" style="width: 79px;"><span style="width: 100%;">编码</span></span>
                <div class="form-group">
                    <input type="text" class="form-control" name="BIANMA" id="BIANMA" value="${pd.BIANMA }" maxlength="32" placeholder="这里输入编码 (不重复, 禁止修改)" title="编码" <c:if test="${null != pd.BIANMA}">readonly="readonly"</c:if> <c:if test="${null == pd.BIANMA}">onblur="hasBianma();"</c:if>>
                    <i class="form-group__bar"></i>
                </div>
            </div>
            
            <div class="input-group" style="margin-top:3px;">
                <span class="input-group-addon" style="width: 79px;"><span style="width: 100%;">排序</span></span>
                <div class="form-group">
                    <input type="number" class="form-control" name="ORDER_BY" id="ORDER_BY" value="${pd.ORDER_BY }" maxlength="32" placeholder="这里输入排序" title="排序">
                    <i class="form-group__bar"></i>
                </div>
            </div>
            
            <div class="input-group" style="margin-top:3px;">
                <span class="input-group-addon" style="width: 79px;"><span style="width: 100%;">备注</span></span>
                <div class="form-group">
                    <input class="form-control" type="text" name="BZ" id="BZ"  value="${pd.BZ }"  maxlength="50" placeholder="这里输入备注说明" title="备注说明" >
                    <i class="form-group__bar"></i>
                </div>
            </div>
            
            <div class="input-group" style="margin-top:3px;">
                <span class="input-group-addon" style="width: 79px;"><span style="width: 100%;">排查表</span></span>
                <div class="form-group">
                    <input type="text" class="form-control" name="TBSNAME" id="TBSNAME" value="${pd.TBSNAME }" maxlength="100" placeholder="这里输入表名, 多个用逗号分隔(非必录)" title="排查表">
                    <i class="form-group__bar"></i>
                </div>
            </div>
            
            <div class="input-group" style="margin-top:3px;">
                <span class="input-group-addon" style="width: 79px;"><span style="width: 100%;">关联字段</span></span>
                <div class="form-group">
                    <input type="text" class="form-control" name="TBFIELD" id="TBFIELD" value="${pd.TBFIELD }" maxlength="32" placeholder="这这里输入关联字段,默认:BIANMA(非必录)" title="关联字段">
                    <i class="form-group__bar"></i>
                </div>
            </div>
            
            <div class="input-group" style="padding-top: 25px;padding-left: 13px;">
				<h6 class="card-subtitle">排查表：删除此条数据时会去此表查询是否被占用(是:禁止删除)</h6>
			</div>
			
			<c:if test="${msg == 'save' }">
			<div class="input-group" style="margin-top:10px;">
                <h3 class="card-body__title" style="padding-left: 8px;">禁止删除：</h3>
                <div class="form-group" style="padding-left: 16px;">
            		<div class="toggle-switch toggle-switch--cyan" style="margin-top:-3px;">
                        <input type="checkbox" class="toggle-switch__checkbox" onclick="yesOrNO();">
                        <i class="toggle-switch__helper"></i>
                    </div>
                </div>
            </div>
            </c:if>
            
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
    
    <!-- 表单验证提示 -->
  	<script src="static/js/jquery.tips.js"></script>
    
    <script type="text/javascript">

		//保存
		function save(){
			if($("#NAME").val()==""){
				$("#NAME").tips({
					side:3,
		            msg:'请输入名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NAME").focus();
			return false;
			}
			if($("#NAME_EN").val()==""){
				$("#NAME_EN").tips({
					side:3,
		            msg:'请输入英文',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NAME_EN").focus();
			return false;
			}
			if($("#BIANMA").val()==""){
				$("#BIANMA").tips({
					side:3,
		            msg:'请输入编码',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#BIANMA").focus();
			return false;
			}
			if($("#ORDER_BY").val()==""){
				$("#ORDER_BY").tips({
					side:3,
		            msg:'请输入数字',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ORDER_BY").focus();
			return false;
			}
			$("#Form").submit();
			$("#showform").hide();
			$("#jiazai").show();
		}
		
		//判断编码是否存在
		function hasBianma(){
			var BIANMA = $.trim($("#BIANMA").val());
			if("" == BIANMA)return;
			$.ajax({
				type: "POST",
				url: '<%=basePath%>dictionaries/hasBianma',
		    	data: {BIANMA:BIANMA,tm:new Date().getTime()},
				dataType:'json',
				cache: false,
				success: function(data){
					 if("success" == data.result){
					 }else{
						$("#BIANMA").tips({
							side:1,
				            msg:'编码'+BIANMA+'已存在,重新输入',
				            bg:'#AE81FF',
				            time:5
				        });
						$('#BIANMA').val('');
					 }
				}
			});
		}
		
		//禁删开关
		function yesOrNO(){
			if("no" == $("#YNDEL").val()){
				$("#YNDEL").val('yes');
			}else{
				$("#YNDEL").val('no');
			}
		}
	</script>
</body>
</html>
