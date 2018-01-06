package org.pplm.gadgets.coder.service;

import org.pplm.gadgets.coder.bean.OptExample;

import java.util.List;

import org.pplm.gadgets.coder.bean.Attr;
import org.pplm.gadgets.coder.bean.Opt;
import org.pplm.gadgets.coder.bean.OptAttr;
import org.pplm.gadgets.coder.bean.OptAttrExample;
import org.pplm.gadgets.coder.mapper.OptAttrMapper;
import org.pplm.gadgets.coder.mapper.OptMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class OptService extends BaseService<Opt, OptExample> {

	@Autowired
	private OptAttrMapper optAttrMapper;
	
	@Autowired
	private DictService dictService;
	
	@Autowired
	private FuncService funcService;
	
	@Autowired
	public OptService(OptMapper mapper) {
		super(mapper);
	}

	public List<Attr> selectAttrByOptPrimaryKey(Long oid) {
		return optAttrMapper.selectAttrByOptPrimaryKey(oid);
	}
	
	public Opt selectWithAttrAndProjectByPrimaryKey(Long id) {
		Opt opt = super.selectByPrimaryKey(id);
		if (opt != null) {
			opt.setAttrs(getAttrsWithDict(id));
		}
		if (opt.getFid() != null) {
			opt.setProject(funcService.selectProjectByPrimayKey(opt.getFid()));
		}
		return opt;
	}
	
	public void bindAttrByPrimaryKey(Long oid, List<Long> aids) {
		OptAttrExample example = new OptAttrExample();
		example.createCriteria().andOidEqualTo(oid);
		optAttrMapper.deleteByExample(example);
		for (int i = 0; i < aids.size(); i++) {
			optAttrMapper.insertSelective(new OptAttr(aids.get(i), oid, i + 1));
		}
	}
	
	public List<Opt> selectWithAttrsByExample(OptExample example) {
		List<Opt> opts = super.selectByExample(example);
		opts.forEach(opt -> {
			opt.setAttrs(getAttrsWithDict(opt.getId()));
		});
		return opts;
	}
	
	private List<Attr> getAttrsWithDict(Long oid) {
		List<Attr> attrs = selectAttrByOptPrimaryKey(oid);
		if (attrs != null) {
			attrs.forEach(attr -> {
				if (attr.getDid() != null) {
					attr.setDict(dictService.selectByPrimaryKey(attr.getDid()));
				}
			});
		}
		return attrs;
	}
	
}
