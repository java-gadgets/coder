package org.pplm.gadgets.coder.controller;

import java.util.Map;

import org.pplm.gadgets.coder.bean.User;
import org.pplm.gadgets.coder.service.SystemService;
import org.pplm.gadgets.coder.utils.ResHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(path = "/v1/system", produces = MediaType.APPLICATION_JSON_VALUE)
public class SystemController {
	
	@Autowired
	private SystemService systemService;
	
	@PostMapping(path = "/login", consumes = MediaType.APPLICATION_JSON_VALUE)
	public Map<String, Object> onPostLogin(@RequestBody User user) {
		User userLogin = systemService.login(user);
		if (userLogin != null) {
			return ResHelper.success(userLogin);
		}
		return ResHelper.error(ResHelper.MESSAGE_ERROR_AUTH);
	}
	
}
