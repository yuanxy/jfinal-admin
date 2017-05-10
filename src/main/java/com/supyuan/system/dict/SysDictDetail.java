package com.supyuan.system.dict;

import com.supyuan.component.base.BaseProjectModel;
import com.supyuan.jfinal.component.annotation.ModelBind;

@ModelBind(table = "sys_dict_detail", key = "detail_id")
public class SysDictDetail extends BaseProjectModel<SysDictDetail> {

	private static final long serialVersionUID = 1L;
	public static final SysDictDetail dao = new SysDictDetail();

}
