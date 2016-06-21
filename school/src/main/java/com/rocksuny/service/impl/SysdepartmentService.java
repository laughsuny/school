package com.rocksuny.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rocksuny.bean.PageBean;
import com.rocksuny.dao.ISysdepartmentDao;
import com.rocksuny.model.Sysdepartment;
import com.rocksuny.service.ISysdepartmentService;
import com.rocksuny.service.ISysuserService;
import com.rocksuny.service.base.BaseService;

@Service
public class SysdepartmentService extends BaseService<Sysdepartment, Integer> implements ISysdepartmentService{
	@Autowired
	private ISysdepartmentDao sysdepartmentDao;
	@Autowired
	private ISysuserService sysuserService;
	@Autowired
	public void setBaseDao(ISysdepartmentDao sysdepartmentDao) {
		// TODO Auto-generated method stub
		super.setBaseDao(sysdepartmentDao);
	}
	@Override
	public PageBean<Sysdepartment> queryByPage(String name, PageBean<Sysdepartment> pageBean) {
		// TODO Auto-generated method stub
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("name", name);
		return findByPage(param, pageBean.getpage(), pageBean.getpagesize(), null);
	}
	@Override
	public List<Sysdepartment> getDepts() {
		// TODO Auto-generated method stub
		return sysdepartmentDao.getDepts();
	}
	@Override
	public void delete(int id) {
		// TODO Auto-generated method stub
		super.delete(id);//删除部门
		sysuserService.deleteByDeptId(id);//根据部门id删除用户
		
	}
	@Override
	public void deleteBatch(String ids) {
		// TODO Auto-generated method stub
		super.deleteBatch(ids);
		sysuserService.deleteBatchByDeptId(ids);//根据部门id字符串批量删除用户
	}
}
