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

	public JsonResult uploadAvatar(HttpServletRequest request, MultipartFile avatar) {
		try {
			if (avatar == null){
				return JsonResult.fail("无法上传空文件！");
			}
			if (avatar.getSize() > 1024*1024*1024){
				return JsonResult.fail("文件大小不能超过10M！");
			}
			// 获取文件后缀
			String ofn = avatar.getOriginalFilename();
			String suffix = ofn.substring(ofn.lastIndexOf(".") + 1);
			// 排除不是jpg/jpeg/gif/png格式的图片文件
			if (!"jpg/jpeg/gif/png".toUpperCase().contains(suffix.toUpperCase())){
				return JsonResult.fail("请选择jpg/jpeg/gif/png格式的图片上传！");
			}
			String savePath = request.getServletContext().getRealPath("/") + "/static/upload/avatar/";
			String staticSavePath = ResourceBundle.getBundle("config/dev").getString("savePath");
			File dir = new File(savePath);
			if (!dir.exists()){
				dir.mkdirs();
			}
			File staticDir = new File(staticSavePath);
			if (!staticDir.exists()){
				staticDir.mkdirs();
			}
			String filename = new Date().getTime() + "." + suffix;
			// 将图片文件写入指定目录
			avatar.transferTo(new File(savePath + filename));
			avatar.transferTo(new File(staticSavePath + filename));
			return JsonResult.success("上传成功！", filename);
		} catch (Exception e){
			e.printStackTrace();
			return JsonResult.fail("服务器异常，上传失败！");
		}
	}

	public JsonResult save(User user) {
		try {
			user.setPassword(DigestUtils.md5Hex(user.getPassword()));
			if (user.getId() == null){
				this.userMapper.insertSelective(user);
			} else {
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
