<#include "spec/" + project.custom + "/package-prefix.ftl" ignore_missing=true />
package ${packagePrefix!}service;

import ${packagePrefix!}bean.${code?cap_first};
import ${packagePrefix!}bean.base.${code?cap_first}Example;
import ${packagePrefix!}mapper.${code?cap_first}Mapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ${code?cap_first}Service extends BaseService<${code?cap_first}, ${code?cap_first}Example> {

	@Autowired
	public ${code?cap_first}Service(${code?cap_first}Mapper mapper) {
		super(mapper);
	}
	
}
