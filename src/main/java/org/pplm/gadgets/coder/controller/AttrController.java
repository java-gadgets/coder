package org.pplm.gadgets.coder.controller;

import java.util.List;
import java.util.Map;

import org.pplm.gadgets.coder.bean.base.AttrExample;
import org.pplm.gadgets.coder.bean.Attr;
import org.pplm.gadgets.coder.service.AttrService;
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
@RequestMapping(path = "/v1/attr", produces = MediaType.APPLICATION_JSON_VALUE)
public class AttrController {

	@Autowired
	private AttrService attrService;
	
	@GetMapping(path = "/list")
	public Map<String, Object> onGetQuery(@RequestParam(name = "fid", required = true) Long fid, Pageable pageable){
		AttrExample example = new AttrExample();
		example.createCriteria().andFidEqualTo(fid);
		return ResHelper.success(attrService.selectByExample(example, pageable));
	}
	
	@GetMapping(path = "/detail")
	public Map<String, Object> onGetDetail(@RequestParam(name = "id", required = true) Long id) {
		Attr attr = attrService.selectByPrimaryKey(id);
		if (attr != null) {
			return ResHelper.success(attr);
		}
		return ResHelper.error(ResHelper.MESSAGE_ERROR_ID);
	}

	@PostMapping(path="/save", consumes = MediaType.APPLICATION_JSON_VALUE)
	public Map<String, Object> onPostCreate(@RequestParam(name = "fid") Long fid, @RequestBody Attr attr) {
		attr.setFid(fid);
		if (attr.getId() == null) {
			if (attrService.insertSelective(attr) == 1) {
				return ResHelper.success();
			}
		} else {
			if (attrService.updateByPrimaryKeySelective(attr) == 1) {
				return ResHelper.success();
			}
		}
		return ResHelper.error(ResHelper.MESSAGE_ERROR_BODY);
	}
	
	@PostMapping(path="/delete")
	public Map<String, Object> onPostDelete(@RequestParam(name = "id", required = true) Long id) {
	    if (attrService.deleteByPrimaryKey(id) == 1) {
			return ResHelper.success();
		}
		return ResHelper.error(ResHelper.MESSAGE_ERROR_ID);
	}
	
	@PostMapping(path="/bindOpt/{aid}")
	public Map<String, Object> onPostBindOpt(@PathVariable("aid") String aid, @RequestBody List<String> oids) {
		return null;
		
	}
	
}
