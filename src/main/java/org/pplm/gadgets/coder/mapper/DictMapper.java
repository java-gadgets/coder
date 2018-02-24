package org.pplm.gadgets.coder.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.pplm.gadgets.coder.bean.Dict;
import org.pplm.gadgets.coder.bean.base.DictExample;

@Mapper
public interface DictMapper extends BaseMapper<Dict, DictExample> {

}