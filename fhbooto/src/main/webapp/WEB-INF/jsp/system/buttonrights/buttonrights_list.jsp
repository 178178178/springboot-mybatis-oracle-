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
    
    <!-- App styles -->
    <link rel="stylesheet" href="static/css/app.min.css">
    
</head>

<body style="background-color: rgba(255,255,255,0);">

      <div class="card" style="margin-top:0px;">
         <div class="card-body">

			<table style="margin-top: 8px;">
				<tr height="35">
					<td style="width:50px;">角色组:</td>
						<c:choose>
						<c:when test="${not empty roleList}">
						<!-- 角色组循环 -->
						<c:forEach items="${roleList}" var="role" varStatus="vs">
							<td <c:if test="${pd.ROLE_ID == role.ROLE_ID}">style="background-color: rgba(255,255,255,0.3);"</c:if>>
								<a class="btn btn-light btn--icon-text"	 href="buttonrights/list?ROLE_ID=${role.ROLE_ID }" ><i class="zmdi zmdi-accounts-alt zmdi-hc-fw"></i>${role.ROLE_NAME }</a>
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
			<div style="overflow-x: scroll; scrolling: auto;width: 100%;">
			<table class="table table-hover mb-0" style="margin-top:7px;">
				<thead>
				<tr>
					<th style="width: 50px;">NO</th>
					<th>角色</th>
					<shiro:hasPermission name="buttonrights:edit">
						<!-- 按钮循环 -->
						<c:forEach items="${buttonlist}" var="fhbutton" varStatus="vsb">
							<th class='center'>${fhbutton.NAME }</th>
						</c:forEach>
					</shiro:hasPermission>
				</tr>
				</thead>
				<c:choose>
					<c:when test="${not empty roleList_z}">
						<!-- 角色循环 -->
						<c:forEach items="${roleList_z}" var="var" varStatus="vs">
						<tr>
						<td style="width:30px;">${vs.index+1}</td>
						<td id="ROLE_NAMETd${var.ROLE_ID }">${var.ROLE_NAME }</td>
						<shiro:hasPermission name="buttonrights:edit">
							<!-- 按钮循环 -->
							<c:forEach items="${buttonlist}" var="fhbutton" varStatus="vsb">
								<!-- 关联表循环 -->
								<c:forEach items="${roleFhbuttonlist}" var="varRb" varStatus="vsRb">
									<c:if test="${var.ROLE_ID == varRb.ROLE_ID && fhbutton.FHBUTTON_ID == varRb.BUTTON_ID }">
										<c:set value="1" var="rbvalue"></c:set>
									</c:if>
								</c:forEach>
								<td style="height: 20px;">
                                    <div class="toggle-switch toggle-switch--cyan">
                                        <input type="checkbox" class="toggle-switch__checkbox" onclick="upRb('${var.ROLE_ID}','${fhbutton.FHBUTTON_ID}')" <c:if test="${rbvalue == 1 }">checked="checked"</c:if>>
                                        <i class="toggle-switch__helper"></i>
                                    </div>
								</td>
								<c:set value="0" var="rbvalue"></c:set>
							</c:forEach>
						</shiro:hasPermission>
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
			</div>
			
			<div>
			<table style="width:100%;margin-top:15px;">
				<tr>
					<td style="vertical-align:top;">
						<a class="btn btn-light btn--icon-text" onclick="window.location.href='<%=basePath%>buttonrights/list?type=2&ROLE_ID=${pd.ROLE_ID }';">切换视图</a>
					</td>
				</tr>
			</table>
			</div>

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
    
	<script type="text/javascript">
		
		//处理按钮点击
		function upRb(ROLE_ID,FHBUTTON_ID){
			$.ajax({
				type: "POST",
				url: "<%=basePath%>buttonrights/upRb?ROLE_ID="+ROLE_ID+"&BUTTON_ID="+FHBUTTON_ID+"&guid="+new Date().getTime(),
		    	data: encodeURI(""),
				dataType:'json',
				//beforeSend: validateData,
				cache: false,
				success: function(data){
				}
			});
		}
	</script>

</body>
</html>