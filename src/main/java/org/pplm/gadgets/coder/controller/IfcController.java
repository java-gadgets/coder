package org.pplm.gadgets.coder.controller;

import java.util.Map;

import org.pplm.gadgets.coder.bean.Ifc;
import org.pplm.gadgets.coder.bean.base.IfcExample;
import org.pplm.gadgets.coder.service.IfcService;
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
@RequestMapping(path = "/v1/ifc", produces = MediaType.APPLICATION_JSON_VALUE)
public class IfcController {

	@Autowired
	private IfcService ifcService;
	
	@GetMapping(path = "/list")
	public Map<String, Object> onGetQuery(@RequestParam(name = "fid", required = true) Long fid, Pageable pageable) {
		IfcExample example = new IfcExample();
		example.createCriteria().andFidEqualTo(fid);
		return ResHelper.success(ifcService.selectByExample(example, pageable));
	}
	
	@PostMapping(path="/save", consumes = MediaType.APPLICATION_JSON_VALUE)
	public Map<String, Object> onPostCreate(@RequestParam(name = "fid", required = false) Long fid, @RequestBody Ifc ifc) {
		ifc.setFid(fid);
		if (ifc.getId() == null) {
			if (ifcService.insertSelective(ifc) == 1) {
				return ResHelper.success();
			}
		} else {
			if (ifcService.updateByPrimaryKeySelective(ifc) == 1) {
				return ResHelper.success();
			}
		}
		return ResHelper.error(ResHelper.MESSAGE_ERROR_BODY);
	}
	
	@GetMapping(path = "/detail")
	public Map<String, Object> onGetDetail(@RequestParam(name = "id", required = true) Long id) {
		Ifc ifc = ifcService.selectByPrimaryKey(id);
		if (ifc != null) {
			return ResHelper.success(ifc);
		}
		return ResHelper.error(ResHelper.MESSAGE_ERROR_ID);
	}
	
	@PostMapping(path="/delete")
	public Map<String, Object> onPostDelete(@RequestParam(name = "id", required = true) Long id) {
	    if (ifcService.deleteByPrimaryKey(id) == 1) {
			return ResHelper.success();
		}
		return ResHelper.error(ResHelper.MESSAGE_ERROR_ID);
	}
	
}
