package com.flouis.service;

import com.flouis.base.DatagridResult;
import com.flouis.base.JsonResult;
import com.flouis.dao.AuthorityMapper;
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

	@Autowired
	private AuthorityMapper authorityMapper;

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

	public JsonResult save(Menu menu) {
		try {
			if (menu.getId() == null){
				this.menuMapper.insertSelective(menu);
			} else {
				this.menuMapper.updateByPrimaryKeySelective(menu);
			}
			return JsonResult.success("操作成功");
		} catch (Exception e){
			e.printStackTrace();
			return JsonResult.fail("服务器异常，操作失败！");
		}
	}

	public JsonResult delete(Long id) {
		try {
			this.menuMapper.deleteByPrimaryKey(id);
			this.authorityMapper.deleteByMenuId(id);
			return JsonResult.success("操作成功");
		} catch (Exception e){
			e.printStackTrace();
			return JsonResult.fail("服务器异常，操作失败！");
		}
	}

	public List<Menu> getAll() {
		return this.menuMapper.queryAll();
	}
}
