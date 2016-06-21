package com.rocksuny.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.rocksuny.bean.PageBean;
import com.rocksuny.controller.base.BaseController;
import com.rocksuny.model.Sysdepartment;
import com.rocksuny.model.Sysrole;
import com.rocksuny.model.Sysuser;
import com.rocksuny.service.ISysdepartmentService;
import com.rocksuny.service.ISysroleService;
import com.rocksuny.service.ISysuserService;

/**
 * 用户管理
 * @author suny 
 * @date 2016-6-1 14:27:15
 */
@Controller
@RequestMapping("/admin/user")
public class SysuserController extends BaseController{

	@Autowired
	private ISysuserService sysuserService;
	@Autowired
	private ISysroleService sysroleService;
	@Autowired
	private ISysdepartmentService sysdepartmentService;
	
	/**
	 * 用户实体
	 */
	private Sysuser user;
	
	/**
	 *  保存用户
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/save")
	public Object save(Sysuser sysuser,String userRole){
		Sysuser user = (Sysuser)session.getAttribute("sysuser");
		Map<String,Object> map = new HashMap<String,Object>();
		sysuser.setCreateTime(new Date());
		sysuser.setCreateUser(user.getId());
		try {
			sysuserService.save(sysuser,userRole);
			map.put("result", "success");
		} catch (Exception e) {
			map.put("result", "error");
			e.printStackTrace();
		}
		return map;
	}
	
	/**
	 * 检查用户账号重复
	 * @param account 用户账号
	 * @return true 重复  false 不重复
	 */
	@ResponseBody
	@RequestMapping(value="/checkUserAccount")
	public Object checkUserAccount(String account){
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("account", account);
		int count = sysuserService.count(param);
		if(count>0){
			return true;
		}else{
			return false;
		}
	}
	
	/**
	 * 增加用户页跳转
	 * @return
	 */
	@RequestMapping("/toAdd")
	public String add(Model model){
		model.addAttribute("action", "save");
		List<Sysrole> roles = sysroleService.getList();
		model.addAttribute("roles", roles);
		List<Sysdepartment> depts = sysdepartmentService.getDepts();
		model.addAttribute("depts", depts);
		return "/admin/user/edit";
	}
	
	/**
	 * 部门编辑详情页跳转
	 * @return
	 */
	@RequestMapping("/toEdit")
	public String toEdit(int id,Model model){
		user = sysuserService.findById(id);
		model.addAttribute("action", "update");
		model.addAttribute("user", user);
		List<Sysrole> roles = sysroleService.getList();
		model.addAttribute("roles", roles);
		List<Sysdepartment> depts = sysdepartmentService.getDepts();
		model.addAttribute("depts", depts);
		return "/admin/user/edit";
	}
	
	/**
	 * 用户分页查询
	 * @param pageBean 分页实体
	 * @param userType 用户类型  0超级管理员 1普通用户
	 * @param username 用户名
	 * @param account  用户登陆账号
	 * @param deptId   部门id
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/listPage")
	public Object listPage(PageBean<Sysuser> pageBean,String userType,String username,String account,String deptId){
		if(userType!=null&&userType.equals("-1")){
			userType = null;
		}
		if(deptId!=null&&deptId.equals("0")){
			deptId = null;
		}
		pageBean = sysuserService.queryByPage(userType, username, account, deptId, pageBean);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("Rows", pageBean.getData());
		map.put("Total", pageBean.getRowTotal());
		return map;
	}
	
	/**
	 * 用户管理页面跳转
	 * @return
	 */
	@RequestMapping("/list")
	public String list(){
		return "/admin/user/list";
	}
	
	/**
	 * 查询所有用户
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/getSysuserList")
	public Object getSysuserList(){
		Map<String,Object> map = new HashMap<String,Object>();
		List<Sysuser> users = sysuserService.getList();
		map.put("users", users);
		return map;
	}
}
