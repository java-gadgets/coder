package org.pplm.gadgets.coder.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.pplm.gadgets.coder.bean.User;
import org.pplm.gadgets.coder.bean.base.UserExample;

@Mapper
public interface UserMapper extends BaseMapper<User, UserExample> {

}