package org.pplm.gadgets.coder.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.pplm.gadgets.coder.bean.Project;
import org.pplm.gadgets.coder.bean.ProjectExample;

@Mapper
public interface ProjectMapper extends BaseMapper<Project, ProjectExample> {

}