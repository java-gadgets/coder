package org.pplm.gadgets.coder.repository;

import org.pplm.gadgets.coder.entity.Opt;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface OptRepository extends BaseRepository<Opt> {
	public Page<Opt> findByFidAndDeleteFlag(Long fid, Integer deleteFlag, Pageable pageable);
}
