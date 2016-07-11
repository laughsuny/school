package com.rocksuny.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.rocksuny.bean.PageBean;
import com.rocksuny.dao.ISysroleDao;
import com.rocksuny.model.Sysrole;
import com.rocksuny.model.Sysrolemenu;
import com.rocksuny.service.ISysmenuService;
import com.rocksuny.service.ISysroleService;
import com.rocksuny.service.ISysrolemenuService;
import com.rocksuny.service.base.BaseService;

@Service
public class SysroleService extends BaseService<Sysrole, Integer> implements ISysroleService{

	@Autowired
	private ISysroleDao roleDao;
	@Autowired
	private ISysrolemenuService sysrolemenuService;
	@Autowired
	private ISysmenuService sysmenuService;
	@Autowired
	public void setBaseDao(ISysroleDao baseDao) {
		// TODO Auto-generated method stub
		super.setBaseDao(baseDao);
	}

	@Override
	public PageBean<Sysrole> queryByPage(String searchStr, PageBean<Sysrole> pageBean) {
		// TODO Auto-generated method stub
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("searchStr", searchStr);
		return findByPage(param, pageBean.getpage(), pageBean.getpagesize(), null);
	}

	@Override
	public void save(Sysrole role, String menuIds) {
		// TODO Auto-generated method stub
		super.save(role);
		if(!StringUtils.isEmpty(menuIds)){
			String[] menuIdsArray = menuIds.split(",");
			int roleId = role.getId();
			if(menuIdsArray != null && menuIdsArray.length >0){
				menuIdsArray = sysmenuService.queryByIdArray(menuIdsArray);
				List<Sysrolemenu> list = new ArrayList<Sysrolemenu>();
				for(String menuId : menuIdsArray){
					Sysrolemenu roleMenu = new Sysrolemenu();
					roleMenu.setRoleId(roleId);
					roleMenu.setMenuId(menuId);
					list.add(roleMenu);
				}
				sysrolemenuService.insertBatch(list);
			}
		}
	}

	@Override
	public void update(Sysrole role, String menuIds) {
		int roleId = role.getId();
		//删除角色-菜单
		sysrolemenuService.deleteByRoleId(roleId);
		if(!StringUtils.isEmpty(menuIds)){
			String[] menuIdsArray = menuIds.split(",");
			menuIdsArray = sysmenuService.queryByIdArray(menuIdsArray);
			if(menuIdsArray != null && menuIdsArray.length >0){
				List<Sysrolemenu> list = new ArrayList<Sysrolemenu>();
				for(String menuId : menuIdsArray){
					Sysrolemenu roleMenu = new Sysrolemenu();
					roleMenu.setRoleId(roleId);
					roleMenu.setMenuId(menuId);
					list.add(roleMenu);
				}
				sysrolemenuService.insertBatch(list);
			}
		}
	}

	@Override
	public void deleteBatch(String ids) {
		// TODO Auto-generated method stub
		super.deleteBatch(ids);
		sysrolemenuService.deleteBatchByRoleId(ids);
	}

	@Override
	public void delete(int id) {
		// TODO Auto-generated method stub
		super.delete(id);
		sysrolemenuService.deleteByRoleId(id);
	}

	@Override
	public List<Sysrole> getList() {
		// TODO Auto-generated method stub
		return roleDao.getList();
	}
	
	
}
