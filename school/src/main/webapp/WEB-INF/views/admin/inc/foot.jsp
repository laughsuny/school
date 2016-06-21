<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript" src="${contextPath}/front/js/dusystem.js"></script>    
<div class="bottomlink">
	<div id="bottom_list">
		<a href="${contextPath}/front/xwzx/index.action" target="_blank">我要进入新闻中心</a><span>|</span>
		<a href="${contextPath}/front/xxgk/index.action" target="_blank">我要查询信息公开</a><span>|</span>
		<a href="${contextPath}/front/bsdt/index.action" target="_blank">我要办理在线服务</a><span>|</span>
		<a href="${contextPath}/front/hdjl/index.action" target="_blank">我要进行互动交流</a><span>|</span>
<!-- 		<a href="#" target="_blank">我要获取投资信息</a><span>|</span> -->
		<a href="${contextPath }/front/mlfs/index.action" target="_blank">我要了解多彩扶绥</a>
<!-- 		<a href="#" target="_blank">我要查看专题专栏</a> -->
	</div>
</div>

<div class="com_bottom">
	<div id="bottom_link">
		<span id="link_title">友情链接：</span>
		<ul style="float:left;">
		 <c:forEach items="${sessionScope.linkTypes }" var="linkType">
			<li><span>${linkType.name}</span><b></b>
				<ul>
					<c:forEach items="${sessionScope.links}" var="link">
					  <c:if test="${link.type eq linkType.id }">
						<li><a href="${link.url }" <c:if test="${link.openType eq 0 }"> target="_self" </c:if><c:if test="${link.openType eq 1 }">target="_blank"</c:if> ><font title="${link.name}">${link.name}</font></a></li>
					  </c:if>	
					</c:forEach>
				</ul>
			</li>
			</c:forEach>
		</ul>
	</div>
	<div id="bottom_info">
		<a target="_blank" href="${contextPath}/front/detail.action?id=7055" >关于我们</a><span> |</span> <a href="${contextPath}/front/map.action">站点地图</a><span>|
		</span> <a target="_blank" href="${contextPath}/front/detail.action?id=7054" >使用帮助</a><span> |
		</span> <a target="_blank" href="${contextPath}/front/detail.action?id=7053">版权保护</a><span> |
		</span> <a target="_blank" href="${contextPath}/front/detail.action?id=7052">联系我们</a> <br />
		主办：扶绥县人民政府&nbsp;&nbsp;承办：扶绥县网络舆情管理中心 <br /> 
		桂ICP备13002509号-1&nbsp;&nbsp;崇左网警备4514010101<br /> <a id="bottom_icon" href="http://www.gx.cyberpolice.cn/AlarmInfo/getTishi.do"></a><br />
		扶绥县人民政府&nbsp;&nbsp;版权所有
	</div>
</div>