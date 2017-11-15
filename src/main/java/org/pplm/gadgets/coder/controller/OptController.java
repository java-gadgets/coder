package org.pplm.gadgets.coder.controller;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.pplm.gadgets.coder.entity.Opt;
import org.pplm.gadgets.coder.entity.OptAttr;
import org.pplm.gadgets.coder.repository.OptRepository;
import org.pplm.gadgets.coder.service.OptAttrService;
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
	private OptRepository optRepository;
	
	@Autowired
	private OptAttrService optAttrService;
	
	@GetMapping(path = "/list")
	public Map<String, Object> onGetQuery(@RequestParam(name = "fid", required = true) String fid, Pageable pageable){
		return ResHelper.success(optRepository.findByFidAndDeleteFlag(Long.parseLong(fid), 0, pageable));
	}
	
	@GetMapping(path = "/detail")
	public Map<String, Object> onGetDetail(@RequestParam("id") String id) {
		Opt opt = optRepository.findOneByIdAndDeleteFlag(Long.parseLong(id), 0);
		if (opt != null) {
			return ResHelper.success(opt);
		}
		return ResHelper.error(ResHelper.MESSAGE_ERROR_ID);
	}

	@PostMapping(path="/save/{fid}", consumes = MediaType.APPLICATION_JSON_VALUE)
	public Map<String, Object> onPostCreate(@PathVariable("fid") String fid, @RequestBody Opt opt) {
		if (opt != null) {
			opt.setFid(Long.parseLong(fid));
			return ResHelper.success(optRepository.save(opt));
		}
		return ResHelper.error(ResHelper.MESSAGE_ERROR_BODY);
	}
	
	@PostMapping(path="/delete/{id}")
	public Map<String, Object> onPostDelete(@PathVariable("id") String id) {
		if(id != null) {
			Opt opt = optRepository.findOneByIdAndDeleteFlag(Long.parseLong(id), 0);
			if(opt != null) {
				opt.setDeleteFlag(1);
				optRepository.save(opt);
				return ResHelper.success();
			}
		}
		return ResHelper.error(ResHelper.MESSAGE_ERROR_ID);
	}
	
	@PostMapping(path="/bindAttr/{id}")
	public Map<String, Object> onPostBindAttr(@PathVariable("id") String id, @RequestBody List<String> aids) {
		final Long oid = Long.parseLong(id);
		List<OptAttr> optAttrs = aids.stream().map(aid -> new OptAttr(oid, Long.parseLong(aid))).collect(Collectors.toList());
		optAttrService.bindAttr(oid, optAttrs);
		return ResHelper.success();
	}
	
}
