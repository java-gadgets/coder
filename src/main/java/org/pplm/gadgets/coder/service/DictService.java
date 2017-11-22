package org.pplm.gadgets.coder.service;

import org.pplm.gadgets.coder.entity.Dict;
import org.pplm.gadgets.coder.repository.DictItemRepository;
import org.pplm.gadgets.coder.repository.DictRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class DictService {

	@Autowired
	private DictRepository dictRepository;
	@Autowired
	private DictItemRepository dictItemRepository;
	
	
	public Dict save(Dict dict) {
		Dict dictResult = dictRepository.save(dict);
		dictItemRepository.deleteByDidIsNull();
		return dictResult;
	}
	
}
