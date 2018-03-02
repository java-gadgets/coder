<#include "spec/" + project.custom + "/package-prefix.ftl" ignore_missing=true />
package ${packagePrefix!}controller;

import java.util.Map;

import ${packagePrefix!}bean.${code?cap_first};
import ${packagePrefix!}bean.base.${code?cap_first}Example;
import ${packagePrefix!}service.${code?cap_first}Service;
import ${packagePrefix!}utils.ResHelper;
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
@RequestMapping(path = "/v1/${code}", produces = MediaType.APPLICATION_JSON_VALUE)
public class ${code?cap_first}Controller {

	@Autowired
	private ${code?cap_first}Service ${code}Service;
	
	@GetMapping(path = "/list")
	public Map<String, Object> onGetQuery(@RequestParam(name = "fid", required = true) Long fid, Pageable pageable) {
		${code?cap_first}Example example = new ${code?cap_first}Example();
		example.createCriteria().andFidEqualTo(fid);
		return ResHelper.success(${code}Service.selectByExample(example, pageable));
	}
	
	@PostMapping(path="/save", consumes = MediaType.APPLICATION_JSON_VALUE)
	public Map<String, Object> onPostCreate(@RequestParam(name = "fid", required = false) Long fid, @RequestBody ${code?cap_first} ${code}) {
		${code}.setFid(fid);
		if (${code}.getId() == null) {
			if (${code}Service.insertSelective(${code}) == 1) {
				return ResHelper.success();
			}
		} else {
			if (${code}Service.updateByPrimaryKeySelective(${code}) == 1) {
				return ResHelper.success();
			}
		}
		return ResHelper.error(ResHelper.MESSAGE_ERROR_BODY);
	}
	
	@GetMapping(path = "/detail")
	public Map<String, Object> onGetDetail(@RequestParam(name = "id", required = true) Long id) {
		${code?cap_first} ${code} = ${code}Service.selectByPrimaryKey(id);
		if (${code} != null) {
			return ResHelper.success(${code});
		}
		return ResHelper.error(ResHelper.MESSAGE_ERROR_ID);
	}
	
	@PostMapping(path="/delete")
	public Map<String, Object> onPostDelete(@RequestParam(name = "id", required = true) Long id) {
	    if (${code}Service.deleteByPrimaryKey(id) == 1) {
			return ResHelper.success();
		}
		return ResHelper.error(ResHelper.MESSAGE_ERROR_ID);
	}
	
}