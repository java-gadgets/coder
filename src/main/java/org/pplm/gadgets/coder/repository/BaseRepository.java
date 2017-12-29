package org.pplm.gadgets.coder.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.NoRepositoryBean;

@NoRepositoryBean
public interface BaseRepository<T>  {
	
	public Page<T> findAllByDeleteFlag(Integer deleteFlag, Pageable pageable);
	
	public T findOneByIdAndDeleteFlag(String id, Integer deleteFlag);
	
}
