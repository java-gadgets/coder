package org.pplm.gadgets.coder.repository;

import java.util.List;

import org.pplm.gadgets.coder.entity.Opt;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface OptRepository extends BaseRepository<Opt> {
	public Page<Opt> findByFidAndDeleteFlag(String fid, Integer deleteFlag, Pageable pageable);
	public List<Opt> findByFidAndDeleteFlag(String fid, Integer deleteFlag);
}
