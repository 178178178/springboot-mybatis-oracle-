<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    
    	<style type="text/css">
		#dialog-add,#dialog-message,#dialog-comment{width:100%; height:100%; position:fixed; top:0px; z-index:10000; display:none;}
		.commitopacity{position:absolute; width:100%; height:600px; background:#7f7f7f; filter:alpha(opacity=50); -moz-opacity:0.4; -khtml-opacity: 0.4; opacity: 0.4; top:0px; z-index:99999;}
		.commitbox{width:95%; padding-left:42px; padding-top:69px; position:absolute; top:0px; z-index:99999;}
		.commitbox_inner{width:96%; height:240px;  margin:6px auto; background:#efefef; border-radius:5px;}
		.commitbox_top{width:100%; height:269px; margin-bottom:10px; padding-top:10px; background:#FFF; border-radius:5px; box-shadow:1px 1px 3px #e8e8e8;}
		.commitbox_top textarea{width:95%; height:165px; display:block; margin:0px auto; border:0px;}
		.commitbox_cen{width:95%; height:40px; padding-top:10px;}
		.commitbox_cen div.left{float:left;background-size:15px; background-position:0px 3px; padding-left:18px; color:#f77500; font-size:16px; line-height:27px;}
		.commitbox_cen div.left img{width:30px;}
		.commitbox_cen div.right{float:right; margin-top:7px;}
		.commitbox_cen div.right span{cursor:pointer;}
		.commitbox_cen div.right span.save{border:solid 1px #C0C0C0; background:#C0C0C0; border-radius:3px; color:#FFF; padding:5px 10px;}
		.commitbox_cen div.right span.quxiao{border:solid 1px #C0C0C0; background:#C0C0C0; border-radius:3px; color:#FFF; padding:4px 9px;}
		.huoqu{border:solid 1px #C0C0C0; background:#C0C0C0; border-radius:3px; color:#FFF; padding:3px 8px;} 
		.qingkong{border:solid 1px #C0C0C0; background:#C0C0C0; border-radius:3px; color:#FFF; padding:3px 8px;}
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
	    
	    <!-- 添加属性  -->
		<input type="hidden" name="hcdname" id="hcdname" value="" />
		<input type="hidden" name="msgIndex" id="msgIndex" value="" />
		<input type="hidden" name="dtype" id="dtype" value="String" />
		<input type="hidden" name="isQian" id="isQian" value="是" />
		<div id="dialog-add">
			<div class="commitopacity"></div>
		  	<div class="commitbox">
			  	<div class="commitbox_inner">
			        <div class="commitbox_top">
			        	<br/>
			        	<table>
			        		<tr height="42px;">
			        			<td style="padding-left: 16px;text-align: right;"><font color="black">属性名：</font></td>
			        			<td>
			        				<input style="width:300px;" name="dname" id="dname" type="text" value="" placeholder="首字母必须为字母或下划线" title="属性名" />
			        			</td>
			        			<td style="padding-left: 16px;text-align: right;"><font color="black">属性类型：</font></td>
			        			<td style="padding-top: 5px;">
			        				<label style="float:left;padding-left: 20px;"><input name="form-field-radiot" id="form-field-radio1" onclick="setType('String');" type="radio" value="icon-edit"><span class="lbl"><font color="black">String</font></span></label>
									<label style="float:left;padding-left: 20px;"><input name="form-field-radiot" id="form-field-radio3" onclick="setType('Date');" type="radio" value="icon-edit"><span class="lbl"><font color="black">Date</font></span></label>
									<label style="float:left;padding-left: 20px;"><input name="form-field-radiot" id="form-field-radio2" onclick="setType('Integer');" type="radio" value="icon-edit"><span class="lbl"><font color="black">Integer</font></span></label>
									<label style="float:left;padding-left: 20px;"><input name="form-field-radiot" id="form-field-radio33" onclick="setType('Double');" type="radio" value="icon-edit"><span class="lbl"><font color="black">Double</font></span></label>
								</td>
			        		</tr>
			        		<tr height="42px;">
			        			<td style="padding-left: 16px;text-align: right;"><font color="black">其备注：</font></td>
			        			<td>
			        				<input style="width:300px;" name="dbz" id="dbz" type="text" value="" placeholder="例如 name的备注为 '姓名'" title="备注"/>
			        			</td>
			        			<td style="padding-left: 16px;text-align: right;"><font color="black">前台录入：</font></td>
			        			<td>
			        				<div style="float: left;padding-top: 3px;">
			        				<label style="float:left;padding-left: 20px;"><input name="form-field-radioq" id="form-field-radio4" onclick="isQian('是');" type="radio" value="icon-edit" checked="checked"><span class="lbl"><font color="black">是</font></span></label>
									<label style="float:left;padding-left: 20px;"><input name="form-field-radioq" id="form-field-radio5" onclick="isQian('否');" type="radio" value="icon-edit"><span class="lbl"><font color="black">否</font></span></label>
									</div>
									<div class="nav-search" style="float: right;padding-right: 5px;">
										<font color="black">长度：</font><input class="nav-search-input" style="width:66px;" name="flength" id="flength" type="number" value="" placeholder="长度" title="长度" />
											<font color="black">.</font> <input class="nav-search-input" style="width:50px;" name="decimal" id="decimal" type="number" value="" placeholder="小数" title="类型为Double时有效" />
									</div>
								</td>
			        		</tr>
			        		<tr height="42px;">
			        			<td style="padding-left: 16px;text-align: right;"><font color="black">引字典：</font></td>
			        			<td><input style="width:300px;" name="dictionariesid" id="dictionariesid" type="text" value="" disabled="disabled" placeholder="(非必录)" title="默认值"/></td>
			        			<td style="padding-left: 2px;text-align: left;">
			        				<a class="huoqu" onclick="selectDid();"  title="获取"><i style="margin-top:-3px;margin-left: 0px;"  class="zmdi zmdi-search"></i></a>
			        				<a class="qingkong" onclick="deldid();"  title="清空">清</a>
			        			</td>
			        			<td style="float: left;"><p style="padding-top: 12px;"><font color="#FF8000">[ 选择父级 , 子一级作为下拉菜单 ]</font></p></td>
			        		</tr>
			        		<tr height="42px;">
			        			<td style="padding-left: 16px;text-align: right;"><font color="black">默认值：</font></td><td><div class="nav-search"><input class="nav-search-input" style="width:300px;" name="ddefault" id="ddefault" type="text" value="" disabled="disabled" placeholder="后台附加值时生效" title="默认值"/></div></td>
			        			<td style="padding-left: 16px;text-align: right;"></td>
			        			<td>
			        			<div class="commitbox_cen">
					                <div class="left" id="cityname"></div>
					                <div class="right" style="padding-right: 28px;"><span class="save" onClick="saveD()">保存</span>&nbsp;&nbsp;<span class="quxiao" onClick="cancel_pl()">取消</span></div>
					            </div>
			        			</td>
			        		</tr>
			        		<tr>
			        			<td style="padding-left: 16px;" colspan="100">
			        				<font color="red" style="font-weight: bold;">
			        					注意：<br/>
			        					  1. 请不要添加  XX_ID 的主键，系统自动生成一个32位无序不重复字符序列作为主键<br/>
			        					  2. 主键为  类名_ID 格式，所有字段的字母均用大写
			        				</font>
								</td>
			        		</tr>
			        	</table>
			        </div>
			  	</div>
		  	</div>
		</div>
	    
	  <div class="card-body">  
	    
	    <form action="createCode/proCode" name="Form" id="Form" method="post">
	    <input type="hidden" name="zindex" id="zindex" value="0">
		<input type="hidden" name="FIELDLIST" id="FIELDLIST" value="">
		<input type="hidden" name="faobject" id="faobject" value="">
	    <div id="showform">
	    
            <div class="input-group">
                <span class="input-group-addon" style="width: 79px;"><span style="width: 100%;">模块说明</span></span>
                <div class="form-group">
                    <input type="text" class="form-control" name="TITLE" id="TITLE" value="${pd.TITLE }" maxlength="32" placeholder="这里输入模块说明" title="模块说明" style="width: 571px;">
                    <i class="form-group__bar"></i>
                </div>
                <span class="input-group-addon" style="width: 79px;"><span style="width: 100%;">模块类型</span></span>
                <div class="form-group">
                    <select name="FHTYPE" id="FHTYPE" data-placeholder="请选择类型" onchange="selectType(this.value)"  style="height: 32px;width: 89px;" >
						<option value="single">单表</option>
						<option value="tree">树形</option>
						<option value="fathertable">主表</option>
						<option value="sontable">明细表</option>
					</select>
                </div>
            </div>
            
            <div class="input-group" style="margin-top:5px;">
                <span class="input-group-addon" style="width: 79px;"><span style="width: 100%;">上级包名</span></span>
                <div class="form-group">
                    <input class="form-control" type="text" name="packageName" id="packageName" value="${pd.PACKAGENAME }" placeholder="包名  (不要输入特殊字符,请用纯字母)"  maxlength="30"  title="上级包名" style="width: 310px;" >
                    <i class="form-group__bar"></i>
                </div>
                <div style="padding-top: 10px;padding-right: 10px;">&nbsp;&nbsp;例如:org.fh.controller.<font color="red" style="font-weight: bold;">system</font>&nbsp;&nbsp;只输入红色部分</div>
                <div class="form-group">
                    <select name="faobjectid" id="faobjectid" data-placeholder="请选择" disabled="disabled" style="height: 25px;width:150px;background-color: #F5F5F5;" onchange="selectFa(this.value)">
						<option value="">选择主表</option>
						<c:forEach items="${varList}" var="var">
						<option value="${var.CREATECODE_ID }">${var.OBJECTNAME}</option>
						</c:forEach>
					</select>
                </div>
            </div>
            
            <div class="input-group" style="margin-top:5px;">
                <span class="input-group-addon" style="width: 79px;"><span style="width: 100%;">处理类名</span></span>
                <div class="form-group">
                    <input class="form-control" type="text" name="objectName" id="objectName" value="${pd.OBJECTNAME }" placeholder="这里输入处理类名称"  maxlength="50"  title="处理类名" style="width: 300px;">
                    <i class="form-group__bar"></i>
                </div>
                <div style="padding-top: 10px;padding-right: 10px;"><font style="font-weight: bold;">(类名首字母必须为大写字母或下划线)</font></div>
                <span class="input-group-addon" style="width: 79px;"><span style="width: 100%;">表前缀</span></span>
                <div class="form-group">
                    <input class="form-control" type="text" name="tabletop" id="tabletop" value="${msg == 'add' ? 'TB_' : ''}${fn:split(pd.TABLENAME, ',fh,')[0]}" placeholder="这里输入表前缀" maxlength="50"  title="表前缀" >
                    <i class="form-group__bar"></i>
                </div>
            </div>
            
            
         	<table id="table_report" style="margin-top: 5px;" class="table table-bordered mb-0">
					
					<thead>
						<tr>
							<th style="width:50px;">NO</th>
							<th>属性名</th>
							<th>类型</th>
							<th>长度</th>
							<th style="width:79px;">小数点</th>
							<th>备注</th>
							<th style="width:100px;">前台录入</th>
							<th>默认值</th>
							<th style="width:69px;">操作</th>
						</tr>
					</thead>
											
					<tbody id="fields"></tbody>
					
			</table>
            
            <div class="input-group" style="margin-top:10px;" >
            	<span style="width: 100%;text-align: center;">
            		<a class="btn btn-light btn--icon-text" id="to-save" onclick="dialog_open();">新增</a>
            		<a class="btn btn-light btn--icon-text" id="productc" onclick="save();">生成</a>
            		<a class="btn btn-light btn--icon-text" onclick="top.Dialog.close();">取消</a>
            	</span>
            </div>
            
           </div>
           
           <div id="jiazai" style="display:none;width: 100%;text-align: center;" class="page-loader" >
           <div><br/><br/><h4>提交成功,等待下载<font color="red"><strong id="second_show">10秒</strong></font>后关闭</h4></div>
			   <div class="page-loader__spinner">
			        <svg viewBox="25 25 50 50">
			            <circle cx="50" cy="50" r="20" fill="none" stroke-width="2" stroke-miterlimit="10"></circle>
			        </svg>
			   </div>
			   <br/>
		   </div>
           
	    </form>
	    
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
    
    <script src="static/js/productCode.js"></script>
    
    <!-- 表单验证提示 -->
  	<script src="static/js/jquery.tips.js"></script>
    
    <script type="text/javascript">
    	var locat = '<%=basePath%>';
    	$(reductionFields());
		//修改时还原属性列表
		function reductionFields(){
			var msg = '${msg}';
			if('edit' == msg){
				var nowarField = '${pd.FIELDLIST}';
				var fieldarray = nowarField.split('Q313596790');
				for(var i=0;i<fieldarray.length;i++){
					if(fieldarray[i] != ''){
					appendC(fieldarray[i]);
					arField[i] = fieldarray[i];
					}
				}
			}
		}
	</script>
</body>
</html>
