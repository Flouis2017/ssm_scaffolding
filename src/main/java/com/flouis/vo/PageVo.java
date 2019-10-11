package com.flouis.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PageVo {

	private Integer page = 1;
	private Integer rows = 10;

	private String sort;
	private String order = "asc";

}
