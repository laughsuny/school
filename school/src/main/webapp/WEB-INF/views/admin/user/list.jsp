<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户列表</title>
    <link href="${contextPath}/resources/admin/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" /> 
    <link href="${contextPath}/resources/admin/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
    
    <script src="${contextPath}/resources/common/js/jquery-1.9.0.min.js" type="text/javascript"></script>
	<script src="${contextPath}/resources/admin/ligerUI/js/ligerui.all.js" type="text/javascript"></script>
	<script src="${contextPath}/resources/admin/js/common.js" type="text/javascript"></script>
    <script type="text/javascript">
   		var gridManager = null;
   		var depts = null;
    	$(function(){
    		$.ajaxSetup({async: false});
    		//加载全部部门信息
    		getDepartmentList();

	    	//工具条
		    $("#toptoolbar").ligerToolBar({ items: [
		        { text: '增加', 
		          id:'add', 
		          click: function(item){
		        	  $("#pageloading").show();
		        	  window.location.href="toAdd.do"; 
		          },icon: 'add'
		        },
		        {text:'批量删除',id:'batchDel',click:batchDel,icon: 'delete'}
		    ]
		    });
	    	//批量删除
	    	function batchDel(){
	    		var data = gridManager.getCheckedRows();
	    		if(data.length == 0){
	    			$.ligerDialog.alert('请选择行');
	    		}else{
	    			 var checkedIds = [];
	                 $(data).each(function (){
	                     checkedIds.push(this.id);
	                 });
	                 $.ligerDialog.confirm('确定删除?', function (yes){
	                 	if(yes){
	                 		$.ajax({
	                 	        type:"POST",
	                 	        url:"batchDel.do",
	                 	        data:{"ids":checkedIds.join(',')
	                 	        },
	                 	        datatype: "json",
	                 	        beforeSend:function(){
	                 	        	//$("#msg").html("logining");
	                 	        	$("#pageloading").show();
	                 	        },
	                 	       success:function(json){
	                 	    	   $("#pageloading").hide();
	                 	    	   if(json.result =="success"){
	                 	    		   $.ligerDialog.success("删除成功","提示");
	                 	    		   //重新加载分页数据
	                        			   gridManager.loadData(true);
	                 	    	   }else{
	                 	    		  $.ligerDialog.error("删除失败","提示");
	                 	    	   }
	                 	    	 	
	                 	        },
	                 	         complete: function(XMLHttpRequest, textStatus){
	                 	            //HideLoading();
	                 	        	 $("#pageloading").hide();
	                 	        }, 
	                 	        error: function(){
	                 	        	$("#pageloading").hide();
	                 	            //请求出错处理
	                 	            $.ligerDialog.error("删除失败","提示");
	                 	        }        
	                 	    });
	                 	}
	                 }); 
	    		}
	    	}
	    	
		    //搜索
            $("#searchbtn").ligerButton({ click: function ()
            {
                if (!gridManager) return;
                var username = $("#username").val(); 
                var account = $("#account").val(); 
                var userType = $("#userType").val();
                var deptId = $("#deptList").val();
                gridManager.setOptions(
                    { parms: [{ name: 'username', value: username},
                              { name: 'account', value: account},
                              { name: 'userType', value: userType},
                              { name: 'deptId', value: deptId}] }
                );
                gridManager.loadData(true);
            }
        	}); 
	    	//表格的加载
	    	$("#maingrid").ligerGrid({
	    		columns:[
	    		{display:'用户帐号',name:"account",width:160, isSort: false},
	    		{display:'用户名称',name:"username",width:160, isSort: false},
	    		{display:"用户类型",name:"userType",render:function(rowdata,rowindex){
	    			var s = "";
	    			switch (rowdata.userType) {
					case 0:
						s="超级管理员";
						break;
					case 1:
						s="普通用户";
						break;
					default:
						s="测试用户";
						break;
					}
	    			return s;
	    		},width:100, isSort: false}, 
	    		{display:"创建时间",name:"createTime",render:function(rowdata,rowindex,value){
	    			var time = timeStamp2String(value);
	    			return time;
	    		},width:150, isSort: false},
	    		{display:"用户id",name:"id",hide:"id"},
	    		{display:"邮箱",name:"email",width:120, isSort: false},
	    		{display:"部门",name:"departmentId",render:function(rowdata,rowindex){
	    			var s = "";
	    			$(depts).each(function(i,v){
	    				if(rowdata.departmentId == v.id){
	    					s = v.name;
	    				}
	    			});
	    			if(s == ""){
	    				s = "超级管理员";
	    			}
	    			return s;
	    		},width:100, isSort: false},
	    		{display:"手机",name:"phone",width:100, isSort: false},
	    		{display:"状态",name:"status",render:function(rowdata,rowindex){
	    			var s = "";
	    			switch (rowdata.status) {
					case 1:
						s = "有效";
						break;
					case 0:
						s = "无效";
						break;
					}
	    			return s;
	    		},width:80, isSort: false},
	    		{ display: '操作', isSort: false, width: 140, isSort: false, render: function (rowdata, rowindex)
                    {
                        var h = "";
                        var loginId = "${adminUser.id}";
                        if(rowdata.id != loginId){
	                        h += "<a href='javascript:beginEdit(" + rowdata.id + ")'>修改</a> ";
	                        h += "<a href='javascript:deleteRow(" + rowdata.id + ")'>删除</a> "; 
	                        h += "<a href='javascript:updatePwd(" + rowdata.id + ")'>重置密码</a> ";
                        }
                        return h;
                    }
                }
	    		],dataAction: 'server',
	    		width: '100%', height: '100%', pageSize: 10,rownumbers:true,heightDiff: -6,
                checkbox : true,cssClass: 'l-grid-gray',
                url:"listPage.do"
	    	});
	    	gridManager = $("#maingrid").ligerGetGridManager();
		    $("#pageloading").hide();
		    
    	});
    	//修改当前密码
    	function updatePwd(id){
    		$.ligerDialog.confirm('确定重置Id为：' + id + '?','警告', function (yes){
    			if(yes){
    				window.location.href = "/admin/user/updatePwd.action?id="+id;
    			}
    		});
    	}
    	//删除单个
    	function deleteRow(id){
    		 $.ligerDialog.confirm('确定删除Id为：' + id + '?','警告', function (yes){
    			 if(yes){
    				 $.ajax({
              	        type:"POST",
              	        url:"delete.action",
              	        data:{"id":id},
              	        datatype: "json",
              	        beforeSend:function(){
              	        	$("#pageloading").show();
              	        },
              	       success:function(json){
              	    	   $("#pageloading").hide();
              	    	   if(json.result =="success"){
              	    		   $.ligerDialog.success("删除成功","提示");
                     			gridManager.loadData(true);
              	    	   }else{
              	    		 $.ligerDialog.error("删除失败","提示");
              	    	   }
              	    	 	
              	        },
              	         complete: function(XMLHttpRequest, textStatus){
              	            //HideLoading();
              	        	 $("#pageloading").hide();
              	        }, 
              	        error: function(){
              	        	$("#pageloading").hide();
              	            //请求出错处理
              	            $.ligerDialog.error("删除失败","提示");
              	        }        
              	    });
    			 }
    		 });
    	}
        //编辑行
        function beginEdit(id) {
        	 //$.ligerDialog.alert("id-->" + id);
        	 $("#pageloading").show();
        	 window.location.href="toEdit.do?id=" + id;
        }
        //获取部门集合
	    function getDepartmentList(){
	    	$.getJSON("/admin/department/getDepartmentList.do",function(json){
	    		depts = eval(json.depts);
	    		initDepts();
	    	});
	    }
        function initDepts(){
        	var _html = "";
        	$(depts).each(function(i,v){
        		_html = "<option value='"+v.id+"' title='"+v.name+"'>"+v.name+"</option>";
        		$("#deptList").append(_html);
        	});
        }
    </script>
</head>
<body style="padding:0px; overflow:hidden;">
	<div class="l-loading" style="display: block;" id="pageloading"></div>
	<form id="form1" runat="server"> 
		<div id="toptoolbar"></div>
		<div class="l-panel-search">
			<div class="l-panel-search-item">
		        用户帐号：
		    </div>
		    <div class="l-panel-search-item">
		        <input type="text" id="account" />
		    </div>
		    <div class="l-panel-search-item">
		        用户名称：
		    </div>
		    <div class="l-panel-search-item">
		        <input type="text" id="username" />
		    </div>
		    <div class="l-panel-search-item">
		        用户类型：
		    </div>
		    <div class="l-panel-search-item">
		        <select id="userType">
		        	<option value="-1">请选择</option>
		        	<option value="0">超级管理员</option>
		        	<option value="1">普通用户</option>
		        </select>
		    </div>
		    <div class="l-panel-search-item">
		        用户部门：
		    </div>
		    <div class="l-panel-search-item">
		        <select id="deptList">
		        	<option value="0">请选择</option>
		        </select>
		    </div>
		    <div class="l-panel-search-item">
		        <div id="searchbtn" style="width:80px;">搜索</div>
		    </div>
		</div>
	</form>
	<div id="maingrid"></div>
</body>
</html>