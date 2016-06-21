package com.rocksuny.service;

import java.util.List;

import com.rocksuny.bean.PageBean;
import com.rocksuny.model.Sysrole;
import com.rocksuny.service.base.IBaseService;

public interface ISysroleService extends IBaseService<Sysrole, Integer>{

	/**
	 * 角色分页模糊查询
	 * 
	 * @param searchStr 角色名称
	 * @param pageBean 分页参数。查询page，页容量为pageSize数据。 @see com.rocksuny.bean.PageBean
	 * @return 查询符合参数条件的用户数据。 若当前页小于1则返回第-页数据；当前页大于最大页数，返回最后一页数据；
	 */
	public PageBean<Sysrole> queryByPage(String searchStr, PageBean<Sysrole> pageBean);
	
	/**
	 * 角色新增
	 * @param role 待新增角色实体
	 * @param menuIds 角色id字符串，逗号分隔
	 */
	public void save(Sysrole role,String menuIds);
	
	/**
	 * 角色修改
	 * @param role 待修改角色实体
	 * @param menuIds 角色id字符串，逗号分隔
	 */
	public void update(Sysrole role,String menuIds);
	
	/**
	 * 批量删除
	 * @param ids id字符串，逗号分隔
	 */
	public void deleteBatch(String ids);
	
	/**
	 * 根据主键删除
	 * @param id 主键id
	 */
	public void delete(int id);
	
	/**
	 * 查询所有角色
	 */
	public List<Sysrole> getList();
	
}
