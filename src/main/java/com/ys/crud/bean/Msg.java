package com.ys.crud.bean;

import java.util.HashMap;
import java.util.Map;

/**
 * 通用的返回类
 * 
 * @author 姚顺
 *
 */

public class Msg {
	//状态码 100-成功 200-失败
	private int code;
	//提示信息
	private String msg;
	//用户要返回给浏览器的数据
	private Map<String, Object> extend = new HashMap<String, Object>();
	
	public static Msg success() {
		Msg msg = new Msg();
		msg.setCode(100);
		msg.setMsg("处理成功");
		return msg;
	}
	
	public static Msg fail() {
		Msg msg = new Msg();
		msg.setCode(200);
		msg.setMsg("处理失败");
		return msg;
	}
	
	public Msg add(String string, Object info) {
		this.extend.put(string, info);
		return this;
	}
	
	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public Map<String, Object> getExtend() {
		return extend;
	}
	public void setExtend(Map<String, Object> extend) {
		this.extend = extend;
	}

	
	
}
