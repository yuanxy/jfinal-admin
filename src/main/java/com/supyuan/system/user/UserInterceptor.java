package com.supyuan.system.user;

import com.jfinal.aop.Interceptor;
import com.jfinal.aop.Invocation;
import com.jfinal.core.Controller;
import com.jfinal.log.Log;
import com.supyuan.component.base.BaseProjectController;
import com.supyuan.component.util.JFlyFoxUtils;
import com.supyuan.jfinal.component.util.Attr;

import javax.servlet.http.HttpServletRequest;

/**
 * 用户认证拦截器
 * 
 * @author flyfox 2014-2-11
 */
public class UserInterceptor implements Interceptor {

	private static final Log log = Log.getLog(UserInterceptor.class);

	public void intercept(Invocation ai) {

		Controller controller = ai.getController();

		HttpServletRequest request = controller.getRequest();
		String referrer = request.getHeader("referer");
		String site = "http://" + request.getServerName();
		log.debug("####IP:" + request.getRemoteAddr() + "\t port:" + request.getRemotePort() + "\t 请求路径:"
				+ request.getRequestURI());
		if (referrer == null || !referrer.startsWith(site)) {
			log.warn("####非法的请求");
		}

		String tmpPath = ai.getActionKey();

		if (tmpPath.startsWith("/")) {
			tmpPath = tmpPath.substring(1, tmpPath.length());
		}
		if (tmpPath.endsWith("/")) {
			tmpPath = tmpPath.substring(0, tmpPath.length() - 1);
		}

		// 每次访问获取session，没有可以从cookie取~
		SysUser user = null;
		if (controller instanceof BaseProjectController) {
			user = (SysUser) ((BaseProjectController) controller).getSessionUser();
		} else {
			user = controller.getSessionAttr(Attr.SESSION_NAME);
		}

		//修复未登录情况时，直接前往某个路由报错问题
		if ((user == null || user.getUserid() <= 0) && (tmpPath.indexOf("/") > -1 || "home".equals(tmpPath))) {
			controller.redirect("/logout");
			return;
		}

		if (JFlyFoxUtils.isBack(tmpPath)) {
			if (user == null || user.getUserid() <= 0) {
				controller.redirect("/trans");
				return;
			}
		}
		ai.invoke();
	}
}
