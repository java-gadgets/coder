package org.pplm.gadgets.coder.controller;

import java.util.Map;

import org.pplm.gadgets.coder.entity.Dict;
import org.pplm.gadgets.coder.repository.DictRepository;
import org.pplm.gadgets.coder.service.DictService;
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
	private DictRepository dictRepsitory;
	
	@Autowired
	private DictService dictService;
	
	@GetMapping(path = "/list")
	public Map<String, Object> onGetList(Pageable pageable) {
		return ResHelper.success(dictRepsitory.findAllByDeleteFlag(0, pageable));
	}	
	
	@GetMapping(path = "/listAll")
	public Map<String, Object> onGetAllList(@RequestParam(name = "pid", required = true) String pid) {
		return ResHelper.success(dictRepsitory.findAllByPidAndDeleteFlag(pid, 0));
	}
	
	@PostMapping(path = "/save")
	public Map<String, Object> onPostSave(@RequestParam(name = "pid", required = true) String pid, @RequestBody Dict dict) {
		if (dict != null) {
			return ResHelper.success(dictService.save(dict));
		}
		return ResHelper.error(ResHelper.MESSAGE_ERROR_BODY);
	}
	
	@PostMapping(path = "/delete")
	public Map<String, Object> onPostDelete(@RequestParam(name = "id", required = true) String id) {
		Dict dict = dictRepsitory.findOne(id);
		dict.setDeleteFlag(1);
		dictRepsitory.save(dict);
		return ResHelper.success();
	}
	
	@GetMapping(path = "/detail")
	public Map<String, Object> onGetDetail(@RequestParam(name = "id", required = true) String id) {
		return ResHelper.success(dictRepsitory.findOneByIdAndDeleteFlag(id, 0));
	}
	
}
