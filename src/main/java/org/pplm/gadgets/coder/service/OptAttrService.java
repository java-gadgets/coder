package org.pplm.gadgets.coder.service;

import java.util.List;

import org.pplm.gadgets.coder.entity.OptAttr;
import org.pplm.gadgets.coder.repository.OptAttrRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class OptAttrService {
	
	@Autowired
	private OptAttrRepository optAttrRepository;
	
	public void bindAttr(String oid, List<OptAttr> optAttrs) {
		optAttrRepository.deleteByOid(oid);
		optAttrRepository.save(optAttrs);
	}
	
	public void bindOpt(String aid, List<OptAttr> optAttrs) {
		optAttrRepository.deleteByAid(aid);
		optAttrRepository.save(optAttrs);
	}
	
}
