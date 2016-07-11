package com.rocksuny.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.rocksuny.dao.base.IBaseDao;
import com.rocksuny.model.Sysroleuser;

@Repository
public interface ISysroleuserDao extends IBaseDao<Sysroleuser, Integer>{
	/**
	 * 查询用户角色中间表
	 * @param userId 用户id
	 * @return
	 */
	public List<Sysroleuser> getAll(@Param("userId")int userId);
	
	/**
	 * 根据用户id删除用户角色中间表
	 * @param userId 用户id
	 */
	public void deleteByUserId(@Param("userId")int userId);
}