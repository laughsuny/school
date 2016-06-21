<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../inc/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>角色列表</title>
    <link href="${contextPath}/resources/admin/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" /> 
    <link href="${contextPath}/resources/admin/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
    
    <script src="${contextPath}/resources/common/js/jquery-1.9.0.min.js" type="text/javascript"></script>
	<script src="${contextPath}/resources/admin/ligerUI/js/ligerui.all.js" type="text/javascript"></script>
	<script src="${contextPath}/resources/admin/js/common.js" type="text/javascript"></script>
    <script type="text/javascript">

        var gridManager = null;
        $(function ()
        {
            //工具条
            $("#toptoolbar").ligerToolBar({ items: [
                { text: '增加', 
                  id:'add', 
                  click: function(item){
                	  window.location.href="toAdd.do"; 
                  },icon: 'add'
                },
                { text: '批量删除', id:'batchDel', click: batchDel,icon: 'delete'}
                
            ]
            });
            //搜索
            $("#searchbtn").ligerButton({ click: function (){
	                if (!gridManager) return;
	                var roleName = $("#txtRoleName").val(); 
	                gridManager.setOptions(
	                    { parms: [{ name: 'searchStr', value: roleName}] }
	                );
	                gridManager.loadData(true);
	            	
            }}); 

            //表格
            $("#maingrid").ligerGrid({
                columns: [
				{ display: 'ID', name: 'id',hide:true},
                { display: '角色名称', name: 'rolename', align: 'center', width: 300, minWidth: 60, isSort: false },
                { display: '角色描述', name: 'desctxt', minWidth: 120 , isSort: false},
                { display: '角色状态', name: 'status', minWidth: 140 ,isSort: false,
                	 render: function (rowdata, rowindex, value) {
               		 	var s = "";
                        if (rowdata.status == "1")
                            s = '有效';
                        if (rowdata.status == "0")
                            s = '无效';
                        return s;
               		 }	
                
                },
                { display: '操作', isSort: false, width: 120, render: function (rowdata, rowindex)
                    {
                        var h = "";
                        h += "<a href='javascript:beginEdit(" + rowdata.id + ")'>修改</a> ";
                        h += "<a href='javascript:deleteRow(" + rowdata.id + ")'>删除</a> "; 
                        return h;
                    }
                }
                ], dataAction: 'server',
                width: '100%', height: '100%', 
                pageSize: 10,
                rownumbers:true,
                checkbox : true,
                //应用灰色表头
                cssClass: 'l-grid-gray', 
                heightDiff: -6,
                url: "listPage.do"
            });
             
            gridManager = $("#maingrid").ligerGetGridManager();

            $("#pageloading").hide();


        });

        //编辑行
        function beginEdit(id) {
        	 window.location.href="toEdit.do?id=" + id;
        }
        //操作删除
        function deleteRow(id){
        	$.ligerDialog.confirm('确定删除吗?','警告', function (yes){
        		if(yes){
        			$.ajax({
            	        url:"delete.do",
            	        data:{
            	        	"id":id
            	        },
            	        success:function(json){
            	    	   $("#pageloading").hide();
            	    	   if(json.result =="success"){
            	    		   $.ligerDialog.success("删除成功","提示");
            	    		   //重新加载分页数据
                   			   gridManager.loadData(true);
            	    	   }
            	        }       
            	    });
        		}
            });
        	
        }
        //批量删除
        function batchDel(){
        	var data = gridManager.getCheckedRows();
            if (data.length == 0){
            	$.ligerDialog.alert('请选择行');
            }else{
                var checkedIds = [];
                $(data).each(function (){
                    checkedIds.push(this.id);
                });
                $.ligerDialog.confirm('确定删除吗?', function (yes){
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
                	    		   //重新加载分页数据
                       			   gridManager.loadData(true);
                	    	   }
                	        }       
                	    });
                	}
                }); 
            }
        }
        
        
    </script>
</head>
<body style="padding: 0px; overflow: hidden;">
	<div class="l-loading" style="display: block" id="pageloading"></div>
	<form id="form1">

		<div id="topmenu"></div>

		<div id="toptoolbar"></div>

		<div class="l-panel-search">
			<div class="l-panel-search-item">角色名称：</div>
			<div class="l-panel-search-item">
				<input type="text" id="txtRoleName" />
			</div>
			<div class="l-panel-search-item">
				<div id="searchbtn" style="width: 80px;">搜索</div>
			</div>
		</div>

		<div id="maingrid" style="margin: 0; padding: 0"></div>

	</form>


	<div style="display: none;"></div>

</body>
</html>
