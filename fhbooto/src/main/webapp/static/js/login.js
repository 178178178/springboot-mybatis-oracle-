
//页面加载完执行
$(document).ready(function(){
	$($("#USERNAME").focus());
	var SKIN = $.cookie('SKIN');
	if (typeof(SKIN) != "undefined") {
		$('body').attr('data-sa-theme', SKIN);
	}else{
		setInterval(switchingBackground, 6000);
	}
});

//登录背景自动切换
var i = 1;
function switchingBackground(){
	if(i==11)i=1;
	$('body').attr('data-sa-theme', i);
	i++;
};

//服务端校验
function check() {
	if (notNull()) {
		var USERNAME = $("#USERNAME").val();
		var PASSWORD = $("#PASSWORD").val();
		var CODE = "qq313596790fh" + USERNAME + ",fh," + PASSWORD;
		$.ajax({
			type : "POST",
			url : local+'admin/check',
			data : {
				KEYDATA : CODE,
				tm : new Date().getTime()
			},
			dataType : 'json',
			cache : false,
			success : function(data) {
				if ("success" == data.result) {
					$("#USERNAME").tips({
						side : 2,
						msg : '正在登录 , 请稍后 ...',
						bg : '#68B500',
						time : 10
					});
					window.location.href = local+"main/index";
				} else if ("usererror" == data.result) {
					$("#USERNAME").tips({
						side : 2,
						msg : "用户名或密码有误",
						bg : '#FF5080',
						time : 15
					});
					$("#USERNAME").focus();
				} else {
					$("#USERNAME").tips({
						side : 2,
						msg : "缺少参数",
						bg : '#FF5080',
						time : 15
					});
					$("#USERNAME").focus();
				}
			}
		});
	}
}

//客户端校验
function notNull() {
	if ($("#USERNAME").val() == "") {
		$("#USERNAME").tips({
			side : 2,
			msg : '用户名不得为空',
			bg : '#AE81FF',
			time : 3
		});
		$("#USERNAME").focus();
		return false;
	} else {
		$("#USERNAME").val(jQuery.trim($('#USERNAME').val()));
	}
	if ($("#PASSWORD").val() == "") {
		$("#PASSWORD").tips({
			side : 2,
			msg : '密码不得为空',
			bg : '#AE81FF',
			time : 3
		});
		$("#PASSWORD").focus();
		return false;
	}
	return true;
}

//重启之后 点击左侧列表跳转登录首页 
if (window != top) {
	top.location.href = location.href;
}
var nowLR = "l";
//键盘回车事件，执行登录
$(document).keyup(function(event) {
	if(event.keyCode == 13 && "l" == nowLR) {
		$("#to-login").trigger("click");
	}else if(event.keyCode == 13 && "r" == nowLR) {
		$("#to-register").trigger("click");
	}
});
function setNowLR(value){
	nowLR = value;
}

//提交注册
function register(){
	if(rcheck()){
		var nowtime = date2str(new Date(),"yyyyMMdd");
		$.ajax({
			type: "POST",
			url: 'admin/register',
	    	data: {USERNAME:$("#RUSERNAME").val(),PASSWORD:$("#RPASSWORD").val(),NAME:$("#RNAME").val(),FKEY:$.md5('USERNAME'+nowtime+',fh,'),tm:new Date().getTime()},
			dataType:'json',
			cache: false,
			success: function(data){
				if("00" == data.result){
					$("#RUSERNAME").tips({
						side : 2,
						msg : '注册成功,请登录',
						bg : '#68B500',
						time : 3
					});
					setNowLR('r');
					sleep(100);
					$("#hasUser").click();
					$("#RNAME").val('');
					$("#RUSERNAME").val('');
					$("#RPASSWORD").val('')
					$("#USERNAME").focus();
				}else if("01" == data.result){
					$("#RUSERNAME").tips({
						side : 1,
						msg : "用户名已存在",
						bg : '#FF5080',
						time : 15
					});
					$("#RUSERNAME").focus();
				}
			}
		});
	}
}

//注册
function rcheck(){
	if($("#RNAME").val()==""){
		$("#RNAME").tips({
			side:3,
            msg:'输入姓名',
            bg:'#AE81FF',
            time:3
        });
		$("#RNAME").focus();
		return false;
	}
	if($("#RUSERNAME").val()==""){
		$("#RUSERNAME").tips({
			side:3,
            msg:'输入用户名',
            bg:'#AE81FF',
            time:2
        });
		$("#RUSERNAME").focus();
		$("#RUSERNAME").val('');
		return false;
	}else{
		$("#RUSERNAME").val(jQuery.trim($('#RUSERNAME').val()));
	}
	if($("#RPASSWORD").val()==""){
		$("#RPASSWORD").tips({
			side:3,
            msg:'输入密码',
            bg:'#AE81FF',
            time:2
        });
		$("#RPASSWORD").focus();
		return false;
	}
	return true;
}

//js  日期格式
function date2str(x,y) {
     var z ={y:x.getFullYear(),M:x.getMonth()+1,d:x.getDate(),h:x.getHours(),m:x.getMinutes(),s:x.getSeconds()};
     return y.replace(/(y+|M+|d+|h+|m+|s+)/g,function(v) {return ((v.length>1?"0":"")+eval('z.'+v.slice(-1))).slice(-(v.length>2?v.length:2))});
 	};
//休眠几秒
function sleep(n) {
     var start = new Date().getTime();
     while (true) {
         if (new Date().getTime() - start > n) {
             break;
         }
     }
 }

// 3-1-3-5-9-6-7-9-0-QQ