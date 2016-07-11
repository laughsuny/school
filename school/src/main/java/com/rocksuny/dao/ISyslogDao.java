package com.rocksuny.dao;

import org.springframework.stereotype.Repository;

import com.rocksuny.dao.base.IBaseDao;
import com.rocksuny.model.Syslog;

@Repository
public interface ISyslogDao extends IBaseDao<Syslog,Integer>{
	/**
	 * 保存日志
	 * @param log
	 */
	public void log(Syslog log);
}