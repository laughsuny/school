<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>编辑部门信息</title>
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
	    	$.ajaxSettings.async = false;
	    	// 判断是否被注册用户名
			jQuery.validator.addMethod("checkDeptName", function(value, element) { 
				var falg = true;
		    	$.post("checkDeptName.do",{"name":$("#name").val()},function(json){
					if(json == true){
						falg = false;
					}
				});
				return this.optional(element) || falg;       
			}, "这个部门名称已经被注册，请输入其他部门名称！");
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
                      element.parent().ligerTip({ content: lable.html(), target: element[0],width:wid });
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
		       	    		   window.history.back();
	       	    		   },1200);
	       	    	   }else if(json.result == "error"){
	       	    		   $.ligerDialog.error("操作失败，请稍后再试！","提示");
	       	    	   }
	       	        },
                  })
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
			<input value="${dept.id }" type="hidden"  name="id" id="hiddenId"/>
	  </c:if>
		<table  cellpadding="0" cellspacing="0" class="l-table-edit">
			<tr>
				<td align="right" class="l-table-edit-td">部门名称<font>*</font>：</td>
				<c:choose>
					<c:when test="${action eq 'save'}">
						<td align="left" class="l-table-edit-td2"><input maxlength="15" class="txt" type="text" id="name" value="${dept.name }" ltype="text" validate="{required:true,checkDeptName:true}" name="name"/></td>
					</c:when>
					<c:otherwise>
						<td align="left" class="l-table-edit-td2"><input maxlength="15" class="txt" type="text" id="name" value="${dept.name }" ltype="text" validate="{required:true}" name="name"/></td>
					</c:otherwise>
				</c:choose>
			</tr>
			<tr>
				<td align="right" class="l-table-edit-td">备注：</td>
				<td align="left" colspan="2" class="l-table-edit-td2">
					<textarea rows="4" cols="40" id="remark" name="remark" class="l-textarea">${dept.remark}</textarea>
				</td>
			</tr>
		</table>
		<div class="btn">
			<input type="submit" value="提交" id="Button1" class="l-button l-button-submit" />
			<input type="reset" value="重置" id="Button2" class="l-button l-button-submit" /> 
		</div>
	</form>
</body>
</html>