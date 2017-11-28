package org.pplm.gadgets.coder.service;

import org.pplm.gadgets.coder.entity.Opt;
import org.pplm.gadgets.coder.repository.OptAttrRepository;
import org.pplm.gadgets.coder.repository.OptRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class OptService {

	@Autowired
	private OptRepository optRepository;
	
	@Autowired
	private OptAttrRepository optAttrRepository;
	
	public boolean delete(String id) {
		Opt opt = optRepository.findOneByIdAndDeleteFlag(id, 0);
		if(opt != null) {
			opt.setDeleteFlag(1);
			optRepository.save(opt);
			optAttrRepository.deleteByOid(id);
			return true;
		}
		return false;
	}
	
}
