package com.flouis.service;

import com.flouis.base.DatagridResult;
import com.flouis.base.JsonResult;
import com.flouis.dao.AuthorityMapper;
import com.flouis.dao.RoleMapper;
import com.flouis.dao.UserMapper;
import com.flouis.entity.Authority;
import com.flouis.entity.Role;
import com.flouis.entity.User;
import com.flouis.vo.RoleVo;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RoleService {

	@Autowired
	private RoleMapper roleMapper;

	@Autowired
	private AuthorityMapper authorityMapper;

	@Autowired
	private UserMapper userMapper;

	public DatagridResult pageList(RoleVo vo) {
		Page page = PageHelper.startPage(vo.getPage(), vo.getRows());
		this.roleMapper.queryList(vo);
		return DatagridResult.success(page.getResult(), page.getTotal());
	}

	public JsonResult getRoleAuthorityList(Long roleId) {
		List<Authority> list = this.authorityMapper.queryListByRoleId(roleId);
		return JsonResult.success(list);
	}

	public JsonResult saveAuthority(String ids, Long roleId) {
		try {
			if (StringUtils.isBlank(ids) || roleId == null){
				return JsonResult.fail("参数错误！");
			}
			String[] menuIdArr = ids.split(",");
			if (menuIdArr.length > 0){
				// 先删除当前角色所有权限
				this.authorityMapper.deleteByRoleId(roleId);

				// 遍历插入权限
				for (String menuId : menuIdArr){
					Authority newOne = new Authority();
					newOne.setMenuId(Long.valueOf(menuId));
					newOne.setRoleId(roleId);
					this.authorityMapper.insertSelective(newOne);
				}
			}
			return JsonResult.success("操作成功");
		} catch(Exception e){
			e.printStackTrace();
			return JsonResult.fail("服务器异常，操作失败！");
		}
	}

	public JsonResult save(Role role) {
		try {
			if (role.getId() == null){
				this.roleMapper.insertSelective(role);
			} else {
				this.roleMapper.updateByPrimaryKeySelective(role);
			}
			return JsonResult.success("操作成功");
		} catch (Exception e){
			e.printStackTrace();
			return JsonResult.fail("服务器异常，操作失败！");
		}
	}

	public JsonResult delete(Long id) {
		try {
			// 首先查询角色是否还有绑定的用户，如果有则不允许删除，提示前端将用户改绑角色
			List<User> userList = this.userMapper.queryListByRoleId(id);
			if (userList != null && userList.size() > 0){
				String tip = "无法删除！请先将该角色下的用户改绑：";
				for (User user : userList){
					tip += user.getUsername() + "(id:" + user.getId() + ") ";
				}
				return JsonResult.fail(tip);
			}
			// 如果没有绑定任何用户，可以直接删除该角色和该角色绑定的权限
			this.roleMapper.deleteByPrimaryKey(id);
			this.authorityMapper.deleteByRoleId(id);
			return JsonResult.success("操作成功");
		} catch (Exception e){
			e.printStackTrace();
			return JsonResult.fail("服务器异常，删除失败！");
		}
	}

	public List<Role> queryAll() {
		return this.roleMapper.queryAll();
	}
}
