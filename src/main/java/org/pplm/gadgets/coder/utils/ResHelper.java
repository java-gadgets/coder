package org.pplm.gadgets.coder.utils;

import java.util.HashMap;
import java.util.Map;

public class ResHelper {
	public static final String CODE = "code";
	public static final String MESSAGE = "msg";
	public static final String DATA = "data";
	
	public static final String CODE_ERROR = "1";
	public static final String CODE_SUCCESS = "0";
	
	public static final String MESSAGE_SUCCESS = "success";
	
	public static final String MESSAGE_ERROR_PARAM = "parameter error";
	public static final String MESSAGE_ERROR_ID = "invalid id";
	public static final String MESSAGE_ERROR_BODY = "invalid body";
	
	public static Map<String, Object> success() {
		Map<String, Object> map = new HashMap<>();
		map.put(CODE, CODE_SUCCESS);
		map.put(MESSAGE, MESSAGE_SUCCESS);
		return map;
	}
	
	public static Map<String, Object> success(Object object) {
		Map<String, Object> map = new HashMap<>();
		map.put(CODE, CODE_SUCCESS);
		map.put(MESSAGE, MESSAGE_SUCCESS);
		map.put(DATA, object);
		return map;
	}
	
	public static Map<String, Object> error(String message) {
		Map<String, Object> map = new HashMap<>();
		map.put(CODE, CODE_ERROR);
		map.put(MESSAGE, message);
		return map;
	}
	
}
