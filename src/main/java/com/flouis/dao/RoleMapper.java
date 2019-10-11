package com.flouis.dao;

import com.flouis.entity.Role;
import com.flouis.vo.RoleVo;

import java.util.List;

public interface RoleMapper {
    int deleteByPrimaryKey(Long id);

    int insertSelective(Role record);

    Role selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(Role record);

	List<Role> queryList(RoleVo vo);

	List<Role> queryAll();
}