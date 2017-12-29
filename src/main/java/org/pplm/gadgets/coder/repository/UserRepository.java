package org.pplm.gadgets.coder.repository;

import org.pplm.gadgets.coder.entity.User;
import org.springframework.data.repository.query.Param;

public interface UserRepository extends BaseRepository<User> {
	
//	@Modifying
//	@Query("UPDATE User SET status = :status WHERE id = :id") // use java class(entity) name for query sql
	public void updateStatus(@Param("id")String id, @Param("status")String status);
	
}
