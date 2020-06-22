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
    
    <script type="text/javascript">
		//刷新ztree
		function parentReload(){
			var MSG = ${MSG};
			if('change' == MSG){
				parent.location.href="<%=basePath%>menu/listAllMenu?MENU_ID="+${MENU_ID};
			}
		}
		parentReload();
	</script>
    
</head>

<body style="background-color: rgba(255,255,255,0);">

      <div class="card" style="margin-top:5px;">
         <div class="card-body">

	
             <table class="table table-hover mb-0">
                 <thead>
	                 <tr>
	                    <th>NO</th>
						<th>名称</th>
						<th>资源路径</th>
						<th>权限标识</th>
						<th>状态</th>
						<th>操作</th>
	                 </tr>
                 </thead>
                 <tbody>
                 <!-- 开始循环 -->	
				 <c:choose>
					<c:when test="${not empty menuList}">
                 	 <c:forEach items="${menuList}" var="menu" varStatus="vs">
		                 <tr>
		                     <td>${menu.MENU_ORDER }</td>
		                     <td>${menu.MENU_ICON } <a href="javascript:goSonmenu('${menu.MENU_ID }')">${menu.MENU_NAME }  <i class="zmdi zmdi-chevron-down zmdi-hc-fw"></i></a> </td>
		                     <td>${menu.MENU_URL == '#'? '&nbsp;&nbsp;&nbsp;&nbsp;(无)': menu.MENU_URL}</td>
		                     <td>${'' == menu.SHIRO_KEY || null == menu.SHIRO_KEY ?'&nbsp;&nbsp;&nbsp;&nbsp;(无)': menu.SHIRO_KEY}</td>
		                     <td>&nbsp;<i class="zmdi ${menu.MENU_STATE == 1? 'zmdi-eye zmdi-hc-fw': 'zmdi-eye-off zmdi-hc-fw'}"></i></td>
		                     <td>
		                     	<shiro:hasPermission name="menu:edit"><a title="编辑图标" onclick="setIcon('${menu.MENU_ID }');"><i class="zmdi zmdi-image-o zmdi-hc-fw"></i></a></shiro:hasPermission>
		                     	<shiro:hasPermission name="menu:edit"><a title="修改" onclick="editMenu('${menu.MENU_ID}');"><i class="zmdi zmdi-edit zmdi-hc-fw"></i></a></shiro:hasPermission>
		                     	<shiro:hasPermission name="menu:del"><a title="删除" onclick="delMenu('${menu.MENU_NAME }','${menu.MENU_ID }');"><i class="zmdi zmdi-close zmdi-hc-fw"></i></a></shiro:hasPermission>
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
						<shiro:hasPermission name="menu:add"><a class="btn btn-light btn--icon-text" onclick="addMenu('${MENU_ID}');">新增</a></shiro:hasPermission>
						<c:if test="${null != pd.MENU_ID && pd.MENU_ID != '0'}">
						<a class="btn btn-light btn--icon-text" onclick="goSonmenu('${pd.PARENT_ID}');">返回</a>
						</c:if>
					</td>
					<td style="vertical-align:top;"><div style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
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

	<script type="text/javascript">
		
		//去此ID下子菜单列表
		function goSonmenu(MENU_ID){
			window.location.href="<%=basePath%>menu/list?MENU_ID="+MENU_ID;
		};
		
		//新增菜单
		function addMenu(MENU_ID){
			window.location.href="<%=basePath%>menu/toAdd?MENU_ID="+MENU_ID;
		};
		
		//编辑菜单
		function editMenu(MENU_ID){
			window.location.href="<%=basePath%>menu/toEdit?id="+MENU_ID;
		};
		
		//编辑菜单图标
		function setIcon(MENU_ID){
		   	 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑图标";
			 diag.URL = '<%=basePath%>menu/toEditicon?MENU_ID='+MENU_ID;
			 diag.Width = 800;
			 diag.Height = 600;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮 
			 diag.CancelEvent = function(){ //关闭事件
				if(diag.innerFrame.contentWindow.document.getElementById('showform').style.display == 'none'){
					setTimeout("location.reload()",100);
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//删除
		function delMenu(MENU_NAME,MENU_ID){
			swal({
                title: '确定要删除 '+MENU_NAME+' 吗?',
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
        			url: '<%=basePath%>menu/delete',
        	    	data: {MENU_ID:MENU_ID,tm:new Date().getTime()},
        			dataType:'json',
        			cache: false,
        			success: function(data){
        				 if("success" == data.result){
        					 swal({
        		                    title: '删除成功',
        		                    text: MENU_NAME+' 已经从列表中删除',
        		                    type: 'success',
        		                    buttonsStyling: false,
        		                    showConfirmButton: false,
        		                    confirmButtonClass: 'btn btn-light',
        		                    background: 'rgba(0, 0, 0, 0.96)'
        		                });
        					 parent.location.href="<%=basePath%>menu/listAllMenu?MENU_ID="+${MENU_ID};
        				 }else{
        					 swal({
     		                    title: '删除失败!',
     		                    text: '请先删除子菜单!',
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
		
	</script>
</body>
</html>
