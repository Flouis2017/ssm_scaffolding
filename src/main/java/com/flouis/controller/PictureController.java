package com.flouis.controller;

import com.flouis.base.JsonResult;
import com.flouis.service.PictureService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/picture")
public class PictureController {

	@Autowired
	private PictureService pictureService;

	@RequestMapping("/show")
	public void show(HttpServletResponse response, String filename){
		try {
			this.pictureService.showPicture(response, filename);
		} catch (Exception e){
			e.printStackTrace();
		}
	}

	@RequestMapping("/upload")
	@ResponseBody
	public JsonResult upload(MultipartFile avatar){
		return this.pictureService.uploadPicture(avatar);
	}

}
