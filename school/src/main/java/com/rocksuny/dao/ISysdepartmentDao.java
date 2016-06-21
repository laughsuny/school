package com.rocksuny.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.rocksuny.dao.base.IBaseDao;
import com.rocksuny.model.Sysdepartment;

@Repository
public interface ISysdepartmentDao extends IBaseDao<Sysdepartment, Integer>{
	/**
	 * 查询所有部门
	 * @return
	 */
	public List<Sysdepartment> getDepts();
}