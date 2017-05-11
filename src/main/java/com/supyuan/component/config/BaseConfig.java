package com.supyuan.component.config;

import com.beetl.functions.BeetlStrUtils;
import com.jfinal.config.Handlers;
import com.jfinal.config.Interceptors;
import com.jfinal.config.Plugins;
import com.jfinal.plugin.activerecord.SqlReporter;
import com.supyuan.component.beelt.BeeltFunctions;
import com.supyuan.component.interceptor.CommonInterceptor;
import com.supyuan.component.interceptor.UserKeyInterceptor;
import com.supyuan.component.plugin.spring.IocInterceptor;
import com.supyuan.component.plugin.spring.SpringPlugin;
import com.supyuan.component.util.JFlyFoxCache;
import com.supyuan.jfinal.component.handler.HtmlHandler;
import com.supyuan.jfinal.config.JflyfoxConfig;
import com.supyuan.system.user.UserInterceptor;
import org.beetl.core.GroupTemplate;
import org.beetl.ext.jfinal3.JFinal3BeetlRenderFactory;

/**
 * API引导式配置
 */
public class BaseConfig extends JflyfoxConfig {

	public void configConstant(com.jfinal.config.Constants me) {
		super.configConstant(me);
		// 开启日志
		SqlReporter.setLog(true);

		JFinal3BeetlRenderFactory rf = new JFinal3BeetlRenderFactory();
		rf.config();
		me.setRenderFactory(rf);

		// 获取GroupTemplate ,可以设置共享变量等操作
		GroupTemplate groupTemplate = rf.groupTemplate;
		groupTemplate.registerFunctionPackage("strutil", BeetlStrUtils.class);
		groupTemplate.registerFunctionPackage("flyfox", BeeltFunctions.class);

	};

	@Override
	public void configHandler(Handlers me) {
		// Beelt
		// me.add(new BeeltHandler());
		// me.add(new ImageHandler());

		me.add(new HtmlHandler());
		super.configHandler(me);
	}

	/**
	 * 配置全局拦截器
	 */
	public void configInterceptor(Interceptors me) {
		super.configInterceptor(me);
		//Spring拦截
		me.add(new IocInterceptor());
		// 用户Key设置
		me.add(new UserKeyInterceptor());
		// 用户认证
		me.add(new UserInterceptor());
		// 公共属性
		me.add(new CommonInterceptor());
	}

	@Override
	public void configPlugin(Plugins me) {
		//Spring插件
		me.add(new SpringPlugin("classpath*:spring/applicationContext.xml"));
		super.configPlugin(me);
	}

	/**
	 * 初始化
	 */
	@Override
	public void afterJFinalStart() {
		super.afterJFinalStart();

		JFlyFoxCache.init();
		System.out.println("##################################");
		System.out.println("############系统启动完成##########");
		System.out.println("##################################");
	}

	@Override
	public void beforeJFinalStop() {
		super.beforeJFinalStop();

		// 关闭模板
		//BeetlRenderFactory.groupTemplate.close();

		System.out.println("##################################");
		System.out.println("############系统停止完成##########");
		System.out.println("##################################");
	}
}
