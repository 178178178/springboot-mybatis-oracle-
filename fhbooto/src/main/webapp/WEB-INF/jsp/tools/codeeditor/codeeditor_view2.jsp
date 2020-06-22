<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
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
	
	<!-- 代码编辑器 -->
    <script src="plugins/codeEditor/jquery.min.js"></script>
    <script>
   	 	var codetype="php7";
    	var unid="59398d6898fb6";
    </script>
    <script src="plugins/codeEditor/runcode.js"></script>
	<style type="text/css" media="screen">
   		#editor { 
      			 //position: absolute;
      			 width: 100%;
      			 height: 600px;
      			 float: left;
       		font-size: 14px;
  				 }
	</style>
	<!-- 代码编辑器 -->
	
</head>
<body style="background-color: #202020;">

	<table id="table_report" class="table table-striped table-bordered table-hover">
		<tr>
			<td colspan="10">
 			  <div class="starter-template">
				 	 <div id="editor" class="ace_editor ace-monokai ace_dark"><textarea id="codeContent" class="ace_text-input" wrap="off" autocorrect="off" autocapitalize="off" spellcheck="false" style="opacity: 0; height: 17px; width: 8px; left: 45px; top: 0px;"></textarea></div>
			  </div>
			</td>
		</tr>
	</table>

	<script src="plugins/codeEditor/ace.js" type="text/javascript" charset="utf-8"></script>
	<script type="text/javascript">
		$(getCodeFromView());
		$(cmainFrame());
		
		if(ie_error()){
	        $('#editor').hide();
	    }else{
	        $('#editorBox').hide();
	        ace.require("ace/ext/language_tools");
	        var editor = ace.edit("editor");
	        editor.setOptions({
	            enableBasicAutocompletion: true,
	            enableSnippets: true,
	            enableLiveAutocompletion: true
	        });
	        editor.setTheme("ace/theme/monokai");
	        editor.getSession().setMode("ace/mode/php");
	    }
		
		//获取code
		function getCodeFromView(){
			var CODEEDITOR_ID = "${pd.CODEEDITOR_ID}";
			$.ajax({
				type: "POST",
				url: '<%=basePath%>codeeditor/getCodeFromView',
		    	data: {CODEEDITOR_ID:CODEEDITOR_ID,tm:new Date().getTime()},
				dataType:'json',
				cache: false,
				success: function(data){
					if("00" == data.result){
					  setCodeTxt(data.code);
					 }
				}
			});
		}
		
		//设置代码内容
		function setCodeTxt(value){
		    if(typeof(editor) == "undefined"){
		        $('#editorBox').val(value);
		    }else{
		        editor.setValue(value,-1);
		    } 
		}
		
		function cmainFrame(){
			var hmain = document.getElementById("editor");
			var bheight = document.documentElement.clientHeight;
			hmain .style.width = '100%';
			hmain .style.height = (bheight - 40) + 'px';
		}
	</script>
</body>
</html>