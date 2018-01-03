package org.pplm.gadgets.coder.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.pplm.gadgets.coder.bean.Attr;
import org.pplm.gadgets.coder.bean.AttrExample;
import org.pplm.gadgets.coder.bean.Opt;

@Mapper
public interface AttrMapper extends BaseMapper<Attr, AttrExample> {
	
	public List<Opt> selectOptByAttrPrimaryKey(@Param("aid") Long aid);
	
	public int bindOptByAttrPrimaryKey(@Param("aid") Long aid, @Param("oid") Long oid, @Param("osv") Integer osv);
	
}