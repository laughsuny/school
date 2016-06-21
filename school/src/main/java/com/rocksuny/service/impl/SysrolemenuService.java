package com.rocksuny.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rocksuny.dao.ISysrolemenuDao;
import com.rocksuny.model.Sysrolemenu;
import com.rocksuny.service.ISysrolemenuService;
import com.rocksuny.service.base.BaseService;

@Service
public class SysrolemenuService extends BaseService<Sysrolemenu, Integer> implements ISysrolemenuService{

	@Autowired
	private ISysrolemenuDao rolemenuDao;
	
	@Autowired
	public void setBaseDao(ISysrolemenuDao rolemenuDao) {
		// TODO Auto-generated method stub
		super.setBaseDao(rolemenuDao);
	}
	@Override
	public List<Sysrolemenu> getListByRoleId(int roleId) {
		// TODO Auto-generated method stub
		return rolemenuDao.getListByRoleId(roleId);
	}
	@Override
	public void deleteByRoleId(int roleId) {
		// TODO Auto-generated method stub
		rolemenuDao.deleteByRoleId(roleId);
	}
	@Override
	public void deleteBatchByRoleId(String ids) {
		// TODO Auto-generated method stub
		rolemenuDao.deleteBatchByRoleId(ids);
	}
	
	
	
	
	
	
}
