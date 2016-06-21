package com.rocksuny.model.base;

import java.io.Serializable;

/**
 * 实体基础类
 * 
 *
 */
public abstract class BaseEntity implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5874746964189166516L;

	
	/**
	 * id主键
	 */
	private Integer id;


	public Integer getId() {
		return id;
	}


	public void setId(Integer id) {
		this.id = id;
	}
	
	
	
	
}
