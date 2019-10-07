package com.flouis.service;

import com.flouis.base.JsonResult;
import com.flouis.dao.AuthorityMapper;
import com.flouis.dao.MenuMapper;
import com.flouis.dao.RoleMapper;
import com.flouis.dao.UserMapper;
import com.flouis.entity.Menu;
import com.flouis.entity.Role;
import com.flouis.entity.User;
import com.flouis.vo.LoginVo;
import com.google.common.collect.Lists;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.List;

@Service
public class SystemService {

	@Autowired
	private UserMapper userMapper;

	@Autowired
	private RoleMapper roleMapper;

	@Autowired
	private AuthorityMapper authorityMapper;

	@Autowired
	private MenuMapper menuMapper;

	public JsonResult doLogin(HttpServletRequest request, LoginVo vo) {
		// 校验验证码
		String cpacha = vo.getCpacha();
		if (!cpacha.equalsIgnoreCase(String.valueOf(request.getSession().getAttribute("loginCpacha")))){
			return JsonResult.fail("验证码出错！");
		}
		// 根据用户名查询用户
		User adminUser = this.userMapper.queryByUsername(vo.getUsername());
		if (adminUser == null){
			return JsonResult.fail("用户名不存在！");
		}
		if (!adminUser.getPassword().equals(DigestUtils.md5Hex(vo.getPassword()))){
			return JsonResult.fail("密码不正确！");
		}
		// 查询用户角色
		Role role = this.roleMapper.selectByPrimaryKey(adminUser.getRoleId());

		// 根据用户角色查询菜单id字符串（一级二级菜单）
		String menuIdStr = this.authorityMapper.queryMenuIdStrByRoleId(role.getId());
		List<Menu> menuList = this.menuMapper.queryListByIdStr(menuIdStr);

		// 将用户信息存入session
		HttpSession session = request.getSession();
		session.setAttribute("adminUser", adminUser);
		session.setAttribute("role", role);
		session.setAttribute("userMenus", menuList);
		return JsonResult.success("登录成功");
	}

	public JsonResult modifyPwd(Long userId, String newPwd) {
		try {
			if (StringUtils.isEmpty(newPwd)){
				return JsonResult.fail("新密码不可为空！");
			}
			User up = new User();
			up.setId(userId);
			up.setPassword(DigestUtils.md5Hex(newPwd));
			this.userMapper.updateByPrimaryKeySelective(up);
			return JsonResult.success("修改密码成功！");
		} catch (Exception e){
			e.printStackTrace();
			return JsonResult.fail("服务器异常，修改密码失败！");
		}
	}

	public JsonResult getIcons(HttpServletRequest request) {
		String realPath = request.getServletContext().getRealPath("/");
		File dir = new File(realPath + "/static/css/icons");
		List<String> icons = Lists.newArrayList();
		if (!dir.exists()){
			return JsonResult.fail("文件目录不存在！");
		}
		File[] fileArr = dir.listFiles();
		for (File f : fileArr){
			if (f != null && f.getName().contains(".png")){
				icons.add("icon-" + f.getName().substring(0, f.getName().indexOf(".")).replace("_", "-"));
			}
		}
		return JsonResult.success(icons);
	}
}
