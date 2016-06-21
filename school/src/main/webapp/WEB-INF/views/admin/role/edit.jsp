<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../inc/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>编辑角色</title>
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
    var treeManager = null;
    $(function ()
      {
	        $.ajaxSettings.async = false;
	        //加载权限树
	      	$.ajax({
	  	        url:"${menuAction}.do",
	  	        <c:if test="${not empty role}">
	  	        data:{
	  	        	"id":'${role.id}'
	  	        }, 
	  	    	</c:if>
	  	        success:function(json){
	  	        	    $("#pageloading").hide();
		             	var tree = $("#tree1").ligerTree({  
		     	             data:json, 
		     	             idFieldName :'id',
		     	             slide : false,
		     	             parentIDFieldName :'pid',
		     	             textFieldName:'name'
		                });
	  	        	
		             	treeManager = $("#tree1").ligerGetTreeManager();
		                treeManager.collapseAll();
	  	        	
	  	        }
	  	    }); 
	
	    	// 判断角色名是否
			jQuery.validator.addMethod("checkRoleName", function(value, element) { 
				var falg = true;
		    	$.post("checkRoleName.do",{"rolename":$.trim($("#rolename").val())},function(json){
					if(json == true){
						falg = false;
					}
				});
				return this.optional(element) || falg;       
			}, "角色名称重复，请重新输入！");
	    	
          $.metadata.setType("attr", "validate");
          var v = $("form").validate({
              debug: true,
              errorPlacement: function (lable, element){
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
              submitHandler: function (){
                  $("form .l-text,.l-textarea").ligerHideTip();
                  
                  var notes = treeManager.getChecked();
                  var ids = [];
                  for (var i = 0; i < notes.length; i++){
                  	ids.push(notes[i].data.id);
                  }
                  $("#hiddenMenuIds").val(ids.join(','));
                  
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
          	    	   }else{
          	    		   $.ligerDialog.error("操作失败","提示");
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
			<input value="${role.id }" type="hidden"  name="id" id="hiddenId"/>
	  </c:if>
		<table  cellpadding="0" cellspacing="0" class="l-table-edit">
			<tr>
				<td align="right" class="l-table-edit-td"><font>*</font>角色名称：</td>
				<c:choose>
					<c:when test="${action eq 'save'}">
						<td align="left" class="l-table-edit-td2"><input maxlength="15" class="txt" type="text" id="rolename" value="${role.rolename }" ltype="text" validate="{required:true,checkRoleName:true}" name="rolename"/></td>
					</c:when>
					<c:otherwise>
						<td align="left" class="l-table-edit-td2"><input maxlength="15" class="txt" type="text" id="rolename" value="${role.rolename }" ltype="text" validate="{required:true}" name="rolename"/></td>
					</c:otherwise>
				</c:choose>
				<td align="left"></td>
			</tr>
			<tr>
				<td align="right" class="l-table-edit-td">角色描述：</td>
				<td align="left" colspan="2" class="l-table-edit-td2">
					<textarea rows="4" cols="40" id="desctxt" name="desctxt" class="l-textarea">${role.desctxt}</textarea>
				</td>
			</tr>
			
			<tr>
				<td align="right" class="l-table-edit-td">角色状态：</td>
				<td align="left" class="l-table-edit-td2">
					<c:choose>
						<c:when test="${ action eq 'save' }">
							<input id="status_1" type="radio" name="status" value="1" checked="checked"/>
						</c:when>
						<c:otherwise>
							<input id="status_1" type="radio" name="status" value="1"
							<c:if test="${ 1 == role.status }" >checked</c:if>
							/>
						
						</c:otherwise>
					</c:choose>
					<label for="status_1">有效</label>
					<input id="status_0" type="radio" name="status" value="0" 
					<c:if test="${ 0 == role.status }" >checked</c:if>/>
					<label for="status_0">无效</label>
				</td>
			</tr>
			<tr>
				<td align="right" class="l-table-edit-td">角色权限：</td>
				<td align="left" class="l-table-edit-td2" width="400px">
					<input type="hidden" id="hiddenMenuIds" name="menuIds">
			    	<ul id="tree1"></ul>
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