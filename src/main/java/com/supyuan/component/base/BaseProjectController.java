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
package com.supyuan.component.base;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.supyuan.component.util.JFlyFoxUtils;
import com.supyuan.jfinal.base.BaseController;
import com.supyuan.jfinal.base.SessionUser;
import com.supyuan.jfinal.component.util.Attr;
import com.supyuan.system.log.SysLog;
import com.supyuan.system.menu.SysMenu;
import com.supyuan.system.user.SysUser;
import com.supyuan.system.user.UserSvc;
import com.supyuan.util.NumberUtils;
import com.supyuan.util.StrUtils;
import com.supyuan.util.cache.Cache;
import com.supyuan.util.cache.CacheManager;

import java.util.List;
import java.util.Map;

/**
 * 项目BaseControler
 * 
 * @author flyfox
 * @date 2015-08-02
 * 
 */
public abstract class BaseProjectController extends BaseController {

	public void renderAuto(String view) {
		String path = getAutoPath(view);

		super.render(path);
	}

	public void redirectAuto(String view) {
		String path = getAutoPath(view);

		super.redirect(path);
	}

	protected String getAutoPath(String view) {
		String path = view;

		if (!view.startsWith("/")) {
			path = "/" + path;
		}


		if (view.startsWith("/")) {
			path = "/" + path;
		}

		path = path.replace("//", "/");
		return path;
	}

	/**
	 * 方法重写
	 * 
	 * 2015年8月2日 下午3:17:29 flyfox 369191470@qq.com
	 * 
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public SessionUser getSessionUser() {
		SysUser sysUser = getSessionAttr(Attr.SESSION_NAME);
		try {
			// 如果session没有，cookie有~那么就设置到Session
			if (sysUser == null) {
				String cookieContent = getCookie(Attr.SESSION_NAME);
				if (cookieContent != null) {
					String key = JFlyFoxUtils.cookieDecrypt(cookieContent);
					if (StrUtils.isNotEmpty(key) && key.split(",").length == 2) {
						int userid = NumberUtils.parseInt(key.split(",")[0]);
						String password = key.split(",")[1];
						sysUser = SysUser.dao.findFirstByWhere(" where userid = ? and password = ? ", userid, password);
						if (sysUser != null)
							setSessionUser(sysUser);
					}
				}
			}
		} catch (Exception e) {
			// 异常cookie重新登陆
			removeSessionAttr(Attr.SESSION_NAME);
			removeCookie(Attr.SESSION_NAME);

			log.error("cooke user异常:", e);
			return null;
		}
		return sysUser;
	}

	/**
	 * 方法重写
	 * 
	 * 2015年8月2日 下午3:17:29 flyfox 369191470@qq.com
	 * 
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public SessionUser setSessionUser(SessionUser user) {
		setSessionAttr(Attr.SESSION_NAME, user);
		// 设置cookie，用id+password作为
		SysUser sysUser = (SysUser) user;
		String key = sysUser.getUserID() + "," + user.getStr("password");
		String cookieContent = JFlyFoxUtils.cookieEncrypt(key);
		setCookie(Attr.SESSION_NAME, cookieContent, 7 * 24 * 60 * 60);
		// 如果是管理员 设置菜单权限
		if (user.getInt("usertype") == 1 || user.getInt("usertype") == 2) {
			Map<Integer, List<SysMenu>> map = new UserSvc().getAuthMap(sysUser);
			// 注入菜单
			setSessionAttr("menu", map);
			// 不能访问的菜单
			setSessionAttr("nomenu", new UserSvc().getNoAuthMap(map));

		}
		return user;
	}

	/**
	 * 方法重写
	 * 
	 * 2015年8月2日 下午3:17:29 flyfox 369191470@qq.com
	 * 
	 * @return
	 */
	public void removeSessionUser() {
		removeSessionAttr(Attr.SESSION_NAME);
		// 删除cookie
		removeCookie(Attr.SESSION_NAME);
	}

	/**
	 * 用户登录，登出记录
	 * 
	 * 2015年10月16日 下午2:36:39 flyfox 369191470@qq.com
	 * 
	 * @param user
	 * @param operType
	 */
	protected void saveLog(SysUser user, String operType) {
		try {
			String tableName = user.getTable().getName();
			Integer updateId = user.getInt("update_id");
			String updateTime = user.getStr("update_time");
			String sql = "INSERT INTO `sys_log` ( `log_type`, `oper_object`, `oper_table`," //
					+ " `oper_id`, `oper_type`, `oper_remark`, `create_time`, `create_id`) " //
					+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
			Db.update(sql, SysLog.TYPE_SYSTEM, SysLog.getTableRemark(tableName), tableName, //
					updateId, operType, "", updateTime, updateId);
		} catch (Exception e) {
			log.error("添加日志失败", e);
		}
	}


	Cache cache = CacheManager.get("JFLYFOX_SESSION");

	public Controller setSessionAttrCache(String key, Object value) {
		String id = getSession().getId();
		cache.add(key + "_" + id, value);
		return this;
	}

	public <T> T getSessionAttrCache(String key) {
		String id = getSession().getId();
		return cache.get(key + "_" + id);
	}

	public Controller removeSessionAttrCache(String key) {
		String id = getSession().getId();
		cache.remove(key + "_" + id);
		return this;
	}

	/**
	 * 是否是管理员
	 * 
	 * 2017年1月21日 下午11:55:16 flyfox 369191470@qq.com
	 * 
	 * @param user
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public boolean isAdmin(SessionUser user) {
		return user.getInt("usertype") == 1;
	}

}
