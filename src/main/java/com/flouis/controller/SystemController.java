package com.flouis.controller;

import com.flouis.base.JsonResult;
import com.flouis.entity.Menu;
import com.flouis.service.SystemService;
import com.flouis.util.CpachaUtil;
import com.flouis.util.MenuUtil;
import com.flouis.vo.LoginVo;
import com.google.common.collect.Lists;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/system")
public class SystemController {

	@Autowired
	private SystemService systemService;

	@RequestMapping("/welcome")
	public String welcome(){
		return "/system/welcome";
	}

	@RequestMapping("/login")
	public String login(){
		return "/system/login";
	}

	@RequestMapping("/doLogin")
	@ResponseBody
	public JsonResult doLogin(HttpServletRequest request, LoginVo vo){
		return this.systemService.doLogin(request, vo);
	}

	@RequestMapping("/home")
	public String home(HttpServletRequest request){
		List<Menu> userMenus = (List<Menu>) request.getSession().getAttribute("userMenus");
		List<Menu> topMenuList = MenuUtil.getTopMenuList(userMenus);
		List<Menu> secondMenuList = MenuUtil.getSecondMenuList(userMenus, topMenuList);
		request.setAttribute("topMenuList", topMenuList);
		request.setAttribute("secondMenuList", secondMenuList);
		return "/system/home";
	}

	@RequestMapping("/logout")
	public String logout(HttpServletRequest request){
		request.getSession().invalidate();
		return "/system/login";
	}

	/**
	 * @description 验证码生成
	 * @param vcodeLen
	 * @param width
	 * @param height
	 * @param cpachaType 用来区别验证码的类型，传入字符串
	 * @param request
	 * @param response
	 */
	@RequestMapping("/getCpacha")
	public void getCpacha(
			@RequestParam(name="vl",required=false,defaultValue="4") Integer vcodeLen,
			@RequestParam(name="w",required=false,defaultValue="120") Integer width,
			@RequestParam(name="h",required=false,defaultValue="40") Integer height,
			@RequestParam(name="type",defaultValue="loginCpacha") String cpachaType,
			HttpServletRequest request, HttpServletResponse response){
		CpachaUtil cpachaUtil = new CpachaUtil(vcodeLen, width, height);
		String generatorVCode = cpachaUtil.generatorVCode();
		request.getSession().setAttribute(cpachaType, generatorVCode);
		BufferedImage generatorRotateVCodeImage = cpachaUtil.generatorRotateVCodeImage(generatorVCode, true);
		try {
			ImageIO.write(generatorRotateVCodeImage, "gif", response.getOutputStream());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@RequestMapping(value = "/modifyPwd", method = RequestMethod.GET)
	public String modifyPwd(){
		return "/system/modifyPwd";
	}

	@RequestMapping(value = "/modifyPwd", method = RequestMethod.POST)
	@ResponseBody
	public JsonResult modifyPwd(Long userId, String newPwd){
		return this.systemService.modifyPwd(userId, newPwd);
	}

	/**
	 * @description 获取系统所有图标资源
	 */
	@RequestMapping("/getIcons")
	@ResponseBody
	public JsonResult getIcons(HttpServletRequest request){
		return this.systemService.getIcons(request);
	}

}
