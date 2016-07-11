package com.rocksuny.service;

import java.util.List;

import com.rocksuny.model.Sysroleuser;
import com.rocksuny.service.base.IBaseService;

public interface ISysroleuserService extends IBaseService<Sysroleuser, Integer>{
	/**
	 * 查询用户角色中间表
	 * @param userId 用户id
	 * @return
	 */
	public List<Sysroleuser> getAll(int userId);
	/**
	 * 根据用户id删除用户角色中间表
	 * @param userId 用户id
	 */
	public void deleteByUserId(int userId);
}
