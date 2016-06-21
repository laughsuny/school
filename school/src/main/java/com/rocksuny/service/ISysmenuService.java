package com.rocksuny.service;

import java.util.List;

import com.rocksuny.model.Sysmenu;
import com.rocksuny.service.base.IBaseService;

public interface ISysmenuService extends IBaseService<Sysmenu, Integer>{

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
}
