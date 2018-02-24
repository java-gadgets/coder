package org.pplm.gadgets.coder.controller;

import java.util.Map;

import org.pplm.gadgets.coder.bean.base.FuncExample;
import org.pplm.gadgets.coder.bean.base.AttrExample;
import org.pplm.gadgets.coder.bean.Func;
import org.pplm.gadgets.coder.service.AttrService;
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
	private FuncService funcService;
	
	@Autowired
	private AttrService attrService;
	
	@GetMapping(path = "/list")
	public Map<String, Object> onGetQuery(@RequestParam(name = "pid", required = false) Long pid, Pageable pageable){
		FuncExample funcExample = new FuncExample();
		if (pid != null) {
			funcExample.createCriteria().andPidEqualTo(pid);
		}
		return ResHelper.success(funcService.selectByExample(funcExample, pageable));
	}

	@PostMapping(path="/save", consumes = MediaType.APPLICATION_JSON_VALUE)
	public Map<String, Object> onPostCreate(@RequestParam(name = "pid", required = true) Long pid, @RequestBody Func func) {
		if (pid == null) {
			return ResHelper.error(ResHelper.MESSAGE_ERROR_ID); 
		}
		func.setPid(pid);
		if (func.getId() == null) {
			if (funcService.insertSelective(func) == 1) {
				return ResHelper.success();
			}
		} else {
			if (funcService.updateByPrimaryKeySelective(func) == 1) {
				return ResHelper.success();
			}
		}
		return ResHelper.error(ResHelper.MESSAGE_ERROR_BODY);
	}
	
	@GetMapping(path = "/detail")
	public Map<String, Object> onGetDetail(@RequestParam(name = "id", required = true) Long id) {
		Func func = funcService.selectByPrimaryKey(id);
		if (func != null) {
			return ResHelper.success(func);
		}
		return ResHelper.error(ResHelper.MESSAGE_ERROR_ID);
	}
	
	@PostMapping(path="/delete")
	public Map<String, Object> onPostDelete(@RequestParam(name = "id", required = true) Long id) {
		if (funcService.deleteByPrimaryKey(id) == 1 ) {
			return ResHelper.success();
		}
		return ResHelper.error(ResHelper.MESSAGE_ERROR_ID);
	}
	
	@GetMapping(path = "/attrs")
	public Map<String, Object> onGetAttrs(@RequestParam("fid") Long fid) {
		AttrExample example = new AttrExample();
		example.createCriteria().andFidEqualTo(fid);
		return ResHelper.success(attrService.selectByExample(example));
	}
	
}
