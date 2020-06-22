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
        var codetype="java";
        var unid="59396e99ae344";
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
<body style="background-color: rgba(255,255,255,0);">
	
	<table class="table table-bordered mb-0">	
		<tr>
			<td colspan="10">
 			  <div class="starter-template">
				 	 <div id="editor" class="ace_editor ace-monokai ace_dark"><textarea id="codeContent" class="ace_text-input" wrap="off" autocorrect="off" autocapitalize="off" spellcheck="false" style="opacity: 0; height: 17px; width: 8px; left: 45px; top: 0px;"></textarea></div>
			  </div>
			</td>
		</tr>
		<tr>
			<td id="sts">
				<a class="btn btn-light btn--icon-text" onclick="save();">保存</a>
				<a class="btn btn-light btn--icon-text" onclick="reduction();">还原</a>
				<a class="btn btn-light btn--icon-text" onclick="history();">历史编辑</a>
			</td>
		</tr>
	</table>

	<script src="plugins/codeEditor/ace.js" type="text/javascript" charset="utf-8"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<script type="text/javascript">
		
		$(getCode());
		$(cmainFrame());
		
		//保存
		function save(){
			var codeTxt  = getCodeTxt();
			var type = "${pd.type}";
			var ftlNmame = "${pd.ftl}";
			$.ajax({
				type: "POST",
				url: '<%=basePath%>codeeditor/save',
		    	data: {codeTxt:codeTxt,type:type,ftlNmame:ftlNmame,tm:new Date().getTime()},
				dataType:'json',
				cache: false,
				success: function(data){
					if("success" == data.result){
					  $("#sts").tips({
							side:1,
				            msg:'保存成功',
				            bg:'#009100',
				            time:8
				       });
					 }
				}
			});
		}
		
		//获取code
		function getCode(){
			var type = "${pd.type}";
			var ftlNmame = "${pd.ftl}";
			$.ajax({
				type: "POST",
				url: '<%=basePath%>codeeditor/getCode',
		    	data: {type:type,ftlNmame:ftlNmame,tm:new Date().getTime()},
				dataType:'json',
				cache: false,
				success: function(data){
					if("success" == data.result){
					  setCodeTxt(data.code);
					 }
				}
			});
		}
		
		//还原
		function reduction(){
			var type = "${pd.type}";
			var ftlNmame = "${pd.ftl}";
			$.ajax({
				type: "POST",
				url: '<%=basePath%>codeeditor/reduction',
		    	data: {type:type,ftlNmame:ftlNmame,tm:new Date().getTime()},
				dataType:'json',
				cache: false,
				success: function(data){
					if("success" == data.result){
					  setCodeTxt(data.code);
					  $("#sts").tips({
							side:1,
				            msg:'还原成功',
				            bg:'#AE81FF',
				            time:8
				       });
					 }
				}
			});
		}
		
		//历史编辑
		function history(){
			 var type = "${pd.type}";
			 var ftlNmame = "${pd.ftl}";
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="历史编辑";
			 diag.URL = '<%=basePath%>codeeditor/list?msg=1&TYPE='+type+'&FTLNMAME='+ftlNmame;
			 diag.Width = 800;
			 diag.Height = 500;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮
			 diag.CancelEvent = function(){ //关闭事件
				if(diag.innerFrame.contentWindow.document.getElementById('msg').value == 'yes'){
					location.reload();
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//设置代码内容
		function setCodeTxt(value){
		    if(typeof(editor) == "undefined"){
		        $('#editorBox').val(value);
		    }else{
		        editor.setValue(value,-1);
		    } 
		}
		
		//获取代码内容
		function getCodeTxt(){
		    if(typeof(editor) == "undefined"){
		        return $('#editorBox').text();
		    }else{
		        return editor.getValue();
		    } 
		}
		
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
	        editor.getSession().setMode("ace/mode/java");
	    }
		
		function cmainFrame(){
			var hmain = document.getElementById("editor");
			var bheight = document.documentElement.clientHeight;
			hmain .style.width = '100%';
			hmain .style.height = (bheight  - 100) + 'px';
		}
		</script>
</body>
</html>