package com.rocksuny.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rocksuny.dao.ISyslogDao;
import com.rocksuny.model.Syslog;
import com.rocksuny.service.ISyslogService;
import com.rocksuny.service.base.BaseService;

@Service
public class SyslogService extends BaseService<Syslog, Integer> implements ISyslogService{

	@Autowired
	private ISyslogDao logDao;
	@Autowired
	public void setBaseDao(ISyslogDao logDao) {
		// TODO Auto-generated method stub
		super.setBaseDao(logDao);
	}
}
