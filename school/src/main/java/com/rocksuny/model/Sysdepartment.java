package com.rocksuny.model;

import java.util.Date;

import com.rocksuny.model.base.BaseEntity;

public class Sysdepartment extends BaseEntity{

    /**
	 * 
	 */
	private static final long serialVersionUID = 7977513327757482527L;

	private String name;

    private String remark;

    private Date createTime;

    private Integer status;

    private Integer createUser;
    
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getCreateUser() {
        return createUser;
    }

    public void setCreateUser(Integer createUser) {
        this.createUser = createUser;
    }
}