package com.rocksuny.aspect;

import java.lang.reflect.Method;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.alibaba.fastjson.JSON;
import com.rocksuny.annotation.SystemControllerLog;
import com.rocksuny.annotation.SystemServiceLog;
import com.rocksuny.model.Syslog;
import com.rocksuny.model.Sysuser;
import com.rocksuny.service.ISyslogService;
import com.rocksuny.service.impl.SyslogService;

/**
 * 日志切点类
 * 
 * @author Administrator
 *
 */
@Aspect
@Component
public class SystemLogAspect {

	@Resource
	private ISyslogService syslogService;

	// 本地异常日志记录对象
	private static final Logger logger = LoggerFactory.getLogger(SystemLogAspect.class);

	// Service层切点
	@Pointcut("@annotation(com.rocksuny.annotation.SystemServiceLog)")
	public void serviceAspect() {
	}

	// Controller层切点
	@Pointcut("@annotation(com.rocksuny.annotation.SystemControllerLog)")
	public void controllerAspect() {
	}

	/**
	 * 前置通知 用于拦截Controller层记录用户的操作
	 * 
	 * @param joinPoint
	 *            切点
	 */
	@Before("controllerAspect()")
	public void doBefore(JoinPoint joinPoint) {

		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes())
				.getRequest();
		HttpSession session = request.getSession();
		// 读取session中的用户
		Sysuser user = (Sysuser) session.getAttribute("sysuser");
		// 请求的IP
		String ip = request.getRemoteAddr();
		try {
			// *========控制台输出=========*//
			System.out.println("=====前置通知开始=====");
			System.out.println("请求方法:"
					+ (joinPoint.getTarget().getClass().getName() + "." + joinPoint.getSignature().getName() + "()"));
			System.out.println("方法描述:" + getControllerMethodDescription(joinPoint));
			System.out.println("请求人:" + user.getAccount());
			System.out.println("请求IP:" + ip);
			// *========数据库日志=========*//

			Syslog log = new Syslog();
			log.setDescription(getControllerMethodDescription(joinPoint));
			log.setMethod(
					(joinPoint.getTarget().getClass().getName() + "." + joinPoint.getSignature().getName() + "()"));
			log.setType(0);
			log.setRequestIp(ip);
			log.setExceptionCode(null);
			log.setExceptionDetail(null);
			log.setParams(null);
			log.setCreateUser(user.getId());
			log.setCreateTime(new Date());
			// 保存数据库
			syslogService.save(log);
			System.out.println("=====前置通知结束=====");
		} catch (Exception e) {
			// 记录本地异常日志
			logger.error("==前置通知异常==");
			logger.error("异常信息:{}", e.getMessage());
		}
	}

	/**
	 * 异常通知 用于拦截service层记录异常日志
	 * 
	 * @param joinPoint
	 * @param e
	 */
	@AfterThrowing(pointcut = "serviceAspect()", throwing = "e")
	public void doAfterThrowing(JoinPoint joinPoint, Throwable e) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes())
				.getRequest();
		HttpSession session = request.getSession();
		// 读取session中的用户
		Sysuser user = (Sysuser) session.getAttribute("sysuser");
		// 获取请求ip
		String ip = request.getRemoteAddr();
		// 获取用户请求方法的参数并序列化为JSON格式字符串
		// 获取用户请求方法的参数并序列化为JSON格式字符串
        StringBuffer params = new StringBuffer();
        if (joinPoint.getArgs() != null && joinPoint.getArgs().length > 0) {
            params.append("[");
            for (int i = 0; i < joinPoint.getArgs().length; i++) {
                params.append(joinPoint.getArgs()[i]);
                params.append(",");
            }
            params.deleteCharAt(params.length()-1);
            params.append("]");
        }
		try {
			/* ========控制台输出========= */
			System.out.println("=====异常通知开始=====");
			System.out.println("异常代码:" + e.getClass().getName());
			System.out.println("异常信息:" + e.getMessage());
			System.out.println("异常方法:"
					+ (joinPoint.getTarget().getClass().getName() + "." + joinPoint.getSignature().getName() + "()"));
			System.out.println("方法描述:" + getServiceMthodDescription(joinPoint));
			System.out.println("请求人:" + user.getAccount());
			System.out.println("请求IP:" + ip);
			System.out.println("请求参数:" + params);
			/* ==========数据库日志========= */
			Syslog log = new Syslog();
			System.out.println("代码执行到这里了");
			log.setDescription(getServiceMthodDescription(joinPoint));
			log.setExceptionCode(e.getClass().getName());
			log.setType(1);
			log.setExceptionDetail(e.getMessage());
			log.setMethod(
					(joinPoint.getTarget().getClass().getName() + "." + joinPoint.getSignature().getName() + "()"));
			log.setParams(params!=null?params.toString():null);
			log.setCreateUser(user.getId());
			log.setCreateTime(new Date());
			log.setRequestIp(ip);
			// 保存数据库
			syslogService.save(log);
			System.out.println("=====异常通知结束=====");
		} catch (Exception ex) {
			// 记录本地异常日志
			logger.error("==异常通知异常==");
			logger.error("异常信息:{}", ex.getMessage());
		}
		/* ==========记录本地异常日志========== */
		logger.error("异常方法:{}异常代码:{}异常信息:{}参数:{}",
				joinPoint.getTarget().getClass().getName() + joinPoint.getSignature().getName(), e.getClass().getName(),
				e.getMessage(), params);

	}

	/**
	 * 获取注解中对方法的描述信息 用于service层注解
	 * 
	 * @param joinPoint
	 *            切点
	 * @return 方法描述
	 * @throws Exception
	 */
	public static String getServiceMthodDescription(JoinPoint joinPoint) throws Exception {
		String targetName = joinPoint.getTarget().getClass().getName();
		String methodName = joinPoint.getSignature().getName();
		Object[] arguments = joinPoint.getArgs();
		Class targetClass = Class.forName(targetName);
		Method[] methods = targetClass.getMethods();
		String description = "";
		for (Method method : methods) {
			if (method.getName().equals(methodName)) {
				Class[] clazzs = method.getParameterTypes();
				if (clazzs.length == arguments.length) {
					description = method.getAnnotation(SystemServiceLog.class).description();
					break;
				}
			}
		}
		return description;
	}

	/**
	 * 获取注解中对方法的描述信息 用于Controller层注解
	 * 
	 * @param joinPoint
	 *            切点
	 * @return 方法描述
	 * @throws Exception
	 */
	public static String getControllerMethodDescription(JoinPoint joinPoint) throws Exception {
		String targetName = joinPoint.getTarget().getClass().getName();
		String methodName = joinPoint.getSignature().getName();
		Object[] arguments = joinPoint.getArgs();
		Class<?> targetClass = Class.forName(targetName);
		Method[] methods = targetClass.getMethods();
		String description = "";
		for (Method method : methods) {
			if (method.getName().equals(methodName)) {
				Class[] clazzs = method.getParameterTypes();
				if (clazzs.length == arguments.length) {
					description = method.getAnnotation(SystemControllerLog.class).description();
					break;
				}
			}
		}
		return description;
	}

}
