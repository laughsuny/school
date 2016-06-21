<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="inc/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="后台主页" content="text/html; charset=UTF-8">
<link href="${contextPath}/resources/admin/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" /> 
<link href="${contextPath}/resources/admin/css/index.css" rel="stylesheet" type="text/css" /> 

<script src="${contextPath}/resources/common/js/jquery-1.9.0.min.js" type="text/javascript"></script>
<script src="${contextPath}/resources/admin/ligerUI/js/ligerui.all.js" type="text/javascript"></script> 
<%-- <script src="${contextPath}/resources/admin/ligerUI/js/ligerTab.js"></script> --%>
<script src="${contextPath}/resources/admin/ligerUI/js/jquery.cookie.js"></script>
<script src="${contextPath}/resources/admin/ligerUI/js/json2.js"></script>
<script src="${contextPath}/resources/admin/js/index.js" type="text/javascript"></script>
<script type="text/javascript">
var path = '${contextPath}';
function logout()
{
	$.ligerDialog.confirm('确定退出系统?','确认', function (yes){
		if(yes){
			window.location.href="/admin/logout.action";
		}
	});
		
	}
</script>
<title>后台主页</title>
</head>
<body style="padding:0px;background:#EAEEF5;">  
<div id="pageloading"></div>  
<div id="topmenu" class="l-topmenu">
    <div class="l-topmenu-logo">网站后台管理系统</div>
    <div class="l-topmenu-welcome">
    <b><span></span>${username}</b><br />
        <a href="/admin/index.action" class="l-link2">网站首页</a>|
        <a href="javascript:void(0);" onClick="logout();return false;" class="l-link2" target="_blank">安全退出</a> 
        
    </div> 
</div>
  <div id="layout1" style="width:99.2%; margin:0 auto; margin-top:4px; "> 
        <div position="left"  title="主要菜单" id="accordion1"> 
                     <div title="功能列表" class="l-scroll">
                         <ul id="tree1" style="margin-top:3px;">
                         </ul>
                    </div>
                    
                     
        </div>
        <div position="center" id="framecenter"> 
            <div tabid="home" title="我的主页" style="height:300px" >
<%--               <jsp:include page="${contextPath }/admin/welcome.action"></jsp:include> --%>
                <iframe frameborder="0" name="home" id="home" src="${contextPath}/admin/welcome.do"></iframe>
            </div> 
        </div> 
        
    </div>
    <div class="footer" >
            Copyright © 我
    </div>
    <div style="display:none"></div>
</body>
</html>