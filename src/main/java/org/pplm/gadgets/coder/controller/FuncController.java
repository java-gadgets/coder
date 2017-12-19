package org.pplm.gadgets.coder.controller;

import java.util.Map;

import org.pplm.gadgets.coder.entity.Func;
import org.pplm.gadgets.coder.entity.Project;
import org.pplm.gadgets.coder.repository.FuncRepository;
import org.pplm.gadgets.coder.repository.ProjectRepository;
import org.pplm.gadgets.coder.service.FuncService;
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
@RequestMapping(path = "/v1/func", produces = MediaType.APPLICATION_JSON_VALUE)
public class FuncController {
	
	@Autowired
	private ProjectRepository projectRepository;
	
	@Autowired
	private FuncRepository funcRepository;
	@Autowired
	private FuncService funcService;
	
	@GetMapping(path = "/list")
	public Map<String, Object> onGetQuery(@RequestParam(name = "pid", required = false) String pid, Pageable pageable){
		if (pid == null) {
			return ResHelper.success(funcRepository.findAllByDeleteFlag(0, pageable));
		} else {
			Project project = projectRepository.findOne(pid);
			if (project == null) {
				return ResHelper.error(ResHelper.MESSAGE_ERROR_ID);
			}
			return ResHelper.success(project.getFuncs());
		}
	}

	@PostMapping(path="/save", consumes = MediaType.APPLICATION_JSON_VALUE)
	public Map<String, Object> onPostCreate(@RequestParam(name = "pid", required = true)String pid, @RequestBody Func func) {
		Project project = projectRepository.findOne(pid);
		if (project == null) {
			return ResHelper.error(ResHelper.MESSAGE_ERROR_ID); 
		}
		if (func != null) {
			func.setProject(project);
			return ResHelper.success(funcService.save(func));
		}
		return ResHelper.error(ResHelper.MESSAGE_ERROR_BODY);
	}
	
	@GetMapping(path = "/detail")
	public Map<String, Object> onGetDetail(@RequestParam(name = "id", required = true) String id) {
		Func func = funcRepository.findOneByIdAndDeleteFlag(id, 0);
		if (func != null) {
			return ResHelper.success(func);
		}
		return ResHelper.error(ResHelper.MESSAGE_ERROR_ID);
	}
	
	@PostMapping(path="/delete")
	public Map<String, Object> onPostDelete(@RequestParam(name = "id", required = true) String id) {
		if(id != null) {
			Func func = funcRepository.findOneByIdAndDeleteFlag(id, 0);
			if(func != null) {
				func.setDeleteFlag(1);
				funcRepository.save(func);
				return ResHelper.success();
			}
		}
		return ResHelper.error(ResHelper.MESSAGE_ERROR_ID);
	}
	
	@GetMapping(path = "/attrs")
	public Map<String, Object> onGetAttrs(@RequestParam("fid") String fid) {
		Func func = funcRepository.findOneByIdAndDeleteFlag(fid, 0);
		if (func != null) {
			return ResHelper.success(func.getAttrs());
		}
		return ResHelper.error(ResHelper.MESSAGE_ERROR_ID);
	}
	
}
