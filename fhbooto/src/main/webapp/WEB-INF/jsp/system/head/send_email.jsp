<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">

	    <!-- Vendor styles -->
	    <link rel="stylesheet" href="static/vendors/bower_components/material-design-iconic-font/dist/css/material-design-iconic-font.min.css">
	    <link rel="stylesheet" href="static/vendors/bower_components/animate.css/animate.min.css">
	    <link rel="stylesheet" href="static/vendors/bower_components/jquery.scrollbar/jquery.scrollbar.css">
	
	    <!-- App styles -->
	    <link rel="stylesheet" href="static/css/app.min.css">

		<style type="text/css">
		#dialog-add,#dialog-message,#dialog-comment{width:100%; height:100%; position:fixed; top:0px; z-index:99999999; display:none;}
		.commitopacity{position:absolute; width:100%; height:700px; background:#7f7f7f; filter:alpha(opacity=50); -moz-opacity:0.5; -khtml-opacity: 0.5; opacity: 0.5; top:0px; z-index:99999;}
		.commitbox{width:100%; margin:0px auto; position:absolute; top:0px; z-index:99999;}
		.commitbox_inner{width:96%; height:255px;  margin:6px auto; background:#efefef; border-radius:5px;}
		.commitbox_top{width:100%; height:253px; margin-bottom:10px; padding-top:10px; background:#FFF; border-radius:5px; box-shadow:1px 1px 3px #e8e8e8;}
		.commitbox_top textarea{width:95%; height:195px; display:block; margin:0px auto; border:0px;}
		.commitbox_cen{width:95%; height:40px; padding-top:10px;}
		.commitbox_cen div.left{float:left;background-size:15px; background-position:0px 3px; padding-left:18px; color:#f77500; font-size:16px; line-height:27px;}
		.commitbox_cen div.left img{width:30px;}
		.commitbox_cen div.right{float:right; margin-top:7px;}
		.commitbox_cen div.right span{cursor:pointer;}
		.commitbox_cen div.right span.save{border:solid 1px #c7c7c7; background:#6FB3E0; border-radius:3px; color:#FFF; padding:5px 10px;}
		.commitbox_cen div.right span.quxiao{border:solid 1px #f77400; background:#f77400; border-radius:3px; color:#FFF; padding:4px 9px;}
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
		
	<!-- 编辑用户名  -->
	<div id="dialog-add">
		<div class="commitopacity"></div>
	  	<div class="commitbox">
		  	<div class="commitbox_inner">
		        <div class="commitbox_top">
		        	<textarea name="EMAILS" id="EMAILS"  placeholder="请选输入邮箱,多个请用(;)分号隔开" title="请选输入邮箱,多个请用(;)分号隔开"></textarea>
		            <div class="commitbox_cen">
		                <div class="left" id="cityname"></div>
		                <div class="right"><span class="save" onClick="cancel_pl()">确定</span>&nbsp;&nbsp;<span class="quxiao" onClick="cancel_pl()">取消</span></div>
		            </div>
		        </div>
		  	</div>
	  	</div>
	</div>

	<div id="showform">
	<textarea name="CONTENT" id="CONTENT" style="display:none" ></textarea>
	<input type="hidden" name="TYPE" id="TYPE" value="2"/>
	<table style="width:98%;margin-top: 10px;margin-left: 1px;" >
		<tr>
			<td style="margin-top:0px;">
				 <div style="float: left;" style="width:81%"><textarea  name="EMAIL" id="EMAIL" rows="1" cols="50" style="width:925px;height:30px;" placeholder="请选输入邮箱,多个请用(;)分号隔开" title="请选输入邮箱,多个请用(;)分号隔开">${pd.EMAIL}</textarea></div>
				 <div style="float: right;margin-right: 12px;margin-top: -3px;" style="width:19%"><a class='btn btn-light btn--icon-text' title="查看用户名" onclick="dialog_open();"><i style="margin-top:3px;margin-left: 5px;"  class="zmdi zmdi-search"></i></a></div>
			</td>
		</tr>
		<tr>
			<td style="margin-top:0px;">
			
			    <div class="input-group">
	                <div class="form-group">
	                    <input type="text" class="form-control" name="TITLE" id="TITLE" value="" maxlength="100" placeholder="这里输入标题" title="标题">
	                    <i class="form-group__bar"></i>
	                </div>
	            </div>
			
			
			</td>
		</tr>
		<tr>
			<td style="padding-top: 3px;">
				 <script id="editor" type="text/plain" style="width:997px;height:439px;"></script>
			</td>
		</tr>
		<tr>
			<td style="text-align: center;padding-top: 15px;padding-left: 15px;" id="nr">
				<a class="btn btn-light btn--icon-text" onclick="sendEmail();">发送</a>
				<a class="btn btn-light btn--icon-text" onclick="top.Dialog.close();">取消</a>
				
				<label class="custom-control custom-radio" style="float:left;padding-left: 25px;">
                   <input type="radio" name="radio-inline" class="custom-control-input" onclick="setType('2');" checked="checked">
                   <span class="custom-control-indicator"></span>
                   <span class="custom-control-description">带标签</span>
                </label>
                <label class="custom-control custom-radio" style="float:left;padding-left:25px;">
                   <input type="radio" name="radio-inline" class="custom-control-input" onclick="setType(1');">
                   <span class="custom-control-indicator"></span>
                   <span class="custom-control-description">纯文本</span>
                </label>
				
				
			</td>
		</tr>
	</table>
	</div>
	
    <div id="jiazai" style="display:none;width: 100%;text-align: center;" class="page-loader" >
       <div><br/><br/><br/><h4 id='msg'>正在发送.....请耐心等待</h4>(注意对方邮箱垃圾箱是否收到)<h4><font color="red"><strong id="bsecond_shows"></strong></font><font color="red"><strong id="second_shows"></strong></font></h4></div>
	   <div class="page-loader__spinner">
	        <svg viewBox="25 25 50 50">
	            <circle cx="50" cy="50" r="20" fill="none" stroke-width="2" stroke-miterlimit="10"></circle>
	        </svg>
	   </div>
	   <br/>
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

	<!-- 百度富文本编辑框-->
	<script type="text/javascript" charset="utf-8">window.UEDITOR_HOME_URL = "<%=path%>/plugins/ueditor/";</script>
	<script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.all.min.js"> </script>
    <script type="text/javascript" charset="utf-8" src="plugins/ueditor/lang/zh-cn/zh-cn.js"></script>
	<!-- 百度富文本编辑框-->

	<!--引入属于此页面的js -->
	<script type="text/javascript" src="static/js/fhemail.js"></script>
    <script type="text/javascript">
    	var local = "<%=basePath%>";
    </script>
</body>
</html>