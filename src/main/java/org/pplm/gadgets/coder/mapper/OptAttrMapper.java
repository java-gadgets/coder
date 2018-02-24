package org.pplm.gadgets.coder.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.pplm.gadgets.coder.bean.Attr;
import org.pplm.gadgets.coder.bean.Opt;
import org.pplm.gadgets.coder.bean.OptAttr;
import org.pplm.gadgets.coder.bean.base.OptAttrExample;

@Mapper
public interface OptAttrMapper extends BaseMapper<OptAttr, OptAttrExample> {

	public List<Opt> selectOptByAttrPrimaryKey(@Param("aid") Long aid);
	public int bindOptByAttrPrimaryKey(@Param("aid") Long aid, @Param("oid") Long oid, @Param("osv") Integer osv);
	public List<Attr> selectAttrByOptPrimaryKey(@Param("oid") Long oid);
	
}