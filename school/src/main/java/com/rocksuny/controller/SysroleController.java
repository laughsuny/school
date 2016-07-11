package com.rocksuny.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.rocksuny.bean.PageBean;
import com.rocksuny.controller.base.BaseController;
import com.rocksuny.model.Sysmenu;
import com.rocksuny.model.Sysrole;
import com.rocksuny.model.Sysrolemenu;
import com.rocksuny.model.Sysuser;
import com.rocksuny.service.ISysmenuService;
import com.rocksuny.service.ISysroleService;
import com.rocksuny.service.ISysrolemenuService;

@Controller
@RequestMapping("/admin/role")
public class SysroleController extends BaseController{
	
	private static Logger log = Logger.getLogger(SysroleController.class);
	@Autowired
	private ISysroleService sysroleService;
	@Autowired
	private ISysmenuService sysmenuService;
	@Autowired
	private ISysrolemenuService sysrolemenuService;
	/**
	 * 角色实体
	 */
	private Sysrole role;
	
	/**
	 *  删除角色
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/delete")
	public Object delete(int id){
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			sysroleService.delete(id);
			map.put("result", "success");
		} catch (Exception e) {
			map.put("result", "error");
			e.printStackTrace();
		}
		return map;
	}
	
	/**
	 *  批量删除角色
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/batchDel")
	public Object batchDel(String ids){
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			sysroleService.deleteBatch(ids);
			map.put("result", "success");
		} catch (Exception e) {
			map.put("result", "error");
			e.printStackTrace();
		}
		return map;
	}
	/**
	 *  修改角色
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/update")
	public Object update(Sysrole role,String menuIds){
		
		Map<String,Object> map = new HashMap<String,Object>();
		role.setUpdateTime(new Date());
		try {
			sysroleService.update(role,menuIds);
			map.put("result", "success");
		} catch (Exception e) {
			map.put("result", "error");
			e.printStackTrace();
		}
		return map;
	}
	
	/**
	 *  保存角色
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/save")
	public Object save(Sysrole role,String menuIds){
		
		Sysuser user = (Sysuser)session.getAttribute("sysuser");
		Map<String,Object> map = new HashMap<String,Object>();
		
		role.setCreateTime(new Date());
		role.setCreateUser(user.getId());
		role.setUpdateTime(new Date());
		try {
			sysroleService.save(role,menuIds);
			map.put("result", "success");
		} catch (Exception e) {
			map.put("result", "error");
			e.printStackTrace();
		}
		return map;
	}
	
	/**
	 * 检查角色名称重复
	 * @param rolename 角色名称
	 * @return true 重复  false 不重复
	 */
	@ResponseBody
	@RequestMapping(value="/checkRoleName")
	public Object checkRoleName(String rolename){
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("rolename", rolename);
		int count = sysroleService.count(param);
		if(count>0){
			return true;
		}else{
			return false;
		}
	}
	
	
	/**
	 *  增加角色时获得菜单树
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/getMenu2Add")
	public Object getMenu2Add(){
		List<Sysmenu> menuList = new ArrayList<Sysmenu>();
		menuList = sysmenuService.getMenus();
		return menuList;
	}
	
	/**
	 *  修改角色时获得角色菜单树
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/getMenu2Update")
	public Object getTreeUpdate(int id){
		List<Sysmenu> menus = new ArrayList<Sysmenu>();
		menus = sysmenuService.getMenus();
		
		List<Sysrolemenu> list = sysrolemenuService.getListByRoleId(id);
		for(Sysrolemenu roleMenu : list){
			for(Sysmenu menu : menus){
				if(menu.getId().equals(roleMenu.getMenuId())){
					menu.setIschecked(true);
				}
			}
		}
		return menus;
	}
	
	/**
	 * 角色列表页
	 * @return
	 */
	@RequestMapping("/list")
	public String list(){
		return "/admin/role/list";
	}
	
	
	/**
	 * 增加角色页
	 * @return
	 */
	@RequestMapping("/toAdd")
	public String add(Model model){
		model.addAttribute("action", "save");
		model.addAttribute("menuAction", "getMenu2Add");
		return "/admin/role/edit";
	}
	
	/**
	 * 角色编辑详情页
	 * @return
	 */
	@RequestMapping("/toEdit")
	public String toEdit(int id,Model model){
		role = sysroleService.findById(id);
		model.addAttribute("action", "update");
		model.addAttribute("role", role);
		model.addAttribute("menuAction", "getMenu2Update");
		return "/admin/role/edit";
	}
	
	/**
	 * 列表页面分页查询
	 * @param pageBean
	 * @param searchStr
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/listPage")
	public Object listPage(PageBean<Sysrole> pageBean,String searchStr){
		pageBean = sysroleService.queryByPage(searchStr, pageBean);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("Rows", pageBean.getData());
		map.put("Total", pageBean.getRowTotal());
		return map;
	}

}
