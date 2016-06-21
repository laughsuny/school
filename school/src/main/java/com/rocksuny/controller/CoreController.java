package com.rocksuny.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.rocksuny.controller.base.BaseController;
import com.rocksuny.model.Sysmenu;
import com.rocksuny.service.ISysmenuService;
import com.rocksuny.service.ISysuserService;

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
		List<Sysmenu> menuList = sysmenuService.getMenus();
		return JSON.toJSONString(menuList);
	}
	
	
	
}
