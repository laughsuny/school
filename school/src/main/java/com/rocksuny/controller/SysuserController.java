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

import com.rocksuny.annotation.SystemControllerLog;
import com.rocksuny.bean.PageBean;
import com.rocksuny.controller.base.BaseController;
import com.rocksuny.model.Sysdepartment;
import com.rocksuny.model.Sysrole;
import com.rocksuny.model.Sysroleuser;
import com.rocksuny.model.Sysuser;
import com.rocksuny.service.ISysdepartmentService;
import com.rocksuny.service.ISysroleService;
import com.rocksuny.service.ISysroleuserService;
import com.rocksuny.service.ISysuserService;
import com.rocksuny.util.Encrypter;

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
	@Autowired
	private ISysroleuserService sysroleuserService;
	
	/**
	 * 用户实体
	 */
	private Sysuser user;
	
	/**
	 * <p>重置用户密码&&修改用户密码</p>
	 * <li>id为空时，修改当前登陆用户的密码，次操作需要输入原始密码<br/>
	 * <li>id不为空时，重置指定id用户的密码<br/>
	 * @param id 用户id
	 * @param oldPwd 用户原始密码
	 * @param newPwd 用户新密码
	 * @return 
	 * <li>{"result":"resetdone"} //重置成功
	 * <li>{"result":"wrongpwd"} //修改个人密码输入原始密码错误
	 * <li>{"result":"updatedone"} //修改个人密码成功
	 * <li>{"result":"error"} //系统错误
	 */
	@SystemControllerLog(description="重置用户密码&&修改用户密码")
	@ResponseBody
	@RequestMapping("/updatePwd")
	public Object updatePwd(Integer id,String oldPwd,String newPwd){
		
		try {
			Sysuser user = null;
			if(id != null){
				user = sysuserService.findById(id);
				json.put("result", "resetdone");//重置密码成功
			}else{
				user = (Sysuser)session.getAttribute("sysuser");
				oldPwd = Encrypter.md5Encrypt(oldPwd).substring(8,24);
				if(!oldPwd.equals(user.getPassword())){
					json.put("result", "wrongpwd");//修改个人密码输入原始密码错误
					return json;
				}else{
					json.put("result", "updatedone");//修改个人密码成功
					session.removeAttribute("sysuser");
				}
			}
			newPwd = Encrypter.md5Encrypt(newPwd).substring(8,24);
			user.setPassword(newPwd);
			sysuserService.update(user);
			
		} catch (Exception e) {
			e.printStackTrace();
			json.put("result", "error");
		}
		return json;
	}
	
	
	/**
	 * 重置密码页面跳转
	 * @param id 待重置密码用户id
	 * @param model
	 * @return
	 */
	@RequestMapping("/toUpdatePwd")
	public String toUpdatePwd(String id,Model model){
		model.addAttribute("id", id);
		return "/admin/user/updatePwd";
	}
	
	/**
	 * 修改用户及其用户角色信息
	 * @param user 用户实体
	 * @param roleIds 角色id集合，逗号分隔
	 * @return
	 */
	@SystemControllerLog(description = "修改用户")
	@ResponseBody
	@RequestMapping("/update")
	public Object update(Sysuser user,String roleIds){
		try {
			sysuserService.update(user, roleIds);
			json.put("result", "success");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			json.put("result", "error");
		}
		return json;
	}
	
	/**
	 * 批量删除用户
	 * @param ids
	 * @return
	 */
	@SystemControllerLog(description="批量删除用户")
	@ResponseBody
	@RequestMapping("/batchDel")
	public Object batchDel(String ids){
		try {
			sysuserService.deleteBatch(ids);
			json.put("result", "success");
		} catch (Exception e) {
			json.put("result", "error");
			e.printStackTrace();
		}
		return json;
	}
	
	/**
	 * 删除用户
	 * @param id 主键id
	 * @return
	 */
	@SystemControllerLog(description="删除用户")
	@ResponseBody
	@RequestMapping("/delete")
	public Object delete(int id){
		try {
			sysuserService.delete(id);
			json.put("result", "success");
		} catch (Exception e) {
			json.put("result", "error");
			e.printStackTrace();
		}
		return json;
	}
	
	/**
	 * 保存用户
	 * @param sysuser 用户实体
	 * @param roleIds 角色id集合，逗号分隔
	 * @return
	 */
	@SystemControllerLog(description="增加用户")
	@ResponseBody
	@RequestMapping("/save")
	public Object save(Sysuser sysuser,String roleIds){
		Sysuser user = (Sysuser)session.getAttribute("sysuser");
		Map<String,Object> map = new HashMap<String,Object>();
		sysuser.setCreateTime(new Date());
		sysuser.setCreateUser(user.getId());
		try {
			sysuserService.save(sysuser,roleIds);
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
	 * 用户编辑详情页跳转
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
		List<Sysroleuser> roleusers = sysroleuserService.getAll(id);
		model.addAttribute("roleusers", roleusers);
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
	@SystemControllerLog(description="用户分页查询")
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
