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
	<!-- alert插件 -->
    <link rel="stylesheet" href="static/vendors/bower_components/sweetalert2/dist/sweetalert2.min.css">
    <!-- App styles -->
    <link rel="stylesheet" href="static/css/app.min.css">
    
    <style type="text/css">
    	.costs-marl15{margin-left: 15px;}
		div.costs-uploadfile-div{
		    position:relative;
		    cursor:pointer;
		}
		div.costs-uploadfile-div #textfield{
		    width:461px;
		    height:30px;
		    cursor:pointer;
		}
		div.costs-uploadfile-div #tp{
		    width:461px;
		    height:30px;    
		    position: absolute;
		    top: 0;
		    left:0;
		    filter: alpha(opacity:0);
		    opacity: 0;
		    cursor:pointer;
		}
    </style>
    
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
		<form action="qgroup/${msg }" name="Form" id="Form" method="post" enctype="multipart/form-data">
			<input type="hidden" name="QGROUP_ID" id="QGROUP_ID" value="${pd.QGROUP_ID}"/>
			<input type="hidden" name="QID" id="QID" value="${pd.QID}"/>
			<div id="showform" style="padding-top: 13px;">
				<div class="input-group">
	                <span class="input-group-addon" style="width: 79px;"><span style="width: 100%;">按钮名称</span></span>
	                <div class="form-group">
	                    <input type="text" class="form-control" name="NAME" id="NAME" value="${pd.NAME }" maxlength="32" placeholder="这里输入群名称" title="群名称">
	                    <i class="form-group__bar"></i>
	                </div>
	            </div>
				<div class="input-group" style="padding-top: 10px;">
	                <span class="input-group-addon" style="width: 79px; border:1px solid #596D88;"><span style="width: 100%;">群头像</span></span>
	                <div class="form-group">
	                    <div class="costs-uploadfile-div">   
	                        <c:if test="${pd == null || pd.PHOTO == '' || pd.PHOTO == null }">                   
						    <input type="file" name="tp" id="tp" onchange="fileType(this)" /> 
						    <input type='text' id="textfield" class="btn btn-light btn--icon-text" value="请选择选择图片" /> 
						    </c:if>
						    <c:if test="${pd != null && pd.PHOTO != '' && pd.PHOTO != null }">
							<a href="${pd.PHOTO}" target="_blank">&nbsp;<img src="${pd.PHOTO}" width="50"/></a>
							<a title="删除" onclick="delP('${pd.PHOTO}','${pd.QGROUP_ID }');"><i class="zmdi zmdi-close zmdi-hc-fw"></i></a>
							<input type="hidden" name="tpz" id="tpz" value="${pd.PHOTO }"/>
							</c:if>
						</div>
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

	<!-- alert插件 -->
    <script src="static/vendors/bower_components/sweetalert2/dist/sweetalert2.min.js"></script>
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
		            msg:'请输入群名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NAME").focus();
			return false;
			}
			if(typeof($("#tpz").val()) == "undefined"){
				if($("#tp").val()=="" || document.getElementById("tp").files[0] =='请选择图片'){
					
					$("#tp").tips({
						side:3,
			            msg:'请选图片',
			            bg:'#AE81FF',
			            time:3
			        });
					return false;
				}
			}
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		
		//过滤类型
		function fileType(obj){
			document.getElementById('textfield').value=obj.value;
			var fileType=obj.value.substr(obj.value.lastIndexOf(".")).toLowerCase();//获得文件后缀名
		    if(fileType != '.gif' && fileType != '.png' && fileType != '.jpg' && fileType != '.jpeg'){
		    	$("#tp").tips({
					side:3,
		            msg:'请上传图片格式的文件',
		            bg:'#AE81FF',
		            time:3
		        });
		    	$("#tp").val('');
		    	document.getElementById("tp").files[0] = '请选择图片';
		    }
		}
		
		//删除
		function delP(PATH,QGROUP_ID){
			swal({
                title: '确定要删除图片吗?',
                text: '',
                type: 'warning',
                showCancelButton: true,
                buttonsStyling: false,
                confirmButtonClass: 'btn btn-danger',
                confirmButtonText: '确定',
                cancelButtonClass: 'btn btn-light',
                cancelButtonText: '取消',
                background: 'rgba(0, 0, 0, 0.96)'
            }).then(function(){
            	$.ajax({
        			type: "POST",
        			url: '<%=basePath%>qgroup/deltp',
        	    	data: {PATH:PATH,QGROUP_ID:QGROUP_ID,tm:new Date().getTime()},
        			dataType:'json',
        			cache: false,
        			success: function(data){
        				 if("success" == data.result){
        					 swal({
        		                    title: '删除成功',
        		                    text: '已经从列表中删除',
        		                    type: 'success',
        		                    buttonsStyling: false,
        		                    showConfirmButton: false,
        		                    confirmButtonClass: 'btn btn-light',
        		                    background: 'rgba(0, 0, 0, 0.96)'
        		                });
        				 }
        				 setTimeout("document.location.reload()", 1500);
        			}
        		});
            }).catch(() => {});
		}
		
		</script>
</body>
</html>