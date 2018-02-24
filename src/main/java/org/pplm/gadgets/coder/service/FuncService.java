package org.pplm.gadgets.coder.service;

import org.pplm.gadgets.coder.bean.base.FuncExample;
import org.pplm.gadgets.coder.bean.base.OptExample;
import org.pplm.gadgets.coder.bean.Project;
import org.pplm.gadgets.coder.mapper.FuncMapper;

import java.util.List;

import org.pplm.gadgets.coder.bean.base.AttrExample;
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
	
	public Func selectWithProjectOptsAttrsByPrimaryKey(Long id) {
		Func func = super.selectByPrimaryKey(id);
		OptExample optExample = new OptExample();
		optExample.createCriteria().andFidEqualTo(id);
		func.setOpts(optService.selectWithAttrsByExample(optExample));
		AttrExample attrExample = new AttrExample();
		attrExample.createCriteria().andFidEqualTo(id);
		func.setAttrs(attrService.selectWithDictByExample(attrExample));
		if (func != null) {
			if (func.getPid() != null) {
				func.setProject(projectService.selectByPrimaryKey(func.getPid()));
			}
		}
		return func;
	}
	
	public Project selectProjectByPrimayKey(Long id) {
		Func func = super.selectByPrimaryKey(id);
		if (func != null) {
			if (func.getPid() != null) {
				return projectService.selectByPrimaryKey(func.getPid());
			}
		}
		return null;
	}
	
	public List<Func> selectWithOptsAndAttrsByExample(FuncExample example) {
		List<Func> funcs = super.selectByExample(example);
		if (funcs != null) {
			funcs.forEach(func -> {
				OptExample optExample = new OptExample();
				optExample.createCriteria().andFidEqualTo(func.getId());
				func.setOpts(optService.selectWithAttrsByExample(optExample));
				AttrExample attrExample = new AttrExample();
				attrExample.createCriteria().andFidEqualTo(func.getId());
				func.setAttrs(attrService.selectWithDictByExample(attrExample));
			});
		}
		return funcs;
	}
	
}
