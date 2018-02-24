package org.pplm.gadgets.coder.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.pplm.gadgets.coder.bean.Func;
import org.pplm.gadgets.coder.bean.base.FuncExample;

@Mapper
public interface FuncMapper extends BaseMapper<Func, FuncExample> {

}