package org.pplm.gadgets.coder.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.pplm.gadgets.coder.entity.Project;
import org.pplm.gadgets.coder.repository.ProjectRepository;
import org.pplm.gadgets.coder.utils.ResHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(path = "/v1/project", produces = MediaType.APPLICATION_JSON_VALUE)
public class ProjectController {
	
	@Autowired
	private ProjectRepository projectRepository;
	
	@GetMapping(path = "/list")
	public Map<String, Object> onGetQuery(HttpServletRequest request, Pageable pageable){
		return ResHelper.success(projectRepository.findAllByDeleteFlag(0, pageable));
	}

	@PostMapping(path="/save", consumes = MediaType.APPLICATION_JSON_VALUE)
	public Map<String, Object> onPostCreate(@RequestBody Project project) {
		if (project != null) {
			return ResHelper.success(projectRepository.save(project));
		}
		return ResHelper.error(ResHelper.MESSAGE_ERROR_BODY);
	}
	
	@GetMapping(path = "/detail")
	public Map<String, Object> onGetDetail(@RequestParam("id") String id) {
		Project project = projectRepository.findOneByIdAndDeleteFlag(id, 0);
		if (project != null) {
			return ResHelper.success(project);
		}
		return ResHelper.error(ResHelper.MESSAGE_ERROR_ID);
	}
	
	@PostMapping(path="/delete/{id}")
	public Map<String, Object> onPostDelete(@PathVariable("id") String id) {
		if(id != null) {
			Project project = projectRepository.findOneByIdAndDeleteFlag(id, 0);
			if(project != null) {
				project.setDeleteFlag(1);
				projectRepository.save(project);
				return ResHelper.success();
			}
		}
		return ResHelper.error(ResHelper.MESSAGE_ERROR_ID);
	}
	
}
