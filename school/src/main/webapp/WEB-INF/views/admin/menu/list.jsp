<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../inc/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>菜单列表</title>
    <link href="${contextPath}/resources/admin/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" /> 
    <link href="${contextPath}/resources/admin/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
    
    
    <script src="${contextPath}/resources/common/js/jquery-1.9.0.min.js" type="text/javascript"></script>
	<script src="${contextPath}/resources/admin/ligerUI/js/ligerui.all.js" type="text/javascript"></script>
	<script src="${contextPath}/resources/admin/js/common.js" type="text/javascript"></script>
	
	
    <script src="${contextPath}/resources/admin/js/jquery-validation/jquery.validate.min.js" type="text/javascript"></script> 
    <script src="${contextPath}/resources/admin/js/jquery-validation/jquery.metadata.js" type="text/javascript"></script>
    <script src="${contextPath}/resources/admin/js/jquery-validation/messages_cn.js" type="text/javascript"></script>
    <script src="${contextPath}/resources/admin/js/jquery-validation/validate_methods.js" type="text/javascript"></script>
    
    <script src="${contextPath}/resources/admin/kindeditor/kindeditor-all-min.js?t=20131123.js"></script>
	<script src="${contextPath}/resources/admin/kindeditor/kindeditor.js"></script>
    
    <style type="text/css">
        #pageloading{position:absolute; left:0px; top:0px; background:white url('${contextPath}/resources/admin/images/loading.gif') no-repeat center; width:100%; height:100%;z-index:99999;}
    	#Editdetail td{
    		padding-top: 8px;padding-left: 4px;
    	}
    	#Editdetail td input[type=text]{
    		height: 24px;
    		width: 200px;
    		line-height: 24px;
    	}
    	#Editdetail td select{
    		height: 24px;
    		line-height: 24px;
    	}
    	#Updatedetail td{
    		padding-top: 8px;padding-left: 4px;
    	}
    	#Updatedetail td input[type=text]{
    		height: 24px;
    		width: 200px;
    		line-height: 24px;
    	}
    	#Updatedetail td select{
    		height: 24px;
    		line-height: 24px;
    	}
    </style>
    <script type="text/javascript">
    
    
  	//修改菜单
    function updateMenu() {
    	
    	var row = gridManager.getSelectedRow();
        if (!row) { $.ligerDialog.alert('请选择行'); return; }
        //alert(JSON.stringify(row));
        
        var parentId = row.pid;
        
        $("#updateName").val(row.name);
    	$("#updateUrl").val(row.url);
    	$("#updateIsdisplay").val(row.isdisplay);
    	$("#updateDesctxt").val(row.desctxt);
    	$("#updatelogo").val(row.picUrl);
    	
    	if(row.picUrl != null && row.picUrl.length > 0 ){
    		$("#updateviewImg").html("<img width=\"200px\" height=\"200px\" src=\""+row.picUrl+"\">");
    	}else{
    		$("#updateviewImg").html("");
    	}
        
    	
    	
    	detailWin = $.ligerDialog.open({  
	        target: $("#Updatedetail"),  
	        width: 800, height: 420, top: 0, title: "修改菜单", //240  
	        buttons: [
            { text: '清空图片', onclick: function (){ 
            		$("#updatelogo").val("");
            		$("#updateviewImg").html("");
            	} 
            },    
	        { text: '保存', onclick: function () { 
	        	
	        	var text = $("#updateText").val();
	        	var url = $("#updateUrl").val();
	        	var furl = $("#updateFurl").val();
	        	var isdisplay = $("#updateIsdisplay").val();
	        	var remark = $("#updateRemark").val();
	        	var picUrl = $("#updatelogo").val();
	        	
	        	if(text == ""){
	        		$.ligerDialog.error("菜单名称不能为空","提示");
	        		$("#updateName").focus();
	        		return;
	        	}else{
	        		
	        		$("#hidenParentIdUpdate").val(parentId);
	        		
	        		$.ajax({
            	        url:"update.do",
            	        data:{
            	        	'id':row.id,
            	        	'parentId':parentId,
            	        	'name':$("#updateName").val(),
            	        	'url':$("#updateUrl").val(),
            	        	'isdisplay':$("#updateIsdisplay").val(),
            	        	'desctxt':$("#updateDesctxt").val(),
            	        	'picUrl':$("#updatelogo").val()
            	        },
            	        datatype: "json",
            	        success:function(json){
            	    	   $("#pageloading").hide();
            	    	   if(json.result =="success"){
            	    		   detailWin.hide();
            	    		   $.ligerDialog.success("操作成功","提示");
            	    		   gridManager.loadData(true);
            	    	   }else{
            	    		   $.ligerDialog.success("操作失败","提示");
            	    	   }
            	        }       
            	    });
	        		
	        		
	        	}
	        	
	        	
	        }},  
	        { text: '取消', onclick: function () { detailWin.hide(); } }  
	        ],
	        isResize :true
	    });  
    	
    }
    
    
    //添加同级菜单
    function addMenu() {
    	
    	var row = gridManager.getSelectedRow();
        if (!row) { $.ligerDialog.alert('请选择行'); return; }
        //alert(JSON.stringify(row));
        
        var parentId = row.pid;
        
        $("#Editdetail input[type='text']").val("");
        $("#viewImg").html("");
        
        
    	detailWin = $.ligerDialog.open({  
	        target: $("#Editdetail"),  
	        width: 800, height: 300, top: 0, title: "添加同级菜单", //240  
	        buttons: [ 
			{ text: '清空图片', onclick: function (){ 
					$("#logo").val("");
					$("#viewImg").html("");
				} 
			},           
	        { text: '保存', onclick: function () { 
	        	
	        	var name = $("#addName").val();
	        	var url = $("#addUrl").val();
	        	var isdisplay = $("#addIsdisplay").val();
	        	var desctxt = $("#addDesctxt").val();
	        	
	        	if(name == ""){
	        		$.ligerDialog.error("菜单名称不能为空","提示");
	        		$("#addName").focus();
	        		return;
	        	}else{
	        		
	        		$("#hidenParentId").val(parentId);
	        		
	        		$.ajax({
            	        url:"save.do",
            	        data:$("#EditForm").serializeArray(),
            	        success:function(json){
            	    	   $("#pageloading").hide();
            	    	   if(json.result =="success"){
            	    		   
            	    		   if(json.newMenu.rootid == 0){
            	    			   $("#selectedMenuId").append("<option value='"+json.newMenu.id+"'>"+json.newMenu.text+"</option>");
            	    		   }
            	    		   detailWin.hide();
            	    		   $.ligerDialog.success("操作成功","提示");
            	    		   gridManager.loadData(true);
            	    	   }else{
            	    		   $.ligerDialog.error("操作失败","提示");
            	    	   }
            	        }
            	    });
	        		
	        		
	        	}
	        	
	        	
	        }},  
	        { text: '取消', onclick: function () { 
	        		detailWin.hide(); 
	        	} 
	        }  
	        ],
	        isResize :true
	    });  
    	
    }
    
    
    //添加子级菜单
    function addSubMenu() {
    	
    	var row = gridManager.getSelectedRow();
        if (!row) { $.ligerDialog.alert('请选择行'); return; }
        //alert(JSON.stringify(row));
        
        var parentId = row.id;
        
        $("#Editdetail input[type='text']").val("");
        $("#viewImg").html("");
        
    	detailWin = $.ligerDialog.open({  
	        target: $("#Editdetail"),  
	        width: 800, height: 300, top: 0, title: "添加子菜单", //240  
	        buttons: [  
   			{ text: '清空图片', onclick: function (){ 
					$("#logo").val("");
					$("#viewImg").html("");
				}	 
			},
	        { text: '保存', onclick: function () { 
	        	var name = $("#addName").val();
	        	var url = $("#addUrl").val();
	        	var isdisplay = $("#addIsdisplay").val();
	        	var desctxt = $("#addDesctxt").val();
	        	
	        	if(name == ""){
	        		$.ligerDialog.error("菜单名称不能为空","提示");
	        		$("#addName").focus();
	        		return;
	        	}else{
	        		
	        		$("#hidenParentId").val(parentId);
	        		
	        		$.ajax({
            	        url:"subSave.do",
            	        data:$("#EditForm").serializeArray(),
            	        success:function(json){
            	    	   $("#pageloading").hide();
            	    	   if(json.result =="success"){
            	    		   detailWin.hide();
            	    		   $.ligerDialog.success("操作成功","提示");
            	    		   gridManager.loadData(true);
            	    	   }else{
            	    		   $.ligerDialog.error("操作失败","提示");
            	    	   }
            	        }        
            	    });
	        		
	        		
	        	}
	        	
	        }},  
	        { text: '取消', onclick: function () { detailWin.hide(); } }  
	        ],
	        isResize :true
	    });  
    	
    }
    
    
    </script>
    
    <script type="text/javascript">
    
        var gridManager = null;
        function getSelected()
        { 
            var row = gridManager.getSelectedRow();
            if (!row) { alert('请选择行'); return; }
            $.ligerDialog.alert(JSON.stringify(row));
        }
        
        $(function ()
        {
        	
            //工具条
            $("#toptoolbar").ligerToolBar({ items: [
                { text: '添加同级菜单', id:'btnAdd', click: addMenu,icon:'add'},
                { text: '添加子菜单', id:'btnAddSub', click: addSubMenu,icon:'add'}
            ]
            });
            

            //表格
            $("#maingrid").ligerGrid({
                columns: [
				{ display: 'ID', name: 'id',hide:true},
				{ display: 'PID', name: 'pid',hide:true},
                { display: '菜单名称',width: 180, name: 'name',id:"columnId", align: 'left',  minWidth: 120 , isSort: false,editor: { type: 'text' }},
                { display: '状态', width: 60,name: 'isdisplay', minWidth: 60 ,isSort: false,
                	 render: function (rowdata, rowindex, value) {
               		 	var s = "";
                        if (rowdata.isdisplay == 1)
                            s = '显示';
                        if (rowdata.isdisplay == 0)
                            s = '隐藏';
                        return s;
               		 }	
                
                },
                { display: 'URL',width: 300, name: 'url', align: 'left',  minWidth: 200 , isSort: false,editor: { type: 'text' }},
                //{ display: 'FURL',width: 200, name: 'furl', align: 'left',  minWidth: 200 , isSort: false,editor: { type: 'text' }},
                { display: '备注',width: 180, name: 'desctxt', align: 'left',  minWidth: 180 , isSort: false,editor: { type: 'text' }},
                { display: '操作', isSort: false, width: 220, minWidth: 200, render: function (rowdata, rowindex,value)
                    {
                        var h = "";
                        h += "<a href='javascript:beginEdit(" + rowindex + ")'>修改</a> ";
                        h += "<a href='javascript:deleteRow(" + rowindex + ")'>删除</a> "; 
                        return h;
                    }
                }
                ],  
                dataAction: 'server',
                //data:TreeDeptData,
                width: '100%', height: '100%', 
                pageSize: 10,
                rownumbers:false,
                //checkbox : true,
                //应用灰色表头
                cssClass: 'l-grid-gray', 
                heightDiff: -6,
                url: "getTree.do", 
                //alternatingRow: false, 
                tree: {
                    columnId: 'columnId',
                    idField: 'id',
                    parentIDField: 'pid'
                },
                usePager:false,
                enabledEdit: true,
                clickToEdit:false
            });
             
            gridManager = $("#maingrid").ligerGetGridManager();

            $("#pageloading").hide();

        });


        //编辑行
        function beginEdit(rowid) {
        	 //$.ligerDialog.alert("id-->" + id);
        	 //window.location.href="toEdit.action?id=" + id;
        	updateMenu();
        }
        
        //操作删除
        function deleteRow(rowid){
        	
        	var selectedRow = gridManager.getSelectedRow();
        	if (!selectedRow) { $.ligerDialog.alert('请选择行'); return; }
        	
        	var msg = "";
        	var hasChild = selectedRow.__hasChildren;
        	var pid = selectedRow.pid;
        	if(hasChild){
        		msg = "该菜单包含子菜单，您确定删除吗?";
        	}else{
        		msg = "您确定删除吗?";
        	}
        	
        	$.ligerDialog.confirm(msg,'警告', function (yes){
        		if(yes){
        			if(pid == '0'){
                		//移除下拉框 value属性为selectedRow.id的选项
                        $("#selectedMenuId option[value="+selectedRow.id+"]").remove();
                	}
        			$.ajax({
            	        url:"delete.do",
            	        data:{
            	        	"id":selectedRow.id
            	        },
            	        datatype: "json",
            	        success:function(json){
            	    	   $("#pageloading").hide();
            	    	   if(json.result =="success"){
            	    		   $.ligerDialog.success("删除成功","提示");
            	    		   //重新加载分页数据
                   			   gridManager.loadData(true);
            	    	   }else{
            	    		   $.ligerDialog.success("操作失败","提示");	            	    		   
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
                $.ligerDialog.confirm('确定删除' + checkedIds.join(',') + '?', function (yes){
                	if(yes){
                		
                		$.ajax({
                	        type:"POST",
                	        url:"batchDel.action",
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
        
        
        //筛选
        function changeMainMenu(){
              if (!gridManager) return;
              var mainMenuId = $("#selectedMenuId").val(); 
              gridManager.setOptions(
                  { parms: [{ name: 'mainMenuId', value: mainMenuId}] }
              );
              gridManager.loadData(true);
           
        	
        }
        
        
    </script>
</head>
<body style="padding:0px; overflow:hidden;"> 
<div class="l-loading" style="display:block" id="pageloading"></div> 
  <form id="form1" runat="server"> 

 <div id="topmenu"></div> 

  <div id="toptoolbar"></div> 

<div class="l-panel-search">
    <div class="l-panel-search-item">
        请选择菜单：
    </div>
    <div class="l-panel-search-item">
        <select style="width: 100px" name="selectedMenu" id="selectedMenuId" onchange="changeMainMenu()">
        	<option value="-1">全部</option>
        	<c:forEach items="${ optionList }" var="menu" >
        		<option value="${menu.id}">${menu.name}</option>
			</c:forEach>
        </select>
    </div>
</div>

    <div id="maingrid" style="margin:0; padding:0"></div>

  </form>


<div id="Editdetail" style="display:none;" >
	<form id="EditForm" >
	<input type="hidden" id="hidenParentId" name="parentId" value=""/>
        <div style="padding-left: 100px;padding-top: 30px">
        	<table>
        		<tr>
        			<td>
       				<table>
		             	
		             	<tr>
		             		<td>菜单名称</td>
		             		<td><input type="text" name="name" id="addName"/></td>
		             		<td></td>
		             	</tr>
		             	<tr>
		             		<td>url</td>
		             		<td><input type="text" name="url" id="addUrl"/></td>
		             		<td></td>
		             	</tr>
		             	<tr>
		             		<td>状态</td>
		             		<td>
		             			<select name="isdisplay" id="addIsdisplay">
		             				<option value="1">显示</option>
		             				<option value="0">隐藏</option>
		             			</select>
							</td>
		             		<td></td>
		             	</tr>
		             	<tr>
		             		<td>备注</td>
		             		<td><input type="text" name="desctxt" id="addDesctxt"/></td>
		             		<td></td>
		             	</tr>
		             	
		             	
		             	<tr>
							<td>缩略图</td>
							<td style="margin: 0;padding: 0;">
							<table>
								<tr>
									<td >
										<input readonly="readonly" name="picUrl" type="text" id="logo" ltype="text" maxlength="50"/>
									</td>
									<td align="left" class="l-table-edit-td">
										<input type="button" value="选择图片" id="choseImg" class="l-button" name="choseImg"/></div>
									</td>
								</tr>
								
							</table>
							</td>
							<td align="left"></td>
						</tr>
						
		             	<tr>
		             		<td colspan="3"><span id="addTips" style="color: red;display: none;"></span></td>
		             	</tr>
		             
		             </table>
        			</td>
        			<td align="right" class="l-table-edit-td">预览:</td>
					<td align="left" class="l-table-edit-td">
						<div id="viewImg">
						</div>
					</td>
					<td align="left"></td>
        		</tr>
        	</table>
             
        </div>  
    </form>
</div>    <%--弹出编辑框DIV--%>  

<div id="Updatedetail" style="display:none;" >
	<form id="UpdateForm" >
	<input type="hidden" id="hidenParentIdUpdate" name="parentId" value=""/>
        <div style="padding-left: 100px;padding-top: 30px">
        	<table>
        		<tr>
        			<td>
       				<table>
		             	
		             	<tr>
		             		<td>菜单名称</td>
		             		<td><input type="text" name="name" id="updateName"/></td>
		             		<td></td>
		             	</tr>
		             	<tr>
		             		<td>url</td>
		             		<td><input type="text" name="url" id="updateUrl"/></td>
		             		<td></td>
		             	</tr>
		             	
		             	<tr>
		             		<td>状态</td>
		             		<td>
		             			<select name="isdisplay" id="updateIsdisplay">
		             				<option value="1">显示</option>
		             				<option value="0">隐藏</option>
		             			</select>
							</td>
		             		<td></td>
		             	</tr>
		             	<tr>
		             		<td>备注</td>
		             		<td><input type="text" name="desctxt" id="updateDesctxt"/></td>
		             		<td></td>
		             	</tr>
		             	
		             	
		             	<tr>
							<td>缩略图</td>
							<td style="margin: 0;padding: 0;">
							<table>
								<tr>
									<td >
										<input readonly="readonly" name="picUrl" type="text" id="updatelogo" ltype="text" maxlength="50"/>
									</td>
									<td align="left" class="l-table-edit-td">
										<input type="button" value="选择图片" id="updatechoseImg" class="l-button" name="updatechoseImg"/></div>
									</td>
								</tr>
								
							</table>
							</td>
							<td align="left"></td>
						</tr>
						
		             	<tr>
		             		<td colspan="3"><span id="updateTips" style="color: red;display: none;"></span></td>
		             	</tr>
		             
		             </table>
        			</td>
        			<td align="right" class="l-table-edit-td">预览:</td>
					<td align="left" class="l-table-edit-td">
						<div id="updateviewImg">
						</div>
					</td>
					<td align="left"></td>
        		</tr>
        	</table>
             
        </div>  
    </form>
</div>    <%--弹出修改框DIV--%>  

</body>
<script>
KindEditor.ready(function(K) {
	var editor = K.editor({
		filterMode : true,
		uploadJson : '${contextPath}/admin/kind/uploadManager.do?type=menu',
		fileManagerJson : '${contextPath}/admin/kind/fileManager.do?type=menu',
		allowFileManager : true,
		afterBlur: function(){this.sync();}
	});
	K.create('#context', {
		filterMode : true,
		uploadJson : '${contextPath}/admin/kind/uploadManager.do?type=menu',
		fileManagerJson : '${contextPath}/admin/kind/fileManager.do?type=menu',
		allowFileManager : true,
		afterBlur: function(){this.sync();}
	});
	
	 K('#choseImg').click(function() {
		editor.loadPlugin('image', function() {
			editor.plugin.imageDialog({
				imageUrl : K('#logo').val(),
				clickFn : function(url, title, width, height, border, align) {
					K('#logo').val(url);
					$("#viewImg").html("<img src=\""+url+"\" width=\""+width+"\" height=\""+height+"\">");
					editor.hideDialog();
				}
			});
		});
	}); 
	
	 
	 K('#updatechoseImg').click(function() {
			editor.loadPlugin('image', function() {
				editor.plugin.imageDialog({
					imageUrl : K('#updatelogo').val(),
					clickFn : function(url, title, width, height, border, align) {
						K('#updatelogo').val(url);
						$("#updateviewImg").html("<img src=\""+url+"\" width=\"200\" height=\"200\">");
						editor.hideDialog();
					}
				});
			});
		}); 
	
});
</script>


</html>
