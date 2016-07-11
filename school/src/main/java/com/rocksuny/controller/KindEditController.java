package com.rocksuny.controller;

import java.io.File;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.alibaba.fastjson.JSONObject;
import com.rocksuny.constant.ConfigHolder;

/**
 * 后台kindEdit富文本框管理上传和文件管理控制
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/admin/kind")
public class KindEditController {
	
	/**
	 * 文档上传管理
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("/uploadManager")
	public Map<String, Object> uoloadManager(HttpServletRequest request,HttpServletResponse response) throws Exception{
		
		String type = request.getParameter("type");
		String flag = request.getParameter("flag");
		
		//文件保存目录路径
		String savePath = request.getServletContext().getRealPath("/") + "upload/";
		//文件保存目录URL
		String saveUrl  = request.getContextPath() + "/upload/";
		//水印文件路径 
		//String iconPath = request.getServletContext().getRealPath("/") + "front/images/icon.png";
		
		if(type != null && type.length() >0){
			savePath+=type+"/";
			saveUrl+=type+"/";
		}
		System.out.println(savePath);
		//定义允许上传的文件扩展名
		HashMap<String, String> extMap = new HashMap<String, String>();
		extMap.put("image", "gif,jpg,jpeg,png,bmp");
		extMap.put("flash", "swf,flv");
		extMap.put("media", "swf,flv,mp3,wav,wma,wmv,mid,avi,mpg,asf,rm,rmvb,mp4");
		extMap.put("file", "doc,docx,xls,xlsx,ppt,htm,html,txt,zip,rar,gz,bz2,flv,mp4,wmv,mov,f4v,3gp,jpg,pdf");

		//最大文件大小
		//long maxSize = 52428800;//50M 字节
		long maxSize = 0;
		String maxSizeStr = ConfigHolder.get("max_upload_size");
		if(maxSizeStr != null && maxSizeStr.length() >0){
			maxSize = Integer.parseInt(maxSizeStr)*1024*1024;
		}else{
			maxSize = 52428800;//50M
		}

		response.setContentType("text/html; charset=UTF-8");

		if(!ServletFileUpload.isMultipartContent(request)){
			return getError("请选择文件。"); 
		}
		//检查目录
		File uploadDir = new File(savePath);
		if (!uploadDir.exists()) {
			uploadDir.mkdirs();
		}
		//检查目录写权限
		/*if(!uploadDir.canWrite()){
			out.println(getError("上传目录没有写权限。"));
			return;
		}*/

		String dirName = request.getParameter("dir");
		if (dirName == null) {
			dirName = "image";
		}
		if(!extMap.containsKey(dirName)){
			return getError("目录名不正确。");
		}
		//创建文件夹
		savePath += dirName + "/";
		saveUrl += dirName + "/";
		File saveDirFile = new File(savePath);
		if (!saveDirFile.exists()) {
			saveDirFile.mkdirs();
		}
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String ymd = sdf.format(new Date());
		savePath += ymd + "/";
		saveUrl += ymd + "/";
		File dirFile = new File(savePath);
		if (!dirFile.exists()) {
			dirFile.mkdirs();
		}
		
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		
        Map<String,MultipartFile> fileMap = multipartRequest.getFileMap();
        
        Iterator<Entry<String, MultipartFile>>  it = fileMap.entrySet().iterator(); 
       
		while (it.hasNext()) {

			Entry<String, MultipartFile> entry = it.next();
        	MultipartFile file = entry.getValue();
        	
        	String fileName = file.getOriginalFilename();
			
			//检查文件大小
			if(file.getSize() > maxSize){
				
				if(maxSizeStr != null && maxSizeStr.length() >0){
					int sizeM = Integer.parseInt(maxSizeStr);
					return getError("上传文件大小超过"+sizeM+"M限制。");
				}else{
					return getError("上传文件大小超过50M限制。");
				}
			}
			
			
			//检查扩展名
			String fileExt = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
			if(!Arrays.<String>asList(extMap.get(dirName).split(",")).contains(fileExt)){
				return getError("上传文件扩展名是不允许的扩展名。\n只允许" + extMap.get(dirName) + "格式。");
			}
			//上传
			SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
			String newFileName = df.format(new Date()) + "_" + new Random().nextInt(1000) + "." + fileExt;
			try {
				File uploadedFile = new File(savePath, newFileName);
				file.transferTo(uploadedFile);
				
				if(flag != null && flag.length() >0){
					//添加水印
					if(Arrays.<String>asList(extMap.get("image").split(",")).contains(fileExt)){
						//ImageMark.pressImage(iconPath, uploadedFile.getAbsolutePath(), 4, 1);
					}
				}
				
			} catch (Exception e) {
				return getError("上传文件失败。");
			}
			
			Map<String, Object> msg = new HashMap<String, Object>();  
            msg.put("error", 0);  
            msg.put("url", saveUrl + newFileName);  
            return msg;
			
		}
		
		return null;
		
	}
	
	
	private Map<String, Object> getError(String errorMsg) {  
        Map<String, Object> errorMap = new HashMap<String, Object>();  
        errorMap.put("error", 1);  
        errorMap.put("message", errorMsg);  
        return errorMap;  
    }
	
	

	/**
	 * 文档管理
	 * @return
	 * @throws Exception 
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping("/fileManager")
	public void fileManager(HttpServletRequest request,HttpServletResponse response) throws Exception{
		
		String type = request.getParameter("type");
		//根目录路径，可以指定绝对路径，比如 /var/www/attached/
		String rootPath = request.getServletContext().getRealPath("/") + "upload/";
		//根目录URL，可以指定绝对路径，比如 http://www.yoursite.com/attached/
		String rootUrl  = request.getContextPath() + "/upload/";
		PrintWriter out = response.getWriter();

		if(type != null && type.length() >0){
			rootPath+=type+"/";
			rootUrl+=type+"/";
		}

		//图片扩展名
		String[] fileTypes = new String[]{"gif", "jpg", "jpeg", "png", "bmp"};

		String dirName = request.getParameter("dir");
		if (dirName != null) {
			if(!Arrays.<String>asList(new String[]{"image", "flash", "media", "file"}).contains(dirName)){
				out.println("Invalid Directory name.");
				return;
			}
			rootPath += dirName + "/";
			rootUrl += dirName + "/";
			File saveDirFile = new File(rootPath);
			if (!saveDirFile.exists()) {
				saveDirFile.mkdirs();
			}
		}
		//根据path参数，设置各路径和URL
		String path = request.getParameter("path") != null ? request.getParameter("path") : "";
		String currentPath = rootPath + path;
		String currentUrl = rootUrl + path;
		String currentDirPath = path;
		String moveupDirPath = "";
		if (!"".equals(path)) {
			String str = currentDirPath.substring(0, currentDirPath.length() - 1);
			moveupDirPath = str.lastIndexOf("/") >= 0 ? str.substring(0, str.lastIndexOf("/") + 1) : "";
		}

		//排序形式，name or size or type
		String order = request.getParameter("order") != null ? request.getParameter("order").toLowerCase() : "name";

		//不允许使用..移动到上一级目录
		if (path.indexOf("..") >= 0) {
			out.println("Access is not allowed.");
			return;
		}
		//最后一个字符不是/
		if (!"".equals(path) && !path.endsWith("/")) {
			out.println("Parameter is not valid.");
			return;
		}
		//目录不存在或不是目录
		File currentPathFile = new File(currentPath);
		if(!currentPathFile.isDirectory()){
			out.println("Directory does not exist.");
			return;
		}

		//遍历目录取的文件信息
		List<Hashtable> fileList = new ArrayList<Hashtable>();
		if(currentPathFile.listFiles() != null) {
			for (File file : currentPathFile.listFiles()) {
				Hashtable<String, Object> hash = new Hashtable<String, Object>();
				String fileName = file.getName();
				if(file.isDirectory()) {
					hash.put("is_dir", true);
					hash.put("has_file", (file.listFiles() != null));
					hash.put("filesize", 0L);
					hash.put("is_photo", false);
					hash.put("filetype", "");
				} else if(file.isFile()){
					String fileExt = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
					hash.put("is_dir", false);
					hash.put("has_file", false);
					hash.put("filesize", file.length());
					hash.put("is_photo", Arrays.<String>asList(fileTypes).contains(fileExt));
					hash.put("filetype", fileExt);
				}
				hash.put("filename", fileName);
				hash.put("datetime", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(file.lastModified()));
				fileList.add(hash);
			}
		}

		if ("size".equals(order)) {
			Collections.sort(fileList, new SizeComparator());
		} else if ("type".equals(order)) {
			Collections.sort(fileList, new TypeComparator());
		} else {
			Collections.sort(fileList, new NameComparator());
		}
		JSONObject result = new JSONObject();
		result.put("moveup_dir_path", moveupDirPath);
		result.put("current_dir_path", currentDirPath);
		result.put("current_url", currentUrl);
		result.put("total_count", fileList.size());
		result.put("file_list", fileList);

		response.setContentType("application/json; charset=UTF-8");
		out.println(result.toJSONString());
		
	}
	
}
@SuppressWarnings("rawtypes")
class NameComparator implements Comparator {
	public int compare(Object a, Object b) {
		Hashtable hashA = (Hashtable)a;
		Hashtable hashB = (Hashtable)b;
		if (((Boolean)hashA.get("is_dir")) && !((Boolean)hashB.get("is_dir"))) {
			return -1;
		} else if (!((Boolean)hashA.get("is_dir")) && ((Boolean)hashB.get("is_dir"))) {
			return 1;
		} else {
			return ((String)hashA.get("filename")).compareTo((String)hashB.get("filename"));
		}
	}
}
@SuppressWarnings("rawtypes")
class SizeComparator implements Comparator {
	public int compare(Object a, Object b) {
		Hashtable hashA = (Hashtable)a;
		Hashtable hashB = (Hashtable)b;
		if (((Boolean)hashA.get("is_dir")) && !((Boolean)hashB.get("is_dir"))) {
			return -1;
		} else if (!((Boolean)hashA.get("is_dir")) && ((Boolean)hashB.get("is_dir"))) {
			return 1;
		} else {
			if (((Long)hashA.get("filesize")) > ((Long)hashB.get("filesize"))) {
				return 1;
			} else if (((Long)hashA.get("filesize")) < ((Long)hashB.get("filesize"))) {
				return -1;
			} else {
				return 0;
			}
		}
	}
}
@SuppressWarnings("rawtypes")
class TypeComparator implements Comparator {
	public int compare(Object a, Object b) {
		Hashtable hashA = (Hashtable)a;
		Hashtable hashB = (Hashtable)b;
		if (((Boolean)hashA.get("is_dir")) && !((Boolean)hashB.get("is_dir"))) {
			return -1;
		} else if (!((Boolean)hashA.get("is_dir")) && ((Boolean)hashB.get("is_dir"))) {
			return 1;
		} else {
			return ((String)hashA.get("filetype")).compareTo((String)hashB.get("filetype"));
		}
	}
}
