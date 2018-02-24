package org.pplm.gadgets.coder.service;

import java.util.List;

import org.pplm.gadgets.coder.bean.User;
import org.pplm.gadgets.coder.bean.base.UserExample;
import org.pplm.gadgets.coder.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SystemService {
	
	@Autowired
	private UserMapper userMapper;
	
	public User login(User user) {
		UserExample userExample = new UserExample();
		userExample.createCriteria()
			.andUsernameEqualTo(user.getUsername())
			.andDeleteFlagEqualTo(0)
			.andStatusEqualTo(1);
		List<User> users = userMapper.selectByExample(userExample);
		User userResult = null;
		if (users.size() > 0) {
			userResult = users.get(0);
			if (userResult.getPassword().equals(user.getPassword())) {
				userResult.setToken(user.getPassword());
				userResult.setPassword("********");
				return userResult;
			}
		}
		return null;
	}
	
}
