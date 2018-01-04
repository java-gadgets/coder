package org.pplm.gadgets.coder.service;

import org.pplm.gadgets.coder.bean.FuncExample;
import org.pplm.gadgets.coder.bean.OptExample;
import org.pplm.gadgets.coder.mapper.FuncMapper;
import org.pplm.gadgets.coder.bean.AttrExample;
import org.pplm.gadgets.coder.bean.Func;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FuncService extends BaseService<Func, FuncExample> {

	@Autowired
	private OptService optService;
	
	@Autowired
	private AttrService attrService;
	
	@Autowired
	private ProjectService projectService;
	
	@Autowired
	public FuncService(FuncMapper funcMapper) {
		super(funcMapper);
	}
	
	public Func selectWithProjectAndOptsByPrimaryKey(Long id) {
		Func func = super.selectByPrimaryKey(id);
		OptExample optExample = new OptExample();
		optExample.createCriteria().andFidEqualTo(id);
		func.setOpts(optService.selectWithAttrsByExample(optExample));
		AttrExample attrExample = new AttrExample();
		attrExample.createCriteria().andFidEqualTo(id);
		func.setAttrs(attrService.selectByExample(attrExample));
		if (func.getPid() != null) {
			func.setProject(projectService.selectByPrimaryKey(func.getPid()));
		}
		return func;
	}
	
}
