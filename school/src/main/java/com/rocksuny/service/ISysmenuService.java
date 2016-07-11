package com.rocksuny.service;

import java.util.List;

import com.rocksuny.model.Sysmenu;
import com.rocksuny.service.base.IBaseService;

public interface ISysmenuService extends IBaseService<Sysmenu, String>{
	/**
	 * 获取所有的菜单集合
	 * @return
	 */
	public List<Sysmenu> getMenus();
	
	/**
	 * 遍历菜单id数组，查找每个菜单对应的所有父级菜单
	 * @param menuIdsArray 菜单id数组
	 * @return
	 */
	public String[] queryByIdArray(String[] menuIdsArray);
	
	/**
	 * 根据父菜单id查询菜单集合
	 * @param pid 父菜单id
	 * @return
	 */
	public List<Sysmenu> getMenusByPid(String pid);
	
	/**
	 * 根据id查询菜单
	 * @param id 菜单id
	 * @return
	 */
	public Sysmenu getMenuById(String id);
	
	/**
	 * 根据id获取菜单及其所有子惨淡
	 * @param id 菜单id
	 * @return
	 */
	public List<Sysmenu> getMenusWithSub(String id);
	
	/**
	 * 删除菜单(逻辑删除,更新status状态为0)
	 * 若该菜单包含子菜单，则包含子菜单一起删除
	 * @param id 待删除菜单id 
	 */
	public void delete(String id);
	
	/**
	 * 根据用户id获取用户所有的菜单权限
	 * @param userId
	 * @return
	 */
	public List<Sysmenu> getMenusByUserId(int userId);
	
	
	
	
	
}
