package org.pplm.gadgets.coder.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.pplm.gadgets.coder.bean.base.ProjectExample;
import org.pplm.gadgets.coder.bean.Project;
import org.pplm.gadgets.coder.service.ProjectService;
import org.pplm.gadgets.coder.utils.ResHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(path = "/v1/project", produces = MediaType.APPLICATION_JSON_VALUE)
public class ProjectController {
	
	@Autowired
	private ProjectService projectService;
	
	@GetMapping(path = "/list")
	public Map<String, Object> onGetQuery(HttpServletRequest request, Pageable pageable){
		ProjectExample projectExample = new ProjectExample();
		return ResHelper.success(projectService.selectByExample(projectExample, pageable));
	}

	@PostMapping(path="/save", consumes = MediaType.APPLICATION_JSON_VALUE)
	public Map<String, Object> onPostCreate(@RequestBody Project project) {
		if (project.getId() == null) {
			if (projectService.insertSelective(project) == 1) {
				return ResHelper.success();
			}
		} else {
			if(projectService.updateByPrimaryKeySelective(project) == 1) {
				return ResHelper.success();
			}
		}
		return ResHelper.error(ResHelper.MESSAGE_ERROR_BODY);
	}
	
	@GetMapping(path = "/detail")
	public Map<String, Object> onGetDetail(@RequestParam(name = "id", required = true) Long id) {
		Project project = projectService.selectByPrimaryKey(id);
		if (project != null && project.getDeleteFlag() == 0) {
			return ResHelper.success(project);
		}
		return ResHelper.error(ResHelper.MESSAGE_ERROR_ID);
	}
	
	@PostMapping(path="/delete")
	public Map<String, Object> onPostDelete(@RequestParam(name = "id", required = true) Long id) {
		if (projectService.deleteByPrimaryKey(id) == 1) {
			return ResHelper.success();
		}
		return ResHelper.error(ResHelper.MESSAGE_ERROR_ID);
	}
	
}
