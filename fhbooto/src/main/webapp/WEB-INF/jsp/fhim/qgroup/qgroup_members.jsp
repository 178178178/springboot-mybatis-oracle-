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
    
    <style type="text/css">
		img{width:39px; height:39px; border-radius:50%;-webkit-border-radius:50%;-moz-border-radius:50%;}
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

      <div class="card" style="margin-top:5px;">
         <div class="card-body">
			<!-- 检索  -->
			<form action="qgroup/groupMembers" method="post" name="Form" id="Form">
			<input name="QGROUP_ID" id="QGROUP_ID" type="hidden" value="${pd.QGROUP_ID }" />
			<table>
				<tr>
					<td>
						<div class="form-group">
                            <input class="form-control" id="keywords" type="text" name="keywords" value="${pd.keywords }" placeholder="这里输入关键词" />
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
						<th style="width: 50px;">
                            <input type="checkbox" id="zcheckbox" style="margin-top: 2px;;">
						</th>
						<th style="width:50px;">NO</th>
						<th>成员</th>
						<th style="width:105px;text-align: center;">操作</th>
					</tr>
				</thead>
										
				<tbody>
				<!-- 开始循环 -->	
				<c:choose>
					<c:when test="${not empty varList}">
						<c:forEach items="${varList}" var="var" varStatus="vs">
							<tr>
								<td>
								 	<input type="checkbox" style="margin-top: 2px;" name='ids' value="${var.USERNAME}">
								</td>
								<td>${page.showCount*(page.currentPage-1)+vs.index+1}</td>
								<td>
									<img src="${(null == var.PHOTO2 || '' == var.PHOTO2)?'static/img/photo.jpg':var.PHOTO2}" width="30" />&nbsp;
									${var.NAME} (${var.USERNAME})
								</td>
								<td>
									<a style="height:23px;" class="btn btn-light btn--icon-text" onclick="del('${pd.QGROUP_ID}','${var.USERNAME}');"><div style="margin-top:-3px;margin-left: -5px;">&nbsp;踢出群</div></a>
								</td>
							</tr>
						
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="100" class="center" >没有相关数据</td>
						</tr>
					</c:otherwise>
				</c:choose>
				</tbody>
			</table>
			<table style="width:100%;margin-top:15px;">
				<tr>
					<td style="vertical-align:top;">
						<a class="btn btn-light btn--icon-text" onclick="makeAll('确定要把选中的成员踢出群吗?');" >踢出群</a>
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
		
		//踢出群
		function del(QGROUP_ID,USERNAME){
			swal({
                title: '确定要踢出群吗?',
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
        			url: '<%=basePath%>qgroup/kickout',
        	    	data: {QGROUP_ID:QGROUP_ID,USERNAME:USERNAME,tm:new Date().getTime()},
        			dataType:'json',
        			cache: false,
        			success: function(data){
        				 if("success" == data.result){
        					 top.kickoutQgroup(USERNAME,QGROUP_ID); 	//通知被踢出的成员，发送个提醒消息，此函数在  im.jsp 页面
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
    				if(msg == '确定要把选中的成员踢出群吗?'){
    					var QGROUP_ID = "${pd.QGROUP_ID}";
						var arrid = str.split(',');
    					
						for(var n=0;n<arrid.length;n++){
							var USERNAME = arrid[n];
							top.kickoutQgroup(USERNAME,QGROUP_ID); 	//通知被踢出的成员，发送个提醒消息，此函数在  im.jsp 页面
						
	    					$.ajax({
	    						type: "POST",
	    						url: '<%=basePath%>qgroup/kickout?tm='+new Date().getTime(),
	    				    	data: {QGROUP_ID:QGROUP_ID,USERNAME:USERNAME},
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
	    							if(n == arrid.length)setTimeout(searchs, 1500);
	    						}
	    					});
						}
    				}
    			}
            }).catch(() => {});
		}
		
	</script>


</body>
</html>