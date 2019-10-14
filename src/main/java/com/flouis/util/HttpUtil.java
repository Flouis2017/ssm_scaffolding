package com.flouis.util;

import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Map;
import java.util.Map.Entry;

/**
 * @date 20191014
 * @author Flouis
 * @description Http请求通用工具类
 */
public class HttpUtil {

	/**
	 * @description get请求
	 * @param url	请求地址
	 * @param param 参数集
	 * @return json格式字符串
	 */
	public static String get(String url, Map<String, Object> param) {
		StringBuilder builder = new StringBuilder();
		try {
			StringBuilder params = new StringBuilder();
			for (Entry<String, Object> entry : param.entrySet()) {
				params.append(entry.getKey());
				params.append("=");
				params.append(entry.getValue().toString());
				params.append("&");
			}
			if (params.length() > 0) {
				params.deleteCharAt(params.lastIndexOf("&"));
			}
			URL restServiceURL = new URL(url + (params.length() > 0 ? "?" + params.toString() : ""));
			HttpURLConnection httpConnection = (HttpURLConnection) restServiceURL.openConnection();
			httpConnection.setRequestMethod("GET");
			httpConnection.setRequestProperty("Accept", "application/json");
			if (httpConnection.getResponseCode() != 200) {
				throw new RuntimeException("HTTP GET Request Failed with Error code : "
						+ httpConnection.getResponseCode());
			}
			InputStream inStrm = httpConnection.getInputStream();
			byte[] b = new byte[1024];
			int length;
			while ((length = inStrm.read(b)) != -1) {
				builder.append(new String(b, 0, length));
			}
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return builder.toString();
	}

	/**
	 * @description post请求
	 * @param url	请求地址
	 * @param param	参数集
	 * @return json格式字符串
	 */
	public static String post(String url, Map<String, Object> param) {
		StringBuilder builder = new StringBuilder();
		try {
			StringBuilder params = new StringBuilder();
			for (Entry<String, Object> entry : param.entrySet()) {
				params.append(entry.getKey());
				params.append("=");
				params.append(entry.getValue().toString());
				params.append("&");
			}
			if (params.length() > 0) {
				params.deleteCharAt(params.lastIndexOf("&"));
			}
			URL restServiceURL = new URL(url + (params.length() > 0 ? "?" + params.toString() : ""));
			HttpURLConnection httpConnection = (HttpURLConnection) restServiceURL.openConnection();
			httpConnection.setRequestMethod("POST");
			httpConnection.setRequestProperty("Accept", "application/json");
			// 设置是否从httpUrlConnection读入，默认情况下是true;
			httpConnection.setDoInput(true);
			httpConnection.setDoOutput(true);
			// Post 请求不能使用缓存
			httpConnection.setUseCaches(false);
			if (httpConnection.getResponseCode() != 200) {
				throw new RuntimeException("HTTP POST Request Failed with Error code : "
						+ httpConnection.getResponseCode());
			}
			InputStream inStrm = httpConnection.getInputStream();
			byte[] b = new byte[1024];
			int length;
			while ((length = inStrm.read(b)) != -1) {
				builder.append(new String(b, 0, length));
			}
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return builder.toString();
	}

}
