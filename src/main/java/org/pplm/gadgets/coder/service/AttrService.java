package org.pplm.gadgets.coder.service;

import java.util.List;
import java.util.Optional;

import org.pplm.gadgets.coder.bean.AttrExample;
import org.pplm.gadgets.coder.bean.Opt;
import org.pplm.gadgets.coder.bean.OptAttr;
import org.pplm.gadgets.coder.bean.OptAttrExample;
import org.pplm.gadgets.coder.bean.Attr;
import org.pplm.gadgets.coder.mapper.AttrMapper;
import org.pplm.gadgets.coder.mapper.OptAttrMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class AttrService extends BaseService<Attr, AttrExample> {

	private AttrMapper mapper;

	@Autowired
	private OptAttrMapper optAttrMapper;

	@Autowired
	public AttrService(AttrMapper mapper) {
		super(mapper);
		this.mapper = mapper;
	}

	public Page<Attr> selectByExample(AttrExample example, Pageable pageable) {
		Page<Attr> attrs = super.selectByExample(example, pageable);
		return attrs;
	}

	@Override
	public int insertSelective(Attr attr) {
		int flag = super.insertSelective(attr);
		final Long aid = attr.getId();
		List<Opt> opts = attr.getOpts();
		if (opts != null) {
			opts.forEach(opt -> {
				optAttrMapper.insertSelective(new OptAttr(aid, opt.getId(), 1));
			});
		}
		return flag;
	}

	public int updateByPrimaryKeySelective(Attr attr) {
		Long aid = attr.getId();
		List<Opt> opts = attr.getOpts();
		if (opts != null) {
			OptAttrExample example = new OptAttrExample();
			example.createCriteria().andAidEqualTo(attr.getId());
			List<OptAttr> optAttrs = optAttrMapper.selectByExample(example);
			optAttrMapper.deleteByExample(example);
			opts.forEach(opt -> {
				Optional<OptAttr> optAttrOptional = optAttrs.stream().filter(optAttr -> optAttr.getOid().equals(opt.getId()))
						.findFirst();
				if (optAttrOptional.isPresent()) {
					optAttrMapper.insertSelective(new OptAttr(aid, opt.getId(), optAttrOptional.get().getSov()));
				} else {
					optAttrMapper.insertSelective(new OptAttr(aid, opt.getId(), 1));
				}
			});
		}
		return super.updateByPrimaryKeySelective(attr);
	}

	@Override
	public Attr selectByPrimaryKey(Long id) {
		List<Opt> opts = mapper.selectOptByAttrPrimaryKey(id);
		Attr attr = super.selectByPrimaryKey(id);
		attr.setOpts(opts);
		return attr;
	}

	public List<Attr> selectByExampleDeep(AttrExample example) {

		return null;
	}

}
