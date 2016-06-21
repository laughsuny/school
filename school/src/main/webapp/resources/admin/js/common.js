//后台全局ajax设置
$.ajaxSetup({
  datatype: "json",
  type: "POST",
  beforeSend:function(){
  	$("#pageloading").show();
  },
  complete: function(XMLHttpRequest, textStatus){
  	 $("#pageloading").hide();
  },
  error: function(){
  	 $("#pageloading").hide();
     $.ligerDialog.error("操作失败","提示");
  }, 
  global: false
  
});

/**
 * 格式化时间带时间(yyyy-mm-dd hh:mi:ss)
 * @param time
 * @returns {String}
 */
function timeStamp2String(time){
	
	if(time){
		var datetime = new Date();
	    datetime.setTime(time);
	    var year = datetime.getFullYear();
	    var month = datetime.getMonth() + 1 < 10 ? "0" + (datetime.getMonth() + 1) : datetime.getMonth() + 1;
	    var date = datetime.getDate() < 10 ? "0" + datetime.getDate() : datetime.getDate();
	    var hour = datetime.getHours()< 10 ? "0" + datetime.getHours() : datetime.getHours();
	    var minute = datetime.getMinutes()< 10 ? "0" + datetime.getMinutes() : datetime.getMinutes();
	    var second = datetime.getSeconds()< 10 ? "0" + datetime.getSeconds() : datetime.getSeconds();
	    return year + "-" + month + "-" + date+" "+hour+":"+minute+":"+second;
	}else{
		return "";
				
	}
	
}
/**
 * 格式化时间(yyyy-mm-dd)
 * @param time
 * @returns {String}
 */
function timeStampString(time){
	if(time){
		var datetime = new Date();
	    datetime.setTime(time);
	    var year = datetime.getFullYear();
	    var month = datetime.getMonth() + 1 < 10 ? "0" + (datetime.getMonth() + 1) : datetime.getMonth() + 1;
	    var date = datetime.getDate() < 10 ? "0" + datetime.getDate() : datetime.getDate();
	    return year+"-"+month+"-"+date;
	}else{
		return "";
				
	}
	
}