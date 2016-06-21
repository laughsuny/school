<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <script type="text/javascript" src="${contextPath}/front/js/dusystem.js"></script> --%>
<%-- <script type="text/javascript" src="${contextPath}/front/js/jquery-1.11.3.min.js"></script> --%>
<script type="text/javascript">
function outLogin(){
	var falg = confirm("确认要退出吗？");
	if(falg){
		$.ajax({
	    	type:"POST",
		        url:"/front/member/outLogin.action",
		        datatype: "json",
		      	beforeSend:function(){
// 		        	$("#pageloading").show();
		        },
	  	    success:function(json){
// 		    	   $("#pageloading").hide();
		    	   if(json ==true){
// 		    		   $.ligerDialog.success("退出成功","提示");
					   alert("退出成功");
		    		   setTimeout(function(){
// 			    		  $("#pageloading").show();
						  window.location.href = "/front/index.action";
		    		   },1500);
		    	   }
		        },
		      	complete: function(XMLHttpRequest, textStatus){
		            //HideLoading();
// 		        	 $("#pageloading").hide();
		        }, 
		        error: function(){
// 		        	$("#pageloading").hide();
		        	//请求出错处理
// 		            $.ligerDialog.error("操作失败","提示");
		        	alert("操作失败");
		        }        
	      });
	}}
	
</script>

<!-- <script>
	$(function() {
		$.getScript('${contextPath}/front/js/hotwords.js',function(){
			if (ojb) { 
				var seriesForSearch = ojb.msg, seriesForSearchArr = seriesForSearch.split(","), randomSeries = function(t) {
							var e = seriesForSearchArr[Math.floor(Math.random() * seriesForSearchArr.length)];
							$(t).val(e)
				};
				$("#search_text").on("focus", function(){
					$(this).val("");
					}).on("blur",function() {
						"" == $(this).val()&& randomSeries(this)
					}), document.getElementById("search_text").focus();
			}
		});
	});
	
</script> -->
<!--头部开始-->
<div class="header">
	<div class="header_content">
		<div id="header_left">
			<a id="StranLink">繁体</a><span class="header_span">|</span>
<!-- 			<a href="javascript:zh_tran('s');" class="zh_click" id="zh_click_s">简体</a> <span class="header_span">|</span> -->
			<a target="_black" href="${contextPath}/front/detail.action?id=7057">RSS订阅</a><span class="header_span">|</span>
			<a id="date">2015年7月27日</a><span class="header_span">|</span> <a
				id="week">星期一</a>
		</div>
		<div id="header_right">
			<div id="head_img"></div>
			<div style="float: left;">
			<c:if test="${sessionScope.frontMember != null}">
				<a href="${contextPath }/front/member/toMemberCenter.action" id="header_login" title="${sessionScope.frontMember.useraccount}">${sessionScope.frontMember.useraccount}</a><span class="header_span">|</span>
				<a href="javascript:outLogin();" id="outLogin">安全退出</a><span class="header_span">|</span>
			</c:if>
			<c:if test="${sessionScope.frontMember == null}">
				<a href="${contextPath }/front/member/toLogin.action" id="header_login">请登录</a><span class="header_span">|</span>
			</c:if>
			<a href="${contextPath}/front/member/registerPerson.action">新用户注册</a>
			</div>
			<div id="search_box">
			<form action="${contextPath }/front/search.action" target="_blank">
				 <table cellpadding="0" cellspacing="0">
            <tr><td><input type="text" id="search_text"  name="searchStr" value="${searchStr}"/></td><td><input type="button"
						value="" id="search_button" autocomplete="off"/></td></tr>
            </table>
            
			</div>
			<input type="submit" id="search_submit" value="搜索" />
			</form>
		</div>
	</div>
</div>
<!--头部结束-->