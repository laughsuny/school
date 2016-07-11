package com.test.app;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.transaction.Transactional;

import org.apache.log4j.Logger;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.rocksuny.model.Syslog;
import com.rocksuny.model.Sysrolemenu;
import com.rocksuny.model.Sysuser;
import com.rocksuny.service.ISyslogService;
import com.rocksuny.service.ISysrolemenuService;
import com.rocksuny.service.ISysuserService;

@RunWith(SpringJUnit4ClassRunner.class)     //表示继承了SpringJUnit4ClassRunner类  
@ContextConfiguration(locations = {"classpath:spring-mybatis.xml"}) 
public class TestMybatis {

	private static Logger log = Logger.getLogger(TestMybatis.class);
	
	@Autowired
	private ISysuserService sysuserService;
	
	@Autowired
	private ISysrolemenuService sysrolemenuService;
	
	@Autowired
	private ISyslogService syslogService;
	
	/*@Test
	public void testSave(){
		Sysuser user = new Sysuser();
		user.setAccount("suny");
		user.setUsername("张旭333");
		user.setCreateTime(new Date());
		log.info(new Date());
		sysuserService.save(user);
	}*/
	
/*	@Test
	public void testSave(){
		Syslog log = new Syslog();
		log.setCreateTime(new Date());
		log.setDescription("junit测试");
		syslogService.save(log);
	}*/
	
	
	
	/**
	 * 测试角色菜单中间表的批量插入
	 */
	@Test
	public void testInsertBatch(){
		List<Sysrolemenu> list = new ArrayList<Sysrolemenu>();
		for(int i=0 ; i < 5 ; i ++){
			Sysrolemenu rolemenu = new Sysrolemenu();
			rolemenu.setMenuId(i+"");
			rolemenu.setRoleId(i+1);
			list.add(rolemenu);
		}
		sysrolemenuService.insertBatch(list);
		
		Sysuser user = new Sysuser();
		user.setAccount("suny");
		user.setUsername("张旭333");
		user.setCreateTime(new Date());
		log.info(new Date());
		sysuserService.save(user);
		
		
		
	}
	
}
