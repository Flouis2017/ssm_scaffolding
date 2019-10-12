package com.flouis.controller;

import com.flouis.base.DatagridResult;
import com.flouis.base.JsonResult;
import com.flouis.entity.Role;
import com.flouis.entity.User;
import com.flouis.service.PictureService;
import com.flouis.service.RoleService;
import com.flouis.service.UserService;
import com.flouis.vo.UserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	private UserService userService;

	@Autowired
	private RoleService roleService;

	@Autowired
	private PictureService pictureService;

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

	/**
	 * @description 上传头像
	 * @param avatar
	 */
	@RequestMapping("/uploadAvatar")
	@ResponseBody
	public JsonResult uploadAvatar(MultipartFile avatar){
		return this.pictureService.uploadPicture(avatar);
	}

	/**
	 * @description 保存用户（添加/编辑数据库落地）
	 * @param user
	 */
	@RequestMapping("/save")
	@ResponseBody
	public JsonResult save(User user){
		return this.userService.save(user);
	}

	/**
	 * @description 删除用户
	 * @param id
	 */
	@RequestMapping("/delete")
	@ResponseBody
	public JsonResult delete(Long id){
		return this.userService.delete(id);
	}

}
