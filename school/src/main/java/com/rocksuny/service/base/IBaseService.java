package com.rocksuny.service.base;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

public interface IBaseService <T, PK extends Serializable>{

	/**
	 * 保存
	 * @param t 实体类型
	 */
	public void save(T t);
	/**
	 * 更新
	 * @param t 实体类型
	 */
	public void update(T t);
	/**
	 * 根据主键删除
	 * @param pk 主键id
	 */
	public void delete(PK pk);
	/**
	 * 根据主键id查询
	 * @param pk 主键id 
	 * @return 满足查询条件的实体
	 */
	public T findById(PK pk);
	/**
	 * 根据查询条件查询满足条件的实体集合
	 * @param params 参数集合
	 * @return  满足条件的实体集合
	 */
	public List<T> find(Map<String, Object> params);
	/**
	 * 批量插入数据
	 * @param list
	 */
	public void insertBatch(List<T> list);
	
	/**
	 * 批量删除
	 * @param ids id字符串，逗号分隔
	 */
	public void deleteBatch(String ids);
	
	
	/**
	 * 根据查询条件查询满足条件的实体数目
	 * @param params 参数集合
	 * @return  满足条件的实体数目
	 */
	public int count(Map<String, Object> params);
	
	
	
	
}
