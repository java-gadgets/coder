package org.pplm.gadgets.coder.service;

import java.util.List;
import java.util.stream.Collectors;

import org.pplm.gadgets.coder.entity.Attr;
import org.pplm.gadgets.coder.entity.Opt;
import org.pplm.gadgets.coder.entity.OptAttr;
import org.pplm.gadgets.coder.repository.AttrRepository;
import org.pplm.gadgets.coder.repository.OptAttrRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class AttrService {
	
	@Autowired
	private AttrRepository attrRepository;
	
	@Autowired
	private OptAttrRepository optAttrRepository;
	
	@Autowired
	private OptAttrService optAttrService;
	
	public Attr save(Attr attr) {
		Attr attrResult = attrRepository.save(attr);
		final String id = attrResult.getId();
		List<Opt> opts = attr.getOpts();
		if (opts != null) {
			optAttrService.bindOpt(id, opts.stream().map(opt -> new OptAttr(opt.getId(), id)).collect(Collectors.toList()));
		}
		return attrResult;
	}
	
	public boolean delete(String id) {
		Attr attr = attrRepository.findOneByIdAndDeleteFlag(id, 0);
		if (attr != null) {
			attr.setDeleteFlag(1);
			attrRepository.save(attr);
			optAttrRepository.deleteByAid(id);
			return true;
		}
		return false;
	}
	
}
