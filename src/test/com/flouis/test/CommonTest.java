package com.flouis.test;

import org.apache.commons.codec.digest.DigestUtils;
import org.junit.Test;

public class CommonTest {

	@Test
	public void test(){
		System.out.println(Thread.currentThread().getName());
	}

	@Test
	public void md5Test(){
		String str = "123456";
		System.out.println(DigestUtils.md5Hex(str)); // e10adc3949ba59abbe56e057f20f883e

		str = "430430";
		System.out.println(DigestUtils.md5Hex(str)); // 291ad281e640429285d30ff25b66813d
	}

}
