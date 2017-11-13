package org.pplm.gadgets.coder.repository;

import org.pplm.gadgets.coder.entity.Attr;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface AttrRepository extends BaseRepository<Attr> {
	public Page<Attr> findByFidAndDeleteFlag(Long fid, Integer deleteFlag, Pageable pageable);
}
