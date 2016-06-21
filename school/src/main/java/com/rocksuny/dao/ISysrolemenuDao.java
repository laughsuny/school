package com.rocksuny.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.rocksuny.dao.base.IBaseDao;
import com.rocksuny.model.Sysrolemenu;

@Repository
public interface ISysrolemenuDao extends IBaseDao<Sysrolemenu, Integer>{
	/**
	 * 根据角色id获取 角色-菜单集合
	 * @param roleId
	 * @return
	 */
	public List<Sysrolemenu> getListByRoleId(@Param("roleId")int roleId);
	
	/**
	 * 根据角色id删除角色菜单集合
	 * @param roleId
	 */
	public void deleteByRoleId(@Param("roleId")int roleId);
	
	/**
	 * 根据角色id字符串删除角色菜单集合
	 * @param ids 角色id字符串 ，逗号分隔
	 */
	public void deleteBatchByRoleId(@Param("ids")String ids);
}