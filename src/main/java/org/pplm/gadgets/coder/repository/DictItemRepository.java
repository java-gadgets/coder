package org.pplm.gadgets.coder.repository;

import org.pplm.gadgets.coder.entity.DictItem;

public interface DictItemRepository extends BaseRepository<DictItem> {
	public void deleteByDidIsNull();
	
}
