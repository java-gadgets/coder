package org.pplm.gadgets.coder.controller;

import java.util.Map;

import org.pplm.gadgets.coder.bean.DictExample;
import org.pplm.gadgets.coder.bean.Func;
import org.pplm.gadgets.coder.bean.Dict;
import org.pplm.gadgets.coder.service.DictService;
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
@RequestMapping(path = "/v1/dict", produces = MediaType.APPLICATION_JSON_VALUE)
public class DictController {
	
	@Autowired
	private DictService dictService;
	
	@Autowired
	private FuncService funcService;
	
	@GetMapping(path = "/list")
	public Map<String, Object> onGetList(@RequestParam(name = "pid", required = false) Long pid, Pageable pageable) {
		DictExample dictExample = new DictExample();
		if (pid != null) {
			dictExample.createCriteria().andPidEqualTo(pid);
		}
		return ResHelper.success(dictService.selectByExample(dictExample, pageable));
	}	
	
	@GetMapping(path = "/listAll")
	public Map<String, Object> onGetAllList(@RequestParam(name = "pid", required = false) Long pid, @RequestParam(name = "fid", required = false) Long fid) {
		if (fid != null) {
			Func func = funcService.selectByPrimaryKey(fid);
			if (func != null) {
				if (func.getPid() != null) {
					pid = func.getPid();
				}
			}
		}
		DictExample dictExample = new DictExample();
		if (pid != null) {
			dictExample.createCriteria().andPidEqualTo(pid);
			return ResHelper.success(dictService.selectByExample(dictExample));
		}
		return ResHelper.error(ResHelper.MESSAGE_ERROR_ID);
	}
	
	@PostMapping(path = "/save")
	public Map<String, Object> onPostSave(@RequestParam(name = "pid", required = false, defaultValue = "2") Long pid, @RequestBody Dict dict) {
		dict.setPid(pid);
		if (dict.getId() == null) {
			if (dictService.insertSelective(dict) == 1) {
				return ResHelper.success();
			}
		} else {
			if (dictService.updateByPrimaryKeySelective(dict) == 1) {
				return ResHelper.success();
			}
		}
		return ResHelper.error(ResHelper.MESSAGE_ERROR_BODY);
	}
	
	@PostMapping(path = "/delete")
	public Map<String, Object> onPostDelete(@RequestParam(name = "id", required = true) Long id) {
		 if (dictService.deleteByPrimaryKey(id) == 1) {
			 return ResHelper.success();
		 }
		 return ResHelper.error(ResHelper.MESSAGE_ERROR_ID);
	}
	
	@GetMapping(path = "/detail")
	public Map<String, Object> onGetDetail(@RequestParam(name = "id", required = true) Long id) {
		Dict dict = dictService.selectByPrimaryKey(id);
		if (dict != null) {
			return ResHelper.success(dict);
		}
		return ResHelper.error(ResHelper.MESSAGE_ERROR_ID);
	}
	
}
