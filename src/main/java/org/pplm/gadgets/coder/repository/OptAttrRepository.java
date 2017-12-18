package org.pplm.gadgets.coder.repository;

import java.util.List;

import org.pplm.gadgets.coder.entity.OptAttr;

public interface OptAttrRepository extends BaseRepository<OptAttr> {
	
	public void deleteByOid(String oid);
	
	public void deleteByAid(String aid);
	
	public List<OptAttr> findByAid(String aid);
	
	public List<OptAttr> findByOid(String oid);
	
}
