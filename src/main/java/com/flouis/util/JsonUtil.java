package com.flouis.util;

import com.alibaba.fastjson.JSON;

/**
 * @date 20191012
 * @author Flouis
 * @description 基于FastJson的json通用工具类
 */
public class JsonUtil {

	/**
	 * @description 对象转json格式字符串
	 * @return String
	 */
	public static String toJsonString(Object obj){
		return JSON.toJSONString(obj);
	}

	/**
	 * @description json格式字符串转为泛型对象
	 * @param jsonStr
	 * @param beanClass
	 * @param <T>
	 * @return 泛型对象
	 */
	public static <T> T toBean(String jsonStr, Class<T> beanClass){
		return JSON.parseObject(jsonStr, beanClass);
	}

}
