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

<body style="background-color: rgba(255,255,255,0);">

      <div class="card" style="margin-top:5px;">
         <div class="card-body">
							
			<!-- 检索  -->
			<form action="qgroup/list" method="post" name="Form" id="Form">
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
						<th style="width:50px;">NO</th>
						<th>群</th>
						<th>群主</th>
						<th>创建时间</th>
						<th style="width:379px;">操作</th>
					</tr>
				</thead>
										
				<tbody>
				<!-- 开始循环 -->	
				<c:choose>
					<c:when test="${not empty varList}">
						<c:forEach items="${varList}" var="var" varStatus="vs">
							<tr>
								<td style="width: 30px;">${page.showCount*(page.currentPage-1)+vs.index+1}</td>
								<td>
									<img src="${var.PHOTO}" width="39" />&nbsp;
									${var.NAME}
								</td>
								<td>${var.USERNAME==pd.USERNAME?"(我创建的)":var.USERNAME}</td>
								<td>${var.CTIME}</td>
								<td>
									<shiro:hasPermission name="qgroup:edit">
										<c:if test="${var.USERNAME==pd.USERNAME }">
										<a style="height:23px;" class="btn btn-light btn--icon-text" onclick="groupMembers('${var.QGROUP_ID}');"><div style="margin-top:-3px;margin-left: -5px;">管理群成员</div></a>
										<a style="height:23px;" class="btn btn-light btn--icon-text" onclick="hismsg('${var.QGROUP_ID}');"><div style="margin-top:-3px;margin-left: -5px;">管理聊天记录</div></a>
										</c:if>
									</shiro:hasPermission>
									<shiro:hasPermission name="qgroup:edit">
										<c:if test="${var.USERNAME==pd.USERNAME }">
										<a style="height:23px;" class="btn btn-light btn--icon-text" title="编辑" onclick="edit('${var.QGROUP_ID}');"><div style="margin-top:-3px;margin-left: -5px;">编辑</div></a>
										</c:if>
									</shiro:hasPermission>
									<shiro:hasPermission name="qgroup:edit">
									<c:if test="${var.USERNAME==pd.USERNAME }">
									<a style="height:23px;" class="btn btn-light btn--icon-text" onclick="del('${var.QGROUP_ID}','${var.PHOTO}','del');"><div style="margin-top:-3px;margin-left: -5px;">解散群</div></a>
									</c:if>
									<c:if test="${var.USERNAME!=pd.USERNAME }">
									<a style="height:23px;" class="btn btn-light btn--icon-text" onclick="del('${var.QGROUP_ID}','${var.PHOTO}','out');"><div style="margin-top:-3px;margin-left: -5px;">退出群</div></a>
									</c:if>
									</shiro:hasPermission>
								</td>
							</tr>
						
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="100" >没有相关数据</td>
						</tr>
					</c:otherwise>
				</c:choose>
				</tbody>
			</table>
			
			<table style="width:100%;margin-top:15px;">
				<tr>
					<td style="vertical-align:top;">
						<shiro:hasPermission name="qgroup:add"><a class="btn btn-light btn--icon-text" onclick="add();">新增</a></shiro:hasPermission>
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
		
		//群成员
		function groupMembers(Id){
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="群成员管理";
			 diag.URL = '<%=basePath%>qgroup/groupMembers?QGROUP_ID='+Id;
			 diag.Width = 800;
			 diag.Height = 600;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮 
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
			 };
			 diag.show();
		}
		
		//聊天记录
		function hismsg(Id){
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="群聊天记录管理";
			 diag.URL = '<%=basePath%>hismsg/list?id='+Id+'&type=group';
			 diag.Width = 1000;
			 diag.Height = 600;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮 
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
			 };
			 diag.show();
		}
		
		//新增
		function add(){
			var QID = "${QID }";
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增";
			 diag.URL = '<%=basePath%>qgroup/goAddFromlist?QID='+QID;
			 diag.Width = 600;
			 diag.Height = 200;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('showform').style.display == 'none'){
					 $.ajax({
							type: "POST",
							url: 'qgroup/getThisQgroup',	 //获取此群的信息
						   	data: {QGROUP_ID:QID,tm:new Date().getTime()},
							dataType:'json',
							cache: false,
							success: function(data){
								top.addQgroup(QID,data.avatar,data.groupname);	//把群添加到群组栏里面	此方法在im.jsp页面中
								searchs();
							}
						});
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//解散or退出群
		function del(Id,PATH,TYPE){
			var msg = "";
			if('del'==TYPE){
				msg = "确定要解散此群吗?";
			}else{
				msg = "确定要退出此群吗?";
			}
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
            	top.removeQgroup(Id,TYPE); 	//从自己群组栏移除  此方法在im.jsp页面中
            	$.ajax({
        			type: "POST",
        			url: '<%=basePath%>qgroup/delete',
        	    	data: {QGROUP_ID:Id,PATH:PATH,TYPE:TYPE,tm:new Date().getTime()},
        			dataType:'json',
        			cache: false,
        			success: function(data){
        				 if("success" == data.result){
        					 swal({
        		                    title: '操作成功',
        		                    text: '',
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
		
		//修改
		function edit(Id){
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑";
			 diag.URL = '<%=basePath%>qgroup/goEdit?QGROUP_ID='+Id;
			 diag.Width = 600;
			 diag.Height = 279;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮 
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('showform').style.display == 'none'){
					 searchs();
				}
				diag.close();
			 };
			 diag.show();
		}
		
	</script>


</body>
</html>