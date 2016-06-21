<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="main_location">
当前位置：<a href="${contextPath }/front/index.action">广西扶绥</a>
<c:forEach items="${datas }" var="data" varStatus="status">
	<c:if test="${!status.last}">
		>&nbsp;<a href="${contextPath }/${data.furl}">${data.text}</a>
	</c:if>
	<c:if test="${status.last}">
		>&nbsp;${data.text}
	</c:if>
</c:forEach>
</div>