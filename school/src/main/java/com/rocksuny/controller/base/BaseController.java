package com.rocksuny.controller.base;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.ModelAttribute;

import com.rocksuny.model.Sysuser;

public class BaseController {

	
	public static final String SUCCESS = "success";
	public static final String ERROR = "error";
	
	/**
	 * 当前请求的request对象
	 */
	protected HttpServletRequest request;
	/**
	 * 当前请求的response对象
	 */
    protected HttpServletResponse response;
	/**
	 * 当前请求的session对象
	 */
    protected HttpSession session;
	/**
	 * ajax请求返回json对象
	 */
	protected Map<String, Object> json=new HashMap<String, Object>();
	
	
	@ModelAttribute 
    protected void setReqAndRes(HttpServletRequest request, HttpServletResponse response){ 
        this.request = request; 
        this.response = response; 
        this.session = request.getSession();
        
        //模拟已经登陆
        /*Sysuser user = new Sysuser();
        user.setUsername("系统管理员");
        user.setId(1);
        this.session.setAttribute("sysuser", user);*/
    }
	
	
}
