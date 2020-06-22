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
			<form action="friends/list" method="post" name="Form" id="Form">
			<table>
				<tr>
					<td>
						<div class="form-group">
                            <input class="form-control" type="text" id="keywords"  name="keywords" value="${pd.keywords }" placeholder="这里输入关键词"/>
                            <i class="form-group__bar"></i>
                        </div>
					</td>
					<td style="padding-left:2px;">
						<div class="form-group">
                            <input class="form-control date-picker flatpickr-input active" name="lastStart" id="lastStart"  value="${pd.lastStart}" type="text" readonly="readonly" style="width:88px;" placeholder="开始日期" title="最近登录开始时间"/>
                            <i class="form-group__bar"></i>
                        </div>	
					</td>
					<td style="padding-left:2px;">
						<div class="form-group">
                            <input class="form-control date-picker flatpickr-input active" name="lastEnd" id="lastEnd"  value="${pd.lastEnd}" type="text" readonly="readonly" style="width:88px;" placeholder="结束日期" title="最近登录截止时间"/>
                            <i class="form-group__bar"></i>
                        </div>	
					</td>
					<td style="vertical-align:top;padding-left:2px;">
						<div class="form-group">
					 		<select class="select2 select2-hidden-accessible" name="FGROUP_ID" id="FGROUP_ID"  title="分组" tabindex="-1" aria-hidden="true"></select>
					 	</div>
					</td>
					<td style="vertical-align:top;padding-left:5px;">
						<shiro:hasPermission name="friends:cha"><a class="btn btn-light btn--icon-text" onclick="searchs();" style="width: 23px;height:23px;margin-top:8px;" title="检索"><i style="margin-top:-3px;margin-left: -5px;"  class="zmdi zmdi-search"></i></a></shiro:hasPermission>
					</td>
				</tr>
			</table>
			<!-- 检索  -->
			
			<div style="max-width:1320px;" >
			 <div class="contacts row">
			 
				 <c:forEach items="${varList}" var="var" varStatus="vs">
                       <div class="col-xl-2 col-lg-3 col-sm-4 col-6">
                           <div class="contacts__item">
                               <a class="contacts__img">
                                   <img src="${(null == var.PHOTO2 || '' == var.PHOTO2)?'static/img/photo.jpg':var.PHOTO2}" width="39" />
                               </a>
                               <div class="contacts__info">
                                   <strong>
                                   ${var.GNAME==null?'未分组':var.GNAME}
                                   (	${var.ALLOW == 'will'?'等待同意':''}
									${var.ALLOW == 'no'?'被拒绝':''}
									${var.ALLOW == 'yes'?'已同意':''})
                                   </strong>
                                   <small>${var.CTIME}</small>
                               </div>
                               <span class="contacts__btn">${var.NAME}(${var.FUSERNAME})</span>
                               <div class="contacts__info">
                               <small>
                              		<shiro:hasPermission name="friends:edit"><a title="修改" onclick="edit('${var.FRIENDS_ID}');"><i class="zmdi zmdi-edit zmdi-hc-fw"></i></a></shiro:hasPermission>
                    				<shiro:hasPermission name="friends:del"><a title="删除" onclick="del('${var.FRIENDS_ID}','${var.FUSERNAME}');"><i class="zmdi zmdi-close zmdi-hc-fw"></i></a></shiro:hasPermission>
									<shiro:hasPermission name="friends:del"><a title="拉黑" onclick="pullblack('${var.FRIENDS_ID}','${var.FUSERNAME}');" title="拉黑后也会在对方好友栏删除您"><i class="zmdi zmdi-block zmdi-hc-fw"></i></a></shiro:hasPermission>
                               </small>
                               </div>
                           </div>
                       </div>
				  </c:forEach>

            </div>
		  </div>
		<table style="width:100%;margin-top:15px;">
			<tr>
				<td style="vertical-align:top;">
				 <a class="btn btn-light btn--icon-text" onclick="window.location.href='<%=basePath%>friends/list2';" title="切换展示">切换展示</a>
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
			$("#Form").submit();
		}
		$(function() {
			var FGROUP_ID = "${pd.FGROUP_ID}";
			$.ajax({
				type: "POST",
				url: '<%=basePath%>fgroup/getFgroup?tm='+new Date().getTime(),
		    	data: {},
				dataType:'json',
				cache: false,
				success: function(data){
					 $("#FGROUP_ID").append("<option value=''>请选择分组</option>");
					 $.each(data.list, function(i, dvar){
						 if(FGROUP_ID == dvar.FGROUP_ID){
							 $("#FGROUP_ID").append("<option value="+dvar.FGROUP_ID+" selected='selected'>"+dvar.NAME+"</option>");
						 }else{
							 $("#FGROUP_ID").append("<option value="+dvar.FGROUP_ID+">"+dvar.NAME+"</option>");
						 }
					 });
				}
			});
			
			//复选框控制全选,全不选 
			$('#zcheckbox').click(function(){
			 if($(this).is(':checked')){
				 $("input[name='ids']").click();
			 }else{
				 $("input[name='ids']").attr("checked", false);
			 }
			});
		});
		
		//删除
		function del(Id,FUSERNAME){
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
        			url: '<%=basePath%>friends/deletefromlist',
        	    	data: {FRIENDS_ID:Id,tm:new Date().getTime()},
        			dataType:'json',
        			cache: false,
        			success: function(data){
        				 if("success" == data.result){
        					 top.removeFriendByI(FUSERNAME); //从自己好友栏移除  此方法在im.jsp页面中
     						 top.removeFriendFromMobile(FUSERNAME);	//从自己手机好友栏里面删除对方
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
		
		//拉黑
		function pullblack(Id,FUSERNAME){
			swal({
                title: '确定要拉黑吗?拉黑后也会在对方好友栏删除您',
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
        			url: '<%=basePath%>friends/pullblackfromlist',
        	    	data: {FRIENDS_ID:Id,FUSERNAME:FUSERNAME,tm:new Date().getTime()},
        			dataType:'json',
        			cache: false,
        			success: function(data){
        				 if("success" == data.result){
        					 top.removeFriendByI(FUSERNAME); 		//从自己好友栏移除  此方法在im.jsp页面中
     						 top.removeIFromFriend(FUSERNAME);		//从对方好友栏里面删除自己
     						 top.removeFriendFromMobile(FUSERNAME);	//从自己手机好友栏里面删除对方
        					 swal({
        		                    title: '拉黑成功',
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
		
		//修改
		function edit(Id){
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑";
			 diag.URL = '<%=basePath%>friends/goEdit?FRIENDS_ID='+Id;
			 diag.Width = 600;
			 diag.Height = 155;
			 diag.Modal = true;				//有无遮罩窗口
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('showform').style.display == 'none'){
					 searchs();
				}
				diag.close();
			 };
			 diag.show();
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
				var nstr = '';
    			for(var i=0;i < document.getElementsByName('ids').length;i++){
    				if(document.getElementsByName('ids')[i].checked){
					  	if(str=='') str += document.getElementsByName('ids')[i].value;
					  	else str += ',' + document.getElementsByName('ids')[i].value;
					  	if(nstr=='') nstr += document.getElementsByName('ids')[i].title;
					  	else nstr += ',' + document.getElementsByName('ids')[i].title;
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
						var arrid = nstr.split(',');
						for(var n=0;n<arrid.length;n++){
							top.removeFriendByI(arrid[n]); //从自己好友栏移除  此方法在im.jsp页面中
						}
						$.ajax({
							type: "POST",
							url: '<%=basePath%>friends/deleteAll?tm='+new Date().getTime(),
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
	</script>


</body>
</html>