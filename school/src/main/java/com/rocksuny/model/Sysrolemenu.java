package com.rocksuny.model;

import com.rocksuny.model.base.BaseEntity;

public class Sysrolemenu extends BaseEntity{
    /**
	 * 
	 */
	private static final long serialVersionUID = -8448002141333930656L;

    private Integer roleId;

    private String menuId;


    public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }

	public String getMenuId() {
		return menuId;
	}

	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}

    
}