package com.rocksuny.service;

import java.util.List;

import com.rocksuny.model.Sysrolemenu;
import com.rocksuny.service.base.IBaseService;

public interface ISysrolemenuService extends IBaseService<Sysrolemenu, Integer>{

	/**
	 * 根据角色id获取 角色-菜单集合
	 * @param roleId
	 * @return
	 */
	public List<Sysrolemenu> getListByRoleId(int roleId);
	
	/**
	 * 根据角色id删除角色菜单集合
	 * @param roleId
	 */
	public void deleteByRoleId(int roleId);
	
	/**
	 * 根据角色id字符串删除角色菜单集合
	 * @param ids 角色id字符串 ，逗号分隔
	 */
	public void deleteBatchByRoleId(String ids);
	
}
