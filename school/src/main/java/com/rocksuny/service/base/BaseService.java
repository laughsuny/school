package com.rocksuny.service.base;

import java.io.Serializable;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.transaction.Transactional;

import org.springframework.util.StringUtils;

import com.rocksuny.bean.PageBean;
import com.rocksuny.dao.base.IBaseDao;


public class BaseService<T,PK extends Serializable> implements IBaseService<T, PK> {

	private IBaseDao<T,PK> baseDao;
	
	protected static final int DEFAULT_PAGE_NO = 1;
	
	protected static final int DEFAULT_PAGE_SIZE = 10;
	
	
	public void setBaseDao(IBaseDao<T, PK> baseDao) {
		// TODO Auto-generated method stub
		this.baseDao = baseDao;
	}
	@Override
	public void save(T t) {
		// TODO Auto-generated method stub
		baseDao.save(t);
	}
	@Override
	public void update(T t) {
		// TODO Auto-generated method stub
		baseDao.update(t);
	}
	@Override
	public void delete(PK pk) {
		// TODO Auto-generated method stub
		baseDao.delete(pk);
	}

	@Override
	public T findById(PK pk) {
		// TODO Auto-generated method stub
		return baseDao.findById(pk);
	}

	@Override
	public List<T> find(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return baseDao.find(params);
	}
	@Override
	public void insertBatch(List<T> list) {
		// TODO Auto-generated method stub
		baseDao.insertBatch(list);
	}
	@Override
	public void deleteBatch(String ids) {
		// TODO Auto-generated method stub
		baseDao.deleteBatch(ids);
	}

	@Override
	public int count(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return baseDao.count(params);
	}

	/**
	 * 
	 * @param paramMap 参数map
	 * @param pageNo 当前页码
	 * @param pageSize 每页条目 
	 * @param orderSql 排序规则
	 * @return
	 */
	protected PageBean<T> findByPage(Map<String, Object> paramMap, int pageNo, int pageSize, String orderSql) {
		PageBean<T> resultBean = new PageBean<T>();
		Map<String, Object> params = new LinkedHashMap<String, Object>();
		
		// 参数校验
		if (pageNo < 1) {
			pageNo = DEFAULT_PAGE_NO;
		}
		if (pageSize < 0) {
			pageSize = DEFAULT_PAGE_SIZE;
		}
		
		params.putAll(paramMap);
		
		// 查询总记录条数，计算分页
		int total = baseDao.count(params);
		int pageTotal = (int) Math.ceil(((double)total)/pageSize);
		// 查询数据
		if (total > 0) {
			if (pageNo < 1) {
				pageNo = 1;
			}
			if (pageTotal < pageNo) {
				pageNo = pageTotal;
			}
			params.put("start", (pageNo-1) * pageSize);
			params.put("count", pageSize);
			if (!StringUtils.isEmpty(orderSql)) {
				params.put("orderSql", orderSql);
			}
			List<T> data = baseDao.find(params);
			resultBean.setData(data);
		}
		// 设置查询结果
		resultBean.setpage(pageNo);
		resultBean.setpagesize(pageSize);
		resultBean.setPageTotal(pageTotal);
		resultBean.setRowTotal(total);
		return resultBean;
	}

	

	
	

}
