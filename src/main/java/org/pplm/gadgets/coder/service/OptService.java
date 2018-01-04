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
	public OptService(OptMapper mapper) {
		super(mapper);
	}

	public List<Attr> selectAttrByOptPrimaryKey(Long oid) {
		return optAttrMapper.selectAttrByOptPrimaryKey(oid);
	}
	
	public void bindAttrByPrimaryKey(Long oid, List<Long> aids) {
		OptAttrExample example = new OptAttrExample();
		example.createCriteria().andOidEqualTo(oid);
		optAttrMapper.deleteByExample(example);
		for (int i = 0; i < aids.size(); i++) {
			optAttrMapper.insertSelective(new OptAttr(aids.get(i), oid, i + 1));
		}
	}
}
