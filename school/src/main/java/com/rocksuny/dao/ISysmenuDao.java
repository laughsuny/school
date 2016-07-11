package com.rocksuny.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.rocksuny.dao.base.IBaseDao;
import com.rocksuny.model.Sysmenu;

@Repository
public interface ISysmenuDao extends IBaseDao<Sysmenu,String>{
	
	/**
	 * 查找所有菜单
	 * @return
	 */
	public List<Sysmenu> getMenus();
	
	/**
	 * 根据菜单id获得 pid
	 * @param id 菜单id
	 * @return
	 */
	public String getPid(@Param("id")String id);
	/**
	 * 根据父菜单id查询菜单集合
	 * @param pid 父菜单id
	 * @return
	 */
	public List<Sysmenu> getMenusByPid(@Param("pid")String pid);
	
	/**
	 * 根据id查询菜单
	 * @param id 菜单id
	 * @return
	 */
	public Sysmenu getMenuById(@Param("id")String id);
	
	/**
	 * 根据id获取菜单及其所有子惨淡
	 * @param id 菜单id
	 * @return
	 */
	public List<Sysmenu> getMenusWithSub(@Param("id")String id);
	
	/**
	 * 删除菜单(逻辑删除,更新status状态为0)
	 * 若该菜单包含子菜单，则包含子菜单一起删除
	 * @param id 待删除菜单id 
	 */
	public void delete(@Param("id")String id);
	
}