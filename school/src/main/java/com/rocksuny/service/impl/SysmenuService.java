package com.rocksuny.service.impl;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rocksuny.dao.ISysmenuDao;
import com.rocksuny.dao.base.IBaseDao;
import com.rocksuny.model.Sysmenu;
import com.rocksuny.service.ISysmenuService;
import com.rocksuny.service.base.BaseService;

@Service
public class SysmenuService extends BaseService<Sysmenu, Integer> implements ISysmenuService{
	
	@Autowired
	private ISysmenuDao menuDao;
	@Autowired
	public void setBaseDao(ISysmenuDao menuDao) {
		// TODO Auto-generated method stub
		super.setBaseDao(menuDao);
	}
	@Override
	public List<Sysmenu> getMenus() {
		// TODO Auto-generated method stub
		return menuDao.getMenus();
	}
	@Override
	public String[] queryByIdArray(String[] menuIdsArray) {
		// TODO Auto-generated method stub
		Set<String> menuIdSet = new HashSet<String>();
		for(String menuid:menuIdsArray){
			menuIdSet.add(menuid);
			String parentId = menuDao.getPid(menuid);
			while(!parentId.equals("0")){
				menuIdSet.add(parentId);
				parentId = menuDao.getPid(parentId);
			}			
		}
		return menuIdSet.toArray(new String[menuIdSet.size()]);
	}
}
