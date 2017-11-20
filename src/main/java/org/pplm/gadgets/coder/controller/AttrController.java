package org.pplm.gadgets.coder.controller;

import java.util.List;
import java.util.Map;

import org.pplm.gadgets.coder.entity.Attr;
import org.pplm.gadgets.coder.repository.AttrRepository;
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
	
	@Autowired
	private AttrRepository attrRepository;
	
	@GetMapping(path = "/list")
	public Map<String, Object> onGetQuery(@RequestParam(name = "fid", required = true) String fid, Pageable pageable){
		//return ResHelper.success(funcRepository.findAll(pageable));
		return ResHelper.success(attrRepository.findByFidAndDeleteFlag(fid, 0, pageable));
	}
	
	@GetMapping(path = "/detail")
	public Map<String, Object> onGetDetail(@RequestParam("id") String id) {
		Attr attr = attrRepository.findOneByIdAndDeleteFlag(id, 0);
		if (attr != null) {
			return ResHelper.success(attr);
		}
		return ResHelper.error(ResHelper.MESSAGE_ERROR_ID);
	}

	@PostMapping(path="/save/{fid}", consumes = MediaType.APPLICATION_JSON_VALUE)
	public Map<String, Object> onPostCreate(@PathVariable("fid") String fid, @RequestBody Attr attr) {
		if (attr != null) {
			attr.setFid(fid);
			return ResHelper.success(attrService.save(attr));
		}
		return ResHelper.error(ResHelper.MESSAGE_ERROR_BODY);
	}
	
	@PostMapping(path="/delete/{id}")
	public Map<String, Object> onPostDelete(@PathVariable("id") String id) {
		if(id != null) {
		    attrService.delete(id);
			return ResHelper.success();
		}
		return ResHelper.error(ResHelper.MESSAGE_ERROR_ID);
	}
	
	@PostMapping(path="/bindOpt/{aid}")
	public Map<String, Object> onPostBindOpt(@PathVariable("aid") String aid, @RequestBody List<String> oids) {
		return null;
		
	}
	
}
