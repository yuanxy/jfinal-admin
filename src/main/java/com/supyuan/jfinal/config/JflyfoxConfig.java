/**
 * Copyright 2015-2025 FLY的狐狸(email:jflyfox@sina.com qq:369191470).
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * 
 */

package com.supyuan.jfinal.config;

import com.jfinal.config.*;
import com.jfinal.ext.handler.ContextPathHandler;
import com.jfinal.ext.interceptor.SessionInViewInterceptor;
import com.jfinal.log.Log4jLogFactory;
import com.jfinal.plugin.activerecord.ActiveRecordPlugin;
import com.jfinal.plugin.activerecord.CaseInsensitiveContainerFactory;
import com.jfinal.plugin.activerecord.dialect.MysqlDialect;
import com.jfinal.plugin.activerecord.dialect.OracleDialect;
import com.jfinal.plugin.activerecord.dialect.PostgreSqlDialect;
import com.jfinal.plugin.druid.DruidPlugin;
import com.jfinal.render.ViewType;
import com.jfinal.template.Engine;
import com.supyuan.jfinal.component.annotation.AutoBindModels;
import com.supyuan.jfinal.component.annotation.AutoBindRoutes;
import com.supyuan.jfinal.component.handler.BasePathHandler;
import com.supyuan.jfinal.component.handler.CurrentPathHandler;
import com.supyuan.jfinal.component.interceptor.ExceptionInterceptor;
import com.supyuan.jfinal.component.interceptor.JflyfoxInterceptor;
import com.supyuan.jfinal.component.interceptor.SessionAttrInterceptor;
import com.supyuan.util.Config;
import com.supyuan.util.cache.Cache;
import com.supyuan.util.cache.CacheManager;
import com.supyuan.util.cache.ICacheManager;
import com.supyuan.util.cache.RedisCache;
import com.supyuan.util.cache.impl.MemoryCache;
import com.supyuan.util.cache.impl.MemorySerializeCache;
import com.supyuan.util.serializable.FSTSerializer;
import com.supyuan.util.serializable.SerializerManage;

/**
 * API引导式配置
 */
public class JflyfoxConfig extends JFinalConfig {

	private static final String CONFIG_WEB_ROOT = "{webroot}";

	/**
	 * 配置常量
	 */
	public void configConstant(Constants me) {
		me.setDevMode(isDevMode());
		me.setViewType(ViewType.JSP); // 设置视图类型为Jsp，否则默认为FreeMarker
		me.setLogFactory(new Log4jLogFactory());
		System.out.println(">>" + Config.getStr("PAGES.404"));
		me.setError401View(Config.getStr("PAGES.401"));
		me.setError403View(Config.getStr("PAGES.403"));
		me.setError404View(Config.getStr("PAGES.404"));
		me.setError500View(Config.getStr("PAGES.500"));
	}

	/**
	 * 配置路由
	 */
	public void configRoute(Routes me) {
		me.setBaseViewPath("/pages");
		// 自动绑定
		// 1.如果没用加入注解，必须以Controller结尾,自动截取前半部分为key
		// 2.加入ControllerBind的 获取 key
		me.add(new AutoBindRoutes());
	}

	/**
	 * 配置插件
	 */
	public void configPlugin(Plugins me) {
		// 配置C3p0数据库连接池插件
		/*C3p0Plugin c3p0Plugin = null;

		String db_type = Config.getStr("db_type") + ".";

		String webRoot = PathKit.getWebRootPath();
		String DBPath = webRoot + "\\WEB-INF\\";
		DBPath = StrUtils.replace(DBPath, "\\", "/");
		String jdbcUrl = Config.getStr(db_type + "jdbcUrl");
		if (db_type.startsWith("sqlite")) {
			jdbcUrl = StrUtils.replaceOnce(jdbcUrl, CONFIG_WEB_ROOT, DBPath);
		}

		c3p0Plugin = new C3p0Plugin( //
				jdbcUrl, Config.getStr(db_type + "user"), //
				Config.getStr(db_type + "password").trim(), //
				Config.getStr(db_type + "driverClass"));

		me.add(c3p0Plugin);

		// 配置ActiveRecord插件
		ActiveRecordPlugin arp = new ActiveRecordPlugin(c3p0Plugin);
		me.add(arp);
		if (isDevMode()) {
			arp.setShowSql(true);
		}

		// 数据库类型
		if (db_type.startsWith("postgre")) {
			arp.setDialect(new PostgreSqlDialect());
		} else if (db_type.startsWith("sqlite")) {
			arp.setDialect(new Sqlite3Dialect());
		} else if (db_type.startsWith("oracle")) {
			arp.setDialect(new OracleDialect());
			arp.setContainerFactory(new CaseInsensitiveContainerFactory(true));
		}

		new AutoBindModels(arp);*/

		String db_type = Config.getStr("db_type") + ".";
		String jdbcUrl = Config.getStr(db_type + "jdbcUrl");
		String user = Config.getStr(db_type + "user");
		String password = Config.getStr(db_type + "password");
		String driverClass = Config.getStr(db_type + "driverClass");

		// 配置数据库连接池插件
		DruidPlugin druidPlugin = new DruidPlugin(jdbcUrl, user, password, driverClass);
		druidPlugin.setInitialSize(5);
		druidPlugin.setMinIdle(5);
		druidPlugin.setMaxActive(20);
		druidPlugin.setMaxWait(60000);
		druidPlugin.setTimeBetweenEvictionRunsMillis(60000);
		druidPlugin.setValidationQuery("SELECT 'x'");
		druidPlugin.setTestWhileIdle(true);
		druidPlugin.setTestOnBorrow(false);
		druidPlugin.setTestOnReturn(false);
		druidPlugin.setMaxPoolPreparedStatementPerConnectionSize(20);
		druidPlugin.setFilters("wall,stat");

		me.add(druidPlugin);
		// 配置ActiveRecord插件
		ActiveRecordPlugin arp = new ActiveRecordPlugin(druidPlugin);
		me.add(arp);
		if (isDevMode()) {
			arp.setShowSql(true);
		}

		// 数据库类型
		if (db_type.startsWith("postgre")) {
			arp.setDialect(new PostgreSqlDialect());
		} else if (db_type.startsWith("oracle")) {
			arp.setDialect(new OracleDialect());
			arp.setContainerFactory(new CaseInsensitiveContainerFactory(true));
		}else if (db_type.startsWith("mysql")) {
			arp.setDialect(new MysqlDialect());
		}

		new AutoBindModels(arp);
	}

	/**
	 * 配置全局拦截器
	 */
	public void configInterceptor(Interceptors me) {
		// 异常拦截器，跳转到500页面
		me.add(new ExceptionInterceptor());
		// session model转换
		me.add(new SessionInViewInterceptor());
		// 设置session属性
		me.add(new SessionAttrInterceptor());
		// 公共拦截器
		me.add(new JflyfoxInterceptor());
		
	}

	/**
	 * 配置处理器
	 */
	public void configHandler(Handlers me) {
		System.out.println("##" + Config.getStr("PATH.BASE_PATH"));
		// 全路径获取
		me.add(new BasePathHandler(Config.getStr("PATH.BASE_PATH")));
		// 根目录获取
		me.add(new ContextPathHandler(Config.getStr("PATH.CONTEXT_PATH")));
		// 当前获取
		me.add(new CurrentPathHandler(Config.getStr("PATH.CURRENT_PATH")));
	}

	/**
	 * 配置模板
	 */
	public void configEngine(Engine engine) {
		
	}
	
	private boolean isDevMode() {
		return Config.getToBoolean("CONSTANTS.DEV_MODE");
	}
	@Override
	public void afterJFinalStart() {
		super.afterJFinalStart();

		// 初始化Cache为fst序列化
		SerializerManage.add("fst", new FSTSerializer());

		// 设置序列化工具
		SerializerManage.setDefaultKey("java");

		// 设置缓存
		CacheManager.setCache(new ICacheManager() {

			public Cache getCache () {
				String cacheName = "MemorySerializeCache";

				if ("MemorySerializeCache".equals(cacheName)) {
					return new MemorySerializeCache();
				} else if ("MemoryCache".equals(cacheName)) {
					return new MemoryCache();
				} else if ("RedisCache".equals(cacheName)) {
					return new RedisCache();
				} else {
					throw new RuntimeException("####init cache error!");
				}
			}
		});

	}
	/*@Override
	public void afterJFinalStart() {
		super.afterJFinalStart();

		// 初始化Cache为fst序列化
		SerializerManage.add("fst", new FSTSerializer());
		
		// 设置序列化工具
		String defaultKey = Config.getStr("CACHE.SERIALIZER.DEFAULT");
		defaultKey = StrUtils.isEmpty(defaultKey) ? "java" : defaultKey;
		SerializerManage.setDefaultKey(defaultKey);

		
		// 设置缓存
		CacheManager.setCache(new ICacheManager() {

			public Cache getCache() {
				String cacheName = Config.getStr("CACHE.NAME");
				cacheName = StrUtils.isEmpty(cacheName) ? "MemorySerializeCache" : cacheName; 
				
				if ("MemorySerializeCache".equals(cacheName)) {
					return new MemorySerializeCache();
				} else if ("MemoryCache".equals(cacheName)) {
					return new MemoryCache();
				}  else if ("RedisCache".equals(cacheName)) {
					return new RedisCache();
				} else {
					throw new RuntimeException("####init cache error!");
				}
			}
		});
		
	}*/

	@Override
	public void beforeJFinalStop() {
		super.beforeJFinalStop();
	}

}
