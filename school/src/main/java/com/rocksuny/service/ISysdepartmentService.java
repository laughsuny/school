package com.rocksuny.service;

import java.util.List;

import com.rocksuny.bean.PageBean;
import com.rocksuny.model.Sysdepartment;
import com.rocksuny.service.base.IBaseService;

public interface ISysdepartmentService extends IBaseService<Sysdepartment, Integer>{

	/**
	 * 部门分页模糊查询
	 * 
	 * @param name 部门名称
	 * @param pageBean 分页参数。查询page，页容量为pageSize数据。 @see com.rocksuny.bean.PageBean
	 * @return 查询符合参数条件的用户数据。 若当前页小于1则返回第-页数据；当前页大于最大页数，返回最后一页数据；
	 */
	public PageBean<Sysdepartment> queryByPage(String name, PageBean<Sysdepartment> pageBean);

	/**
	 * 查询所有部门
	 * @return
	 */
	public List<Sysdepartment> getDepts();
	
	/**
	 * 删除部门和部门下的用户
	 * @param id 部门主键
	 */
	public void delete(int id);
	
	/**
	 * 批量删除
	 * @param ids 部门id字符串，逗号分隔
	 */
	public void deleteBatch(String ids);
}
