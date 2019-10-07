package com.flouis.dao;

import com.flouis.entity.Authority;
import org.apache.ibatis.annotations.Param;

public interface AuthorityMapper {

    int deleteByPrimaryKey(Long id);

    int insertSelective(Authority record);

    Authority selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(Authority record);

	String queryMenuIdStrByRoleId(@Param("roleId") Long roleId);
}