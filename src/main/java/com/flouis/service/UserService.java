package com.flouis.service;

import com.flouis.base.DatagridResult;
import com.flouis.dao.UserMapper;
import com.flouis.vo.UserVo;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService {

	@Autowired
	private UserMapper userMapper;

	public DatagridResult pageList(UserVo vo) {
		Page page = PageHelper.startPage(vo.getPage(), vo.getRows());
		this.userMapper.queryList(vo);
		return DatagridResult.success(page.getResult(), page.getTotal());
	}

}
