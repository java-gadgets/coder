package org.pplm.gadgets.coder.service;

import java.util.List;
import java.util.Optional;

import org.pplm.gadgets.coder.bean.base.AttrExample;
import org.pplm.gadgets.coder.bean.Dict;
import org.pplm.gadgets.coder.bean.Opt;
import org.pplm.gadgets.coder.bean.OptAttr;
import org.pplm.gadgets.coder.bean.base.OptAttrExample;
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

	@Autowired
	private OptAttrMapper optAttrMapper;
	
	@Autowired
	private DictService dictService;
	
	@Autowired
	public AttrService(AttrMapper mapper) {
		super(mapper);
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
		Dict dict = attr.getDict();
		if (dict != null) {
			if (dict.getId() != null) {
				attr.setDid(dict.getId());
			}
		}
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
		List<Opt> opts = optAttrMapper.selectOptByAttrPrimaryKey(id);
		Attr attr = super.selectByPrimaryKey(id);
		attr.setOpts(opts);
		if (attr.getDid() != null) {
			attr.setDict(dictService.selectByPrimaryKey(attr.getDid()));
		}
		return attr;
	}

	public List<Attr> selectWithDictByExample(AttrExample example) {
		List<Attr> attrs = super.selectByExample(example);
		attrs.forEach(attr -> {
			if (attr.getDid() != null) {
				attr.setDict(dictService.selectByPrimaryKey(attr.getDid()));
			}
		});
		return attrs;
	}
	
}
