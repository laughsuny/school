package com.rocksuny.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.rocksuny.model.Sysuser;
import com.rocksuny.util.LoginFiled;

public class LoginInterceptor implements HandlerInterceptor {

	private static final String[] IGNORE_URI = { "/admin/login.do", "/admin/checkLogin.do" };

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// TODO Auto-generated method stub

		boolean flag = false;
		String url = request.getRequestURL().toString();
		for (String s : IGNORE_URI) {
			if (url.contains(s)) {
				flag = true;
				break;
			}
		}
		if (!flag) {
			Sysuser user = (Sysuser) request.getSession().getAttribute("sysuser");
			if (user != null) {
				LoginFiled.sysuser = user;
				flag = true;
			} else {
				response.setCharacterEncoding("UTF-8");
				response.getWriter().write(
						"<script type='text/javascript'>window.parent.location.href='/admin/login.do';</script>");
				flag = false;
			}
		}

		return flag;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub

	}

}
