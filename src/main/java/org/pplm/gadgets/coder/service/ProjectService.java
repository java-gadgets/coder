package org.pplm.gadgets.coder.service;

import org.pplm.gadgets.coder.bean.base.FuncExample;
import org.pplm.gadgets.coder.bean.Project;
import org.pplm.gadgets.coder.bean.base.ProjectExample;
import org.pplm.gadgets.coder.mapper.ProjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ProjectService extends BaseService<Project, ProjectExample> {

	@Autowired
	private FuncService funcService;
	
	@Autowired
	public ProjectService(ProjectMapper projectMapper) {
		super(projectMapper);
	}
	
	public Project selectWithFuncsByPrimaryKey(Long id) {
		Project project = super.selectByPrimaryKey(id);
		if (project != null) {
			FuncExample funcExample = new FuncExample();
			funcExample.createCriteria().andPidEqualTo(id);
			project.setFuncs(funcService.selectWithOptsAndAttrsByExample(funcExample));
		}
		return project;
	}
	
}
