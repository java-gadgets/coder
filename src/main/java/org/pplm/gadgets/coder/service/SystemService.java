package org.pplm.gadgets.coder.service;

import org.pplm.gadgets.coder.entity.User;
import org.pplm.gadgets.coder.repository.SystemRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SystemService {
	
	@Autowired
	private SystemRepository systemRepository;
	
	public User login(User user) {
		User userResult = systemRepository.findOneByUsernameAndDeleteFlag(user.getUsername(), 0);
		if (userResult != null && userResult.getPassword().equals(user.getPassword())) {
			userResult.setPassword("********");
		}
		return userResult;
	}
}
