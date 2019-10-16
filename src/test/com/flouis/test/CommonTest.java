package com.flouis.test;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.flouis.util.HttpUtil;
import com.google.common.collect.Maps;
import org.apache.commons.codec.digest.DigestUtils;
import org.junit.Test;

import java.util.Map;

public class CommonTest {

	/*@Test
	public void test(){
		String str = "12,4,14,1,2,";
		String[] arr = str.split(",");
		System.out.println(arr.length);
		for (String x : arr){
			System.out.print(x + " ");
		}
	}*/

	/*@Test
	public void md5Test(){
		String str = "123456";
		System.out.println(DigestUtils.md5Hex(str)); // e10adc3949ba59abbe56e057f20f883e

		str = "430430";
		System.out.println(DigestUtils.md5Hex(str)); // 291ad281e640429285d30ff25b66813d
	}*/

	/*@Test
	public void httpUtilTest(){
		String reqUrl = "https://test.a1life.cn/user/getUserByMobile";
		Map argMap = Maps.newHashMap();
		argMap.put("phoneNum", "18760537263");
		JSONObject jsonRes = JSON.parseObject(HttpUtil.get(reqUrl, argMap));
		System.out.println("GET Result:\n" + jsonRes);

		jsonRes = JSON.parseObject(HttpUtil.post(reqUrl, argMap));
		System.out.println("POST Result:\n" + jsonRes);
	}*/

}
