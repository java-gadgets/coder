package org.pplm.gadgets.coder.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.pplm.gadgets.coder.bean.DictItem;
import org.pplm.gadgets.coder.bean.DictItemExample;

@Mapper
public interface DictItemMapper extends BaseMapper<DictItem, DictItemExample> {

}