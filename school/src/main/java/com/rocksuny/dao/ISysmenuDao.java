package com.rocksuny.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.rocksuny.dao.base.IBaseDao;
import com.rocksuny.model.Sysmenu;

@Repository
public interface ISysmenuDao extends IBaseDao<Sysmenu,Integer>{
	
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
	
}