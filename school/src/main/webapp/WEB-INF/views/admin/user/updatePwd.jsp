<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改密码</title>
 	<link href="${contextPath}/resources/admin/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="${contextPath}/resources/admin/ligerUI/skins/Silvery/css/style.css" rel="stylesheet" type="text/css" />
    <link href="${contextPath}/resources/admin/css/edit.css" rel="stylesheet" type="text/css" />
    
    <script src="${contextPath}/resources/common/js/jquery-1.9.0.min.js" type="text/javascript"></script>
    <script src="${contextPath}/resources/admin/ligerUI/js/core/base.js" type="text/javascript"></script> 
    <script src="${contextPath}/resources/admin/ligerUI/js/ligerui.all.js" type="text/javascript"></script> 
	<script src="${contextPath}/resources/admin/js/common.js" type="text/javascript"></script>
	
    <script src="${contextPath}/resources/admin/js/jquery-validation/jquery.validate.min.js" type="text/javascript"></script> 
    <script src="${contextPath}/resources/admin/js/jquery-validation/jquery.metadata.js" type="text/javascript"></script>
    <script src="${contextPath}/resources/admin/js/jquery-validation/messages_cn.js" type="text/javascript"></script>
    <script src="${contextPath}/resources/admin/js/jquery-validation/validate_methods.js" type="text/javascript"></script>
    <script type="text/javascript">
    	var eee;
    	$(function (){
    	    	$.ajaxSettings.async = false;
    	          $.metadata.setType("attr", "validate");
    	          var v = $("form").validate({
    	              debug: true,
    	              errorPlacement: function (lable, element){
    	            	  var len = lable.html().length;
    	            	  var wid = 12*len+10;
    	                  if (element.hasClass("l-textarea")){
    	                      element.ligerTip({ content: lable.html(), target: element[0],width:wid }); 
    	                  }
    	                  else if (element.hasClass("l-text-field")){
    	                      element.parent().ligerTip({ content: lable.html(), target: element[0],width:wid });
    	                  }
    	                  else{
    	                      lable.appendTo(element.parents("td:first").next("td"));
    	                  }
    	              },
    	              success: function (lable){
    	                  lable.ligerHideTip();
    	                  lable.remove();
    	              },
    	              submitHandler: function (){
    	                  $("form .l-text,.l-textarea").ligerHideTip();
    	                  $.ajax({
    	          	        url:"updatePwd.do",
    	          	        data:$("#myfrom").serializeArray(),
    			      	    success:function(json){
    		       	    	   $("#pageloading").hide();
    		       	    	   if(json.result =="updatedone"){
    		       	    		   $.ligerDialog.success("修改成功,请重新登录!","提示");
    		       	    			setTimeout(function(){
	    		       	    		   //window.parent.location.href="/admin/index.action";
	    		       	    		},1500); 
    		       	    	   }else if(json.result =="resetdone"){
	    		       	    		$.ligerDialog.success("修改成功!","提示");
		       	    				
		       	    				setTimeout(function(){
		       	    					window.location.href = "/admin/user/list.do";
		    		       	    	},1500); 
    		       	    	   }else if(json.result == "error"){
    		       	    			$.ligerDialog.error("操作失败,请稍后再试！","提示");
    		       	    	   }else{
    		       	    		    $.ligerDialog.warn("旧密码输入不正确","提示");
    		       	    	   }
    		       	        }       
    	                  });
    	              }
    	          });
    	          $("form").ligerForm();
    	      });  
   	</script>
   	<style type="text/css">
		body{ padding-left: 10px; font-size: 12px;}
		#departmentId{font-size: 12px; font-weight: normal;}
		.back{ height: 30px;padding: 10px;}
		.l-table-edit {width:100%; border:1px solid #EDECFF; font-family:Verdana, Geneva, sans-serif;}
        .l-table-edit-td{ padding:4px;background-color:#fafafa;}
         .l-table-edit-td2{ padding:4px;padding:0.4em; }
        .l-table-edit-td .txt{font-size: 12px; font-weight: normal;}
        .l-verify-tip{ left:230px; top:120px;}
        font{color: red;}
        .l-button-submit,.l-button-reset{width:80px; float:left; margin-left:10px; padding-bottom:2px;}
        .btn{height: 50px; padding-top: 20px;padding-left: 60px;}
	</style>
</head>
<body>
<div id="pageloading" style="display: none;"></div>
	<c:if test="${id !=null }">
		<div class="back">
			<button type="button" class="l-button" onclick="history.go(-1)">返回</button>
		</div>
	</c:if>
	<form action="" method="post" id="myfrom">
		<c:if test="${id!=null}">
			<input type="hidden" id="id" name="id" value="${id }"/>
		</c:if>
		<table  cellpadding="0" cellspacing="0" class="l-table-edit">
		  <c:if test="${id==null }">
			<tr>
				<td align="right" class="l-table-edit-td">旧密码：</td>
				
				<td align="left" class="l-table-edit-td2"><div>
				<table cellpadding="0" cellspacing="0" >
					<tr >
						<td align="left" >
							<input type="password" maxlength="15" class="txt" id="oldPwd" name="oldPwd" ltype="text" validate="{required:true}"/>
						</td>
						<td align="left" >
							<span style="color: red">*</span>
						</td>
					</tr>
					
				</table></div></td>
				
			</tr>
		  </c:if>
			<tr>
				<td align="right" class="l-table-edit-td">密码：</td>
				<td align="left" class="l-table-edit-td2"><div>
				<table cellpadding="0" cellspacing="0" >
					<tr >
						<td align="left" >
							<input type="password" id="newPwd" name="newPwd" class="txt" ltype="text" validate="{required:true,isPwd:true}"/>
						</td>
						<td align="left" >
							<span style="color: red">*</span>
						</td>
					</tr>
					
				</table></div></td>
			</tr>
			<tr>
				<td align="right" class="l-table-edit-td">确认密码：</td>
				<td align="left" class="l-table-edit-td2"><div>
				<table cellpadding="0" cellspacing="0" >
					<tr >
						<td align="left" >
							<input type="password" id="repassword" name="repassword" class="txt" ltype="text" validate="{required:true,equalTo:'#newPwd'}"/>
						</td>
						<td align="left" >
							<span style="color: red">*</span>
						</td>
					</tr>
					
				</table></div></td>
			</tr>
		</table>
		<div class="btn">
			<input type="submit" value="提交" id="Button1" class="l-button l-button-submit" />
			<input type="reset" value="重置" id="Button2" class="l-button l-button-submit" /> 
		</div>
	</form>	
</body>
</html>