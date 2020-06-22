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

      <div class="card" style="margin-top:0px;">
         <div class="card-body">

			<table>
				<tr height="35">
					<td style="width:69px;padding-right: 3px;"><shiro:hasPermission name="role:add"><a href="javascript:addRole(0);" class="btn btn-light btn--icon-text">新增组</a></shiro:hasPermission></td>
						<c:choose>
						<c:when test="${not empty roleList}">
						<c:forEach items="${roleList}" var="role" varStatus="vs">
							<td <c:if test="${pd.ROLE_ID == role.ROLE_ID}">style="background-color: rgba(255,255,255,0.3);"</c:if>>
								<a class="btn btn-light btn--icon-text"	 href="role/list?ROLE_ID=${role.ROLE_ID }" ><i class="zmdi zmdi-accounts-alt zmdi-hc-fw"></i>${role.ROLE_NAME }</a>
							</td>
							<td style="width:1px;"></td>
						</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
							<td colspan="100">没有相关数据</td>
							</tr>
						</c:otherwise>
						</c:choose>
					<td></td>
				</tr>
			</table>
			
			<table>
				<tr height="7px;"><td colspan="100"></td></tr>
				<tr>
				<td><font color="#808080">本组：</font></td>
				<td>
				<shiro:hasPermission name="role:edit"><a class="btn btn-light btn--icon-text" onclick="editRole('${pd.ROLE_ID }');">修改组名称</a></shiro:hasPermission>
					<c:choose>
						<c:when test="${pd.ROLE_ID == '99'}">
						</c:when>
						<c:otherwise>
						<a class="btn btn-light btn--icon-text" onclick="editRights('${pd.ROLE_ID }');">
							<c:if test="${pd.ROLE_ID == '1'}">Admin 菜单权限</c:if>
							<c:if test="${pd.ROLE_ID != '1'}">组菜单权限</c:if>
						</a>
						</c:otherwise>
					</c:choose>
					<c:choose> 
						<c:when test="${pd.ROLE_ID == '1'}">
						</c:when>
						<c:otherwise>
						<shiro:hasPermission name="role:del"><a class="btn btn-light btn--icon-text" style="width: 23px;height:23px;margin-top:8px;" title="删除" onclick="delRole('${pd.ROLE_ID }','z','${pd.ROLE_NAME }');"><i style="margin-top:-3px;margin-left: -9px;" class="zmdi zmdi-close zmdi-hc-fw"></i></a></shiro:hasPermission>
						</c:otherwise>
					</c:choose>
				</td>
				</tr>
			</table>
			
			<table class="table table-hover mb-0" style="margin-top:7px;">
				<thead>
				<tr>
					<th>NO</th>
					<th>角色</th>
					<th>编码</th>
					<shiro:hasPermission name="role:edit">
					<th>增</th>
					<th>删</th>
					<th>改</th>
					<th>查</th>
					</shiro:hasPermission>
					<th>操作</th>
				</tr>
				</thead>
				<c:choose>
					<c:when test="${not empty roleList_z}">
						<c:forEach items="${roleList_z}" var="var" varStatus="vs">
						<tr>
						<td style="width:30px;">${vs.index+1}</td>
						<td id="ROLE_NAMETd${var.ROLE_ID }">${var.ROLE_NAME }</td>
						<td>${var.RNUMBER }</td>
						<shiro:hasPermission name="role:edit">
						<td style="width:30px;"><a onclick="roleButton('${var.ROLE_ID }','add_qx');" title="分配新增权限"><i class="zmdi zmdi-wrench zmdi-hc-fw"></i></a></td>
						<td style="width:30px;"><a onclick="roleButton('${var.ROLE_ID }','del_qx');" title="分配删除权限"><i class="zmdi zmdi-wrench zmdi-hc-fw"></i></a></td>
						<td style="width:30px;"><a onclick="roleButton('${var.ROLE_ID }','edit_qx');" title="分配修改权限"><i class="zmdi zmdi-wrench zmdi-hc-fw"></i></a></td>
						<td style="width:30px;"><a onclick="roleButton('${var.ROLE_ID }','cha_qx');" title="分配查看权限"><i class="zmdi zmdi-wrench zmdi-hc-fw"></i></a></td>
						</shiro:hasPermission>
						<td style="width:155px;">
						<a onclick="editRights('${var.ROLE_ID }');" title="菜单权限	"><i class="zmdi zmdi-label zmdi-hc-fw"></i></a>
							<c:if test="${var.ROLE_ID != 'fhadminzhuche' }"><!-- 注册用户角色不能修改 -->
								<shiro:hasPermission name="role:edit"><a title="编辑" onclick="editRole('${var.ROLE_ID }');"><i class="zmdi zmdi-edit zmdi-hc-fw"></i></a></shiro:hasPermission>
							</c:if>
						<c:choose> 
							<c:when test="${var.ROLE_ID == '1'}">
							</c:when>
							<c:otherwise>
							 	<c:if test="${var.ROLE_ID != 'fhadminzhuche' }"><!-- 注册用户角色不能删除 -->
							 		<shiro:hasPermission name="role:del"><a title="删除" onclick="delRole('${var.ROLE_ID }','c','${var.ROLE_NAME }');"><i class="zmdi zmdi-close zmdi-hc-fw"></i></a></shiro:hasPermission>
							 	</c:if>
							</c:otherwise>
						</c:choose>
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
			</table>


			<table style="width:100%;margin-top:15px;">
				<tr>
					<td style="vertical-align:top;">
						<shiro:hasPermission name="role:add"><a class="btn btn-light btn--icon-text" onclick="addRole('${pd.ROLE_ID }');">新增</a></shiro:hasPermission>
					</td>
				</tr>
			</table>


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

		//新增
		function addRole(pid){
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增";
			 diag.URL = '<%=basePath%>role/toAdd?parent_id='+pid;
			 diag.Width = 600;
			 diag.Height = 139;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('showform').style.display == 'none'){
					setTimeout("self.location.reload()",100);
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//修改
		function editRole(ROLE_ID){
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑";
			 diag.URL = '<%=basePath%>role/toEdit?ROLE_ID='+ROLE_ID;
			 diag.Width = 600;
			 diag.Height = 139;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('showform').style.display == 'none'){
					setTimeout("self.location.reload()",100);
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//删除
		function delRole(ROLE_ID,msg,ROLE_NAME){
			swal({
                title: '确定要删除['+ROLE_NAME+']吗?',
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
        			url: '<%=basePath%>role/delete',
        	    	data: {ROLE_ID:ROLE_ID,tm:new Date().getTime()},
        			dataType:'json',
        			cache: false,
        			success: function(data){
        				 if("success" == data.result){
        					 swal({
        		                    title: '删除成功',
        		                    text: '['+ROLE_NAME+'] 已经从列表中删除',
        		                    type: 'success',
        		                    buttonsStyling: false,
        		                    showConfirmButton: false,
        		                    confirmButtonClass: 'btn btn-light',
        		                    background: 'rgba(0, 0, 0, 0.96)'
        		                });
        					 if(msg == 'c'){
 								document.location.reload();
 							}else{
 								window.location.href="<%=basePath%>role/list";
 							}
        				 }else if("false" == data.result){
        					 swal({
     		                    title: '删除失败!',
     		                    text: '请先删除下级角色!!',
     		                    type: 'warning',
     		                    buttonsStyling: false,
     		                    showConfirmButton: false,
     		                    confirmButtonClass: 'btn btn-light',
     		                    background: 'rgba(0, 0, 0, 0.96)'
     		                });
        				 }else if("false2" == data.result){
        					 swal({
      		                    title: '删除失败!',
      		                    text: '此角色已被使用!',
      		                    type: 'warning',
      		                    buttonsStyling: false,
      		                    showConfirmButton: false,
      		                    confirmButtonClass: 'btn btn-light',
      		                    background: 'rgba(0, 0, 0, 0.96)'
      		                });
        				 }
        			}
        		});
            }).catch(() => {});
		}
		
		//菜单权限
		function editRights(ROLE_ID){
			 var diag = new top.Dialog();
			 diag.Drag = true;
			 diag.Title = "菜单权限";
			 diag.URL = '<%=basePath%>role/menuqx?ROLE_ID='+ROLE_ID;
			 diag.Width = 320;
			 diag.Height = 466;
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
			 };
			 diag.show();
		}
		
		//按钮权限(增删改查)
		function roleButton(ROLE_ID,msg){
			if(msg == 'add_qx'){
				var Title = "授权新增权限(此角色下打勾的菜单拥有新增权限)";
			}else if(msg == 'del_qx'){
				Title = "授权删除权限(此角色下打勾的菜单拥有删除权限)";
			}else if(msg == 'edit_qx'){
				Title = "授权修改权限(此角色下打勾的菜单拥有修改权限)";
			}else if(msg == 'cha_qx'){
				Title = "授权查看权限(此角色下打勾的菜单拥有查看权限)";
			}
			 var diag = new top.Dialog();
			 diag.Drag = true;
			 diag.Title = Title;
			 diag.URL = '<%=basePath%>role/b4Button?ROLE_ID='+ROLE_ID+'&msg='+msg;
			 diag.Width = 320;
			 diag.Height = 466;
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
			 };
			 diag.show();
		}
		
	</script>
</body>
</html>
