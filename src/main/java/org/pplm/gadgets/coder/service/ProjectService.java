package org.pplm.gadgets.coder.service;

import org.pplm.gadgets.coder.bean.Project;
import org.pplm.gadgets.coder.bean.ProjectExample;
import org.pplm.gadgets.coder.mapper.ProjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ProjectService extends BaseService<Project, ProjectExample> {

	@Autowired
	public ProjectService(ProjectMapper projectMapper) {
		super(projectMapper);
	}
	
}
