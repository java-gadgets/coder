package org.pplm.gadgets.coder.controller;

import java.util.List;
import java.util.Map;

import org.pplm.gadgets.coder.bean.Attr;
import org.pplm.gadgets.coder.bean.Opt;
import org.pplm.gadgets.coder.bean.OptExample;
import org.pplm.gadgets.coder.service.OptService;
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
@RequestMapping(path = "/v1/opt", produces = MediaType.APPLICATION_JSON_VALUE)
public class OptController {
	
	@Autowired
	private OptService optService;
	
	@GetMapping(path = "/list")
	public Map<String, Object> onGetList(@RequestParam(name = "fid", required = true) Long fid, Pageable pageable){
		OptExample example = new OptExample();
		example.createCriteria().andFidEqualTo(fid);
		return ResHelper.success(optService.selectByExample(example, pageable));
	}
	
	@GetMapping(path = "/listAll")
	public Map<String, Object> onGetListAll(@RequestParam(name = "fid", required = true) Long fid){
		OptExample example = new OptExample();
		example.createCriteria().andFidEqualTo(fid);
		return ResHelper.success(optService.selectByExample(example));
	}
	
	@GetMapping(path = "/detail")
	public Map<String, Object> onGetDetail(@RequestParam(name = "id", required = true) Long id) {
		Opt opt = optService.selectByPrimaryKey(id);
		if (opt != null) {
			return ResHelper.success(opt);
		}
		return ResHelper.error(ResHelper.MESSAGE_ERROR_ID);
	}

	@PostMapping(path="/save", consumes = MediaType.APPLICATION_JSON_VALUE)
	public Map<String, Object> onPostCreate(@RequestParam(name = "fid", required = true) Long fid, @RequestBody Opt opt) {
		opt.setFid(fid);
		if (opt.getId() == null) {
			if(optService.insertSelective(opt) == 1) {
				return ResHelper.success();
			}
		} else {
			if (optService.updateByPrimaryKeySelective(opt) == 1) {
				return ResHelper.success();
			}
		}
		return ResHelper.error(ResHelper.MESSAGE_ERROR_BODY);
	}
	
	@PostMapping(path="/delete")
	public Map<String, Object> onPostDelete(@RequestParam(name = "id", required = true) Long id) {
		if (optService.deleteByPrimaryKey(id) == 1) {
			return ResHelper.success();
		}
		return ResHelper.error(ResHelper.MESSAGE_ERROR_ID);
	}
	
	@PostMapping(path="/bindAttr/{oid}")
	public Map<String, Object> onPostBindAttr(@PathVariable("oid") Long oid, @RequestBody List<Long> aids) {
		optService.bindAttrByPrimaryKey(oid, aids);
		return ResHelper.success();
	}
	
	@GetMapping(path = "/attrs")
	public Map<String, Object> onGetAttrs(@RequestParam("oid") Long oid) {
		List<Attr> attrs = optService.selectAttrByOptPrimaryKey(oid);
		return ResHelper.success(attrs);
	}
	
}
