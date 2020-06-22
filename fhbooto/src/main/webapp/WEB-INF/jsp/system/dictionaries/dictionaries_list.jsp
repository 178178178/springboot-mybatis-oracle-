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
			<!-- 检索  -->
			<form action="dictionaries/list" method="post" name="Form" id="Form">
				<table>
					<tr>
						<td>
							<div class="form-group">
                           		<input class="form-control" id="KEYWORDS" type="text" name="KEYWORDS" value="${page.pd.KEYWORDS }" placeholder="这里输入关键词" />
                            	<i class="form-group__bar"></i>
                        	</div>
						</td>
						<td style="vertical-align:top;padding-left:5px;padding-top: 10px;">&nbsp;
							<select name="DICTIONARIES_ID" id="DICTIONARIES_ID">
								<option value="${DICTIONARIES_ID}" <c:if test="${DICTIONARIES_ID != ''}">selected</c:if>>本级</option>
								<option value="" <c:if test="${DICTIONARIES_ID == ''}">selected</c:if>>全部</option>
							</select>
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
							<th>名称</th>
							<th>英文</th>
							<th>编码</th>
							<th style="width:150px;">ID</th>
							<th>排序</th>
							<th>操作</th>
						</tr>
					</thead>
											
					<tbody>
					<!-- 开始循环 -->	
					<c:choose>
						<c:when test="${not empty varList}">
							<c:forEach items="${varList}" var="var" varStatus="vs">
								<tr>
									<td style="width: 30px;">${page.showCount*(page.currentPage-1)+vs.index+1}</td>
									<td><a href="javascript:goSondict('${var.DICTIONARIES_ID }')">${var.NAME} <i class="zmdi zmdi-chevron-down zmdi-hc-fw"></i></a></td>
									<td><a href="javascript:goSondict('${var.DICTIONARIES_ID }')">${var.NAME_EN}</a></td>
									<td>${var.BIANMA}</td>
									<td>${var.DICTIONARIES_ID}</td>
									<td>${var.ORDER_BY}</td>
									<td>
										<shiro:hasPermission name="dictionaries:edit"><a title="修改" onclick="edit('${var.DICTIONARIES_ID}');"><i class="zmdi zmdi-edit zmdi-hc-fw"></i></a></shiro:hasPermission>
		                     			<shiro:hasPermission name="dictionaries:del">
		                     				<c:if test="${'yes' != var.YNDEL}">
		                     					<a title="删除" onclick="del('${var.DICTIONARIES_ID }');"><i class="zmdi zmdi-close zmdi-hc-fw"></i></a>
		                     				</c:if>
		                     			</shiro:hasPermission>
									</td>
								</tr>
							
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr class="main_info">
								<td colspan="100">没有相关数据</td>
							</tr>
						</c:otherwise>
					</c:choose>
					</tbody>
				</table>
				<table style="width:100%;margin-top:15px;">
					<tr>
						<td style="vertical-align:top;">
							<shiro:hasPermission name="dictionaries:add"><a class="btn btn-light btn--icon-text" onclick="add('${DICTIONARIES_ID}');">新增</a></shiro:hasPermission>
							<c:if test="${null != pd.DICTIONARIES_ID && pd.DICTIONARIES_ID != ''}">
							<a class="btn btn-light btn--icon-text" onclick="goSondict('${pd.PARENT_ID}');">返回</a>
							</c:if>
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
		
		//去此ID下子列表
		function goSondict(DICTIONARIES_ID){
			window.location.href="<%=basePath%>dictionaries/list?DICTIONARIES_ID="+DICTIONARIES_ID;
		};
		
		//新增
		function add(DICTIONARIES_ID){
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增";
			 diag.URL = '<%=basePath%>dictionaries/goAdd?DICTIONARIES_ID='+DICTIONARIES_ID;
			 diag.Width = 600;
			 diag.Height = 459;
			 diag.CancelEvent = function(){ //关闭事件
				 if('none' == diag.innerFrame.contentWindow.document.getElementById('showform').style.display){
					 parent.location.href="<%=basePath%>dictionaries/listAllDict?DICTIONARIES_ID=${DICTIONARIES_ID}&dnowPage=${page.currentPage}";
				}
				diag.close();
			 };
			 diag.show();
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
        			url: '<%=basePath%>dictionaries/delete',
        	    	data: {DICTIONARIES_ID:Id,tm:new Date().getTime()},
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
        					 parent.location.href="<%=basePath%>dictionaries/listAllDict?DICTIONARIES_ID=${DICTIONARIES_ID}&dnowPage=${page.currentPage}";
        				 }else if("error" == data.result){
        					 swal({
     		                    title: '删除失败!',
     		                    text: '删除失败！请先删除子级或删除占用资源!',
     		                    type: 'warning',
     		                    buttonsStyling: false,
     		                    showConfirmButton: false,
     		                    confirmButtonClass: 'btn btn-light',
     		                    background: 'rgba(0, 0, 0, 0.96)'
     		                 });
        				 }else{
        					 swal({
      		                    title: '删除失败!',
      		                    text: '删除失败！排查表不存在或其表中没有BIANMA字段!',
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
		
		//修改
		function edit(Id){
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑";
			 diag.URL = '<%=basePath%>dictionaries/goEdit?DICTIONARIES_ID='+Id;
			 diag.Width = 600;
			 diag.Height = 439;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('showform').style.display == 'none'){
					 parent.location.href="<%=basePath%>dictionaries/listAllDict?DICTIONARIES_ID=${DICTIONARIES_ID}&dnowPage=${page.currentPage}";
				}
				diag.close();
			 };
			 diag.show();
		}
		
	</script>


</body>
</html>