package com.flouis.dao;

import com.flouis.entity.Log;

public interface LogMapper {

    int deleteByPrimaryKey(Long id);

    int insertSelective(Log record);

    Log selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(Log record);

}