package org.pplm.gadgets.coder.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.pplm.gadgets.coder.bean.Attr;
import org.pplm.gadgets.coder.bean.AttrExample;

@Mapper
public interface AttrMapper extends BaseMapper<Attr, AttrExample> {

}