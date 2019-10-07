package com.flouis.service;

import com.flouis.base.DatagridResult;
import com.flouis.dao.MenuMapper;
import com.flouis.entity.Menu;
import com.google.common.collect.Lists;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MenuService {

	@Autowired
	private MenuMapper menuMapper;

	public List<Menu> queryTopMenuList() {
		return this.menuMapper.queryTopMenuList();
	}

	public DatagridResult list() {
		List<Menu> list = this.menuMapper.queryAll();
		if (list == null){
			list = Lists.newArrayList();
		}
		return DatagridResult.success(list, (long) list.size());
	}

}
