<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="inc/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>欢迎进入扶绥后台管理系统</title>
<link href="${contextPath}/resources/admin/css/index.css" rel="stylesheet" type="text/css" />
    <script src="${contextPath}/resources/common/js/jquery-1.9.0.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            $(".homelist table tr:odd").addClass("homeodd");
            $(".homelist table tr:even").addClass("homeeven");
          
        }); 
</script> 
<style>
        .title{width:600px; margin:0 auto; margin-top:20px; color:#5d98cb;}
    </style>
</head>
<body>
	<table cellpadding="0" cellspacing="0" class="homemain"><tr><td>
<div class="topbg">
<table  cellpadding="0" cellspacing="0" width="100%">
<tr><td class="td11"></td><td class="td22" ><span></span><h1>最新发布文章</h1></td><td class="td33"></td></tr>
</table>
</div>
<div class="toptitle">
<table cellpadding="0" cellspacing="0">
<tr>
<td class="td1">标题</td><td class="td2">发布者</td><td class="td3">发布栏目</td><td class="td4">发布日期</td>
</tr>
</table>
</div>
<div  class="homelist">
			<table cellpadding="0" cellspacing="0">
			  <c:forEach items="${indexArticles}" var="article">
				<tr>
					<td class="td1" title="${article.title}">
						<c:choose>
							<c:when test="${fn:length(article.title)>20}">
								${fn:substring(article.title,0,19)}...
							</c:when>
							<c:otherwise>
								${article.title}
							</c:otherwise>
						</c:choose>
					</td>
					<td class="td2">${article.username}</td>
					<td class="td3">${article.menuName}</td>
					<td class="td4"><fmt:formatDate value="${article.createTime}"/></td>
				</tr>
			  </c:forEach>

			</table>
		</div>
<div class="homebottom">
<table cellpadding="0" cellspacing="0">
<tr><td class="td31"></td><td class="td32"></td><td class="td33"></td></tr>
</table>
</div>
</td></tr></table>
</body>
</html>