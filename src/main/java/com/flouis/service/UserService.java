package com.flouis.service;

import com.flouis.base.DatagridResult;
import com.flouis.base.JsonResult;
import com.flouis.dao.UserMapper;
import com.flouis.entity.User;
import com.flouis.vo.UserVo;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.Date;
import java.util.ResourceBundle;

@Service
public class UserService {

	@Autowired
	private UserMapper userMapper;

	public DatagridResult pageList(UserVo vo) {
		Page page = PageHelper.startPage(vo.getPage(), vo.getRows());
		this.userMapper.queryList(vo);
		return DatagridResult.success(page.getResult(), page.getTotal());
	}

	public JsonResult save(User user) {
		try {
			User dbUser = this.userMapper.queryByUsername(user.getUsername());
			if (user.getId() == null){
				// 添加之前的重复校验——校验username是否存在
				if (dbUser != null){
					return JsonResult.fail("用户名已被占用！");
				}
				user.setPassword(DigestUtils.md5Hex(user.getPassword()));
				this.userMapper.insertSelective(user);
			} else {
				// 修改之前的重复校验——校验username是否已经被其他用户使用
				if (dbUser != null && !dbUser.getId().equals(user.getId())){
					return JsonResult.fail("用户名已被占用！");
				}
				this.userMapper.updateByPrimaryKeySelective(user);
			}
			return JsonResult.success("操作成功");
		} catch (Exception e){
			e.printStackTrace();
			return JsonResult.fail("服务器异常，操作失败！");
		}
	}

	public JsonResult delete(Long id) {
		try {
			// 删除用户记录
			this.userMapper.deleteByPrimaryKey(id);
			return JsonResult.success("操作成功");
		} catch (Exception e){
			e.printStackTrace();
			return JsonResult.fail("服务器异常，操作失败！");
		}
	}

}
