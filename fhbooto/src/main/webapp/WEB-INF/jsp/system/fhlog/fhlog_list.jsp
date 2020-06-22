<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"  %>
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
    
</head>

<body style="background-color: rgba(255,255,255,0);">

      <div class="card" style="margin-top:5px;">
         <div class="card-body">
          <form action="fhlog/list" method="post" name="Form" id="Form">
			<!-- 检索条件  -->
			<table>
				<tr>
					<td>
						<div class="form-group">
                            <input class="form-control" id="KEYWORDS" type="text" name="KEYWORDS" value="${pd.KEYWORDS }" placeholder="这里输入关键词" />
                            <i class="form-group__bar"></i>
                        </div>
					</td>
					<td style="vertical-align:top;padding-left:5px;">
						<a class="btn btn-light btn--icon-text" onclick="searchs();" style="width: 23px;height:23px;margin-top:8px;" title="检索"><i style="margin-top:-3px;margin-left: -5px;"  class="zmdi zmdi-search"></i></a>
					</td>
				</tr>
			</table>
			<!-- 检索  -->
	
             <table class="table table-hover mb-0">
                 <thead>
	                 <tr>
	                 	<th  style="width: 50px;">
                            <input type="checkbox" id="zcheckbox" style="margin-top: 2px;;">
						</th>
	                    <th style="width: 50px;">NO</th>
						<th>用户名</th>
						<th>事件</th>
						<th>操作时间</th>
						<th>操作</th>
	                 </tr>
                 </thead>
                 <tbody>
                 <!-- 开始循环 -->	
				 <c:choose>
					<c:when test="${not empty varList}">
                 	 <c:forEach items="${varList}" var="var" varStatus="vs">
		                 <tr>
							 <td>
							  	<input type="checkbox" style="margin-top: 2px;" name='ids' value="${var.FHLOG_ID}">
							 </td>
		                     <td>${page.showCount*(page.currentPage-1)+vs.index+1}</td>
		                     <td>${var.USERNAME }</td>
		                     <td>${var.CONTENT }</td>
		                     <td>${var.CZTIME }</td>
		                     <td>
		                     	<shiro:hasPermission name="fhlog:del"><a title="删除" onclick="del('${var.FHLOG_ID }');"><i class="zmdi zmdi-close zmdi-hc-fw"></i></a></shiro:hasPermission>
		                     </td>
		                 </tr>
	                 </c:forEach>
	                </c:when>
					<c:otherwise>
						<tr>
							<td colspan="10">没有相关数据</td>
						</tr>
					</c:otherwise>
				 </c:choose>
                 </tbody>
             </table>
             
             <table style="width:100%;margin-top:15px;">
				<tr>
					<td style="vertical-align:top;">
						<shiro:hasPermission name="fhlog:del"><a class="btn btn-light btn--icon-text" onclick="makeAll('确定要删除选中的数据吗?');">删除</a></shiro:hasPermission>
					</td>
					<td style="vertical-align:top;"><div style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
				</tr>
			</table>
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
    
    <!-- alert插件 -->
    <script src="static/vendors/bower_components/sweetalert2/dist/sweetalert2.min.js"></script>
	<!-- 表单验证提示 -->
  	<script src="static/js/jquery.tips.js"></script>
	<script type="text/javascript">
		//检索
		function searchs(){
			$("#Form").submit();
		}
		
		//删除
		function del(Id){
			swal({
                title: '确定要删除 吗?',
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
        			url: '<%=basePath%>fhlog/delete',
        	    	data: {FHLOG_ID:Id,tm:new Date().getTime()},
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
        				 setTimeout(searchs, 1500);
        			}
        		});
            }).catch(() => {});
		}
		
		//批量操作
		function makeAll(msg){
			swal({
                title: msg,
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
            	var str = '';
    			for(var i=0;i < document.getElementsByName('ids').length;i++){
    				  if(document.getElementsByName('ids')[i].checked){
    				  	if(str=='') str += document.getElementsByName('ids')[i].value;
    				  	else str += ',' + document.getElementsByName('ids')[i].value;
    				  }
    			}
    			if(str==''){
    				$("#zcheckbox").tips({
    					side:2,
    		            msg:'点这里全选',
    		            bg:'#AE81FF',
    		            time:3
    		        });
    				swal({
                        title: '您没有选择任何内容!',
                        text: '',
                        type: 'warning',
                        buttonsStyling: false,
                        confirmButtonClass: 'btn btn-sm btn-light',
                        background: 'rgba(0, 0, 0, 0.96)'
                    })
    				return;
    			}else{
    				if(msg == '确定要删除选中的数据吗?'){
    					$.ajax({
    						type: "POST",
    						url: '<%=basePath%>fhlog/deleteAll?tm='+new Date().getTime(),
    				    	data: {DATA_IDS:str},
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
    	        				 setTimeout(searchs, 1500);
    						}
    					});
    				}
    			}
            }).catch(() => {});
		}
		
		$(function() {
			//复选框控制全选,全不选 
			$('#zcheckbox').click(function(){
			 if($(this).is(':checked')){
				 $("input[name='ids']").click();
			 }else{
				 $("input[name='ids']").attr("checked", false);
			 }
			});
		})
		
	</script>
</body>
</html>
