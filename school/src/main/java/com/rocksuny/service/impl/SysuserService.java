package com.rocksuny.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.rocksuny.bean.PageBean;
import com.rocksuny.dao.ISysuserDao;
import com.rocksuny.model.Sysroleuser;
import com.rocksuny.model.Sysuser;
import com.rocksuny.service.ISysroleuserService;
import com.rocksuny.service.ISysuserService;
import com.rocksuny.service.base.BaseService;
import com.rocksuny.util.Encrypter;

@Service
public class SysuserService extends BaseService<Sysuser, Integer> implements ISysuserService{

	@Autowired
	private ISysuserDao userDao;
	@Autowired
	private ISysroleuserService sysroleuserService;
	@Autowired
	public void setBaseDao(ISysuserDao userDao) {
		// TODO Auto-generated method stub
		super.setBaseDao(userDao);
	}
	@Override
	public List<Sysuser> getList() {
		// TODO Auto-generated method stub
		return userDao.getList();
	}
	@Override
	public void deleteByDeptId(int id) {
		// TODO Auto-generated method stub
		userDao.deleteByDeptId(id);
	}
	@Override
	public void deleteBatchByDeptId(String ids) {
		// TODO Auto-generated method stub
		userDao.deleteBatchByDeptId(ids);
	}
	@Override
	public PageBean<Sysuser> queryByPage(String userType, String username, String account, String deptId,
			PageBean<Sysuser> pageBean) {
		// TODO Auto-generated method stub
		Map<String,Object> param = new HashMap<String, Object>();
		username = StringUtils.isEmpty(username)?null:username;
		account = StringUtils.isEmpty(account)?null:account;
		param.put("username", username);
		param.put("account", account);
		param.put("userType", userType);
		param.put("deptId", deptId);
		return this.findByPage(param, pageBean.getpage(), pageBean.getpagesize(), null);
	}
	@Override
	public void save(Sysuser user, String roleIds) {
		// TODO Auto-generated method stub
		String pwd = Encrypter.md5Encrypt(user.getPassword());
		pwd = pwd.substring(8, 24);
		user.setPassword(pwd);
		super.save(user);
		//添加用户角色
		if(!StringUtils.isEmpty(roleIds)){
			String[] roles = roleIds.split(",");
			if(roles.length>0){
				for (String str : roles) {
					Sysroleuser roleUser = new Sysroleuser();
					roleUser.setRoleId(Integer.parseInt(str));
					roleUser.setUserId(user.getId());
					sysroleuserService.save(roleUser);
				}
			}
		}
	}
	
	
	
	
}
