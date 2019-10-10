package com.flouis.controller;

import com.flouis.base.DatagridResult;
import com.flouis.base.JsonResult;
import com.flouis.entity.Role;
import com.flouis.service.RoleService;
import com.flouis.vo.RoleVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/role")
public class RoleController {

	@Autowired
	private RoleService roleService;

	@RequestMapping("/index")
	public String index(){
		return "/role/index";
	}

	/**
	 * @description 获取角色列表-分页
	 */
	@RequestMapping("/list")
	@ResponseBody
	public DatagridResult pageList(RoleVo vo){
		return this.roleService.pageList(vo);
	}

	/**
	 * @description 根据角色id获取权限
	 * @param roleId
	 * @return
	 */
	@RequestMapping("/getRoleAuthorityList")
	@ResponseBody
	public JsonResult getRoleAuthorityList(Long roleId){
		return this.roleService.getRoleAuthorityList(roleId);
	}

	/**
	 * @description 保存权限
	 * @param ids
	 * @param roleId
	 */
	@RequestMapping("/saveAuthority")
	@ResponseBody
	public JsonResult saveAuthority(String ids, Long roleId){
		return this.roleService.saveAuthority(ids, roleId);
	}

	/**
	 * @description 保存角色（添加/编辑）
	 */
	@RequestMapping("/save")
	@ResponseBody
	public JsonResult save(Role role){
		return this.roleService.save(role);
	}

	/**
	 * @description 删除角色
	 * @param id 角色id
	 */
	@RequestMapping("/delete")
	@ResponseBody
	public JsonResult delete(Long id){
		return this.roleService.delete(id);
	}

}
