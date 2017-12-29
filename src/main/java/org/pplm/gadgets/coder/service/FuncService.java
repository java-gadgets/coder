package org.pplm.gadgets.coder.service;

import org.pplm.gadgets.coder.bean.FuncExample;
import org.pplm.gadgets.coder.mapper.FuncMapper;
import org.pplm.gadgets.coder.bean.Func;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FuncService extends BaseService<Func, FuncExample> {

	@Autowired
	public FuncService(FuncMapper funcMapper) {
		super(funcMapper);
	}
	
}
