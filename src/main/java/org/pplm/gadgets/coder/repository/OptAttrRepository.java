package org.pplm.gadgets.coder.repository;

import org.pplm.gadgets.coder.entity.OptAttr;

public interface OptAttrRepository extends BaseRepository<OptAttr> {
	
	public void deleteByOid(String oid);
	public void deleteByAid(String aid);
	
}
