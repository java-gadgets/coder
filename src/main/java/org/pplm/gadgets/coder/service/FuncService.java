package org.pplm.gadgets.coder.service;

import org.apache.commons.lang3.StringUtils;
import org.pplm.gadgets.coder.entity.Func;
import org.pplm.gadgets.coder.repository.FuncRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FuncService {
	
	@Autowired
	private FuncRepository funcRepository;
	
	public Func save(Func func) {
		String id = func.getId();
		if (StringUtils.isNotBlank(id)) {
			Func temp = funcRepository.findOne(id);
			func.setAttrs(temp.getAttrs());
			func.setOpts(temp.getOpts());
		}
		return funcRepository.save(func);
	}
	
}
