package com.flouis.dao;

import com.flouis.entity.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserMapper {
    int deleteByPrimaryKey(Long id);

    int insertSelective(User record);

    User selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(User record);

	User queryByUsername(@Param("username") String username);

	List<User> queryListByRoleId(@Param("roleId") Long roleId);
}