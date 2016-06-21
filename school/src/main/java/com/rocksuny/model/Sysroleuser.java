package com.rocksuny.model;

import com.rocksuny.model.base.BaseEntity;

public class Sysroleuser extends BaseEntity{
    /**
	 * 
	 */
	private static final long serialVersionUID = 3542358622521724175L;

	private Integer userId;

    private Integer roleId;


    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }
}