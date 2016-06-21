package com.rocksuny.bean;

import java.util.List;

import com.rocksuny.constant.ConfigHolder;

/**
 * 分页页面数据Bean
 * 
 * @author suny
 *
 * @param <T>
 *            数据类型
 */
public class PageBean<T> {

	/**
	 * 当前页
	 */
	private Integer page = 1;

	/**
	 * 每页最大数据条数
	 */
	private Integer pagesize = Integer.parseInt(ConfigHolder.get(
			ConfigHolder.DEFAULT_PAGE_SIZE, "10"));

	/**
	 * 数据总条数
	 */
	private Integer rowTotal;

	/**
	 * 页面总数
	 */
	private Integer pageTotal;

	/**
	 * 当前页数据
	 */
	private List<T> data;

	public Integer getpage() {
		return page;
	}

	public void setpage(Integer page) {
		this.page = page;
	}

	public Integer getpagesize() {
		return pagesize;
	}

	public void setpagesize(Integer pagesize) {
		this.pagesize = pagesize;
	}

	public Integer getRowTotal() {
		return rowTotal;
	}

	public void setRowTotal(Integer rowTotal) {
		this.rowTotal = rowTotal;
	}

	public Integer getPageTotal() {
		return pageTotal;
	}

	public void setPageTotal(Integer pageTotal) {
		this.pageTotal = pageTotal;
	}

	public List<T> getData() {
		return data;
	}

	public void setData(List<T> data) {
		this.data = data;
	}

}