<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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

    <!-- 下拉选择框插件 -->
    <link rel="stylesheet" href="static/vendors/bower_components/select2/dist/css/select2.min.css">
    <!-- App styles -->
    <link rel="stylesheet" href="static/css/app.min.css">
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

	<div class="card-body">
					
		<form action="timingbackup/${msg }" name="Form" id="Form" method="post">
			<input type="hidden" name="TIMINGBACKUP_ID" id="TIMINGBACKUP_ID" value="${pd.TIMINGBACKUP_ID}"/>
			<div id="showform" style="padding-top: 13px;">
			
				<div class="input-group">
	                <span class="input-group-addon" style="width: 79px; border:1px solid #596D88"><span style="width: 100%;">备份对象</span></span>
	                <div class="form-group" style="padding-left: 15px;">
	                    <select class="select2 select2-hidden-accessible" name="TABLENAME" id="TABLENAME" data-placeholder="请选择" tabindex="-1" aria-hidden="true" >
							<option value="all">整库</option>
							<c:if test="${dbtype != 'sqlserver' }">
							<c:forEach items="${varList}" var="varTab">
								<option value="${varTab }" <c:if test="${pd.TABLENAME==varTab}">selected</c:if>>${varTab }</option>
							</c:forEach>
						 	</c:if>
						 </select>
	                </div>
	            </div>
				
				<div class="input-group" style="margin-top:3px;">
	                <span class="input-group-addon" style="width: 79px;"><span style="width: 100%;">时间规则</span></span>
	                <div class="form-group">
	                    <input type="text" class="form-control" name="FHTIME" id="FHTIME" value="${pd.FHTIME }" maxlength="32" placeholder="这里输入时间规则" title="时间规则">
	                    <i class="form-group__bar"></i>
	                </div>
	            </div>
	            <div class="input-group" style="margin-top:3px;">
	                <span class="input-group-addon" style="width: 79px;"><span style="width: 100%;">备注说明</span></span>
	                <div class="form-group">
	                    <input class="form-control" type="text" name="BZ" id="BZ"  value="${pd.BZ }"  maxlength="50" placeholder="这里输入备注说明" title="备注说明" >
	                    <i class="form-group__bar"></i>
	                </div>
	            </div>						
			
				<table class="table table-bordered mb-0" style="margin-top:3px;">
					<tr>
						<td style="width:100px;text-align: right;" id="setFHTIME">设定</td>
						<td style="text-align: right;">
							<select onchange="setTimegz(this.value,'month')">
								<option value="*">每</option>
								<option value="1">一</option>
								<option value="2">二</option>
								<option value="3">三</option>
								<option value="4">四</option>
								<option value="5">五</option>
								<option value="6">六</option>
								<option value="7">七</option>
								<option value="8">八</option>
								<option value="9">九</option>
								<option value="10">十</option>
								<option value="11">十一</option>
								<option value="12">十二</option>
							</select>
						</td>
						<td style="width:75px;text-align: left;padding-top: 13px;">月</td>
						<td style="text-align: right;">
							<select onchange="setTimegz(this.value,'week')" id="weekId">
								<option value="*">每</option>
								<option value="MON">一</option>
								<option value="TUES">二</option>
								<option value="WED">三</option>
								<option value="THUR">四</option>
								<option value="FTI">五</option>
								<option value="SAT">六</option>
								<option value="SUN">七</option>
							</select>
						</td>
						<td style="width:75px;text-align: left;padding-top: 13px;">周</td>
						<td style="text-align: right;">
							<select onchange="setTimegz(this.value,'day')" id="dayId">
								<option value="*">每</option>
								<option value="1">1</option>
								<option value="2">2</option>
								<option value="3">3</option>
								<option value="4">4</option>
								<option value="5">5</option>
								<option value="6">6</option>
								<option value="7">7</option>
								<option value="8">8</option>
								<option value="9">9</option>
								<option value="10">10</option>
								<option value="11">11</option>
								<option value="12">12</option>
								<option value="13">13</option>
								<option value="14">14</option>
								<option value="15">15</option>
								<option value="16">16</option>
								<option value="17">17</option>
								<option value="18">18</option>
								<option value="19">19</option>
								<option value="20">20</option>
								<option value="21">21</option>
								<option value="22">22</option>
								<option value="23">23</option>
								<option value="24">24</option>
								<option value="25">25</option>
								<option value="26">26</option>
								<option value="27">27</option>
								<option value="28">28</option>
							</select>
						</td>
						<td style="width:75px;text-align: left;padding-top: 13px;">日</td>
						<td style="text-align: right;">
							<select onchange="setTimegz(this.value,'hour')">
								<option value="*">每</option>
								<option value="1">1</option>
								<option value="2">2</option>
								<option value="3">3</option>
								<option value="4">4</option>
								<option value="5">5</option>
								<option value="6">6</option>
								<option value="7">7</option>
								<option value="8">8</option>
								<option value="9">9</option>
								<option value="10">10</option>
								<option value="11">11</option>
								<option value="12">12</option>
								<option value="13">13</option>
								<option value="14">14</option>
								<option value="15">15</option>
								<option value="16">16</option>
								<option value="17">17</option>
								<option value="18">18</option>
								<option value="19">19</option>
								<option value="20">20</option>
								<option value="21">21</option>
								<option value="22">22</option>
								<option value="23">23</option>
							</select>
						</td>
						<td style="width:75px;text-align: left;padding-top: 13px;">时</td>
					</tr>
					<tr>
						<td colspan="10" style="text-align: center;"><b>规则说明</b></td>
					</tr>
					<tr>
						<td colspan="10"><input type="text" class="center" name="TIMEEXPLAIN" id="TIMEEXPLAIN" value="${pd.TIMEEXPLAIN}" maxlength="100" placeholder="这里是规则说明" title="规则说明" style="width:100%;" readonly="readonly"/></td>
					</tr>
				</table>
			
				<div class="input-group" style="margin-top:10px;" >
	            	<span style="width: 100%;text-align: center;">
	            		<a class="btn btn-light btn--icon-text" id="to-save" onclick="save();">保存</a>
	            		<a class="btn btn-light btn--icon-text" onclick="top.Dialog.close();">取消</a>
	            	</span>
	            </div>
            
            </div>
           
           <div id="jiazai" style="display:none;width: 100%;text-align: center;" class="page-loader" >
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
  
    <!-- 下拉选择框插件 -->
    <script src="static/vendors/bower_components/select2/dist/js/select2.full.min.js"></script>
    <!-- 表单验证提示 -->
  	<script src="static/js/jquery.tips.js"></script>
  	<!-- App functions and actions -->
    <script src="static/js/app.min.js"></script>
  	
	<script type="text/javascript">
		
		var hour = "*";
		var day = "*";
		var week = "*";
		var month = "*";
		//设置时间规则
		function setTimegz(value,type){
			if('hour' == type){
				hour = value;
			}else if('day' == type){
				day = value;
			}else if('week' == type){
				week = value;
			}else{
				month = value;
			}
			var strM = "";
			var strW = "";
			var strD = "";
			var strH = "";
			if("*" == month){
				strM = "每个月";
			}else{
				strM = "每年 "+month + " 月份";
			}
			if("?" != week){
				if("*" == week){
					strW = "每周";
					strD = "每天";
					$("#dayId").removeAttr("disabled");  
					$("#dayId").css("background","#FFFFFF");
				}else{
					$("#dayId").attr("disabled","disabled"); 
					$("#dayId").css("background","#F5F5F5");
					day = "?";
					strD = "";
					strW = "每个星期"+getWeek(week);
				}
			}
			if("?" != day){
				if("*" == day){
					strD = "每天";
					strW = "每周";
					$("#weekId").removeAttr("disabled");
					$("#weekId").css("background","#FFFFFF");
				}else{
					$("#weekId").attr("disabled","disabled"); 
					$("#weekId").css("background","#F5F5F5");
					week = "?";
					strW = "";
					strD = day + "号";
				}
			}
			if("*" == hour){
				strH = "每小时";
			}else{
				strH = hour + "点时";
			}
			if("*" == day && "*" == week){
				day = "*";
				week = "?";
			}
			$("#FHTIME").val("0 0 "+hour + " " + day + " " + month + " " + week);
			$("#TIMEEXPLAIN").val(strM+"的 "+strW+" "+strD+" "+strH+"执行一次");
		}
		
		//获取星期汉字
		function getWeek(value){
			var arrW = new Array("MON","TUES","WED","THUR","FTI","SAT","SUN");
			var arrH = new Array("一","二","三","四","五","六","日");
			for(var i=0;i<arrW.length;i++){
				if(value == arrW[i]) return arrH[i];
			}
		}
		
		//保存
		function save(){
			if($("#FHTIME").val()==""){
				$("#setFHTIME").tips({
					side:3,
		            msg:'请设置时间规则',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FHTIME").focus();
			return false;
			}
			if($("#BZ").val()==""){
				$("#BZ").tips({
					side:3,
		            msg:'请输入备注',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#BZ").focus();
			return false;
			}
			$("#Form").submit();
			$("#showform").hide();
			$("#jiazai").show();
		}

	</script>
</body>
</html>