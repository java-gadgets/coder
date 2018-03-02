package org.pplm.gadgets.coder.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.pplm.gadgets.coder.bean.Ifc;
import org.pplm.gadgets.coder.bean.base.IfcExample;

@Mapper
public interface IfcMapper extends BaseMapper<Ifc, IfcExample> {

}