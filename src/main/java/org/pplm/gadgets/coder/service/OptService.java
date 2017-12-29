package org.pplm.gadgets.coder.service;

import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

import org.pplm.gadgets.coder.entity.Attr;
import org.pplm.gadgets.coder.entity.Opt;
import org.pplm.gadgets.coder.entity.OptAttr;
import org.pplm.gadgets.coder.repository.AttrRepository;
import org.pplm.gadgets.coder.repository.OptAttrRepository;
import org.pplm.gadgets.coder.repository.OptRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class OptService {

//	@Autowired
	private OptRepository optRepository;
	
//	@Autowired
	private OptAttrRepository optAttrRepository;
	
//	@Autowired
	private AttrRepository attrRepository;
	
	public boolean delete(String id) {
		Opt opt = optRepository.findOneByIdAndDeleteFlag(id, 0);
		if(opt != null) {
			opt.setDeleteFlag(1);
			//optRepository.save(opt);
			optAttrRepository.deleteByOid(id);
			return true;
		}
		return false;
	}
	
	public List<Attr> findAllAttrsById(String id) {
		List<OptAttr> optAttrs = optAttrRepository.findByOid(id);
		if (optAttrs != null) {
			List<String> aids = optAttrs.stream().sorted((e1, e2) -> e1.getId().compareTo(e2.getId())).map(e -> e.getAid()).collect(Collectors.toList());
			if (aids.size() > 0) {
			//	return attrRepository.findAll(aids);
			}
			return Collections.emptyList();
		}
		return null;
	}
	
}
