package com.flouis.base;

import com.google.common.collect.Lists;
import lombok.Getter;
import lombok.Setter;

/**
 * @date 20191006
 * @author Flouis
 * @description EasyUI 数据表格返回类
 */
@Getter
@Setter
public class DatagridResult {

	private Boolean flag;
	private String msg = "";
	private Object rows = Lists.newArrayList();
	private Long total = 0L;

	private DatagridResult(Boolean flag, String msg, Object rows, Long total){
		this.setFlag(flag);
		this.setMsg(msg);
		this.setTotal(total);
		this.setRows(rows);
	}

	private DatagridResult(){}

	public static DatagridResult success(Object rows, Long total){
		return new DatagridResult(true, "", rows, total);
	}

	public static DatagridResult fail(String msg){
		DatagridResult datagridResult = new DatagridResult();
		datagridResult.setFlag(false);
		datagridResult.setMsg(msg);
		return datagridResult;
	}

}
