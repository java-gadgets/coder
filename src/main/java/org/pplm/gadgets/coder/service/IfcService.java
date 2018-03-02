package org.pplm.gadgets.coder.service;

import org.pplm.gadgets.coder.bean.Ifc;
import org.pplm.gadgets.coder.bean.base.IfcExample;
import org.pplm.gadgets.coder.mapper.IfcMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class IfcService extends BaseService<Ifc, IfcExample> {

	@Autowired
	public IfcService(IfcMapper IfcMapper) {
		super(IfcMapper);
	}
	
}
