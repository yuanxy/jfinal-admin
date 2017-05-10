package com.supyuan.system.rolemenu;

import com.supyuan.component.base.BaseProjectModel;
import com.supyuan.jfinal.component.annotation.ModelBind;

@ModelBind(table = "sys_role_menu")
public class SysRoleMenu extends BaseProjectModel<SysRoleMenu> {

	private static final long serialVersionUID = 1L;
	public static final SysRoleMenu dao = new SysRoleMenu();

}
