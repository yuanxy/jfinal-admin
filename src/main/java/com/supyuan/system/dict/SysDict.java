package com.supyuan.system.dict;

import com.supyuan.component.base.BaseProjectModel;
import com.supyuan.jfinal.component.annotation.ModelBind;

@ModelBind(table = "sys_dict", key = "dict_id")
public class SysDict extends BaseProjectModel<SysDict> {

	private static final long serialVersionUID = 1L;
	public static final SysDict dao = new SysDict();

}
