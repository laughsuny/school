package com.rocksuny.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.rocksuny.dao.base.IBaseDao;
import com.rocksuny.model.Sysrole;

@Repository
public interface ISysroleDao extends IBaseDao<Sysrole, Integer>{
	/**
	 * 查询所有角色
	 */
	public List<Sysrole> getList();
}