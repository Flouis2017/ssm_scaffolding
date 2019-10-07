package com.flouis.interceptor;

import com.flouis.entity.Menu;
import com.flouis.util.MenuUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

public class LoginInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
							 Object handler) throws Exception {
		Object adminUser = request.getSession().getAttribute("adminUser");
		// 未登录或登录失败
		if (adminUser == null){
			response.sendRedirect("/system/login");
			return false;
		}
		// 获取当前页面三级菜单（按钮）权限
		String secondMenuId = request.getParameter("_secondMenuId");
		if (StringUtils.isNoneEmpty(secondMenuId)){
			List<Menu> thirdMenuList = MenuUtil.getThirdMenuList((List<Menu>) request.getSession().getAttribute("userMenus"), Long.valueOf(secondMenuId));
			request.setAttribute("thirdMenuList", thirdMenuList);
		}
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response,
						   Object handler, ModelAndView modelAndView) throws Exception {}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response,
								Object handler, Exception ex) throws Exception {}

}
