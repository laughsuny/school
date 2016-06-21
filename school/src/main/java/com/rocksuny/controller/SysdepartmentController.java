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
import com.rocksuny.model.Sysuser;
import com.rocksuny.service.ISysdepartmentService;

@Controller
@RequestMapping("/admin/department")
public class SysdepartmentController extends BaseController{

	@Autowired
	private ISysdepartmentService sysdepartmentService;
	
	/**
	 * 部门实体
	 */
	private Sysdepartment department;
	
	/**
	 *  修改部门
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/update")
	public Object update(Sysdepartment dept){
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			sysdepartmentService.update(dept);
			map.put("result", "success");
		} catch (Exception e) {
			map.put("result", "error");
			e.printStackTrace();
		}
		return map;
	}
	
	/**
	 *  删除部门
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/delete")
	public Object delete(int id){
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			sysdepartmentService.delete(id);
			map.put("result", "success");
		} catch (Exception e) {
			map.put("result", "error");
			e.printStackTrace();
		}
		return map;
	}
	
	/**
	 *  批量删除部门
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/batchDel")
	public Object batchDel(String ids){
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			sysdepartmentService.deleteBatch(ids);
			map.put("result", "success");
		} catch (Exception e) {
			map.put("result", "error");
			e.printStackTrace();
		}
		return map;
	}
	
	/**
	 *  保存部门
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/save")
	public Object save(Sysdepartment dept){
		
		Sysuser user = (Sysuser)session.getAttribute("sysuser");
		Map<String,Object> map = new HashMap<String,Object>();
		
		dept.setCreateTime(new Date());
		dept.setCreateUser(user.getId());
		
		try {
			sysdepartmentService.save(dept);
			map.put("result", "success");
		} catch (Exception e) {
			map.put("result", "error");
			e.printStackTrace();
		}
		return map;
	}
	
	/**
	 * 检查部门名称重复
	 * @param name 部门名称
	 * @return true 重复  false 不重复
	 */
	@ResponseBody
	@RequestMapping(value="/checkDeptName")
	public Object checkDeptName(String name){
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("name", name);
		int count = sysdepartmentService.count(param);
		if(count>0){
			return true;
		}else{
			return false;
		}
	}
	
	/**
	 * 增加部门页
	 * @return
	 */
	@RequestMapping("/toAdd")
	public String add(Model model){
		model.addAttribute("action", "save");
		return "/admin/department/edit";
	}
	
	/**
	 * 部门编辑详情页
	 * @return
	 */
	@RequestMapping("/toEdit")
	public String toEdit(int id,Model model){
		department = sysdepartmentService.findById(id);
		model.addAttribute("action", "update");
		model.addAttribute("dept", department);
		return "/admin/department/edit";
	}
	
	/**
	 * 部门管理主页跳转
	 * @return
	 */
	@RequestMapping("/list")
	public String list(){
		return "admin/department/list";
	}
	
	/**
	 * 部门分页查询
	 * @param pageBean
	 * @param name
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/listPage")
	public Object listPage(PageBean<Sysdepartment> pageBean,String name){
		pageBean = sysdepartmentService.queryByPage(name,pageBean);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("Rows", pageBean.getData());
		map.put("Total", pageBean.getRowTotal());
		map.put("action", "save");
		return map;
	}
	
	/**
	 * 查询有所部门
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/getDepartmentList")
	public Object getDepartmentList(){
		List<Sysdepartment> depts = sysdepartmentService.getDepts();
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("depts", depts);
		return map;
	}
	
}
