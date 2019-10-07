package com.flouis.base;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class JsonResult {

	public final static String successMsg = "Your Request has been handled successfully.";
	public final static String failMsg = "Your Request occurred errors!";

	private Boolean flag;	// true：成功	false：失败
	private String msg;		// 消息
	private Object data;	// 数据包

	private JsonResult(Boolean flag, String msg, Object data){
		this.setFlag(flag);
		this.setMsg(msg);
		this.setData(data);
	}

	private JsonResult(){}

	public static JsonResult returnResult(Boolean flag, String msg, Object data){
		return new JsonResult(flag, msg, data);
	}

	public static JsonResult success(){
		return new JsonResult(true, successMsg, null);
	}

	public static JsonResult success(String msg){
		return new JsonResult(true, msg, null);
	}

	public static JsonResult success(Object data){
		return new JsonResult(true, successMsg, data);
	}

	public static JsonResult fail(){
		return new JsonResult(false, failMsg, null);
	}

	public static JsonResult fail(String msg){
		return new JsonResult(false, msg, null);
	}


}
