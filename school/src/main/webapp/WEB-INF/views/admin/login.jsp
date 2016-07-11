<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>登录</title>
<link rel="stylesheet" type="text/css" href="${contextPath}/resources/admin/css/cssreset-min.css" />
<link href="${contextPath}/resources/admin/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/resources/admin/ligerUI/skins/Silvery/css/style.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/resources/admin/css/login2.css" rel="stylesheet" type="text/css" />
<script src="${contextPath}/resources/common/js/jquery-1.9.0.min.js" type="text/javascript"></script>
<script src="${contextPath}/resources/admin/ligerUI/js/ligerui.all.js" type="text/javascript"></script>
<script>
function inputblur(obj){		
	if (!$(obj).val()||$(obj).val()=="请输入用户名"||$(obj).val()=="请输入验证码") {
			$(obj).parents(".input_box").removeClass("focus");
		}
	}
	function inputfocus(obj) {
		$(obj).parents(".input_box").addClass("focus");
	}
	function ischeck() {
		if ($("#cb1").is(':checked')) {
			$("#remember_button .button").removeClass("checked");
		} else {
			$("#remember_button .button").addClass("checked");
		}
	}
	$(function() {
		$.ajaxSetup({async: false});
		$("#codeClick").click(function(){
			changeCode($("#yzm_pic"));
		});
		function changeCode(domEle){
			var url = "/servlet/AuthImageServlet?t="+ Math.random()+"&preName=admin";
			$(domEle).attr("src",url);
		}
		//验证是否为空
		function check(){
			if($.trim($("#userAccount").val())=="请输入用户名"||$.trim($("#userAccount").val()).length==0){
				$.ligerDialog.warn("用户名不能为空","提示");
				return false;
			}else if($("#pass").val()=="请输入密码"||$("#pass").val().length==0){
				$.ligerDialog.warn("密码不能为空","提示");
				return false;
			}else if($("#code").val()=="请输入验证码"||$("#code").val().length==0){
				$.ligerDialog.warn("验证码不能为空","提示");
				return false;
			}
			return true;
		}
		
		$("#myfrom").submit(function(){
			var flag = false;
			if(!check()){
				return false;
			}else{
				var checkUser = $("#cb1").is(':checked');
				$("#checkUser").val(checkUser);
				$.ajax({
                	type:"POST",
          	        url:"/admin/checkLogin.do",
          	        data:$("#myfrom").serializeArray(),
          	        datatype: "json",
          	      	async : false,
          	      	beforeSend:function(){
	          	      	var t = $(document).scrollTop();
	    	        	$("#pageloading").css({"top":t});
	    	        	$("#pageloading").show();
	      	        },
		      	    success:function(json){
	       	    	   if(json.result =="errorCode"){
	       	    		$("#pageloading").hide();
	       	    		   $.ligerDialog.warn("验证码不正确","提示");
							$("input[name='code']").val("");
							$("#codeClick").click();
							flag = false;
	       	    	   }else if(json.result =="none"){
	       	    		$("#pageloading").hide();
	       	    			$.ligerDialog.warn("用户名或密码不正确","提示");
	       	    			$("input[name='code']").val("");
	       	    			$("#pass").val("");
	       	    			$("#codeClick").click();
	       	    			flag = false;
	       	    	   }else if(json.result == "invalid"){
	       	    			$("#pageloading").hide();
	       	    			$.ligerDialog.warn("当前这个用户是无效的，请联系管理员","提示");
	       	    			$("input[name='code']").val("");
	       	    			$("#pass").val("");
	       	    			$("#codeClick").click();
	       	    			flag = false;
	       	    	   }else if(json.result == "error"){
	       	    			$("#pageloading").hide();
	       	    			$.ligerDialog.warn("系统错误，请稍后再试","提示");
	       	    			$("input[name='code']").val("");
	       	    			$("#pass").val("");
	       	    			$("#codeClick").click();
	       	    			flag = false;
	       	    	   }else{
// 	       	    		    $.ligerDialog.success("登录成功！","提示");
							$.ligerDialog.waitting('登录成功！'); setTimeout(function () { 
// 								window.location.href="/admin/index.action";
								$.ligerDialog.closeWaitting();
							}, 1200);
	       	    			flag = true;
// 	       	    			window.location.href="/admin/index.action";
	       	    	   }
	       	        },
	      	      	complete: function(XMLHttpRequest, textStatus){
	      	            //HideLoading();
	      	      		$("#pageloading").hide();
	      	        }, 
	      	        error: function(){
	      	        	$("#pageloading").hide();
	      	        	//请求出错处理
	      	            $.ligerDialog.error("操作失败","提示");
	      	        	flag = false;
	      	        }        
                  });
				return flag;
			}
		});
		
		if ($("#pwd").val() == "" || $("#pwd").val() == "请输入密码") {
			$("#pass").hide();
			$("#pass").parent(".input_box").removeClass("focus");
			$("#pwd").show();
		} else {
			$("#pass").show().focus();
			$("#pass").val("");
			$("#pass").parent(".input_box").addClass("focus");
			$("#pwd").hide();
		}
		$("#pass").blur(function() {
			if ($(this).val() == "") {
				$("#pass").hide();
				$("#pass").parent(".input_box").removeClass("focus");
				$("#pwd").show();
			}
		});
		$("#pwd").focus(function() {
			if ($(this).val() == "请输入密码") {
				$("#pass").show().focus();
				$("#pass").parent(".input_box").addClass("focus");
				$("#pwd").hide();
			}
		});
		$("#pwd").blur(function() {
			if ($(this).val() == "") {
				$("#pass").hide();
				$("#pass").parent(".input_box").removeClass("focus");
				$("#pwd").show();
			}
		});
	});
</script>
<style type="text/css">
#pageloading {
	position: absolute;
	left: 0px;
	background: white
		url('${contextPath}/resources/admin/images/loading.gif') no-repeat
		center;
	width: 100%;
	height: 100%;
	z-index: 99999;
}
</style>
</head>
<body>
	<div id="pageloading" style="display: none;"></div>
	<div class="main">
		<div class="login_title">
			<div>
				<span class="span_28">网站后台管理系统</span>
			</div>
		</div>
		<div class="login_bgbox">
			<div class="login_bg">
				<div id="login_box_bg">
					<div id="login_box">
						<form action="/admin/index.do" method="post" id="myfrom">
							<input id="checkUser" name="checkUser" type="hidden" />
							<table cellpadding="0" cellspacing="0">
								<tr>
									<td>
										<div class="input_box" id="username">
											<span class="picture"></span><span class="vertical_line"></span>
											<c:if test="${empty userAccount}">
												<input class="input_text" value="请输入用户名" id="userAccount"
													name="userAccount"
													onblur="if(value==''){value='请输入用户名';inputblur(this)}"
													onfocus="if(value=='请输入用户名') {value='';inputfocus(this)}"
													type="text" />
											</c:if>
											<c:if test="${!empty userAccount}">
												<input class="input_text" value="${userAccount}"
													id="userAccount" name="userAccount"
													onblur="if(value==''){value='请输入用户名';inputblur(this)}"
													onfocus="if(value=='请输入用户名') {value='';inputfocus(this)}"
													type="text" />
											</c:if>
										</div>
									</td>
								</tr>
								<tr>
									<td>
										<div class="input_box" id="password">
											<span class="picture"></span><span class="vertical_line"></span>
											<input id="pass" class="input_text" type="password"
												name="password" style="display: none;" /> <input id="pwd"
												class="input_text" value="请输入密码" type="text" />
										</div>
									</td>
								</tr>
								<tr>
									<td>
										<div id="yzm_box">
											<div class="input_box" id="yzm">
												<span><input class="input_text" value="请输入验证码"
													id="code" name="code" maxlength="4" size="4"
													onblur="if(value==''){value='请输入验证码';inputblur(this)}"
													onfocus="if(value=='请输入验证码') {value='';inputfocus(this)}"
													type="text" /></span>
											</div>
											<img id="yzm_pic" name="verifyImg"
												src="/servlet/AuthImageServlet?preName=admin" /> <span
												class="font_4">看不清楚！<a href="javascript:void(0);"
												id="codeClick">换一张</a></span>
										</div>
									</td>
								</tr>
								<tr>
									<td>
										<div id="button_box">
											<div id="remember_button">
												<label class="button" onclick="ischeck()" for="cb1"></label>
												<input id="cb1" type="checkbox" /> <label class="text"
													onclick="ischeck()" for="cb1">记住我?</label>
											</div>
											<div id="submit_button">
												<input id="submit" type="submit" value="" />
											</div>
										</div>
									</td>
								</tr>
							</table>
						</form>
						<span class="tip">*专业后台系统，非工作人员请关闭页面</span>
					</div>
					<span class="msg">版权所有：suny</span>
				</div>
			</div>

		</div>
	</div>
</body>
</html>
