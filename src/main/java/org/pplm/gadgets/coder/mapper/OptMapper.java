package org.pplm.gadgets.coder.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.pplm.gadgets.coder.bean.Opt;
import org.pplm.gadgets.coder.bean.OptExample;

@Mapper
public interface OptMapper extends BaseMapper<Opt, OptExample> {

}