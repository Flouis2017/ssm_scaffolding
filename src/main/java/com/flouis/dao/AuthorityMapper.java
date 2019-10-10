package com.flouis.dao;

import com.flouis.entity.Authority;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AuthorityMapper {

    int deleteByPrimaryKey(Long id);

    int insertSelective(Authority record);

    Authority selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(Authority record);

	String queryMenuIdStrByRoleId(@Param("roleId") Long roleId);

	int deleteByMenuId(@Param("menuId") Long menuId);

	List<Authority> queryListByRoleId(@Param("roleId") Long roleId);

	int deleteByRoleId(@Param("roleId") Long roleId);
}