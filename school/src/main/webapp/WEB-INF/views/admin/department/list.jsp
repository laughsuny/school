<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>部门管理</title>
    <link href="${contextPath}/resources/admin/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" /> 
    <link href="${contextPath}/resources/admin/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
    
    <script src="${contextPath}/resources/common/js/jquery-1.9.0.min.js" type="text/javascript"></script>
	<script src="${contextPath}/resources/admin/ligerUI/js/ligerui.all.js" type="text/javascript"></script>
	<script src="${contextPath}/resources/admin/js/common.js" type="text/javascript"></script>
    <script type="text/javascript">
    	var gridManager = null;
    	var sysuserList = null;
    	
    	$(function(){
    		getSysuserList();
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
		  	//搜索
            $("#searchbtn").ligerButton({ click: function ()
            {
                if (!gridManager) return;
                var name = $("#name").val(); 
                gridManager.setOptions(
                    { parms: [{ name: 'name', value: name} ]}
                );
                gridManager.loadData(true);
            }
        	});
		  	//表格的加载
	    	$("#maingrid").ligerGrid({
	    		columns:[
	    		{display:'部门名称',name:"name",width: 300, isSort: false},
	    		{display:'备注',name:"remark", isSort: false},
	    		{display:"创建人",name:"createUser",render:function(rowdata,rowindex){
					var s = null;
	    			$(sysuserList).each(function(i,v){
	    				if(v.id == rowdata.createUser){
	    					s = v.username;
	    				}
	    			});
					return s;
	    		}, isSort: false}, 
	    		{display:"创建时间",name:"createTime",render:function(rowdata,rowindex,value){
	    			var time = timeStamp2String(value)
	    			return time;
	    		}, isSort: false},
	    		{display:"用户id",name:"id",hide:"id"},
	    		{ display: '操作', isSort: false, width: 120, render: function (rowdata, rowindex)
                    {
                        var h = "";
                        h += "<a href='javascript:beginEdit(" + rowdata.id + ")'>修改</a> ";
                        h += "<a href='javascript:deleteRow(" + rowdata.id + ")'>删除</a> "; 
                        return h;
                    }
                }
	    		],dataAction: 'server',
	    		width: '100%', height: '100%', pageSize: 10,rownumbers:true,heightDiff: -6,
                checkbox : true,cssClass: 'l-grid-gray',dateFormat:"yyyy-MM-dd",
                url:"listPage.do"
	    	});
	    	gridManager = $("#maingrid").ligerGetGridManager();
		    $("#pageloading").hide();
    	});
    	//批量删除部门
    	function batchDel(){
    		var data = gridManager.getCheckedRows();
    		if(data.length == 0){
    			$.ligerDialog.alert('请选择行');
    		}else{
    			 var checkedIds = [];
                 $(data).each(function (){
                     checkedIds.push(this.id);
                 });
                 $.ligerDialog.confirm('删除部门会删除部门下的用户，确定删除？', function (yes){
                 	if(yes){
                 		$.ajax({
                 	        url:"batchDel.do",
                 	        data:{
                 	        	"ids":checkedIds.join(',')
                 	        },
                 	       success:function(json){
                 	    	   $("#pageloading").hide();
                 	    	   if(json.result =="success"){
                  	    		   $.ligerDialog.success("删除成功","提示");
                  	    	   }else if(json.result == "error"){
                  	    		   $.ligerDialog.error("删除失败","提示");
                  	    	   }
	                 	    	//重新加载分页数据
	                   			gridManager.loadData(true);
                 	        }       
                 	    });
                 	}
                 }); 
    		}
    	}
    	//查询所有的用户信息
    	function getSysuserList(){
    		$.getJSON("/admin/user/getSysuserList.do",function(json){
    			var users = eval(json.users);
    			sysuserList = users;
    		});
    	}
    	//删除单个部门
    	function deleteRow(id){
    		$.ligerDialog.confirm('删除部门会删除部门下的用户，确定删除？','警告', function (yes){
   			 if(yes){
   				 $.ajax({
           	        url:"delete.do",
           	        data:{"id":id},
           	        success:function(json){
           	    	   $("#pageloading").hide();
           	    	   if(json.result =="success"){
           	    		   $.ligerDialog.success("删除成功","提示");
           	    	   }else if(json.result == "error"){
           	    		   $.ligerDialog.error("删除失败","提示");
           	    	   }
           	    	   gridManager.loadData(true);
           	        }  
           	    });
   			 }
   		 });
    	}
    	//修改部门信息
    	function beginEdit(id){
    		$("#pageloading").show();
       	 	window.location.href="toEdit.do?id=" + id;
    	}
    </script>
</head>
<body style="padding:0px; overflow:hidden;">
	<div class="l-loading" style="display: block;" id="pageloading"></div>
	<form id="form1"> 
		<div id="toptoolbar"></div>
		<div class="l-panel-search">
		    <div class="l-panel-search-item">
		        部门名称：
		    </div>
		    <div class="l-panel-search-item">
		        <input type="text" id="name" />
		    </div>
		    <div class="l-panel-search-item">
		        <div id="searchbtn" style="width:80px;">搜索</div>
		    </div>
		</div>
	</form>
	<div id="maingrid"></div>
</body>
</html>