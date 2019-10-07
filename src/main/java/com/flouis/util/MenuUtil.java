package com.flouis.util;

import java.util.List;
import com.flouis.entity.Menu;
import com.google.common.collect.Lists;

/**
 * @description 菜单工具类
 * @author Flouis
 */
public class MenuUtil {
	/**
	 * @description 从给定的菜单中返回所有顶级菜单（模块权限）
	 */
	public static List<Menu> getTopMenuList(List<Menu> menuList){
		List<Menu> ret = Lists.newArrayList();
		for(Menu menu:menuList){
			if(menu.getParentId() == 0){
				ret.add(menu);
			}
		}
		return ret;
	}

	/**
	 * @description 获取所有的二级菜单（页面权限）
	 */
	public static List<Menu> getSecondMenuList(List<Menu> menuList, List<Menu> topMenuList){
		List<Menu> resList = Lists.newArrayList();
		for (Menu menu : menuList){
			for (Menu topMenu : topMenuList){
				if (menu.getParentId().equals(topMenu.getId())){
					resList.add(menu);
					break;
				}
			}
		}
		return resList;
	}

	/**
	 * @description 获取某个二级菜单下的按钮
	 */
	public static List<Menu> getThirdMenuList(List<Menu> menuList, Long secondMenuId){
		List<Menu> ret = Lists.newArrayList();
		for(Menu menu : menuList){
			if(menu.getParentId().equals(secondMenuId)){
				ret.add(menu);
			}
		}
		return ret;
	}

}
