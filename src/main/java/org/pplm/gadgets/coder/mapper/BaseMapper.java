package org.pplm.gadgets.coder.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.pplm.gadgets.coder.bean.Example;
import org.pplm.gadgets.coder.bean.Record;

public interface BaseMapper <R extends Record, E extends Example> {

    public long countByExample(E example);
    public int deleteByExample(E example);
    public int deleteByPrimaryKey(Long id);
    int insert(R record);
    int insertSelective(R record);
    public List<R> selectByExample(E example);
    public R selectByPrimaryKey(Long id);
    public int updateByExampleSelective(@Param("record") R record, @Param("example") E example);
    public int updateByExample(@Param("record") R record, @Param("example") E example);
    public int updateByPrimaryKeySelective(R record);
    public int updateByPrimaryKey(R record);
    
}
