package com.rocksuny.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.Cookie;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.rocksuny.annotation.SystemControllerLog;
import com.rocksuny.controller.base.BaseController;
import com.rocksuny.model.Sysmenu;
import com.rocksuny.model.Sysuser;
import com.rocksuny.service.ISysmenuService;
import com.rocksuny.service.ISysuserService;
import com.rocksuny.util.LoginFiled;

/**
 * 后台核心跳转通用类
 * @author suny
 *
 */
@Controller
@RequestMapping("/admin")
public class CoreController extends BaseController{

	
	@Autowired
	private ISysuserService sysuserService;
	@Autowired
	private ISysmenuService sysmenuService;

	
	/**
	 * 检查登陆
	 * @param code
	 * @param userAccount
	 * @param password
	 * @param checkUser
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/checkLogin")
	//此处为记录AOP拦截Controller记录用户操作    
	public Object checkLogin(String code,String userAccount,String password,String checkUser){
		userAccount = userAccount.trim();
		String rand = (String) request.getSession().getAttribute("adminRand");
		code = code.toUpperCase();
		try {
			if (!code.equals(rand)) {
				json.put("result", "errorCode");
			} else {
				Sysuser user = sysuserService.checkLogin(userAccount, password);
				if (user == null) {
					json.put("result", "none");
				} else {
					if (user.getStatus() == 0) {
						json.put("result", "invalid");
					}else{
						session.setAttribute("sysuser", user);
						user.setLastLoginTime(new Date());
						user.setLastLoginIp(request.getRemoteAddr());
						sysuserService.update(user);
						if (checkUser.equals("true")) {
							Cookie cookie = new Cookie("userAccount",user.getAccount());
							//设置时长是7天
							cookie.setMaxAge(604800000);
							response.addCookie(cookie);
						}
						json.put("result", SUCCESS);
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			json.put("result", ERROR);
		}
		return json;
	}
	
	
	
	/**
	 * 登陆页跳转
	 * @return
	 */
	@RequestMapping("/login")
	public String login(Model model){
		Cookie cookies[] = request.getCookies();
		String userAccount = "";
		if(cookies!=null){
			for (int i = 0; i < cookies.length; i++) {
				if(cookies[i].getName().equals("userAccount")){
					userAccount = cookies[i].getValue();
					model.addAttribute("userAccount",userAccount);
					break;
				}
			}
		}
		return "/admin/login";
	}
	
	
	/**
	 * 首页跳转
	 * @return
	 */
	@RequestMapping("/index")
	public String index(){
		return "/admin/index";
	}
	
	@RequestMapping("/welcome")
	public String welcome(Model model){
		
		return "/admin/welcome";
	}
	
	/**
	 * 后台主页加载菜单
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/menuList")
	public Object menuList(){
		
		List<Sysmenu> menuList = new ArrayList<Sysmenu>();
		Sysuser user = LoginFiled.sysuser;
		if(user.getUserType() == 0){//超级管理员
			menuList = sysmenuService.getMenus();
		}else{//普通用户
			menuList = sysmenuService.getMenusByUserId(user.getId());
		}
		
		
		
		//List<Sysmenu> menuList = sysmenuService.getMenus();
		return JSON.toJSONString(menuList);
	}
	
	
	
}
