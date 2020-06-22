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
		div.costs-uploadfile-div #fileField{
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
	    
	    <form action="user/readExcel" name="Form" id="Form" method="post" enctype="multipart/form-data">
	    <div id="showform">
            <div class="input-group">
                <span class="input-group-addon" style="width: 79px; border:1px solid #596D88;"><span style="width: 100%;">excel文件</span></span>
                <div class="form-group">
                    <div class="costs-uploadfile-div">                             
					    <input type="file" name="excel" id="fileField" onchange="checkFileType(this)" /> 
					    <input type='text' id="textfield" class="btn btn-light btn--icon-text" value="请选择选择excel文件" /> 
					</div>
                </div>
            </div>
            <div class="input-group" style="margin-top:10px;" >
            	<span style="width: 100%;text-align: center;">
            		<a class="btn btn-light btn--icon-text" id="to-save" onclick="save();">导入</a>
            		<a class="btn btn-light btn--icon-text" onclick="top.Dialog.close();">取消</a>
            		<a class="btn btn-light btn--icon-text" id="to-save" onclick="window.location.href='<%=basePath%>user/downExcel'">下载模版</a>
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
	    
		function checkFileType(obj){
			document.getElementById('textfield').value=obj.value;
			var fileType=obj.value.substr(obj.value.lastIndexOf(".")).toLowerCase();//获得文件后缀名
		    if(fileType != '.xls'){
		    	$("#fileField").tips({
					side:3,
		            msg:'请上传xls格式的文件',
		            bg:'#AE81FF',
		            time:3
		        });
		    	$("#fileField").val('');
		    	$("#textfield").val('请选择xls格式的文件');
		    }
		}
		
		//保存
		function save(){
			if($("#fileField").val()==""){
				$("#fileField").tips({
					side:3,
		            msg:'请选择文件',
		            bg:'#AE81FF',
		            time:3
		        });
				return false;
			}
			$("#Form").submit();
			$("#showform").hide();
			$("#jiazai").show();
		}
    
	</script>
</body>
</html>
