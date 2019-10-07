package com.flouis.util;

import org.apache.commons.lang3.StringUtils;

public class StringUtil {

	public static String getString(String str){
		return StringUtils.isBlank(str) ? null : str;
	}

}
