package com.flouis.controller;

import com.flouis.base.DatagridResult;
import com.flouis.entity.Role;
import com.flouis.service.RoleService;
import com.flouis.service.UserService;
import com.flouis.vo.UserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	private UserService userService;

	@Autowired
	private RoleService roleService;

	/**
	 * @description 跳转用户管理页
	 * @param request
	 */
	@RequestMapping("/index")
	public String index(HttpServletRequest request){
		// 查询所有角色
		List<Role> roleList = this.roleService.queryAll();
		request.setAttribute("roleList", roleList);
		return "/user/index";
	}

	/**
	 * @description 获取用户列表-分页
	 * @param vo
	 */
	@RequestMapping("/list")
	@ResponseBody
	public DatagridResult pageList(UserVo vo){
		return this.userService.pageList(vo);
	}

}
