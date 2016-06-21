package com.rocksuny.model;

import com.rocksuny.model.base.BaseEntity;

public class Sysbutton extends BaseEntity{
    /**
	 * 
	 */
	private static final long serialVersionUID = -7401172223088961735L;


    private String name;

    private Integer menuId;

    private String sec;


    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public Integer getMenuId() {
        return menuId;
    }

    public void setMenuId(Integer menuId) {
        this.menuId = menuId;
    }

    public String getSec() {
        return sec;
    }

    public void setSec(String sec) {
        this.sec = sec == null ? null : sec.trim();
    }
}