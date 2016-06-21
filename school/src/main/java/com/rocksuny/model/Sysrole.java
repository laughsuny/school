package com.rocksuny.model;

import java.util.Date;

import com.rocksuny.model.base.BaseEntity;

public class Sysrole extends BaseEntity{
    /**
	 * 
	 */
	private static final long serialVersionUID = 3292122863802498948L;

	private String rolename;

    private String desctxt;

    private String buttons;

    private Integer status;

    private Date createTime;

    private Date updateTime;

    private Integer createUser;


    public String getRolename() {
        return rolename;
    }

    public void setRolename(String rolename) {
        this.rolename = rolename == null ? null : rolename.trim();
    }

    public String getDesctxt() {
        return desctxt;
    }

    public void setDesctxt(String desctxt) {
        this.desctxt = desctxt == null ? null : desctxt.trim();
    }

    public String getButtons() {
        return buttons;
    }

    public void setButtons(String buttons) {
        this.buttons = buttons == null ? null : buttons.trim();
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public Integer getCreateUser() {
        return createUser;
    }

    public void setCreateUser(Integer createUser) {
        this.createUser = createUser;
    }
}