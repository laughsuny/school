package com.rocksuny.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rocksuny.dao.ISysroleuserDao;
import com.rocksuny.model.Sysroleuser;
import com.rocksuny.service.ISysroleuserService;
import com.rocksuny.service.base.BaseService;

@Service
public class SysroleuserService extends BaseService<Sysroleuser, Integer> implements ISysroleuserService{

	@Autowired
	private ISysroleuserDao roleuserDao;
	
	@Autowired
	public void setBaseDao(ISysroleuserDao roleuserDao) {
		// TODO Auto-generated method stub
		super.setBaseDao(roleuserDao);
	}

	@Override
	public List<Sysroleuser> getAll(int userId) {
		// TODO Auto-generated method stub
		return roleuserDao.getAll(userId);
	}

	@Override
	public void deleteByUserId(int userId) {
		// TODO Auto-generated method stub
		roleuserDao.deleteByUserId(userId);
	}
}
