package com.flouis.vo;

import com.flouis.util.StringUtil;

public class MenuVo extends PageVo {

	private String name;

	public String getName() {
		return StringUtil.getString(this.name);
	}

	public void setName(String name) {
		this.name = name;
	}
}
