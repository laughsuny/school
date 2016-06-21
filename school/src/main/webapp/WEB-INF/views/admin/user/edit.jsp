<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>编辑用户信息</title>
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
    $(function ()
      {
    	var userType = $("input[name='userType']:checked").val();
    	if(userType==1){
    		$("#myfrom table tr:last").show();
    	}else{
    		$("#myfrom table tr:last").hide();
    	}
    	$("input[name='userType']").click(function(){
    		if($(this).val()==1){
    			$("#myfrom table tr:last").show();
    		}else{
    			$("#myfrom table tr:last").hide();
    		}
    	});
    	$.ajaxSettings.async = false;
    	// 判断是否被注册用户名
		jQuery.validator.addMethod("checkUserAccount", function(value, element) { 
			var falg = true;
	    	$.post("checkUserAccount.do",{"account":$("#account").val()},function(json){
				if(json == true){
					falg = false;
				}
			});
			return this.optional(element) || falg;       
		}, "这个用户名已经被注册，请输入其他用户名！");
       	   
          $.metadata.setType("attr", "validate");
          var v = $("form").validate({
              debug: true,
              errorPlacement: function (lable, element)
              {
            	  var len = lable.html().length;
            	  var wid = 12*len+10;
                  if (element.hasClass("l-textarea"))
                  {
                      element.ligerTip({ content: lable.html(), target: element[0],width:wid }); 
                  }
                  else if (element.hasClass("l-text-field"))
                  {
                      element.parent().ligerTip({ content: lable.html(), target: element[0],width:wid  });
                  }
                  else
                  {
                      lable.appendTo(element.parents("td:first").next("td"));
                  }
              },
              success: function (lable)
              {
                  lable.ligerHideTip();
                  lable.remove();
              },
              submitHandler: function ()
              {
                  $("form .l-text,.l-textarea").ligerHideTip();
                  $.ajax({
          	        url:"${action}.do",
          	        data:$("#myfrom").serializeArray(),
		      	    success:function(json){
	       	    	   $("#pageloading").hide();
	       	    	   if(json.result =="success"){
	       	    		   $.ligerDialog.success("操作成功","提示");
		       	    		setTimeout(function(){
		       	    			history.go(-1);
		       	    		},1200);
	       	    	   }else{
		       	    		$.ligerDialog.error("操作失败，请稍后重试！","提示");
	       	    	   }
	       	        }
                  });
              }
          });
          $("form").ligerForm();
      });  
    </script>	
</head>
<body>
	<div id="pageloading" style="display: none;"></div>
	<div class="back">
		<button type="button" class="l-button" onclick="history.go(-1)">返回</button>
	</div>
	<form action="" method="post" id="myfrom">
	  <c:if test="${action eq 'update' }">
			<input value="${user.id }" type="hidden"  name="id" id="hiddenId"/>
	  </c:if>
		<table  cellpadding="0" cellspacing="0" class="l-table-edit">
			<tr>
				<td align="right" class="l-table-edit-td">用户帐号：</td>
				
				<td align="left" class="l-table-edit-td2"><div>
				<table cellpadding="0" cellspacing="0" >
					<tr >
						<td align="left" >
							<c:if test="${action eq 'update' }">
				<input maxlength="15" class="txt" type="text" id="account" ltype="text" validate="{required:true}" value="${user.account }" name="account" readonly="readonly"/>
				</c:if>
				<c:if test="${action eq 'save' }">
				<input maxlength="15" class="txt" type="text" id="account" ltype="text" validate="{checkUserAccount:true}" value="${user.account }" name="account"/>
				</c:if>
						</td>
						<td align="left" >
							<span style="color: red">*</span>
						</td>
					</tr>
					
				</table></div></td>
								
			</tr>
			<tr>
				<td align="right" class="l-table-edit-td">用户名称：</td>
				<td align="left" class="l-table-edit-td2"><div>
				<table cellpadding="0" cellspacing="0" >
					<tr >
						<td align="left" >
							<input type="text" maxlength="15" class="txt" id="username" name="username" value="${user.username }" ltype="text" validate="{required:true}"/>
						</td>
						<td align="left" >
							<span style="color: red">*</span>
						</td>
					</tr>
					
				</table></div></td>
			</tr>
			<c:if test="${action eq 'save' }">
			<tr>
				<td align="right" class="l-table-edit-td">密码：</td>
				<td align="left" class="l-table-edit-td2"><div>
				<table cellpadding="0" cellspacing="0" >
					<tr >
						<td align="left" >
							<input type="password" id="password" name="password" class="txt" ltype="text" validate="{required:true,isPwd:true}"/>
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
							<input type="password" id="repassword" name="repassword" class="txt" ltype="text" validate="{required:true,equalTo:'#password'}"/>
						</td>
						<td align="left" >
							<span style="color: red">*</span>
						</td>
					</tr>
					
				</table></div></td>
				
			</tr>
			</c:if>
			<tr>
				<td align="right" class="l-table-edit-td">用户类别：</td>
				<td align="left" class="l-table-edit-td2">
					<c:choose>
						<c:when test="${ action eq 'save' }">
							<input type="radio" name="userType" value="1" checked="checked"/><label>普通用户</label>
							<input type="radio" name="userType" value="0"/><label>超级管理员</label>
						</c:when>
						<c:otherwise>
							<input type="radio" name="userType" <c:if test="${1 == user.userType}">checked="checked"</c:if> value="1"/><label>普通用户</label>
							<input type="radio" name="userType" <c:if test="${0 == user.userType}">checked="checked"</c:if> value="0"/><label>超级管理员</label>
						</c:otherwise>
					</c:choose>
				</td>
				<td align="left"></td>
			</tr>
			<tr>
				<td align="right" class="l-table-edit-td">Email地址：</td>
				<td align="left" class="l-table-edit-td2"><input type="text" value="${user.email }" validate="{isEmail:true}" id="email"  name="email" class="txt" ltype="text"/></td>
				<td align="left"></td>
			</tr>
			<tr>
				<td align="right" class="l-table-edit-td">手机：</td>
				<td align="left" class="l-table-edit-td2"><input type="text" value="${user.phone }" validate="{isMobile:true}" id="phone" class="txt" name="phone" ltype="text"/></td>
				<td align="left"></td>
			</tr>
			<tr>
				<td align="right" class="l-table-edit-td">部门：</td>
				<td align="left" class="l-table-edit-td2">
					<select id="departmentId" name="departmentId" style="width: 230px;" >
					<option value="0">请选择</option>
					<c:choose>
						<c:when test="${ action eq 'save' }">
							<c:forEach items="${depts}" var="dept">
								<option value="${dept.id}">${dept.name}</option>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<c:forEach items="${depts}" var="dept">
							
								<option value="${dept.id}" <c:if test="${user.departmentId ==dept.id }">selected="selected"</c:if> >${dept.name}</option>
							</c:forEach>
						</c:otherwise>
					</c:choose>
					</select>
				</td>
				<td align="left"></td>
			</tr>
			<tr>
				<td align="right" class="l-table-edit-td">状态：</td>
				<td align="left" class="l-table-edit-td2">
				  <c:choose>
				  	<c:when test="${action eq 'save' }">
				  		<input type="radio" name="status" value="1" checked="checked"/><label>有效</label>
						<input type="radio" name="status" value="0"/><label>无效</label>
				  	</c:when>
				  	<c:otherwise>
				  		<input type="radio" name="status" value="1" <c:if test="${user.status == 1 }">checked="checked"</c:if> /><label>有效</label>
						<input type="radio" name="status" value="0" <c:if test="${user.status == 0 }">checked="checked"</c:if>/><label>无效</label>
				  	</c:otherwise>
				  </c:choose>
				</td>
				<td align="left"></td>
			</tr>
			<tr>
				<td align="right" class="l-table-edit-td">是否可以编辑：</td>
				<td align="left" class="l-table-edit-td2">
				  <c:choose>
				  	<c:when test="${action eq 'save' }">
				  		<input type="radio" name="isedit" value="1" checked="checked"/><label>是</label>
						<input type="radio" name="isedit" value="0"/><label>否</label>
				  	</c:when>
				  	<c:otherwise>
				  		<input type="radio" name="isedit" value="1" <c:if test="${user.isedit == 1 }">checked="checked"</c:if> /><label>是</label>
						<input type="radio" name="isedit" value="0" <c:if test="${user.isedit == 0 }">checked="checked"</c:if>/><label>否</label>
				  	</c:otherwise>
				  </c:choose>
					
				</td>
				<td align="left"></td>
			</tr>
			<tr>
				<td align="right" class="l-table-edit-td">用户角色：</td>
				<td colspan="2">
					<ul>
					  <c:choose>
					  	<c:when test="${action eq 'save' }">
					  		<c:forEach items="${roles }" var="role">
								<li class="yh"><input type="checkbox" name="userRole" value="${role.id}"/>${role.rolename}</li>
							</c:forEach>
					  	</c:when>
					  	<c:otherwise>
<%-- 					  	  <c:if test="${!empty adminUserRoles }"> --%>
					  		<c:forEach items="${roles }" var="role">
								<li class="yh"><input type="checkbox" name="userRole" 
									<c:forEach items="${adminUserRoles }" var="adminUserRole">
										<c:if test="${adminUserRole.roleId == role.id }">
											checked = "checked"
										</c:if>
									</c:forEach>
								 value="${role.id }" />${role.rolename}</li>
							</c:forEach>
<%-- 						   </c:if> --%>
					  	</c:otherwise>
					  </c:choose>
					</ul>
				</td>
				<td align="left"></td>
			</tr>
		</table>
		<div class="btn">
			<input type="submit" value="提交" id="Button1" class="l-button l-button-submit" />
			<input type="reset" value="重置" id="Button2" class="l-button l-button-submit" /> 
		</div>
	</form>
</body>
</html>