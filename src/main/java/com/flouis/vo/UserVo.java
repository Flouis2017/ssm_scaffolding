package com.flouis.vo;

import com.flouis.util.StringUtil;

public class UserVo extends PageVo{

	private String username;
	private Integer gender;
	private Long roleId;

	public String getUsername() {
		return StringUtil.getString(this.username);
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public Integer getGender() {
		return gender;
	}

	public void setGender(Integer gender) {
		this.gender = gender;
	}

	public Long getRoleId() {
		return roleId;
	}

	public void setRoleId(Long roleId) {
		this.roleId = roleId;
	}
}
