package com.flouis.service;

import com.flouis.base.JsonResult;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.util.Date;
import java.util.ResourceBundle;

@Service
public class PictureService {

	private String saveDirPath = ResourceBundle.getBundle("config/dev").getString("avatarDirPath");

	public void showPicture(HttpServletResponse response, String filename) throws Exception{
		ServletOutputStream out = null;
		FileInputStream fis = null;
		try {
			fis = new FileInputStream(saveDirPath + filename);
			out = response.getOutputStream();
			// 将文件流写回前端
			int len;
			byte[] buffer = new byte[10240];
			while ((len = fis.read(buffer)) != -1){
				out.write(buffer, 0, len);
			}
			out.flush();
		} catch (Exception e){
			e.printStackTrace();
			out.flush();
			out.close();
			fis.close();
		} finally {
			out.close();
			fis.close();
		}
	}

	public JsonResult uploadPicture(MultipartFile avatar){
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
			File saveDir = new File(saveDirPath);
			if (!saveDir.exists()){
				saveDir.mkdirs();
			}
			String filename = new Date().getTime() + "." + suffix;
			// 将图片文件写入指定目录
			avatar.transferTo(new File(saveDirPath + filename));
			return JsonResult.success("上传成功！", filename);
		} catch (Exception e){
			e.printStackTrace();
			return JsonResult.fail("服务器异常，上传失败！");
		}
	}

}
