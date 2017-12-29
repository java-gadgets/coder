package org.pplm.gadgets.coder.service;

import java.util.List;
import java.util.stream.Collectors;

import org.apache.commons.lang3.StringUtils;
import org.pplm.gadgets.coder.entity.OptAttr;
import org.pplm.gadgets.coder.repository.OptAttrRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class OptAttrService {
	
//	@Autowired
	private OptAttrRepository optAttrRepository;
	
	public void bindAttr(String oid, List<OptAttr> optAttrs) {
		optAttrRepository.deleteByOid(oid);
		//optAttrRepository.save(optAttrs);
	}
	
	public void bindOpt(String aid, List<OptAttr> optAttrs) {
		List<OptAttr> optAttrsTemp = optAttrRepository.findByAid(aid);
		List<OptAttr> removes = filter(optAttrsTemp, optAttrs);
		List<OptAttr> adds = filter(optAttrs, optAttrsTemp);
		if (removes.size() > 0) {
			//optAttrRepository.delete(removes);
		}
		if (adds.size() > 0) {
		//	optAttrRepository.save(adds);
		}
		//optAttrRepository.deleteByAid(aid);
		//optAttrRepository.save(optAttrs);
	}
	
	public List<OptAttr> filter(List<OptAttr> srcs, List<OptAttr> filters) {
		return srcs.stream().filter(optAttr -> {
			String oid = optAttr.getOid();
			if (StringUtils.isNotBlank(oid)) {
				for (OptAttr item : filters) {
					if (oid.equals(item.getOid())) {
						return false;
					}
				}
			}
			return true;
		}).collect(Collectors.toList());
	}

}
