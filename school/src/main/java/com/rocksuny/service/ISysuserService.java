package com.rocksuny.service;

import java.util.List;

import com.rocksuny.bean.PageBean;
import com.rocksuny.model.Sysuser;
import com.rocksuny.service.base.IBaseService;

public interface ISysuserService extends IBaseService<Sysuser, Integer>{

	/**
	 * 保存用户 及用户角色中间表
	 * @param user 用户实体
	 * @param roleIds 角色id集合，逗号分隔
	 */
	public void save(Sysuser user,String roleIds);
	
	/**
	 * 查询所有用户
	 * @return
	 */
	public List<Sysuser> getList();
	
	/**
	 * 根据部门id删除用户
	 * @param id 部门id
	 */
	public void deleteByDeptId(int id);
	
	/**
	 * 根据部门id字符串批量删除用户
	 * @param ids 部门id字符串
	 */
	public void deleteBatchByDeptId(String ids);
	
	/**
	 * 用户分页模糊查询
	 * @param userType 用户类型  0超级管理员 1普通用户
	 * @param username 用户名
	 * @param account  用户登陆账号
	 * @param deptId   部门id
	 * @param pageBean 分页参数。查询page，页容量为pageSize数据。 @see com.rocksuny.bean.PageBean
	 * @return 查询符合参数条件的用户数据。 若当前页小于1则返回第-页数据；当前页大于最大页数，返回最后一页数据；
	 */
	public PageBean<Sysuser> queryByPage(String userType,String username,String account,String deptId, PageBean<Sysuser> pageBean);
	
}
