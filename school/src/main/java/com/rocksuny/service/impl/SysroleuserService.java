package com.rocksuny.service.impl;

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
}
