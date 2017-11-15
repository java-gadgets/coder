package org.pplm.gadgets.coder.service;

import java.util.List;

import org.pplm.gadgets.coder.entity.OptAttr;
import org.pplm.gadgets.coder.repository.OptAttrRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class OptAttrService {
	
	@Autowired
	private OptAttrRepository optAttrRepository;
	
	@Transactional
	public void bindAttr(Long oid, List<OptAttr> optAttrs) {
		optAttrRepository.deleteByOid(oid);
		optAttrRepository.save(optAttrs);
	}
	
}
