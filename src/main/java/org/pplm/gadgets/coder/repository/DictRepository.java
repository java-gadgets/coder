package org.pplm.gadgets.coder.repository;

import java.util.List;

import org.pplm.gadgets.coder.entity.Dict;

public interface DictRepository extends BaseRepository<Dict> {
	public List<Dict> findAllByPidAndDeleteFlag(String pid, Integer deleteFlag);
}
