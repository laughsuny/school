package com.rocksuny.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.rocksuny.dao.base.IBaseDao;
import com.rocksuny.model.Sysuser;

@Repository
public interface ISysuserDao extends IBaseDao<Sysuser,Integer>{
	
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
	public void deleteBatchByDeptId(@Param("ids")String ids);
	
	/**
	 * 根据指定参数查询sysuser
	 * @param params
	 * @return
	 */
	public Sysuser queryUser(Map<String, Object> params);
}