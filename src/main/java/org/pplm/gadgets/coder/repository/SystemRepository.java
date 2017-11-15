package org.pplm.gadgets.coder.repository;

import org.pplm.gadgets.coder.entity.User;

public interface SystemRepository extends BaseRepository<User> {
	
	public User findOneByUsernameAndDeleteFlag(String username, Integer deleteFlag);
	
}
