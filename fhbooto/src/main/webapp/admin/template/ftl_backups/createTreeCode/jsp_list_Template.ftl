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
    
    <!-- 日期框插件 -->
    <link rel="stylesheet" href="static/vendors/bower_components/flatpickr/dist/flatpickr.min.css">
    <!-- 下拉选择框插件 -->
    <link rel="stylesheet" href="static/vendors/bower_components/select2/dist/css/select2.min.css">
    <!-- alert插件 -->
    <link rel="stylesheet" href="static/vendors/bower_components/sweetalert2/dist/sweetalert2.min.css">
    
    <!-- App styles -->
    <link rel="stylesheet" href="static/css/app.min.css">
    
</head>

<body style="background-color: rgba(255,255,255,0);">

      <div class="card" style="margin-top:5px;">
         <div class="card-body">
			<!-- 检索  -->
			<form action="${objectNameLower}/list" method="post" name="Form" id="Form">
				<table style="margin-top:5px;">
					<tr>
						<td>
							<div class="form-group">
	                            <input class="form-control" id="KEYWORDS" type="text" name="KEYWORDS" value="${r"${pd.KEYWORDS }"}" placeholder="这里输入关键词" />
	                            <i class="form-group__bar"></i>
	                        </div>
						</td>
						<td style="vertical-align:top;padding-left:5px;">
							<a class="btn btn-light btn--icon-text" onclick="searchs();" style="width: 23px;height:23px;margin-top:8px;" title="检索"><i style="margin-top:-3px;margin-left: -5px;"  class="zmdi zmdi-search"></i></a>
							<shiro:hasPermission name="toExcel"><a class="btn btn-light btn--icon-text" onclick="toExcel();" style="width: 23px;height:23px;margin-top:8px;" title="导出到excel表格"><i style="margin-top:-3px;margin-left: -10px;" class="zmdi zmdi-cloud-download zmdi-hc-fw"></i></a></shiro:hasPermission>
						</td>
					</tr>
				</table>
				<!-- 检索  -->
			
				<table class="table table-hover mb-0">
					<thead>
						<tr>
							<th style="width:50px;">NO</th>
							<th>名称</th>
						<#list fieldList as var>
							<th>${var[2]}</th>
						</#list>
							<th>操作</th>
						</tr>
					</thead>
											
					<tbody>
					<!-- 开始循环 -->	
					<c:choose>
						<c:when test="${r"${not empty varList}"}">
							<c:forEach items="${r"${varList}"}" var="var" varStatus="vs">
								<tr>
									<td>${r"${page.showCount*(page.currentPage-1)+vs.index+1}"}</td>
									<td><a href="javascript:goSondict('${r"${var."}${objectNameUpper}_ID${r"}"}')">${r"${var.NAME}"}  <i class="zmdi zmdi-chevron-down zmdi-hc-fw"></i></a></td>
							<#list fieldList as var>
								<#if var[1] == 'String' && var[7] != 'null'>
									<td>${r"${var."}DNAME${var_index+1}${r"}"}</td>
								<#else>
									<td>${r"${var."}${var[0]}${r"}"}</td>
								</#if>
							</#list>
									<td>
										<shiro:hasPermission name="${objectNameLower}:edit"><a title="修改" onclick="edit('${r"${var."}${objectNameUpper}_ID${r"}"}');"><i class="zmdi zmdi-edit zmdi-hc-fw"></i></a></shiro:hasPermission>
	                 					<shiro:hasPermission name="${objectNameLower}:del"><a title="删除" onclick="del('${r"${var."}${objectNameUpper}_ID${r"}"}');"><i class="zmdi zmdi-close zmdi-hc-fw"></i></a></shiro:hasPermission>
									</td>
								</tr>
							
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr class="main_info">
								<td colspan="100" class="center" >没有相关数据</td>
							</tr>
						</c:otherwise>
					</c:choose>
					</tbody>
				</table>
				
				<table style="width:100%;margin-top:15px;">
					<tr>
						<td style="vertical-align:top;">
							<shiro:hasPermission name="${objectNameLower}:add"><a class="btn btn-light btn--icon-text" onclick="add('${r"${"}${objectNameUpper}_ID${r"}"}');">新增</a></shiro:hasPermission>
							<c:if test="${r"${null != pd."}${objectNameUpper}_ID${r" && pd."}${objectNameUpper}_ID${r" != ''}"}">
							<a class="btn btn-light btn--icon-text" onclick="goSondict('${r"${pd.PARENT_ID}"}');">返回</a>
							</c:if>
						</td>
						<td style="vertical-align:top;"><div style="float: right;padding-top: 0px;margin-top: 0px;">${r"${page.pageStr}"}</div></td>
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
     <!-- 日期框插件 -->
    <script src="static/vendors/bower_components/flatpickr/dist/flatpickr.min.js"></script>
	<!-- 下拉选择框插件 -->
    <script src="static/vendors/bower_components/select2/dist/js/select2.full.min.js"></script>
    <!-- alert插件 -->
    <script src="static/vendors/bower_components/sweetalert2/dist/sweetalert2.min.js"></script>
	<!-- 表单验证提示 -->
  	<script src="static/js/jquery.tips.js"></script>
	<script type="text/javascript">
		//检索
		function searchs(){
			//$("#Form").submit();
		}
		
		//去此ID下子级列表
		function goSondict(${objectNameUpper}_ID){
			window.location.href="<%=basePath%>${objectNameLower}/list?${objectNameUpper}_ID="+${objectNameUpper}_ID;
		};
		
		//新增
		function add(${objectNameUpper}_ID){
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增";
			 diag.URL = '<%=basePath%>${objectNameLower}/goAdd?${objectNameUpper}_ID='+${objectNameUpper}_ID;
			 diag.Width = 800;
			 diag.Height = 600;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('showform').style.display == 'none'){
					 parent.location.href="<%=basePath%>${objectNameLower}/listTree?${objectNameUpper}_ID=${r"${"}${objectNameUpper}_ID${r"}"}&dnowPage=${r"${page.currentPage}"}";
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
        			url: '<%=basePath%>${objectNameLower}/delete',
        	    	data: {${objectNameUpper}_ID:Id,tm:new Date().getTime()},
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
        		               parent.location.href="<%=basePath%>${objectNameLower}/listTree?${objectNameUpper}_ID=${r"${"}${objectNameUpper}_ID${r"}"}&dnowPage=${r"${page.currentPage}"}";
        				 }else{
        				 	swal({
     		                    title: '删除失败!',
     		                    text: '删除失败！请先删除子级数据!',
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
			 diag.URL = '<%=basePath%>${objectNameLower}/goEdit?${objectNameUpper}_ID='+Id;
			 diag.Width = 800;
			 diag.Height = 600;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('showform').style.display == 'none'){
					 parent.location.href="<%=basePath%>${objectNameLower}/listTree?${objectNameUpper}_ID=${r"${"}${objectNameUpper}_ID${r"}"}&dnowPage=${r"${page.currentPage}"}";
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//导出excel
		function toExcel(){
			window.location.href='<%=basePath%>${objectNameLower}/excel';
		}
	</script>


</body>
</html>