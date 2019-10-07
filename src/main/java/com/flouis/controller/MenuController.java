package com.flouis.controller;

import com.flouis.base.DatagridResult;
import com.flouis.base.JsonResult;
import com.flouis.entity.Menu;
import com.flouis.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/menu")
public class MenuController {

	@Autowired
	private MenuService menuService;

	/**
	 * @description 菜单管理页
	 */
	@RequestMapping("/index")
	public String index(HttpServletRequest request){
		List<Menu> topMenuList = this.menuService.queryTopMenuList();
		request.setAttribute("topMenuList", topMenuList);
		return "/menu/index";
	}

	/**
	 * @description 分页获取菜单列表
	 */
	@RequestMapping("/list")
	@ResponseBody
	public DatagridResult list(){
		return this.menuService.list();
	}

	/**
	 * @description 保存菜单（新增/编辑）todo
	 */
	@RequestMapping("/save")
	@ResponseBody
	public JsonResult save(Menu menu){
		System.out.println(menu);
		return JsonResult.fail("Unknown Error!");
	}

	/**
	 * @description 删除菜单 todo
	 */
	@RequestMapping("/delete")
	@ResponseBody
	public JsonResult delete(Long id){
		System.out.println("The id of menu need to delete is " + id);
		return JsonResult.fail("Unknown Error!");
	}


}
