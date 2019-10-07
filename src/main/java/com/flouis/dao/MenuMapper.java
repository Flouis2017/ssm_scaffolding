package com.flouis.dao;

import com.flouis.entity.Menu;
import com.flouis.vo.MenuVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MenuMapper {
    int deleteByPrimaryKey(Long id);

    int insertSelective(Menu record);

    Menu selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(Menu record);

	List<Menu> queryListByIdStr(@Param("menuIdStr") String menuIdStr);

	List<Menu> queryTopMenuList();

	List<Menu> queryAll();
}