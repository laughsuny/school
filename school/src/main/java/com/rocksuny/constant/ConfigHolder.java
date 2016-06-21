package com.rocksuny.constant;

import java.io.IOException;
import java.util.Properties;

import org.apache.log4j.Logger;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.support.PropertiesLoaderUtils;


/**
 * 系统配置。config.properties文件中的配置持有类
 * 
 * @author suny
 *
 */
public class ConfigHolder {
	
	/**
	 * 默认分页页容量
	 */
	public static final String DEFAULT_PAGE_SIZE = "default.pageSize";

	private static final Logger LOG = Logger.getLogger(ConfigHolder.class);

	/**
	 * 配置
	 */
	private static Properties properties = null;

	static {
		try {
			properties = PropertiesLoaderUtils
					.loadProperties(new ClassPathResource("config.properties"));
		} catch (IOException e) {
			LOG.error("load config from config.properties error." + e);
		}
	}

	/**
	 * 获取配置文件中指定配置项的值。
	 * 
	 * @param key
	 *            需要获取的配置项。
	 * @return 返回配置文件中参数key对应的配置项的值。如果参数key对应的配置项不存在，返回null
	 */
	public static String get(String key) {
		return properties.getProperty(key);
	}

	/**
	 * 获取配置文件中指定配置项的值。
	 * 
	 * @param key
	 *            需要获取的配置项
	 * @param defaultValue
	 *            默认值
	 * @return 返回配置文件中参数key对应的配置项的值。如果参数key对应的配置项不存在，返回defaultValue
	 */
	public static String get(String key, String defaultValue) {
		return properties.getProperty(key, defaultValue);
	}
}